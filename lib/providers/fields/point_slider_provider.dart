import 'package:flutter_riverpod/flutter_riverpod.dart';

final pointSliderProvider =
    NotifierProvider<PointSliderNotifier, double>(() => PointSliderNotifier());

class PointSliderNotifier extends Notifier<double> {
  @override
  double build() {
    return 50;
  }

  void initializePoint() {
    state = 50;
  }

  void setPoint(double point) {
    state = point;
  }
}
