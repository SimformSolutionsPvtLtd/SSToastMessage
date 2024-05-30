#
# Be sure to run `pod lib lint SSToastMessage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = 'SSToastMessage'
  s.version = '2.0.0'
  s.platform = :ios
  s.platform = :osx
  s.swift_versions = '5.0'
  s.summary = 'Simple popup view build in SwiftUI.'
  s.description = <<-DESC
                  Create Toast Views with Minimal Effort in SwiftUI Using SSToastMessage.SSToastMessage enables you to effortlessly add toast
                  notifications, alerts, and floating messages to any view on both iPhone and macOS. With SSToastMessage, you can display left and
                  right toast views over any top-level view, making it incredibly versatile and powerful. Designed to be simple, lightweight, and
                  user-friendly, SSToastMessage allows you to show popups with a single line of code. Enhance your app's user experience with seamless
                  and stylish notifications.
                  DESC
    
  s.homepage = 'https://github.com/SimformSolutionsPvtLtd/SSToastMessage'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Ankit Panchal' => 'ankit.p@simformsolutions.com' }
  s.source = { :git => 'https://github.com/SimformSolutionsPvtLtd/SSToastMessage.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.simform.com'
    
  s.ios.deployment_target = '14.0'
  s.osx.deployment_target = '13.0'
    
  s.source_files = '**/Sources/Classes/*.swift'
  s.frameworks = ['SwiftUI']
    
end
