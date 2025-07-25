### FaceBeautysFlutter

#### 运行步骤

1、克隆仓库

```apl

```

2、下载FaceBeautySDK包

​	Android：

​		将FaceBeauty.arr文件分别放到`mt_plugin/android/libs`文件夹下和`mtcamera/android/app/libs`文件夹下。

​		将jinLibs文件夹放到`/mt_plugin/android/src/main`文件夹下面。

​	iOS：

​		将FaceBeauty.framwork文件放到`mt_plugin/ios/Vendored`文件夹下。

3、联系FaceBeauty商务获取证书文件和资源包。

4、将资源包中的文件放到对应的文件夹下

​	Android：

​		将资源文件放到`mt_plugin/android/src/main/assets/fbeffect`文件夹下。

​	iOS：

​		将资源文件FaceBeauty.bundle放到`mt_plugin/ios/Vendored`文件夹下。

5、在Android Studio中打开示例项目FaceBeautyFultter。

6、在pubspec.yaml所处的文件夹下执行flutter命令`flutter pub get`获取依赖。

7、将Android和iOS的包名和应用名替换成用户对应的包名和应用名。

8、添加key

​	Android：

​		打开`mt_plugin/android/src/main/kotlin/com/toivan/mtcamera/mt_plugin/MtPlugin.kt`文件，将`<YOUR_APP_ID>`替换成你的App ID。

```kotlin
FBEffect.shareInstance().initFaceBeauty(it, "<YOUR_APP_ID>", object : FBEffect.InitCallback {
                        override fun onInitSuccess() = Unit
                        override fun onInitFailure() = Unit
                    })
```

​	iOS：

​		打开`mcamera/ios/Runner/IOSFlutterView.m`文件，将`<YOUR_APP_ID>`替换成你的App ID。App ID需要联系FaceBeauty商务获取。

```objective-c
[[FaceBeauty shareInstance] initFaceBeauty:@"<YOUR_APP_ID>" withDelegate:self];
```

9、连接Android或iOS真机（非模拟器），运行项目。