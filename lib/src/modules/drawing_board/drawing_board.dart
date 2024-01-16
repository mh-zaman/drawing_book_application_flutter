import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../configs/responsive_config.dart';
import '../../helpers/constants/constants.dart';
import '../../localization/loalization.dart';
import 'components/desktop_widget.dart';
import 'components/mobile_widget.dart';
import 'components/shared/canvas_side_bar.dart';
import 'components/shared/show_customized_alert_dialog.dart';
import 'functions/drawing_canvas_functions.dart';
import 'providers/canvas_pd.dart';

class DrawingBoard extends ConsumerWidget {
  const DrawingBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    t = AppLocalizations.of(context);
    // ref.watch(localeConfigProvider);
    final score = ref.watch(scorePd);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kCanvasColor,
        elevation: 1.0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              t!.drawHere,
              style: const TextStyle(
                color: kTextColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              t!.developingMessage,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisAlignment: mainCenter,
            children: [
              Row(
                children: [
                  Text(
                    t!.score,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 3.0),
                  Text(
                    score.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: score < 0 ? Colors.red : Colors.green,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                ],
              ),
            ],
          ),
        ],
      ),
      drawer: Responsive.isMobile(context)
          ? const Drawer(child: CanvasSideBar())
          : null,
      body: const Responsive(
        mobile: MobileWidget(),
        desktop: DesktopWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Predict'),
        icon: const Icon(Icons.check),
        onPressed: () async {
          await predict(ref).then((res) async {
            if (res != null) {
              debugPrint("Result From Api : $res");
              // ignore: use_build_context_synchronously
              await showCustomizedAlertDialog(context, res, ref);
            }
          });
        },
      ),
    );
  }
}