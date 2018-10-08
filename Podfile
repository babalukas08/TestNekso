# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def basic_pods
    # Pods for FormulariosElectronicos
    pod 'ObjectMapper', '~> 3.1'
    pod 'RealmSwift'
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
    pod 'RxGesture'
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'

    end

target 'NeksoTest' do
  # Pods for NeksoTest
  basic_pods
end

target 'NeksoTestTests' do
    inherit! :search_paths
    # Pods for testing
    basic_pods
end
