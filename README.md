发布pod依赖
  参考：https://anuragajwani.medium.com/how-to-distribute-compiled-static-frameworks-via-cocoapods-817a4c57cb10


1. 创建Dcapi.xcframework文件夹，存放Dcapi.xcframework，同步上传git
2. 创建DcapiPod文件夹，同步上传git
  2.1 添加到本地pod库关联git
    pod repo add pod名 git路径
      eg: pod repo add DcapiPod https://codeup.aliyun.com/5efc30990e73ad738218a97c/bn/DcapiPod.git
  2.2 创建Dcapi.podspec文件（在DcapiPod文件夹里），配置第三方代码库
      cat > Dcapi.podspec <<-EOF
        Pod::Spec.new do |s|
            s.name         = "Dcapi"
            s.version      = "0.0.4"
            s.summary      = "A brief description of Dcapi project."
            s.description  = <<-DESC
            An extended description of Dcapi project.
            DESC
            s.homepage     = "http://your.homepage/here"
            s.license = { :type => 'Copyright', :text => <<-LICENSE
                          Copyright 2020
                          Permission is granted to...
                          LICENSE
                        }
            s.author             = { "$(git config user.name)" => "$(git config user.email)" }
            s.source       = { :git => "https://codeup.aliyun.com/5efc30990e73ad738218a97c/bn/Dcapi.xcframework.git", :tag => "#{s.version}"， :branch => "master" }
            s.vendored_frameworks = "Dcapi.xcframework"
            spec.libraries = 'resolv'
            s.platform = :ios
            s.swift_version = "5.2"
            s.ios.deployment_target  = '12.4'
            spec.header_dir = 'Dcapi'
            spec.pod_target_xcconfig = { 
                'VALID_ARCHS' => 'arm64',
                'VALID_ARCHS[sdk=iphonesimulator*]' => '' 
              }
            spec.user_target_xcconfig = { 'VALID_ARCHS' => 'arm64','VALID_ARCHS[sdk=iphonesimulator*]' => '' }
        end
        EOF
      最终配置信息结果
        Pod::Spec.new do |spec|
        spec.name         = "Dcapi"
        spec.version      = "0.0.1"
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
  2.3 发布到
    pod repo push pod库名 podspec文件
    eg: pod repo push DcapiPod Dcapi.podspec
  2.4 同步git后，最终会得到文件（Dcapi/0.0.1/Dcapi.podspec是同步下来的）
    DcapiPod/Dcapi/0.0.1/Dcapi.podspec
3. 使用
  3.1 podfile文件里添加：
    pod 'Dcapi', :source => 'https://codeup.aliyun.com/5efc30990e73ad738218a97c/bn/DcapiPod.git'
  3.2 执行命令，下载包
    pod install 
  3.3 在具体的java里引入
    #import <Dcapi/Dcapi.h>
