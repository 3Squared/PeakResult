Pod::Spec.new do |s|

  s.name         = "PeakResult"
  s.version      = "2.0.0"
  s.summary      = "An enum that contains a result."
  s.homepage     = "https://gitlab.3squared.com/MobileTeam/PeakResult"
  s.license      = { :type => 'Custom', :file => 'LICENCE' }
  s.author       = { "Sam Oakley" => "sam.oakley@3squared.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "git@gitlab.3squared.com:MobileTeam/PeakResult.git", :tag => s.version.to_s }
  s.source_files = "PeakResult", "PeakResult/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }

end
