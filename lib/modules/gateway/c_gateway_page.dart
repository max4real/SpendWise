import 'package:get/get.dart';
import 'package:spend_wise/modules/auth/v_login_gateway.dart';

class GatewayController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> initLoad() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Get.offAll(() => const LoginGatewayPage());
  }
}
