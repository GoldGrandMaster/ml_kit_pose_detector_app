import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
// import 'app/modules/home/views/components/indicator.dart';
import 'app/routes/app_pages.dart';
// import 'package:percent_indicator/percent_indicator.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
