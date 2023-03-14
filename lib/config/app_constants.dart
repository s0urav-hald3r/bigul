import 'package:flutter/material.dart';

class AppConstants {
  // Custom colors
  static const blueColor = Color(0xFF5367FC);
  static const greyColor = Color(0xFF9E9E9E);
  static const blackColor = Color(0xFF231F20);
  static const greenColor = Color(0xFF008490);

  //API endpoints
  static String baseUrl = "https://bigul.app/api/";

  static const mobileLogin = "login-signup";
  static const resendOtp = "resend-otp";
  static const verifyOtp = "verify-otp";

  static const sendVerificationEmail = "send-verification-email";
}
