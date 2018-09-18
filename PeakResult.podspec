Pod::Spec.new do |s|

  s.name         = "PeakResult"
  s.version      = "2.1.1"
  s.summary      = "An enum that contains a result."
  s.homepage     = "https://github.com/3squared/PeakResult"
  s.license      = { :type => 'Custom', :file => 'LICENSE.md' }
  s.author       = { "Sam Oakley" => "sam.oakley@3squared.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/3squared/PeakResult.git", :tag => s.version.to_s }
  s.source_files = "PeakResult", "PeakResult/**/*.{h,m,swift}"
  s.swift_version = '4.2'

end
