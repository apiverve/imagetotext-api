/// Response models for the Image to Text API.

/// API Response wrapper.
class ImagetotextResponse {
  final String status;
  final dynamic error;
  final ImagetotextData? data;

  /// Set only when the current plan locks one or more fields; null otherwise.
  final PremiumInfo? premium;

  ImagetotextResponse({
    required this.status,
    this.error,
    this.data,
    this.premium,
  });

  factory ImagetotextResponse.fromJson(Map<String, dynamic> json) => ImagetotextResponse(
    status: json['status'] as String? ?? '',
    error: json['error'],
    data: json['data'] != null ? ImagetotextData.fromJson(json['data']) : null,
    premium: json['premium'] != null ? PremiumInfo.fromJson(json['premium']) : null,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    if (error != null) 'error': error,
    if (data != null) 'data': data,
    if (premium != null) 'premium': premium!.toJson(),
  };
}

/// Describes fields the current plan does not unlock. Locked fields arrive as null
/// in [data], and [lockedFields] names them (nested ones use dot paths).
class PremiumInfo {
  final String? message;
  final String? upgradeUrl;
  final List<String>? lockedFields;

  PremiumInfo({this.message, this.upgradeUrl, this.lockedFields});

  factory PremiumInfo.fromJson(Map<String, dynamic> json) => PremiumInfo(
    message: json['message'] as String?,
    upgradeUrl: json['upgrade_url'] as String?,
    lockedFields: (json['locked_fields'] as List?)?.map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    if (message != null) 'message': message,
    if (upgradeUrl != null) 'upgrade_url': upgradeUrl,
    if (lockedFields != null) 'locked_fields': lockedFields,
  };
}

/// Response data for the Image to Text API.

class ImagetotextData {
  String? text;
  num? words;
  num? characters;
  num? lines;
  List<String>? language;
  num? confidence;
  List<ImagetotextDataWordboxesItem>? wordBoxes;

  ImagetotextData({
    this.text,
    this.words,
    this.characters,
    this.lines,
    this.language,
    this.confidence,
    this.wordBoxes,
  });

  factory ImagetotextData.fromJson(Map<String, dynamic> json) => ImagetotextData(
      text: json['text'],
      words: json['words'],
      characters: json['characters'],
      lines: json['lines'],
      language: (json['language'] as List?)?.cast<String>(),
      confidence: json['confidence'],
      wordBoxes: (json['wordBoxes'] as List?)?.map((e) => ImagetotextDataWordboxesItem.fromJson(e)).toList(),
    );
}

class ImagetotextDataWordboxesItem {
  String? text;
  num? confidence;
  num? left;
  num? top;
  num? width;
  num? height;
  num? block;
  num? line;

  ImagetotextDataWordboxesItem({
    this.text,
    this.confidence,
    this.left,
    this.top,
    this.width,
    this.height,
    this.block,
    this.line,
  });

  factory ImagetotextDataWordboxesItem.fromJson(Map<String, dynamic> json) => ImagetotextDataWordboxesItem(
      text: json['text'],
      confidence: json['confidence'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      block: json['block'],
      line: json['line'],
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
