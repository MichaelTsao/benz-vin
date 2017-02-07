# Uncomment this line to define a global platform for your project
 platform :ios, ‘9.0’
# Uncomment this line if you're using Swift
use_frameworks!

target 'UsedCarVIN' do
pod 'SnapKit', '~> 3.0.2'
pod 'SVProgressHUD', '~> 2.0'
pod 'UIColor_Hex_Swift', '~> 3.0.2'
pod 'SwiftyButton', '~> 0.5.0'
pod 'Pager', '~> 1.1.1'
pod 'CHCSVParser', '~> 2.1.0'
pod 'UMengAnalytics', '~> 4.1.8'
end

target 'UsedCarVINTests' do

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
