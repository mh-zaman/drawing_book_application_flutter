import 'package:flutter/material.dart';

import '../../../configs/responsive_config.dart';
import '../../../helpers/constants/constants.dart';
import '../enums/canvas_type.dart';
import 'shared/drawing_canvas.dart';

class MobileWidget extends StatelessWidget {
  const MobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: defaultBorderRadius,
        border: Border.all(color: kPrimaryColor, width: 2.0),
      ),
      child: DrawingCanvas(
        height: size.height,
        width: Responsive.isMobile(context) ? size.width : size.width - 300,
        canvasType: CanvasType.equation,
      ),
    );
  }
}
