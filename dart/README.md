# Image to Text API - Dart/Flutter Client

Image to Text is a simple tool for extracting text from images. It returns the extracted text.

[![pub package](https://img.shields.io/pub/v/apiverve_imagetotext.svg)](https://pub.dev/packages/apiverve_imagetotext)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is the Dart/Flutter client for the [Image to Text API](https://imagetotext.apiverve.com?utm_source=dart&utm_medium=readme).

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  apiverve_imagetotext: ^1.1.14
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
    final response = await client.execute({
      'url': 'https://findingtom.com/images/uploads/what-is-medium-com/article-image-15.png'
    });

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
    "text": "Ayear after that (in 2021) I hired somebody tpHfelp me write blog posts for\nmy personal website.\n\nThe point is, | like reinvesting the money | make\nback into my business.",
    "confidence": 88,
    "words": 28,
    "characters": 170,
    "lines": 5
  }
}
```

## API Reference

- **API Home:** [Image to Text API](https://imagetotext.apiverve.com?utm_source=dart&utm_medium=readme)
- **Documentation:** [docs.apiverve.com/ref/imagetotext](https://docs.apiverve.com/ref/imagetotext?utm_source=dart&utm_medium=readme)

## Authentication

All requests require an API key. Get yours at [apiverve.com](https://apiverve.com?utm_source=dart&utm_medium=readme).

## License

MIT License - see [LICENSE](LICENSE) for details.

---

Built with Dart for [APIVerve](https://apiverve.com?utm_source=dart&utm_medium=readme)
