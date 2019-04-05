Pod::Spec.new do |s|

  s.name         = "MIPicker"
  s.version      = "0.1.0"
  s.summary      = "An image picker similar to UIImagePicker with multiple image selection support"
  s.homepage     = "https://github.com/SainTod/MIPicker"
  s.license      = "MIT"
  s.author             = { "Alexx" => "alexx.dudkin@gmail.com" }
  s.source       = { :git => "https://github.com/SainTod.git", :tag => "#{s.version}" }
  s.source_files  = "MultipleImagePicker/MultipleImagePicker/Source", "Source/**/*.{h,m}"
  s.platforms = { :ios => "11.0"}
  s.swift_version = '4.2'
  s.requires_arc = true

end
