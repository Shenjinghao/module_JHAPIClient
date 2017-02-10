

Pod::Spec.new do |s|
  s.name         = "JHAPIClient"
  s.version      = "0.0.2"
  s.summary      = "JHAPIClient提供基于AFNetworking的网络服务"
  s.description  = <<-DESC
                   A longer description of CYDate in Markdown format.
                   DESC

  s.homepage     = "https://github.com/Shenjinghao/module_JHAPIClient.git"
  s.license      = { :type => "MIT" }
  s.author             = { "shenjinghao" => "807880748@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Shenjinghao/module_JHAPIClient.git", :tag => "0.0.1" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.requires_arc = true
  
  # s.framework  = "UIKit"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.xcconfig  =   { 'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/**' }
  s.dependency "AFNetworking", "~>2.5.0"
end

