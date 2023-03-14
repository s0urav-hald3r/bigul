import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_constants.dart';
import '../config/size_configs.dart';
import '../controllers/auth_controller.dart';
import '../utils/input_validators.dart';
import 'loader.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  TextEditingController emailController = TextEditingController();
  bool isEmailfilled = false;
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find<AuthController>();

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
                                'Email Verification',
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
                          Image.asset('assets/images/email_screen_logo.png'),
                          const Gap(20),
                          Text(
                            'Email Address',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppConstants.blackColor,
                                fontSize: SizeConfig.screenWidth! * 0.04,
                                fontWeight: FontWeight.w700),
                          ),
                          const Gap(20),
                          Text(
                            'Enter your Email. We will send you a link which you can verify even later!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppConstants.greyColor,
                                fontSize: SizeConfig.screenWidth! * 0.0375,
                                fontWeight: FontWeight.w500),
                          ),
                          const Gap(30),
                          Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight! * 0.065,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppConstants.blueColor),
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IntrinsicWidth(
                                  child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      cursorColor: AppConstants.blueColor,
                                      autofocus: false,
                                      controller: emailController,
                                      maxLength: 30,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.screenWidth! * 0.04,
                                          letterSpacing: 01,
                                          fontWeight: FontWeight.w500,
                                          color: AppConstants.blackColor),
                                      decoration: InputDecoration(
                                        errorStyle: const TextStyle(
                                            height: 0,
                                            fontSize: 0,
                                            color: Colors.white),
                                        hintText: 'Enter Email Address',
                                        hintStyle: GoogleFonts.poppins(
                                          color: AppConstants.greyColor,
                                          letterSpacing: 01,
                                          fontSize:
                                              SizeConfig.screenWidth! * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        counterText: '',
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        isDense: true,
                                      ),
                                      onChanged: (v) {
                                        if (v.isNotEmpty) {
                                          setState(() {
                                            isEmailfilled = true;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return Validators.choose('email', val);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => emailController.text.isEmpty
                                ? null
                                : _authController.sendVerificationEmail(
                                    emailController.text.trim(), context),
                            child: Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight! * 0.065,
                              decoration: BoxDecoration(
                                  color: isEmailfilled
                                      ? AppConstants.blueColor
                                      : AppConstants.greyColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text(
                                  'Send Link',
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
