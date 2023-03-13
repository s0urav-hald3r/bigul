import 'package:bigul/config/app_constants.dart';
import 'package:bigul/config/size_configs.dart';
import 'package:bigul/screens/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/input_validators.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void handleOtpLogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) =>
                OTP(mobileNumber: phoneController.text.trim()))));
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: ((context) => const Center(
    //           child: CircularProgressIndicator(color: AppConstants.blueColor),
    //         )));
    // String phone = phoneController.text.trim();
    // if (!(_formKey.currentState!.validate())) {
    //   Get.snackbar("Error", 'Invalid Phone Number',
    //       snackPosition: SnackPosition.BOTTOM,
    //       colorText: AppConstants.blueColor);
    //   Future.delayed(
    //       const Duration(seconds: 2), (() => _formKey.currentState!.reset()));
    //   Navigator.pop(context);
    //   return;
    // }
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              padding: EdgeInsets.only(
                  top: SizeConfig.safeAreaTop!, left: 20, right: 20),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_attern.png'))),
              child: Column(
                children: [
                  const Gap(20),
                  Image.asset(
                    'assets/images/splash_logo.png',
                    width: SizeConfig.screenWidth! * 0.4,
                  ),
                  const Gap(20),
                  Image.asset('assets/images/intro_logo.png'),
                  const Gap(20),
                  Text(
                    'A Trading and Investment Ecosystem built for your Success!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: AppConstants.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const Gap(30),
                  Text(
                    'Let’s get started!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        letterSpacing: 0.75,
                        color: AppConstants.blueColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const Gap(30),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight! * 0.065,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.blueColor),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              cursorColor: AppConstants.blueColor,
                              autofocus: false,
                              maxLength: 10,
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth! * 0.04,
                                  letterSpacing: 01,
                                  fontWeight: FontWeight.w500,
                                  color: AppConstants.blackColor),
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                    height: 0,
                                    fontSize: 0,
                                    color: Colors.white),
                                hintText: 'Enter Mobile Number',
                                hintStyle: GoogleFonts.poppins(
                                  color: AppConstants.greyColor,
                                  letterSpacing: 01,
                                  fontSize: SizeConfig.screenWidth! * 0.04,
                                  fontWeight: FontWeight.w500,
                                ),
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(left: 20),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (v) {
                                if (v.length == 10) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                }
                              },
                              validator: (val) {
                                return Validators.choose('phone', val);
                              },
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => phoneController.text.isEmpty
                              ? null
                              : handleOtpLogin(),
                          child: Container(
                            width: SizeConfig.screenWidth! * 0.25,
                            height: SizeConfig.screenHeight! * 0.065,
                            margin: const EdgeInsets.all(2.5),
                            decoration: BoxDecoration(
                                color: AppConstants.blueColor,
                                border:
                                    Border.all(color: AppConstants.blueColor),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                'Get OTP',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth! * 0.2,
                          color: AppConstants.greyColor,
                          height: 1,
                        ),
                        const Gap(5),
                        Text(
                          'OR',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: AppConstants.greyColor,
                              fontWeight: FontWeight.w500),
                        ),
                        const Gap(5),
                        Container(
                          width: SizeConfig.screenWidth! * 0.2,
                          color: AppConstants.greyColor,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight! * 0.065,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5.0,
                          ),
                        ],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google_logo.png'),
                        const Gap(20),
                        Text(
                          'Sign in with Google',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              color: AppConstants.greyColor,
                              fontSize: SizeConfig.screenWidth! * 0.04,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
