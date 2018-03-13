Pod::Spec.new do |s|
  s.name             = "ELBibles"
  s.version          = "1.0.1"
  s.summary          = "ELBibles models a set of Holy Bibles."
  s.description      = <<-DESC
ELBibles models the Holy Bibles as Objective C objects
DESC
  s.homepage         = "https://github.com/eddy-lau/ELBibles"
  s.license          = 'MIT'
  s.author           = { "Eddie Lau" => "eddie@touchutility.com" }
  s.source           = { :git => "https://github.com/eddy-lau/ELBibles.git", :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'ELBibles/Classes/**/*'
#  s.resource_bundles = {
#    'ELBibles' => ['ELBibles/Assets/*.png']
#  }
  s.dependency 'SQLiteDatabase'
end
