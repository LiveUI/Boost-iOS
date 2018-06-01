# Uncomment the next line to define a global platform for your project
platform :ios, '10.3'

target 'Boost' do
    
    use_frameworks!
    
    pod 'Presentables', :path => '../Presentables'
    pod 'SnapKit', '~>4.0.0'
    pod 'Modular', '~>0.0.9'
    pod 'AwesomeEnum', '~> 1.2.0'
    pod 'Reloaded', :path => '../Reloaded'
    pod 'BoostSDK', :path => '../BoostSDK'

    target 'BoostTests' do
        inherit! :search_paths
        pod 'SpecTools'
    end
    
    target 'BoostUITests' do
        inherit! :search_paths
    end
    
end
