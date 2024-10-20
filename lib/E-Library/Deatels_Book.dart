import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_library/E-Library/Profile/Profile_Screen.dart';
import 'package:e_library/Provider/App_theme.dart';
import 'package:e_library/E-Library/Categore_Book.dart';
import 'package:e_library/Provider/download.dart';
import 'package:e_library/Provider/favorite.dart';
import 'package:e_library/Provider/rate.dart';
import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/Provider/translate.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../log_in/FirstRoute.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';

int newMyMony = 0;

Map<String, dynamic> showCommentList = {};
Future<Map<String, dynamic>> showComment(String token,int id) async {
  url = 'http://10.0.2.2:8000/api/showComment/$id';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> booksList = jsonDecode(response.body);
    var comments = booksList['comments'];

    return {
      'comments': comments,
    };
  } else {
    throw Exception('Failed to get books');
  }
}


Future<bool> payForBook(String token,int id) async {
   url = 'http://10.0.2.2:8000/api/payForBook/$id';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}


Future<bool> comment(String token,String com, int id) async {

  url = 'http://10.0.2.2:8000/api/comment/$id';
  final response = await http.post(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "text": com,

      });
  print('Response status: ${response.statusCode}');

  if (response.statusCode == 200 ) {
    return true;

  } else {
    return false;
  }
}


Future<bool> deleteBook(String token, int id) async {
  url = 'http://10.0.2.2:8000/api/delete/$id';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 ) {

    return true ;
  }
  else {
    return false ;

  }
}

Future<bool> rate(String token,int num, int id) async {
  String rateValue = num.toString();
  url = 'http://10.0.2.2:8000/api/rate/$id';
  final response = await http.post(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "rate": rateValue,

      });
  print('Response status: ${response.statusCode}');

  if (response.statusCode == 200 ) {
    return true;

  } else {
    return false;
  }
}



Future<bool> addFavorite(String token, int id) async {
  url = 'http://10.0.2.2:8000/api/addFavorite/$id';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    return true ;

  } else {
    return false ;
  }
}
final bookUrl = 'http://10.0.2.2:8000/${bookInfo['details']['path']}';



TextEditingController commentController = TextEditingController();
class Deatels extends ConsumerWidget {






  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;
  late var rateText = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookId =bookInfo['details']['id']; // تأكد من أن هذا هو int صحيح
    final isFavorite = ref.watch(favoriteProvider(bookId));


    final currentText = ref.watch(textSwitcherProvider);

    final rating = ref.watch(ratingProvider);
    String rateText;

    switch (rating) {
      case 1:
        rateText = 'Bad Book 😒';
        break;
      case 2:
        rateText = 'Its Ok 😶';
        break;
      case 3:
        rateText = 'Good Book 😌';
        break;
      case 4:
        rateText = 'Very Good Book 😁';
        break;
      case 5:
        rateText = 'Perfect Book 😍';
        break;
      default:
        rateText = '';
    }

    return Scaffold(
        backgroundColor: Colors.blue[100],
        bottomNavigationBar: myBottomAppBar(context),
        floatingActionButton: FloatingActionButton(
          tooltip: "Favorite",
          onPressed: () async {
            ref.read(favoriteProvider(bookId).notifier).toggleFavorite();
            addFavorite(token, bookId);
          },
          child:  Icon(
            Icons.favorite,
            size: 25,
            color: isFavorite ? Colors.red : Color(0xFFF8BBD0),

          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        appBar: AppBar(
            title: const Text("Details Book",
                style: TextStyle(
                    color: Color(0xFFF8BBD0),
                    fontSize: 30,
                    fontFamily: 'Lucida Calligraphy Font',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700)),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFFF8BBD0),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            actions:<Widget>[
              IconButton(onPressed:()async{
                bool check_Delete = await deleteBook(token,  bookInfo['details']['id']);

                if (check_Delete) {

                  var snackBar = SnackBar(
                    content: Text(
                        textAlign: TextAlign.center,
                        'The book has been sent to the recycle bin'),
                    backgroundColor: Colors.purple,
                    behavior: SnackBarBehavior.floating,
                    width: 350,
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar);
                }else{
                  var snackBar = SnackBar(
                    content: Text(
                        textAlign: TextAlign.center,
                        'You cant delete this book'),
                    backgroundColor: Colors.purple,
                    behavior: SnackBarBehavior.floating,
                    width: 350,
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar);


                }

              },

                  icon: Icon(
                      Icons.delete,
                      color: Color(0xFFF8BBD0)


                  ))
            ]
        ),


        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.purpleAccent,
                Color(0xFFBBDEFB),
                Color(0xFFBBDEFB),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      bookInfo['details']['name'],
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     SizedBox(
                      height: 200,
                      width: 150,
                      child:  CachedNetworkImage(
                        imageUrl: 'http://10.0.2.2:8000/${bookInfo['details']['image']}',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url,
                            error) =>
                            Icon(Icons.error),
                        fit: BoxFit.cover,
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {
                            ref.read(ratingProvider.notifier).rateBook(1);
                            rate(token,1, bookInfo['details']['id']);
                          },
                          color: rating >= 1 ? Colors.orange : Colors.grey,
                        ),
                        IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {
                            ref.read(ratingProvider.notifier).rateBook(2);
                            rate(token,2, bookInfo['details']['id']);
                          },
                          color: rating >= 2 ? Colors.orange : Colors.grey,
                        ),
                        IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {
                            ref.read(ratingProvider.notifier).rateBook(3);
                            rate(token,3, bookInfo['details']['id']);
                          },
                          color: rating >= 3 ? Colors.orange : Colors.grey,
                        ),
                        IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {
                            ref.read(ratingProvider.notifier).rateBook(4);
                            rate(token,4, bookInfo['details']['id']);
                          },
                          color: rating >= 4 ? Colors.orange : Colors.grey,
                        ),
                        IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {
                            ref.read(ratingProvider.notifier).rateBook(5);
                            rate(token,5, bookInfo['details']['id']);
                          },
                          color: rating >= 5 ? Colors.orange : Colors.grey,
                        ),
                      ],
                    ),
                    Text(
                      rateText,
                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Author: ",
                            style: TextStyle(color: Colors.purple[800],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            bookInfo['details']['author'],
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 1.0,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Price : ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic,
                              color: Colors.purple[300],
                            ),
                          ),
                          Text(bookInfo['details']['price']),
                          Icon(
                            Icons.money_off,
                            color: Colors.purple[300],
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Text(
                            'Number : ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.italic,
                                color: Colors.purple[300]),
                          ),
                          Text(bookInfo['details']['phone_n']),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      const Text(
                                        'description : ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            ref.read(textSwitcherProvider.notifier).toggleText();
                                          },
                                          child: Row(children: [
                                            Text(
                                              'Click To Translate',
                                              style:
                                              TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                            Icon(
                                              Icons.translate,
                                              color: Colors.grey[600],
                                            )
                                          ]))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      width: 220,
                                      child: Text(
                                          currentText)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 160,
                            width: 120,
                            child: Image(
                              image: AssetImage('assets/boy.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}

Future<void> myComment(BuildContext context) async {
  // set up the AlertDialog

  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.symmetric(horizontal: 15),
    backgroundColor: Colors.purple[100],
    title: const Text(
      'Comments On This Book',
      style: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.w800),
    ),
    titleTextStyle: const TextStyle(color: Colors.purple),
    content: Container(
      color: Colors.purple[50],
      width: 500,
      height: 800,
      child: StatefulBuilder(
        builder: (context, setInnerState) => ListView.separated(
          itemCount:   showCommentList['comments'].length,
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.purple,
                height: 1.5,
              ),
            );
          },
          itemBuilder: (context, index) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          showCommentList['comments'][index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black54),
                        ),
                        Text(
                          showCommentList['comments'][index]['comment'],
                          style: TextStyle(
                              color: Colors.black38),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(Icons.favorite_border),
                            Text(
                              '15',
                              style: TextStyle(
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              '15/8/2024',
                              style: TextStyle(
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(
                                  100),
                              child:  CachedNetworkImage(
                                imageUrl: 'http://10.0.2.2:8000/${  showCommentList['comments'][index]['image']}',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url,
                                    error) => Image.asset(
                                  "assets/ic_profile.jpeg",
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),

                                fit: BoxFit.cover,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
    actions: [
      StatefulBuilder(
        builder: (context, setInnerState) => TextField(
          controller: commentController,
          onChanged: (value) {},
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                    color: Colors.purple, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                const BorderSide(color: Colors.purple),
              ),
              filled: true,
              fillColor: const Color(0xFFF8BBD0),
              labelStyle:
              const TextStyle(color: Colors.purple),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Colors.purple)),
              labelText: 'Add Comment',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.purple[300],
                ),
                onPressed: () async{
                  await comment(token,commentController.text,  bookInfo['details']['id']);
                  setInnerState(() async =>  {
                    showCommentList = await showComment(token, bookInfo['details']['id'])
                  });
                  //Navigator.of(context).pop();
                },
              )),
        ),
      ),
    ],
  );

  return showDialog(
      context: context,
      builder: (context1) {
        return alert;
      });
}

BottomAppBar myBottomAppBar(BuildContext context){
  return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: colors(context).appBar1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () async{
                profileInfo = await profil(token,bookInfo['details']['id']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  Profile(context),
                  ),
                );

              },
              icon: const Icon(Icons.person,size: 25, color:  Color(0xFFF8BBD0))
          ),
          IconButton(
              onPressed: () async {
                showCommentList = await showComment(token, bookInfo['details']['id']);
                myComment(context);
              },
              icon: const Icon(Icons.comment_outlined, size: 25, color: Color(0xFFF8BBD0))
          ),
          IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.chat_bubble, size: 25, color: Color(0xFFF8BBD0))
          ),
          IconButton(
              onPressed: ()async {

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.blue[50],
                        title: const Text('Payment Confirmation',style: TextStyle(fontSize:20 )),
                        titleTextStyle: const TextStyle(color: Colors.purple),
                        content:  Text('Are you sure you want buy this book for ${bookInfo['details']['price']} ?'),
                        contentTextStyle: const TextStyle(color: Colors.black54),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            textColor: Colors.purple,
                            child: const Text('CANCEL'),
                          ),
                        Container(child:  DownloadButton(bookUrl: bookUrl),)

                        ],
                      );
                    });

              },
              icon: const Icon(Icons.download, size: 25, color: Color(0xFFF8BBD0))
          ),
          const SizedBox(width: 20)
        ],
      )
  );
}


class DownloadButton extends ConsumerWidget {
  final String bookUrl;

  DownloadButton({required this.bookUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDownloading = ref.watch(bookDownloaderProvider);

    return MaterialButton(
      onPressed: () async{
        bool chickIfPaidDone = await payForBook(token,bookInfo['details']['id']);
        Map<String, dynamic> myMap2 = await money(token);
        myMoney = myMap2['wallet'];
        Navigator.of(context).pop();
        print("path = ${bookInfo['details']['path']}");

        if(chickIfPaidDone){
            //ref.read(bookDownloaderProvider.notifier).downloadBook(bookUrl);

          var snackBar = SnackBar(
            content: Text(
                textAlign: TextAlign.center,
                'The book downloading successfully'),
            backgroundColor: Colors.purple,
            behavior: SnackBarBehavior.floating,
            width: 350,
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        } else {
          var snackBar = SnackBar(
            content: Text(
                textAlign: TextAlign.center,
                'The book dose not downloading successfully'),
            backgroundColor: Colors.purple,
            behavior: SnackBarBehavior.floating,
            width: 350,
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
      },

      textColor: Colors.purple,
      child: const Text('OK'),
    );
  }
}

/*
Future<void> downloadFile(String url) async {
  try {
    var dir = await getApplicationDocumentsDirectory();
    await Dio().download(url, '${dir.path}/title.pdf');
    print('Download completed');
  } catch (e) {
    print('Error downloading file: $e');
  }
}*/