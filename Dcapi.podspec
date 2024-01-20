Pod::Spec.new do |spec|
    spec.name         = "Dcapi"
    spec.version      = "0.0.3"
    spec.summary      = "A brief description of Dcapi project."
    spec.description  = <<-DESC
    An extended description of Dcapi project.
    DESC
    spec.homepage     = "http://your.homepage/here"
    spec.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2020
                   Permission is granted to...
                  LICENSE
                }
    spec.author             = { "王琴" => "752935464@qq.com" }

    spec.source       = { 
        :git => "https://codeup.aliyun.com/5efc30990e73ad738218a97c/bn/Dcapi.xcframework.git",
        # :git => "https://codeup.aliyun.com/5efc30990e73ad738218a97c/bn/Dcapi.framework.git",
        :branch => "master",
        # :submodules => "Dcapi.framework"
      }
  
    spec.vendored_frameworks = "Dcapi.xcframework"
    spec.libraries = 'resolv'
    spec.platform = :ios
    spec.ios.deployment_target  = '12.4'
    # spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
    # spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
    spec.header_dir = 'Dcapi'
    spec.pod_target_xcconfig = { 
        'VALID_ARCHS' => 'arm64',
        'VALID_ARCHS[sdk=iphonesimulator*]' => '' 
      }
    spec.user_target_xcconfig = { 'VALID_ARCHS' => 'arm64','VALID_ARCHS[sdk=iphonesimulator*]' => '' }
end
