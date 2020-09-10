#
# Be sure to run `pod lib lint SSToastMessage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
 	  s.name                   = 'SSToastMessage'
  	s.version                = '1.0.0'
  	s.platform               = :ios
    s.swift_versions         = '5.0'
  	s.summary                = 'Simple popup view build in SwiftUI.'
  	s.description            = <<-DESC
						       SSToastMessage is written purely in SwiftUI. It will add toast, alert, 
						       and floating message view over the top of any view. It is intended to be simple, 
						       lightweight, and easy to use. It will be a popup with a single line of code.
                               DESC
    
    s.homepage               = 'https://github.com/SimformSolutionsPvtLtd/SSToastMessage'
    s.license                = { :type => 'MIT', :file => 'LICENSE' }
    s.author                 = { 'Ankit Panchal' => 'ankit.p@simformsolutions.com' }
    s.source                 = { :git => 'https://github.com/SimformSolutionsPvtLtd/SSToastMessage.git', :tag => s.version }
    s.social_media_url       = 'https://www.simform.com'
    
    s.ios.deployment_target  = '13.0'
    
    s.source_files           = 'Sources/Classes/*.swift'
    s.requires_arc           = true
    s.frameworks             = ['SwiftUI']
    
end
