import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../utils/constants/images.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.01),
        Image.asset(Images.logo, width: height * 0.2),
        SizedBox(height: height * 0.01),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                'Chef Brand Version ${snapshot.data!.version}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              );
            } else {
              return Text(
                'Chef Brand Version Loading...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              );
            }
          },
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }
}
