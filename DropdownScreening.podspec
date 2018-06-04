Pod::Spec.new do |s|
  s.name         = "DropdownScreening" 
  s.version      = "1.0.0"     
  s.license      = "MIT"       
  s.summary      = "DropdownScreening 是一款自定义的下拉筛选控件。是一款比较灵活好用的控件，如果对你有用，请给Star，谢谢"

  s.homepage     = "https://github.com/baishiyun/DropdownScreening"
  s.source       = { :git => "https://github.com/baishiyun/DropdownScreening.git", :tag => "#{s.version}" }
  s.source_files =  "DropdownScreening/*.{h,m,png}"
  s.requires_arc = true 
  s.platform     = :ios, "7.0" 
  s.frameworks   = "UIKit", "Foundation"
  s.author             = { "白仕云" => "baishiyun@163.com" } 
  s.social_media_url   = "https://github.com/baishiyun" 

end