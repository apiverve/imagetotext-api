# Image to Text API - Ruby Gem

Image to Text is an OCR and image to text API that extracts text from image files or remote image URLs using optical character recognition. Upload a JPG, PNG, or GIF up to 5 MB to receive the raw extracted text.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apiverve_imagetotext'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install apiverve_imagetotext
```

## Getting Started

Get your API key at [APIVerve](https://apiverve.com)

### Basic Usage

```ruby
require 'apiverve_imagetotext'

# Initialize the client
client = APIVerve::Imagetotext::Client.new(api_key: "YOUR_API_KEY")

# Make a request
response = client.execute({ url: "https://findingtom.com/images/uploads/what-is-medium-com/article-image-15.png" })

# Print the response
puts response
```

### File Upload

```ruby
# Upload a file
response = client.execute_with_file("/path/to/file.jpg")

# Or use a URL
response = client.execute_with_url("https://example.com/image.jpg")
```

### Error Handling

```ruby
begin
  response = client.execute({ url: "https://findingtom.com/images/uploads/what-is-medium-com/article-image-15.png" })
  puts response["data"]
rescue APIVerve::Imagetotext::ValidationError => e
  puts "Validation error: #{e.errors.join(', ')}"
rescue APIVerve::Imagetotext::APIError => e
  puts "API error: #{e.message}"
  puts "Status code: #{e.status_code}"
end
```

### Debug Mode

```ruby
# Enable debug logging
client = APIVerve::Imagetotext::Client.new(
  api_key: "YOUR_API_KEY",
  debug: true
)
```

## Example Response

```json
{
  "status": "ok",
  "error": null,
  "data": {
    "text": "Ayear after that (in 2021) I hired somebody tpHfelp me write blog posts for\nmy personal website.\n\nThe point is, | like reinvesting the money | make\nback into my business.",
    "words": 28,
    "characters": 170,
    "lines": 5
  }
}
```

## Documentation

For more information, visit the [API Documentation](https://docs.apiverve.com/ref/imagetotext?utm_source=rubygems&utm_medium=referral&utm_content=readme).

## Support

- Website: [https://apiverve.com/marketplace/imagetotext?utm_source=ruby&utm_medium=referral&utm_content=readme](https://apiverve.com/marketplace/imagetotext?utm_source=ruby&utm_medium=referral&utm_content=readme)
- Email: hello@apiverve.com

## License

This gem is available under the [MIT License](LICENSE).
