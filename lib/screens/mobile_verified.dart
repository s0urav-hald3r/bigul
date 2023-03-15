import 'package:bigul/screens/digilocker_1_1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_constants.dart';
import '../config/size_configs.dart';

class MobileVerified extends StatelessWidget {
  const MobileVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! * 0.8,
      height: SizeConfig.screenHeight! * 0.4,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_attern.png'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Spacer(flex: 4),
              Text(
                'Mobile Number Verified',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: AppConstants.blackColor,
                    fontSize: SizeConfig.screenWidth! * 0.04,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(flex: 3),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: AppConstants.greyColor,
                ),
              )
            ],
          ),
          Image.asset(
            'assets/images/mobile_verified.png',
            fit: BoxFit.contain,
            width: SizeConfig.screenWidth! * 0.484,
          ),
        ],
      ),
    );
  }
}
