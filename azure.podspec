#
# Be sure to run `pod spec lint azure.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "azure"
  s.version      = "0.5.0"
  s.summary      = "Windows Azure Client Library for Objective-C."
  s.homepage     = "https://github.com/andrerod/ios"
  s.license      = { :type => 'Apache 2.0', :file => 'http://www.apache.org/licenses/LICENSE-2.0' }
  s.author       = { "Andre Rodrigues" => "andrerod@microsoft.com" }

  s.platform     = :ios, '5.0'

  s.dependency 'AFNetworking', '~> 1.0'
end
