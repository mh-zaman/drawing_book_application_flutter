import 'dart:async';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../helpers/constants/constants.dart';
import '../../../../localization/loalization.dart';
import '../../enums/drawing_enums.dart';
import '../../providers/canvas_pd.dart';
import 'icon_box.dart';

class CanvasSideBar extends ConsumerWidget {
  const CanvasSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: 300,
        height: size.height,
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10),
          children: [
            Text(
              t!.tools,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 5,
              runSpacing: 5,
              children: [
                IconBox(
                  iconData: FontAwesomeIcons.pencil,
                  selected:
                      ref.watch(drawingModeProvider) == DrawingMode.pencil,
                  onTap: () => ref
                      .read(drawingModeProvider.notifier)
                      .update((_) => DrawingMode.pencil),
                  tooltip: t!.pencil,
                ),
                IconBox(
                  iconData: FontAwesomeIcons.eraser,
                  selected:
                      ref.watch(drawingModeProvider) == DrawingMode.eraser,
                  onTap: () => ref
                      .read(drawingModeProvider.notifier)
                      .update((_) => DrawingMode.eraser),
                  tooltip: t!.eraser,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              t!.size,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    t!.strokeSize,
                    style: const TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.w600),
                  ),
                  Slider(
                    activeColor: kPrimaryColor,
                    inactiveColor: kPrimaryColor.withOpacity(0.5),
                    value: ref.watch(strokeSizeProvider),
                    min: 0,
                    max: 50,
                    onChanged: (val) => ref
                        .read(strokeSizeProvider.notifier)
                        .update((_) => val.roundToDouble()),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    t!.eraserSize,
                    style: const TextStyle(
                        fontSize: 13.0, fontWeight: FontWeight.w600),
                  ),
                  Slider(
                    activeColor: kPrimaryColor,
                    inactiveColor: kPrimaryColor.withOpacity(0.5),
                    value: ref.watch(eraserSizeProvider),
                    min: 0,
                    max: 80,
                    onChanged: (val) => ref
                        .read(eraserSizeProvider.notifier)
                        .update((_) => val.roundToDouble()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              t!.actions,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      canClearCanvas(ref) ? kSecondaryColor : kFadeTextColor,
                    ),
                  ),
                  onPressed:
                      canClearCanvas(ref) ? () => clearCanvas(ref) : null,
                  child: Text(
                    t!.clear,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      canClearCanvas(ref) || ref.watch(scorePd) != 0
                          ? kSecondaryColor
                          : kFadeTextColor,
                    ),
                  ),
                  onPressed: canClearCanvas(ref) || ref.watch(scorePd) != 0
                      ? () => resetCanvas(ref)
                      : null,
                  child: Text(
                    t!.reset,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // TextButton(
                //   style: ButtonStyle(
                //     foregroundColor: MaterialStateProperty.all(kSecondaryColor),
                //   ),
                //   child: Text(
                //     t!.showOnGithub,
                //     style: const TextStyle(fontWeight: FontWeight.bold),
                //   ),
                //   onPressed: () => _launchUrl(kGithubRepo),
                // ),
              ],
            ),
            const SizedBox(height: 10),
            // Row(
            //   mainAxisSize: mainMin,
            //   children: [
            //     Text(locales == Locales.english
            //         ? 'Language Change to Bangla'
            //         : 'ভাষা পরিবর্তন করুন'),
            //     const SizedBox(width: 20),
            //     Switch(
            //       value: locales == Locales.bengali,
            //       onChanged: (_) async {
            //         await changeLocale(
            //           ref,
            //           localeType == Locales.english
            //               ? Locales.bengali
            //               : Locales.english,
            //         );
            //       },
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
            //   ),
            //   onPressed: () {
            //     Beamer.of(context).beamToNamed(AppRoutes.dataCollectRoute);
            //     printUrlHistory(context);
            //   },
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            //     child: Text(
            //       t!.contributeData,
            //       style: const TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50),
            // const KFooterWidget(),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
