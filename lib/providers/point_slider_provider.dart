import 'package:flutter_riverpod/flutter_riverpod.dart';

final pointSliderProvider = StateNotifierProvider<PointSliderNotifier, double>(
    (ref) => PointSliderNotifier());

class PointSliderNotifier extends StateNotifier<double> {
  PointSliderNotifier() : super(50);
  void setPoint(double point) {
    state = point;
  }
}
