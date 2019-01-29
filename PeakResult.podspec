Pod::Spec.new do |s|

  s.name         = "PeakResult"
  s.version      = "2.1.1"
  s.summary      = "An enum that contains a result."
  s.homepage     = "https://github.com/3squared/PeakResult"
  s.license      = { :type => 'Custom', :file => 'LICENSE.md' }
  s.author       = { "Sam Oakley" => "sam.oakley@3squared.com" }
  s.source       = { :git => "https://github.com/3squared/PeakResult.git", :tag => s.version.to_s }
  s.swift_version = '4.2'

  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.macos.deployment_target = '10.13'

  s.source_files = "PeakResult", "PeakResult/Core/**/*.{h,m,swift}"
  s.ios.source_files = "PeakResult/Platforms/iOS/**/*.{h,m,swift}"
  s.tvos.source_files = "PeakResult/Platforms/iOS/**/*.{h,m,swift}"
  s.macos.source_files = "PeakResult/Platforms/macOS/**/*.{h,m,swift}"

end
