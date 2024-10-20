
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_library/E-Library/Deatels_Book.dart';

import '../E-Library/Categore_Book.dart';
class FavoriteNotifier extends StateNotifier<bool> {
  FavoriteNotifier(bool initialState) : super(initialState);

  void toggleFavorite() {
    state = !state;
  }
}

final favoriteProvider = StateNotifierProvider.family<FavoriteNotifier, bool, int>((ref, bookId) {
  bool initialFavoriteState = bookInfo['details']['isFavorite']; // استبدل بالقيمة الحقيقية
  return FavoriteNotifier(initialFavoriteState);
});