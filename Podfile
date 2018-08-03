# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def testPods
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
end

def commonPods
    pod 'RxSwift',    '~> 4.0'
end

target 'DemoApp' do
    use_frameworks!
    
    commonPods
    pod 'SnapKit', '~> 4.0.0'
    pod 'RxCocoa',    '~> 4.0'
    pod 'Kingfisher', '~> 4.0'
    
    target 'DemoAppTests' do
        inherit! :search_paths
        testPods
        pod 'RxCocoa',    '~> 4.0'
    end
    
end

target 'Platform' do
    use_frameworks!
    
    commonPods
    pod 'Alamofire'
    pod 'RxAlamofire'
    
    target 'PlatformTests' do
        inherit! :search_paths
        testPods
    end
end

target 'Domain' do
    use_frameworks!
    
    commonPods
    target 'DomainTests' do
        inherit! :search_paths
        testPods
    end
end
