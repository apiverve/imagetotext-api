/// Response models for the Image to Text API.

/// API Response wrapper.
class ImagetotextResponse {
  final String status;
  final dynamic error;
  final ImagetotextData? data;

  ImagetotextResponse({
    required this.status,
    this.error,
    this.data,
  });

  factory ImagetotextResponse.fromJson(Map<String, dynamic> json) => ImagetotextResponse(
    status: json['status'] as String? ?? '',
    error: json['error'],
    data: json['data'] != null ? ImagetotextData.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    if (error != null) 'error': error,
    if (data != null) 'data': data,
  };
}

/// Response data for the Image to Text API.

class ImagetotextData {
  String? text;
  int? confidence;
  int? words;
  int? characters;
  int? lines;

  ImagetotextData({
    this.text,
    this.confidence,
    this.words,
    this.characters,
    this.lines,
  });

  factory ImagetotextData.fromJson(Map<String, dynamic> json) => ImagetotextData(
      text: json['text'],
      confidence: json['confidence'],
      words: json['words'],
      characters: json['characters'],
      lines: json['lines'],
    );
}

class ImagetotextRequest {
  String? url;

  ImagetotextRequest({
    this.url,
  });

  Map<String, dynamic> toJson() => {
      if (url != null) 'url': url,
    };
}
