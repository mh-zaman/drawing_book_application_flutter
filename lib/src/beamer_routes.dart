import 'package:beamer/beamer.dart'
    show
        BeamGuard,
        BeamPage,
        BeamPageType,
        BeamerDelegate,
        RoutesLocationBuilder;
import 'package:flutter/widgets.dart' show ValueKey;

import 'app_routes.dart' show AppRoutes;
import 'helpers/constants/constants.dart' show appTitle, isMaintenanceBreak;
import 'modules/drawing_board/drawing_board.dart';
import 'shared/page_not_found/page_not_found.dart' show KPageNotFound;

final routerDelegate = BeamerDelegate(
  initialPath: AppRoutes.homeRoute,
  notFoundPage: const BeamPage(
    title: 'Page not found',
    child: KPageNotFound(error: '404 - Page not found!'),
  ),
  locationBuilder: RoutesLocationBuilder(
    routes: {
      AppRoutes.homeRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.homeRoute),
          title: appTitle,
          type: BeamPageType.slideRightTransition,
          child: DrawingBoard(),
        );
      },
    },
  ).call,
  guards: [
    BeamGuard(
      pathPatterns: [
        // .../
      ],
      check: (_, __) => !isMaintenanceBreak,
      beamToNamed: (_, __) => AppRoutes.homeRoute,
    ),
  ],
);
