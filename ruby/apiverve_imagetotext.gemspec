# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "apiverve_imagetotext"
  spec.version       = "1.2.3"
  spec.authors       = ["APIVerve"]
  spec.email         = ["hello@apiverve.com"]

  spec.summary       = "Image to Text API - Ruby Client"
  spec.description   = "Image to Text is an OCR and image to text API that extracts text from image files or remote image URLs using optical character recognition. Upload a JPG, PNG, or GIF up to 5 MB to receive the raw extracted text."
  spec.homepage      = "https://apiverve.com/marketplace/imagetotext?utm_source=ruby&utm_medium=referral&utm_content=homepage"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/apiverve/imagetotext-API/tree/main/ruby"
  spec.metadata["changelog_uri"] = "https://apiverve.com/changelog"
  spec.metadata["documentation_uri"] = "https://docs.apiverve.com/ref/imagetotext"

  spec.files = Dir.glob("{lib}/**/*") + %w[README.md LICENSE]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 1.0", "< 3.0"
  spec.add_dependency "faraday-multipart", "~> 1.0"
  spec.add_dependency "json", "~> 2.0"
end
