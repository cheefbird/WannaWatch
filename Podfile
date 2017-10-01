# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'WannaWatch' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WannaWatch
  pod 'RxSwift', :inhibit_warnings => true
  pod 'RxCocoa', :inhibit_warnings => true
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'RxRealm'
  pod 'RxRealmDataSources'
  pod 'SwiftyJSON'
  pod 'RealmSwift'
  pod 'Action'
  pod 'Kingfisher', '~> 3.13.1'

  target 'WannaWatchTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxTest'
    pod 'RxBlocking'
  end

end

# enable tracing resources
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'RxSwift'
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D',
          'TRACE_RESOURCES']
        end
      end
    end
  end
end
