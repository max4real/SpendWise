import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/gateway/v_gateway_page.dart';
import '_servies/theme_services/c_theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    injectDependencies();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'max notes',
      useInheritedMediaQuery: true,
      locale: const Locale('en', 'EN'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const GatewayPage(),
    );
  }

  void injectDependencies() {
    Get.put(ThemeController());
  }
}
