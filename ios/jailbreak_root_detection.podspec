#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint screen_protector.podspec --verbose --no-clean` to validate before publishing.
# Run `pod install --repo-update --verbose` to uppdate new version.
#
Pod::Spec.new do |s|
  s.name             = 'jailbreak_root_detection'
  s.version          = '1.0.0'
  s.summary          = 'Check Jailbreak and Rooted for Android and iOS.'
  s.description      = <<-DESC
Check Jailbreak and Rooted for Android and iOS.
                       DESC
  s.homepage         = 'https://github.com/w3connext/jailbreak_root_detection'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'w3connext'
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency       'Flutter'
  s.dependency       'IOSSecuritySuite', '~> 1.9.5'
  s.platform         = :ios, '11.0'
  s.swift_version    = ["4.0", "4.1", "4.2", "5.0", "5.1", "5.2", "5.3", "5.4", "5.5"]
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
