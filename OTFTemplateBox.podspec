#
# Be sure to run `pod lib lint OTFTemplateBox.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OTFTemplateBox'
  s.version          = '0.0.4'
  s.summary          = 'A short description of OTFTemplateBox.'
  s.description      = "This framework will be used to provide templating to other frameworks using yaml file."
  s.homepage         = 'https://github.com/TheraForge/OTFTemplateBox'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hippocrates Technologies' => 'hippocratestech-dev@googlegroups.com' }
  s.source           = { :git => 'https://github.com/TheraForge/OTFTemplateBox.git', :branch => 'main' }
  s.source_files = 'OTFTemplateBox/**/*.{h,m,c,swift}'
  s.exclude_files = 'OTFTemplateBox/Pods/**/*', 'OTFTemplateBox/info.plist', 'OTFTemplateBox/Support Files/**/*.{h,m,swift}'
  s.ios.deployment_target = '13.0'
  s.dependency 'Yams'
  s.dependency 'OTFToolBoxCore'
  s.dependency 'OTFCareKitUI'
end

