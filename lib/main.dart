import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:tutorheaven/routes/approutes.dart';

Future<void> main() async {
  // https://www.youtube.com/watch?v=YjFJ0WjTVTA
  WidgetsFlutterBinding.ensureInitialized();

  Get.reset();
  await dotenv.load(fileName: '.env');

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/splash',
    getPages: AppRoutes.routes,
  ));
}
