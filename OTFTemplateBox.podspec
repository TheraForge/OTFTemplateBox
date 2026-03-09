#
# Be sure to run `pod lib lint OTFTemplateBox.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OTFTemplateBox'
  s.version          = '2.0.0'
  s.summary          = 'TheraForge OTFTemplateBox is a fully customizable zero-code template framework for app customization.'
  s.homepage         = 'https://github.com/TheraForge/OTFTemplateBox'
  s.license          = { :type => 'BSD-4', :file => 'LICENSE.md' }
  s.author           = { 'Hippocrates Technologies' => 'hippocratestech-dev@googlegroups.com' }
  s.source           = { :git => 'https://github.com/TheraForge/OTFTemplateBox.git', :tag => s.version.to_s }

  # Platforms support
  s.ios.deployment_target     = '16.0'
  s.watchos.deployment_target = '9.0'

  # Swift module
  s.swift_version = '5.0'

  # Source files
  s.source_files = 'OTFTemplateBox/**/*.{swift}'

  # Restricted Dependencies
  s.ios.dependency 'Yams'

  # Shared dependencies
  s.dependency 'OTFUtilities', '2.0.0'
end