#
#  Be sure to run `pod spec lint wxxsdk.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
 
s.name              = "WxxKit"
s.version           = "1.1.3"
s.summary           = "iOS通用库"

s.homepage          = "https://github.com/wengxianxun/WxxKit"
     
s.license           = { :type => "MIT", :file => "LICENSE" }

s.platform          = :ios, "7.0"
s.ios.deployment_target = "7.0"
s.author              = { "wengxianxun" => "wengxianxun@hotmail.com" }

s.source            = { :git => "https://github.com/wengxianxun/WxxKit.git", :tag => "#{s.version}" }
s.source_files      = 'WxxKit/WxxKitFrameWork/**/*.{h,m}'
#s.frameworks = 'CoreImage', 'WebKit', 'Security', 'SystemConfiguration', 'UIKit','CFNetwork','MediaPlayer','StoreKit','CoreMotion','AudioToolbox','AdSupport','CoreTelephony'
#s.library = 'z','sqlite3'
  
end
 
 
