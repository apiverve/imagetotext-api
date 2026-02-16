import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'models.dart';

/// Validation rule for a parameter.
class ValidationRule {
  final String type;
  final bool required;
  final num? min;
  final num? max;
  final int? minLength;
  final int? maxLength;
  final String? format;
  final List<String>? enumValues;

  const ValidationRule({
    required this.type,
    required this.required,
    this.min,
    this.max,
    this.minLength,
    this.maxLength,
    this.format,
    this.enumValues,
  });
}

/// Exception thrown when parameter validation fails.
class ImagetotextValidationException implements Exception {
  final List<String> errors;

  ImagetotextValidationException(this.errors);

  @override
  String toString() => 'ImagetotextValidationException: ${errors.join("; ")}';
}

/// Format validation patterns.
final _formatPatterns = {
  'email': RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$'),
  'url': RegExp(r'^https?://.+'),
  'ip': RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$'),
  'date': RegExp(r'^\d{4}-\d{2}-\d{2}$'),
  'hexColor': RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$'),
};

/// Image to Text API client.
///
/// For more information, visit: https://imagetotext.apiverve.com?utm_source=dart&utm_medium=readme
///
/// Parameters:
/// * [image] (required) - Upload an image file to extract text from (supported formats: JPG, PNG, GIF, max 5MB)
class ImagetotextClient {
  final String apiKey;
  final String baseUrl;
  final http.Client _httpClient;

  /// Validation rules for parameters.
  static final Map<String, ValidationRule> _validationRules = <String, ValidationRule>{
    'image': ValidationRule(type: 'string', required: true),
  };

  ImagetotextClient(this.apiKey, {
    this.baseUrl = 'https://api.apiverve.com/v1/imagetotext',
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Validates parameters against defined rules.
  /// Throws [ImagetotextValidationException] if validation fails.
  void _validateParams(Map<String, dynamic> params) {
    final errors = <String>[];

    for (final entry in _validationRules.entries) {
      final paramName = entry.key;
      final rule = entry.value;
      final value = params[paramName];

      // Check required
      if (rule.required && (value == null || (value is String && value.isEmpty))) {
        errors.add('Required parameter [$paramName] is missing');
        continue;
      }

      if (value == null) continue;

      // Type-specific validation
      if (rule.type == 'integer' || rule.type == 'number') {
        final numValue = value is num ? value : num.tryParse(value.toString());
        if (numValue == null) {
          errors.add('Parameter [$paramName] must be a valid ${rule.type}');
          continue;
        }
        if (rule.min != null && numValue < rule.min!) {
          errors.add('Parameter [$paramName] must be at least ${rule.min}');
        }
        if (rule.max != null && numValue > rule.max!) {
          errors.add('Parameter [$paramName] must be at most ${rule.max}');
        }
      } else if (rule.type == 'string' && value is String) {
        if (rule.minLength != null && value.length < rule.minLength!) {
          errors.add('Parameter [$paramName] must be at least ${rule.minLength} characters');
        }
        if (rule.maxLength != null && value.length > rule.maxLength!) {
          errors.add('Parameter [$paramName] must be at most ${rule.maxLength} characters');
        }
        if (rule.format != null && _formatPatterns.containsKey(rule.format)) {
          if (!_formatPatterns[rule.format]!.hasMatch(value)) {
            errors.add('Parameter [$paramName] must be a valid ${rule.format}');
          }
        }
      }

      // Enum validation
      if (rule.enumValues != null && rule.enumValues!.isNotEmpty) {
        if (!rule.enumValues!.contains(value.toString())) {
          errors.add('Parameter [$paramName] must be one of: ${rule.enumValues!.join(", ")}');
        }
      }
    }

    if (errors.isNotEmpty) {
      throw ImagetotextValidationException(errors);
    }
  }

  /// Execute a request to the Image to Text API.
  ///
  /// Parameters are validated before sending the request.
  Future<ImagetotextResponse> execute(Map<String, dynamic> params) async {
    // Validate parameters
    _validateParams(params);
    if (apiKey.isEmpty) {
      throw ImagetotextException('API key is required. Get your API key at: https://apiverve.com');
    }

    try {
      final response = await _httpClient.post(
        Uri.parse(baseUrl),
        headers: {
          'x-api-key': apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return ImagetotextResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        throw ImagetotextException('Invalid API key');
      } else if (response.statusCode == 404) {
        throw ImagetotextException('Resource not found');
      } else {
        throw ImagetotextException('API error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ImagetotextException) rethrow;
      throw ImagetotextException('Request failed: $e');
    }
  }

  /// Execute a request to the Image to Text API with a file upload.
  ///
  /// [filePath] - Path to the file to upload
  /// [additionalParams] - Optional additional parameters to send with the request
  Future<ImagetotextResponse> executeWithFile(
    String filePath, {
    Map<String, String>? additionalParams,
  }) async {
    if (apiKey.isEmpty) {
      throw ImagetotextException('API key is required. Get your API key at: https://apiverve.com');
    }

    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw ImagetotextException('File not found: $filePath');
      }

      final request = http.MultipartRequest('POST', Uri.parse(baseUrl));
      request.headers['x-api-key'] = apiKey;

      // Add the file
      final fileName = filePath.split('/').last.split('\\').last;
      final mimeType = _getMimeType(fileName);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        filePath,
        contentType: MediaType.parse(mimeType),
      ));

      // Add additional parameters
      if (additionalParams != null) {
        request.fields.addAll(additionalParams);
      }

      final streamedResponse = await _httpClient.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return ImagetotextResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        throw ImagetotextException('Invalid API key');
      } else if (response.statusCode == 404) {
        throw ImagetotextException('Resource not found');
      } else {
        throw ImagetotextException('API error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ImagetotextException) rethrow;
      throw ImagetotextException('File upload failed: $e');
    }
  }

  /// Execute a request with file bytes.
  ///
  /// [bytes] - File content as bytes
  /// [fileName] - Name of the file
  /// [additionalParams] - Optional additional parameters
  Future<ImagetotextResponse> executeWithBytes(
    List<int> bytes,
    String fileName, {
    Map<String, String>? additionalParams,
  }) async {
    if (apiKey.isEmpty) {
      throw ImagetotextException('API key is required. Get your API key at: https://apiverve.com');
    }

    try {
      final request = http.MultipartRequest('POST', Uri.parse(baseUrl));
      request.headers['x-api-key'] = apiKey;

      // Add the file from bytes
      final mimeType = _getMimeType(fileName);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      ));

      // Add additional parameters
      if (additionalParams != null) {
        request.fields.addAll(additionalParams);
      }

      final streamedResponse = await _httpClient.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return ImagetotextResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        throw ImagetotextException('Invalid API key');
      } else if (response.statusCode == 404) {
        throw ImagetotextException('Resource not found');
      } else {
        throw ImagetotextException('API error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ImagetotextException) rethrow;
      throw ImagetotextException('File upload failed: $e');
    }
  }

  String _getMimeType(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  /// Close the HTTP client.
  void close() {
    _httpClient.close();
  }
}

/// Exception thrown by the Image to Text API client.
class ImagetotextException implements Exception {
  final String message;

  ImagetotextException(this.message);

  @override
  String toString() => 'ImagetotextException: $message';
}
