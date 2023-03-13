import 'dart:async';
import 'package:get/state_manager.dart';

class OtpCountDownTimer extends GetxController {
  RxInt min = 00.obs;
  RxInt sec = 29.obs;

  Timer? _timer;

  int get minute => min.value;

  int get second => sec.value;

  void startTimer() {
    min.value = 00;
    sec.value = 29;

    _timer == null ? null : _timer!.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (sec > 00) {
        sec = sec - 1;
      } else if (min.value == 0 && sec.value == 0) {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    min.value = 00;
    sec.value = 00;
  }

  bool get isTimerStop => min.value == 0 && sec.value == 0;
}
