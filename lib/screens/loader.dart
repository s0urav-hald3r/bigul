import 'package:flutter/material.dart';

import '../config/app_constants.dart';
import '../config/size_configs.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      color: Colors.black26,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppConstants.blueColor,
        ),
      ),
    );
  }
}
