import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../helpers/constants/constants.dart';
import '../enums/canvas_type.dart';
import '../enums/drawing_enums.dart';
import '../models/sketch.dart';

final canvasGlobalKeyProvider = Provider.family<GlobalKey, String>((_, __) => GlobalKey());

final selectedColorProvider = StateProvider<Color>((_) => Colors.black);
final strokeSizeProvider = StateProvider<double>((_) => 10.0);
final eraserSizeProvider = StateProvider<double>((_) => 30.0);

final drawingModeProvider = StateProvider<DrawingMode>((_) => DrawingMode.pencil);
final scorePd = StateProvider<int>((_) => 0);

final currentSketchProvider = StateProvider.family<Sketch?, String>((_, __) => null);
final allSketchesProvider = StateProvider.family<List<Sketch>, String>((_, __) => []);
final redoSketchesProvider = StateProvider<List<Sketch>>((_) => []);

final lastCanvasChangedProvider = StateProvider<CanvasType?>((_) => null);

bool canClearCanvas(WidgetRef ref) {
  final equSketches = ref.watch(allSketchesProvider(equCanvasKey));
  final ansSketches = ref.watch(allSketchesProvider(ansCanvasKey));
  return equSketches.isNotEmpty || ansSketches.isNotEmpty;
}

void clearCanvas(WidgetRef ref) {
  ref.read(allSketchesProvider(equCanvasKey).notifier).update((_) => []);
  ref.read(allSketchesProvider(ansCanvasKey).notifier).update((_) => []);
  ref.read(redoSketchesProvider.notifier).update((_) => []);
  ref.read(currentSketchProvider(equCanvasKey).notifier).update((_) => null);
  ref.read(currentSketchProvider(ansCanvasKey).notifier).update((_) => null);
}

void resetCanvas(WidgetRef ref) {
  clearCanvas(ref);
  ref.read(scorePd.notifier).update((_) => 0);
}

