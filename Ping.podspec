
Pod::Spec.new do |spec|

  spec.name         = "Ping"
  spec.version      = "0.0.1"
  spec.summary      = "Ping is the avatar generator for Echo Blockchain accounts by him username."

  spec.description  = <<-DESC
Ping is the avatar generator for Echo Blockchain accounts by him username. Each Echo Blockchain account has its own unique avatar. Ping will help you get it.
                   DESC

  spec.homepage     = "https://gitlab.pixelplex.by/650_ECHO_Mobile_Wallet/libraries/echo-ios-ping.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Pixelplex Developer" => "e.grigorovich@pixelplex.io" }

  spec.ios.deployment_target = "9.0"
  spec.swift_version = "4.0"

  spec.source        = { :git => "https://gitlab.pixelplex.by/650_ECHO_Mobile_Wallet/libraries/echo-ios-ping.git", :tag => "#{spec.version}" }
  spec.source_files  = "Ping/**/*.{h,m,swift}"

end