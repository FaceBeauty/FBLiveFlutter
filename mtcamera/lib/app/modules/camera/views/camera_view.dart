import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mt_plugin/components/mt_beauty_panel/view.dart';

import '../controllers/camera_controller.dart';
import 'dart:ui' as ui;
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

///相机View
class CameraView extends GetView<CameraController> {

  @override
  Widget build(BuildContext context) {
    print('CameraView controller: $controller');
    return Scaffold(
      body: Stack(
        children: [
          MtBeautyPanelContainer(),
        ],
      ),
    );
  }

}
class _ImagePainter extends CustomPainter {
  final ui.Image image;
  _ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();
    final scale = (size.width / imageWidth).clamp(0.0, 1.0);

    final drawWidth = imageWidth * scale;
    final drawHeight = imageHeight * scale;
// 旋转中心设为左上角，先平移画布到右上角，再逆时针旋转90度
    canvas.save();
    canvas.translate(drawWidth, 0);
    canvas.rotate(90 * 3.1415926 / 180);
    final src = Rect.fromLTWH(0, 0, imageWidth, imageHeight);
    final dst = Rect.fromLTWH(0, 0, drawWidth, drawHeight);

    canvas.drawImageRect(image, src, dst, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ImagePainter oldDelegate) => oldDelegate.image != image;
}