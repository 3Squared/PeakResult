Pod::Spec.new do |s|

  s.name         = "PeakResult"
  s.version      = "2.1.0"
  s.summary      = "An enum that contains a result."
  s.homepage     = "https://gitlab.3squared.com/MobileTeam/PeakResult"
  s.license      = { :type => 'Custom', :file => 'LICENSE.md' }
  s.author       = { "Sam Oakley" => "sam.oakley@3squared.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "git@gitlab.3squared.com:MobileTeam/PeakResult.git", :tag => s.version.to_s }
  s.source_files = "PeakResult", "PeakResult/**/*.{h,m,swift}"
  s.swift_version = '4.2'

end
