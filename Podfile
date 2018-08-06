# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Caiva_iOS' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Caiva_iOS
  pod 'RealmSwift'
  pod 'TapticEngine'
  pod 'Hero'
  pod 'AlertHelperKit', :git => 'https://github.com/keygx/AlertHelperKit'

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '4.1'
          end
      end
  end
  # pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'


end