import 'package:flutter_riverpod/flutter_riverpod.dart';

// Comment model
class CommentModel {
  final List<String> comments;

  CommentModel(this.comments);
}

// StateNotifier to manage comments
class CommentNotifier extends StateNotifier<CommentModel> {
  CommentNotifier() : super(CommentModel([]));

  void addComment(String comment) {
    state = CommentModel([...state.comments, comment]);
  }
}

// Provider for the CommentNotifier
final commentProvider = StateNotifierProvider<CommentNotifier, CommentModel>((ref) {
  return CommentNotifier();
});