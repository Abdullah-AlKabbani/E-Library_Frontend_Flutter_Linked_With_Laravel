import 'package:e_library/E-Library/Deatels_Book.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/E-Library/List_Book.dart';
import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'dart:async';


int notiId =0;
Future<bool> readNotification(String token, int id) async {
  url = 'http://10.0.2.2:8000/api/readNotification/$id';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 ) {

    return true ;
  }
  else {
    return true ;

  }
}

Future<bool> markAllRead(String token) async {
  url = 'http://10.0.2.2:8000/api/markAllRead';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 ) {

    return true ;
  }
  else {
    return true ;

  }
}


class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Notifications",
                style: TextStyle(
                    color: Color(0xFFF8BBD0),
                    fontSize: 30,
                    fontFamily: 'Lucida Calligraphy Font',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700))),
        body: Container(
          color: const Color(0xFFE3F2FD),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.purple,
                      Colors.purpleAccent,
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Notifications Count ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFF8BBD0),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "(${showNotificationList['Notification'].length})",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFF8BBD0),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Icon(
                          Icons.notifications_on_sharp,
                          color: Color(0xFFF8BBD0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: InkWell(
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(5),
                        separatorBuilder: (context, index) {

                          return const Padding(
                            padding: EdgeInsets.all(7),
                            child: Divider(
                              thickness: 2,
                              color: Colors.purple,
                              height: 1.5,
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount:  showNotificationList['Notification'].length,
                        itemBuilder: (context, index) {
                          notiId = showNotificationList['Notification'][index]['comment_id'];
                          return Container(

                            margin: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 77,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFE1BEE7),
                                      Color(0xFFE3F2FD),
                                      Color(0xFFBBDEFB),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                                borderRadius:
                                BorderRadius.all(Radius.circular(30))),

                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 15, left: 10, right: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                              width: 45,
                                              height: 45,
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                  child: const Image(
                                                      image: AssetImage(
                                                          'assets/ic_profile.jpeg'))),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children:  [
                                            Container(
                                              width: 150,
                                              child: Text(
                                                showNotificationList['Notification'][index]['name'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                                textAlign: TextAlign.start,
                                              ),

                                            ),
                                            SizedBox(width: 50),
                                            Icon(
                                              Icons.notifications_on_sharp,
                                              color: Colors.purple,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          showNotificationList['Notification'][index]['comment'] +
                                              "...",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45),
                                        ),
                                        const SizedBox(height: 10)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                        }),
                    onTap: () async {
                      bool check_read = await readNotification(token,notiId);
                      // ignore: use_build_context_synchronously
                      if (check_read) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  Deatels(),
                          ),
                        );
                      }
                    }
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.purple,
                      Colors.purpleAccent,
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: ()async {
                          bool check_All = await markAllRead(token);
                          // ignore: use_build_context_synchronously
                          if (check_All) {
                            setState(() {
                            });
                          }
                        },
                        child: Row(children: const [
                          Text(
                            'Make All Read',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFF8BBD0),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.mark_chat_read,
                            color: Color(0xFFF8BBD0),
                          )
                        ]))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
