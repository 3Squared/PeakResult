#
#  Be sure to run `pod spec lint Result.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "PeakResult"
  s.version      = "1.0.1"
  s.summary      = "An enum that contains a result."
  s.homepage     = "https://gitlab.3squared.com/iOSLibraries/PeakResult"
  s.license      = { :type => 'Custom', :file => 'LICENCE' }
  s.author       = { "Sam Oakley" => "sam.oakley@3squared.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "git@gitlab.3squared.com:iOSLibraries/PeakResult.git", :tag => s.version.to_s }
  s.source_files = "PeakResult", "PeakResult/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }

end
