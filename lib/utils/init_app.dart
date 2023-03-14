import 'package:bigul/controllers/auth_controller.dart';
import 'package:bigul/controllers/time_controller.dart';
import 'package:get/get.dart';

initApp() async {
  Get.lazyPut(() => TimeController(), fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);
}
