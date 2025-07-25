[简体中文](README.md)| English

## FaceBeauty

### Quick Integration on Flutter Platform

#### Flutter Plugin

GitHub Repository

```apl
https://github.com/FaceBeauty/FBLiveFlutter
```

#### Steps for Integrating the Flutter Plugin:

1. Download the FaceBeauty SDK package

   - Android：


   	Place the `FaceBeauty.aar` file in the `mt_plugin/android/libs` folder and the `mtcamera/android/app/libs` folder respectively. Place the `jniLibs` folder under the `/mt_plugin/android/src/main` folder.

   - iOS：

     Place the `FaceBeauty.framework` file in the `mt_plugin/ios/Vendored` folder.

2. Contact FaceBeauty's business team to obtain the certificate file and resource package.

3. Place the files in the resource package in the corresponding folders.

   - Android：

     Place the resource files in the `mt_plugin/android/src/main/assets/fbeffect` folder.

   - iOS：

     Place the resource file `FaceBeauty.bundle` in the `mt_plugin/ios/Vendored` folder.

4. Open the sample project `FaceBeautyFlutter` in Android Studio.

5. Execute the Flutter command `flutter pub get` in the folder where `pubspec.yaml` is located to get the dependencies.

6. Replace the Android and iOS package names and app names with the corresponding ones of the user.

7. Add the key.

   - Android：

     Open the `mt_plugin/android/src/main/kotlin/com/toivan/mtcamera/mt_plugin/MtPlugin.kt` file and replace `<YOUR_APP_ID>` with your App ID.

     ```
     FBEffect.shareInstance().initFaceBeauty(it, "<YOUR_APP_ID>", object : FBEffect.InitCallback {
                             override fun onInitSuccess() = Unit
                             override fun onInitFailure() = Unit
                         })
     ```

   - iOS：

     Open the `mcamera/ios/Runner/IOSFlutterView.m` file and replace `<YOUR_APP_ID>` with your App ID. The App ID needs to be obtained by contacting FaceBeauty's business team.

     ```
     [[FaceBeauty shareInstance] initFaceBeauty:@"<YOUR_APP_ID>" withDelegate:self];
     ```

8. Connect an Android or iOS physical device (not an emulator) and run the project.
