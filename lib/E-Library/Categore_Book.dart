import 'dart:convert';

import 'package:e_library/E-Library/Deatels_Book.dart';
import 'package:e_library/E-Library/List_Book.dart';
import 'package:e_library/Provider/App_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_library/E-Library/Home_Screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Provider/favorite.dart';
import '../log_in/FirstRoute.dart';

Map<String, dynamic> bookInfo = {};

Future<Map<String,dynamic>> details(String token,int id) async {
  url = 'http://10.0.2.2:8000/api/details/$id';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },

  );

  print('Response body: ${response.body}');
  final Map<String, dynamic> details = jsonDecode(response.body);
  Map list = details['details'];


  if (response.statusCode == 200) {
    return {
      'details': list,
    };
  }
  else{
    return{
      'details': list,
    };
  }
}


String categories = '';


class BookList extends ConsumerWidget {
  final String category;

  BookList(BuildContext context, {required this.category, Key? key}) : super(key: key);

  Widget? _star(double num) {
    int num1 = num.round();
    if (num1 == 1) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    } else if (num1 == 2) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    } else if (num1 == 3) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    } else if (num1 == 4) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    } else if (num1 == 5) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ],
      );
    }else if (num1 == 0) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(category,
            style: const TextStyle(
                color: Color(0xFFF8BBD0),
                fontWeight: FontWeight.w700,
                fontSize: 25,
                fontFamily: 'Lucida Calligraphy Font',
                fontStyle: FontStyle.italic)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFF8BBD0),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          color: const Color(0xFFE3F2FD),
          child: Column(children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/search.png'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                      const BorderSide(color: Colors.purple, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.purple),
                    ),
                    filled: true,
                    fillColor: Colors.blue[100],
                    labelStyle: const TextStyle(color: Colors.purple),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple)),
                    labelText: 'Search',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.purple[300],
                      ),
                      onPressed: () {},
                    )),
              ),
            ),
            Expanded(
                child: ListView.builder(

                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: showBooksList['books'].length,
                    itemBuilder: (context, index) {

                      final isFavorite = showBooksList['books'][index]['isFavorite'];


                      return StatefulBuilder(

                        builder: (context, setInnerState) =>

                            InkWell(
                              onTap: () async{
                                bookInfo = await details(
                                    token,showBooksList['books'][index]['id']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Deatels()),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 5, left: 20, right: 20),
                                // width: MediaQuery.of(context).size.width,

                                decoration: BoxDecoration(
                                    gradient: colors(context).gradient1,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30))),

                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(

                                                height: 110,
                                                width: 80,
                                                child: CachedNetworkImage(
                                                  imageUrl: 'http://10.0.2.2:8000/${showBooksList['books'][index]['image']}',
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                      error) =>
                                                      Icon(Icons.error),
                                                  fit: BoxFit.cover,
                                                )
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(child: _star(
                                              double.parse(showBooksList['books'][index]['rate'].toString())),)
                                          ],
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 207,
                                              child: Text(
                                                showBooksList['books'][index]
                                                ['name'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            SizedBox(
                                              width: 207,
                                              child: Text(
                                                showBooksList['books'][index]
                                                ['author'],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      myComment(context);
                                                    },
                                                    icon: const Icon(
                                                      Icons.comment_outlined,
                                                      color: Colors.black38,
                                                    )),

                                                Icon(
                                                  color: isFavorite ? Colors.red : Colors.grey,
                                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                                ),

                                                Row(
                                                  children: [
                                                    Text(
                                                      showBooksList['books'][index]
                                                      ['price'],
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w800,
                                                          color:
                                                          Colors.purpleAccent),
                                                      textAlign: TextAlign
                                                          .start,
                                                    ),
                                                    const Icon(
                                                      Icons.money_off,
                                                      color: Colors
                                                          .purpleAccent,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      );
                    }))
          ])),
    );
  }
}

