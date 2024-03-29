import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Colors,
        Column,
        FontWeight,
        MediaQuery,
        Scaffold,
        StatelessWidget,
        Text,
        TextAlign,
        TextStyle,
        Widget;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../../helpers/constants/constants.dart' show mainCenter, mainMin;

class KErrorWidget extends StatelessWidget {
  const KErrorWidget({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: mainCenter,
          mainAxisSize: mainMin,
          children: [
            SvgPicture.asset(
              'assets/svgs/error.svg',
              height: size.height * 0.35,
              width: size.width * 0.35,
            ),
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
