Pod::Spec.new do |s|
  s.name = "LYMarqueeLabel"
  s.version = "1.7.2"
  s.swift_version = "4.2"
  s.summary = "文字跑马灯"
  s.homepage = "https://github.com/GordonLY/LYMarqueeLabel"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.authors = "Gordon"
  s.ios.deployment_target = "9.0"
  s.source = { :git => "https://github.com/GordonLY/LYMarqueeLabel.git", :tag => s.version }
  s.framework = "UIKit"

  s.subspec "LYMarqueeLabel" do |ss|
    ss.source_files  = "LYMarqueeLabel/*.swift"
  end
end
