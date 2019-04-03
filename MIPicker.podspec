Pod::Spec.new do |s|

  s.name         = "MIPicker"
  s.version      = "0.0.1"
  s.summary      = "An image picker similar to UIImagePicker with multiple image selection support"
  s.homepage     = "https://github.com/SainTod/MIPicker"
  s.license      = "MIT"
  s.author             = { "Alexx" => "alexx.dudkin@gmail.com" }
  s.source       = { :git => "https://github.com/SainTod/MIPicker", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true

end
