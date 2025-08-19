import 'dart:io';

import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class CameraController extends GetxController {
  late final RtcEngine engine;

  final isJoined = false.obs;
  final remoteUid = <int>[].obs;
  final MethodChannel _channel = const MethodChannel("beauty_plugin");

// 新增：存储当前帧图像
  final _frameImage = Rxn<ui.Image>();
  ui.Image? get frameImage => _frameImage.value;

  @override
  void onInit() {
    super.onInit();
    initAgora();
    print("🎯 进入相机页面");
  }

  void checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('www.baidu.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('✅ 网络正常');
      } else {
        print('❌ 无网络连接');
      }
    } catch (e) {
      print('❌ 网络错误: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
    // _channel.setMethodCallHandler(_handleNativeMethod);
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }
  Future<void> _dispose() async {
    // await engine.leaveChannel();
    // await engine.release();
  }

  Future<void> initAgora() async  {

}


  Future<void> _handleNativeMethod(MethodCall call) async {
    if (call.method == "onFrame") {
      try {
        final Map<dynamic, dynamic> args = call.arguments;
        Uint8List bytes = args['bytes'];
        int width = args['width'];
        int height = args['height'];
        int stride = args['stride'];
        // int format = args['format'];

        // ⚠️ 校验内存长度
        if (bytes.length != stride * height) {
          print("❌ 内存大小不合法: ${bytes.length} vs ${stride * height}");
          return;
        }

      } catch (e, stack) {
        print("❌ pushVideoFrame 失败: $e");
        print("Stack: $stack");
      }

    }
  }


  @override
  void onClose() {}


}
