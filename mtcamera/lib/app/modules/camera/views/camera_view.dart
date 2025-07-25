import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mt_plugin/components/mt_beauty_panel/view.dart';

import '../controllers/camera_controller.dart';


///相机View
class CameraView extends GetView<CameraController> {

  @override
  Widget build(BuildContext context) {
    return MtBeautyPanelContainer();
  }

}
