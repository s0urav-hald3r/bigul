import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_constants.dart';
import '../config/size_configs.dart';

class DocFetch extends StatelessWidget {
  const DocFetch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! * 0.8,
      height: SizeConfig.screenHeight! * 0.401,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_attern.png'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 4),
              Column(
                children: [
                  Text(
                    'Documents fetched',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: AppConstants.blackColor,
                        fontSize: SizeConfig.screenWidth! * 0.04,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Let’s continue with the KYC journey.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: AppConstants.greyColor,
                        fontSize: SizeConfig.screenWidth! * 0.03,
                        fontWeight: FontWeight.w400),
                  ),
                ],
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
            'assets/images/data_verified.png',
            fit: BoxFit.contain,
            width: SizeConfig.screenWidth! * 0.484,
          ),
        ],
      ),
    );
  }
}
