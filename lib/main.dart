import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/routes/route_helper.dart';

import 'helper/dependencies.dart' as dep;

// Untuk naikan version cukup via file pubspec.yaml saja

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: 'Rumah Kreatif Toba',
      // home: PembelianPage(),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
