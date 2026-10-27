Pod::Spec.new do |s|
  s.name             = 'APIVerveImagetoText'
  s.version          = '1.2.3'
  s.summary          = 'Image to Text is an OCR and image to text API that extracts text from image files or remote image URLs using optical character recognition.'
  s.description      = <<-'DESC'
Image to Text is an OCR and image to text API that extracts text from image files or remote image URLs using optical character recognition. Upload a JPG, PNG, or GIF up to 5 MB to receive the raw extracted text.

This iOS/macOS SDK provides a convenient way to access the Image to Text from APIVerve.
Supports both callback-based and async/await patterns.
                       DESC

  s.homepage         = 'https://apiverve.com/marketplace/imagetotext?utm_source=cocoapods&utm_medium=referral&utm_content=homepage'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'APIVerve' => 'hello@apiverve.com' }
  # The SDK repo holds every language; the pod lives under cocoapods/ with its own tag.
  s.source           = { :git => 'https://github.com/apiverve/imagetotext-api.git', :tag => "cocoapods/v#{s.version}" }

  s.ios.deployment_target = '15.0'
  s.osx.deployment_target = '12.0'

  s.swift_version = '5.0'

  s.source_files = 'cocoapods/Sources/APIVerveImagetoText/**/*.swift'

  s.frameworks = 'Foundation'

  # APIResponse, APIVerveError and the request plumbing, shared by every APIVerve pod.
  s.dependency 'APIVerveCore', '~> 1.2'
end
