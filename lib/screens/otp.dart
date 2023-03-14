import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../config/app_constants.dart';
import '../config/size_configs.dart';
import '../controllers/auth_controller.dart';
import '../controllers/time_controller.dart';
import 'loader.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key, required this.mobileNumber}) : super(key: key);
  final String mobileNumber;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  NumberFormat formatter = NumberFormat("00");
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  final TimeController _timeController = Get.put(TimeController());
  final AuthController _authController = Get.find<AuthController>();
  bool isOTPfilled = false;

  @override
  void initState() {
    _timeController.startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timeController.stopTimer();
    super.dispose();
  }

  void otpLogin() {
    String otp = otpController.text;
    if (otp.length != 6) {
      errorController.add(ErrorAnimationType.shake);
      return;
    }
    _authController.verifyOtp(widget.mobileNumber, otp, context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Obx(() => Stack(
                  children: [
                    Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        padding: EdgeInsets.only(
                            top: SizeConfig.safeAreaTop!, left: 20, right: 20),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/bg_attern.png'))),
                        child: Column(children: [
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/logo.png'),
                              const Spacer(flex: 3),
                              Text(
                                'Mobile Verification',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: AppConstants.greyColor,
                                    fontSize: SizeConfig.screenWidth! * 0.04,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(flex: 4)
                            ],
                          ),
                          const Gap(20),
                          Image.asset('assets/images/otp_screen_logo.png'),
                          const Gap(20),
                          Text(
                            'Verification',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppConstants.blackColor,
                                fontSize: SizeConfig.screenWidth! * 0.04,
                                fontWeight: FontWeight.w700),
                          ),
                          const Gap(10),
                          Text(
                            'Enter the 6 digit OTP sent to',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppConstants.greyColor,
                                fontSize: SizeConfig.screenWidth! * 0.0375,
                                fontWeight: FontWeight.w500),
                          ),
                          const Gap(2.5),
                          Text(
                            '+91 ${widget.mobileNumber}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppConstants.blackColor,
                                fontSize: SizeConfig.screenWidth! * 0.04,
                                fontWeight: FontWeight.w500),
                          ),
                          const Gap(10),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Edit Mobile Number',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: AppConstants.blueColor,
                                  decoration: TextDecoration.underline,
                                  fontSize: SizeConfig.screenWidth! * 0.035,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const Gap(40),
                          PinCodeTextField(
                            keyboardType: TextInputType.number,
                            appContext: context,
                            length: 6,
                            obscureText: false,
                            cursorColor: AppConstants.blackColor,
                            cursorHeight: 20,
                            textStyle: GoogleFonts.poppins(
                                color: AppConstants.blackColor,
                                fontWeight: FontWeight.w700),
                            animationType: AnimationType.slide,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldOuterPadding: EdgeInsets.zero,
                                fieldWidth: SizeConfig.screenWidth! * 0.13,
                                fieldHeight: SizeConfig.screenWidth! * 0.15,
                                borderWidth: 1,
                                activeColor: AppConstants.blueColor,
                                inactiveColor: AppConstants.blackColor,
                                selectedColor: AppConstants.blueColor,
                                selectedFillColor: Colors.white,
                                activeFillColor: Colors.white,
                                inactiveFillColor: Colors.white),
                            autoFocus: false,
                            animationDuration:
                                const Duration(milliseconds: 100),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: otpController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onCompleted: (v) {
                              debugPrint("Completed: $v");
                            },
                            onChanged: (value) {
                              if (value.length == 6) {
                                setState(() {
                                  isOTPfilled = true;
                                });
                              }
                              debugPrint('OnChanged: $value');
                            },
                          ),
                          const Gap(20),
                          Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${formatter.format(_timeController.minute)} : ${formatter.format(_timeController.second)}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: AppConstants.greyColor,
                                        fontSize:
                                            SizeConfig.screenWidth! * 0.035,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Gap(10),
                                  InkWell(
                                    onTap: () {
                                      if (_timeController.isTimerStop) {
                                        _timeController.startTimer();
                                        _authController
                                            .resendOtp(widget.mobileNumber);
                                      } else {
                                        null;
                                      }
                                    },
                                    child: Text(
                                      'Resend OTP',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          decoration: TextDecoration.underline,
                                          color: _timeController.isTimerStop
                                              ? AppConstants.blueColor
                                              : AppConstants.greyColor,
                                          fontSize:
                                              SizeConfig.screenWidth! * 0.035,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )),
                          const Spacer(),
                          InkWell(
                            onTap: () =>
                                otpController.text.isEmpty ? null : otpLogin(),
                            child: Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight! * 0.065,
                              decoration: BoxDecoration(
                                  color: isOTPfilled
                                      ? AppConstants.blueColor
                                      : AppConstants.greyColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text(
                                  'Verify Mobile Number',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: SizeConfig.screenWidth! * 0.04,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          const Gap(20),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Back',
                              style: GoogleFonts.poppins(
                                  color: AppConstants.blackColor,
                                  fontSize: SizeConfig.screenWidth! * 0.04,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Gap(20),
                        ])),
                    _authController.isLoading.value
                        ? const Loader()
                        : const SizedBox()
                  ],
                ))));
  }
}
