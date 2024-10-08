import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'point_slider_provider.g.dart';

@riverpod
class PointSlider extends _$PointSlider {
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
