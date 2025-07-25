简体中文 | [English](README_EN.md) 

## FaceBeauty

### Flutter平台 快速集成

#### Flutter插件

GitHub仓库

```apl
https://github.com/FaceBeauty/FBLiveFlutter
```

#### Flutter插件集成步骤:

1. 下载FaceBeautySDK包

   - Android：


   ​	将FaceBeauty.arr文件分别放到`mt_plugin/android/libs`文件夹下和`mtcamera/android/app/libs`文件夹下。将jinLibs文件夹放到`/mt_plugin/android/src/main`文件夹下面。

   - iOS：

     将FaceBeauty.framwork文件放到`mt_plugin/ios/Vendored`文件夹下。

2. 联系FaceBeauty商务获取证书文件和资源包。

3. 将资源包中的文件放到对应的文件夹下

   - Android：

     将资源文件放到`mt_plugin/android/src/main/assets/fbeffect`文件夹下。

   - iOS：

     将资源文件FaceBeauty.bundle放到`mt_plugin/ios/Vendored`文件夹下。

4. 在Android Studio中打开示例项目FaceBeautyFultter

5. 在pubspec.yaml所处的文件夹下执行flutter命令`flutter pub get`获取依赖。

6. 将Android和iOS的包名和应用名替换成用户对应的包名和应用名。

7. 添加key

   - Android：

     打开`mt_plugin/android/src/main/kotlin/com/toivan/mtcamera/mt_plugin/MtPlugin.kt`文件，将`<YOUR_APP_ID>`替换成你的App ID。

     ```
     FBEffect.shareInstance().initFaceBeauty(it, "<YOUR_APP_ID>", object : FBEffect.InitCallback {
                             override fun onInitSuccess() = Unit
                             override fun onInitFailure() = Unit
                         })
     ```

   - iOS：

     打开`mcamera/ios/Runner/IOSFlutterView.m`文件，将`<YOUR_APP_ID>`替换成你的App ID。App ID需要联系FaceBeauty商务获取

     ```
     [[FaceBeauty shareInstance] initFaceBeauty:@"<YOUR_APP_ID>" withDelegate:self];
     ```

8. 连接Android或iOS真机（非模拟器），运行项目。
