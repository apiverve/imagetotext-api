# Image to Text API - Dart/Flutter Client

Image to Text is an OCR and image to text API that extracts text from image files or remote image URLs using optical character recognition. Upload a JPG, PNG, or GIF up to 5 MB to receive the raw extracted text.

[![pub package](https://img.shields.io/pub/v/apiverve_imagetotext.svg)](https://pub.dev/packages/apiverve_imagetotext)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is the Dart/Flutter client for the [Image to Text API](https://apiverve.com/marketplace/imagetotext?utm_source=dart&utm_medium=referral&utm_content=readme).

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  apiverve_imagetotext: ^1.2.5
```

Then run:

```bash
dart pub get
# or for Flutter
flutter pub get
```

## Usage

```dart
import 'package:apiverve_imagetotext/apiverve_imagetotext.dart';

void main() async {
  final client = ImagetotextClient('YOUR_API_KEY');

  try {
    // This API requires a file upload — a JSON body is rejected with a 400.
    final response = await client.executeWithFile('/path/to/your-file');

    print('Status: ${response.status}');
    print('Data: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}
```

## Response

```json
{
  "status": "ok",
  "error": null,
  "data": {
    "text": "A year after that (in 2021) I hired somebody tp#lp me write blog posts for\nmy personal website.\n\nThe point is, | like reinvesting the money | make\nback into my business.",
    "words": 32,
    "characters": 169,
    "lines": 5,
    "language": [
      "en"
    ],
    "confidence": 87.7,
    "wordBoxes": [
      {
        "text": "after",
        "confidence": 96.7,
        "left": 76,
        "top": 19,
        "width": 35,
        "height": 13,
        "block": 1,
        "line": 1
      },
      {
        "text": "that",
        "confidence": 96.9,
        "left": 115,
        "top": 19,
        "width": 30,
        "height": 12,
        "block": 1,
        "line": 1
      },
      {
        "text": "tp#lp",
        "confidence": 62.6,
        "left": 357,
        "top": 19,
        "width": 49,
        "height": 16,
        "block": 1,
        "line": 1
      },
      {
        "text": "business.",
        "confidence": 96.9,
        "left": 174,
        "top": 150,
        "width": 99,
        "height": 20,
        "block": 3,
        "line": 2
      }
    ]
  }
}
```

## API Reference

- **API Home:** [Image to Text API](https://apiverve.com/marketplace/imagetotext?utm_source=dart&utm_medium=referral&utm_content=readme)
- **Documentation:** [docs.apiverve.com/ref/imagetotext](https://docs.apiverve.com/ref/imagetotext?utm_source=dart&utm_medium=referral&utm_content=readme)

## Authentication

All requests require an API key. Get yours at [apiverve.com](https://apiverve.com?utm_source=dart&utm_medium=referral&utm_content=readme).

## License

MIT License - see [LICENSE](LICENSE) for details.

---

Built with Dart for [APIVerve](https://apiverve.com?utm_source=dart&utm_medium=referral&utm_content=readme)
