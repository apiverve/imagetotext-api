# Image to Text API - PHP Package

Image to Text is a simple tool for extracting text from images. It returns the extracted text.

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
$response = $client->execute(['url' => 'https://findingtom.com/images/uploads/what-is-medium-com/article-image-15.png']);

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
    "text": "Ayear after that (in 2021) I hired somebody tpHfelp me write blog posts for\nmy personal website.\n\nThe point is, | like reinvesting the money | make\nback into my business.",
    "confidence": 88,
    "words": 28,
    "characters": 170,
    "lines": 5
  }
}
```

## Requirements

- PHP 7.4 or higher
- Guzzle HTTP client

## Documentation

For more information, visit the [API Documentation](https://docs.apiverve.com/ref/imagetotext?utm_source=packagist&utm_medium=readme).

## Support

- Website: [https://imagetotext.apiverve.com?utm_source=php&utm_medium=readme](https://imagetotext.apiverve.com?utm_source=php&utm_medium=readme)
- Email: hello@apiverve.com

## License

This package is available under the [MIT License](LICENSE).
