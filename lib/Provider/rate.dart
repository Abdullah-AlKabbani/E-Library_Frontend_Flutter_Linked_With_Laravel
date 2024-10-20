import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// نموذج الحالة للتقييم
class RatingNotifier extends StateNotifier<int> {
  RatingNotifier() : super(0); // الحالة الأولية (0 تعني عدم وجود تقييم)

  void rateBook(int rating) {
    state = rating;
  }
}

// مزود الحالة
final ratingProvider = StateNotifierProvider<RatingNotifier, int>((ref) {
  return RatingNotifier();
});
