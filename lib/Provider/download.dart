import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class BookDownloader extends StateNotifier<bool> {
  BookDownloader() : super(false);

  Future<void> downloadBook(String url) async {
    try {
      state = true; // بدء التنزيل
      var dir = await getApplicationDocumentsDirectory();
      String savePath ='C:\Users\DELL\Desktop'; //'${dir.path}/book.pdf'; // اسم الملف
       print(savePath);
      await Dio().download(url, savePath);
      print("تم تنزيل الكتاب بنجاح إلى: $savePath");
    } catch (e) {
      print("حدث خطأ أثناء تنزيل الكتاب: $e");
    } finally {
      state = false; // انتهاء التنزيل
    }
  }
}

final bookDownloaderProvider = StateNotifierProvider<BookDownloader, bool>((ref) {
  return BookDownloader();
});