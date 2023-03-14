import 'package:bigul/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../config/app_constants.dart';
import '../config/size_configs.dart';
import 'loader.dart';

class DigiLocker11 extends StatelessWidget {
  DigiLocker11({Key? key}) : super(key: key);

  final DataController _dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
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
                              Column(
                                children: [
                                  Text(
                                    'You are on Step 2 of 8',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: AppConstants.greyColor,
                                        fontSize:
                                            SizeConfig.screenWidth! * 0.04,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Gap(5),
                                  AnimatedSmoothIndicator(
                                    activeIndex: 1,
                                    count: 8,
                                    effect: WormEffect(
                                        dotColor: AppConstants.greyColor,
                                        activeDotColor: AppConstants.blueColor,
                                        dotHeight:
                                            SizeConfig.screenWidth! * 0.0175,
                                        dotWidth:
                                            SizeConfig.screenWidth! * 0.035),
                                  )
                                ],
                              ),
                              const Spacer(flex: 4)
                            ],
                          ),
                          const Gap(20),
                          Image.asset('assets/images/locker_screen_logo.png'),
                          const Gap(20),
                          Text(
                            'We need access to your Digilocker',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppConstants.blackColor,
                                fontSize: SizeConfig.screenWidth! * 0.04,
                                fontWeight: FontWeight.w700),
                          ),
                          const Gap(20),
                          Text(
                            'Digilocker automatically verifies your\ndocuments needed for KYC and\naccount opening with Bigul.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppConstants.greyColor,
                                fontSize: SizeConfig.screenWidth! * 0.0375,
                                fontWeight: FontWeight.w500),
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svgs/lock.svg'),
                              const Gap(7.5),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.5),
                                child: Text(
                                  'Don’t worry, your data is 100% safe!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: AppConstants.greenColor,
                                      fontSize:
                                          SizeConfig.screenWidth! * 0.0325,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'By tapping ‘Allow Access’, you provide consent to allow this application to access your DigiLocker.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: AppConstants.greyColor,
                                fontSize: SizeConfig.screenWidth! * 0.03,
                                fontWeight: FontWeight.w400),
                          ),
                          const Gap(20),
                          InkWell(
                            onTap: () =>
                                _dataController.fetchDigiLockerData(context),
                            child: Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight! * 0.065,
                              decoration: BoxDecoration(
                                  color: AppConstants.blueColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text(
                                  'Allow Access',
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
                    _dataController.isLoading.value
                        ? const Loader()
                        : const SizedBox()
                  ],
                ))));
  }
}
