Pod::Spec.new do |s|
  s.name             = "DTXcodeUtils"
  s.version          = "0.1.1"
  s.summary          = "Useful helper functions for writing Xcode plugins"
  s.homepage         = "https://github.com/thurn/DTXcodeUtils"
  s.license          = 'Creative Commons Zero'
  s.author           = { "Derek Thurn" => "derek@fake.email" }
  s.source           = { :git => "https://github.com/thurn/DTXcodeUtils.git", :tag => s.version.to_s }

  s.platform     = :osx
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}', 'Pod/XcodeHeaders/**/*.h'
end
