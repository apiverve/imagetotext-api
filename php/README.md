# Image to Text API - PHP Package

Image to Text is an OCR and image to text API that extracts text from image files or remote image URLs using optical character recognition. Upload a JPG, PNG, or GIF up to 5 MB to receive the raw extracted text.

## Installation

Install via Composer:

```bash
composer require apiverve/imagetotext
```

## Getting Started

Get your API key at [APIVerve](https://apiverve.com)

### Basic Usage

```php
<?php

require_once 'vendor/autoload.php';

use APIVerve\Imagetotext\Client;

// Initialize the client
$client = new Client('YOUR_API_KEY');

// Make a request
$response = $client->execute([
    'image' => '',
    'language' => ''
]);

// Print the response
print_r($response);
```

### File Upload

```php
// Upload a file
$response = $client->executeWithFile('/path/to/file.jpg');

// Or use a URL
$response = $client->executeWithUrl('https://example.com/image.jpg');
```

### Error Handling

```php
use APIVerve\Imagetotext\Client;
use APIVerve\Imagetotext\Exceptions\APIException;
use APIVerve\Imagetotext\Exceptions\ValidationException;

try {
    $response = $client->execute(['url' => 'https://findingtom.com/images/uploads/what-is-medium-com/article-image-15.png']);
    print_r($response['data']);
} catch (ValidationException $e) {
    echo "Validation error: " . implode(', ', $e->getErrors());
} catch (APIException $e) {
    echo "API error: " . $e->getMessage();
    echo "Status code: " . $e->getStatusCode();
}
```

### Debug Mode

```php
// Enable debug logging
$client = new Client(
    apiKey: 'YOUR_API_KEY',
    debug: true
);
```

## Example Response

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

## Requirements

- PHP 7.4 or higher
- Guzzle HTTP client

## Documentation

For more information, visit the [API Documentation](https://docs.apiverve.com/ref/imagetotext?utm_source=packagist&utm_medium=referral&utm_content=readme).

## Support

- Website: [https://apiverve.com/marketplace/imagetotext?utm_source=php&utm_medium=referral&utm_content=readme](https://apiverve.com/marketplace/imagetotext?utm_source=php&utm_medium=referral&utm_content=readme)
- Email: hello@apiverve.com

## License

This package is available under the [MIT License](LICENSE).
