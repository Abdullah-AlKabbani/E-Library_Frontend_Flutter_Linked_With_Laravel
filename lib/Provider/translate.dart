import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_library/E-Library/Categore_Book.dart';

class TextSwitcher extends StateNotifier<String> {
  TextSwitcher() : super(bookInfo['details']['descreption']);

  void toggleText() {
    state = state == bookInfo['details']['descreption'] ? bookInfo['details']['translatedText'] : bookInfo['details']['descreption'];
  }
}

// إنشاء موفر للحالة
final textSwitcherProvider = StateNotifierProvider<TextSwitcher, String>((ref) {
  return TextSwitcher();
});