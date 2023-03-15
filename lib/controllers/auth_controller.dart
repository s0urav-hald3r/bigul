// ignore_for_file: use_build_context_synchronously

import 'package:bigul/screens/digilocker_1_1.dart';
import 'package:bigul/screens/email_verified.dart';
import 'package:bigul/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_constants.dart';
import '../screens/mobile_verified.dart';
import '../service/exception.dart';
import '../service/services.dart';

class AuthController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  RxBool isLoading = false.obs;

  sendOtp(String mobile) async {
    isLoading.value = true;
    try {
      dynamic response = await _apiProvider.post(
        AppConstants.baseUrl + AppConstants.mobileLogin,
        {"mobile": mobile, "mx_Source_URL": "bigul.app"},
      );
      if (response != null) {
        Get.to(OTP(mobileNumber: mobile));
      }
    } catch (e) {
      if (e is CustomException) {
        Get.snackbar(
          "Error",
          e.getMessage(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  resendOtp(String mobile) async {
    isLoading.value = true;
    try {
      await _apiProvider.post(
        AppConstants.baseUrl + AppConstants.resendOtp,
        {
          "mobile": mobile,
          "email": "shoaibquraishi1@gmail.com",
          "type": "email"
          // In the resend OTP API, their are no need for email & type field. But as these are required fields, so that I have to add those static paramater as mentioned in the Postman collection
        },
      );
    } catch (e) {
      if (e is CustomException) {
        Get.snackbar(
          "Error",
          e.getMessage(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  verifyOtp(String mobile, String otp, BuildContext context) async {
    isLoading.value = true;
    try {
      dynamic response = await _apiProvider.post(
        AppConstants.baseUrl + AppConstants.verifyOtp,
        {"mobile": mobile, "motp": otp},
      );
      if (response != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Dialog(
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: MobileVerified(),
                ));
        Future.delayed(
            const Duration(seconds: 2),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => DigiLocker11()),
                (route) => false));
      }
    } catch (e) {
      if (e is CustomException) {
        Get.snackbar(
          "Error",
          e.getMessage(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  sendVerificationEmail(String email, BuildContext context) async {
    isLoading.value = true;
    try {
      dynamic response = await _apiProvider.post(
        AppConstants.baseUrl + AppConstants.sendVerificationEmail,
        {"mobile": 7566643335, "email": email},
        // In the send verification email API, their is no need for mobile field. But as this is required fields, so that I have to add this static paramater as mentioned in the Postman collection
      );
      if (response != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Dialog(
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: EmailVerified(),
                ));
      }
    } catch (e) {
      if (e is CustomException) {
        Get.snackbar(
          "Error",
          e.getMessage(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
