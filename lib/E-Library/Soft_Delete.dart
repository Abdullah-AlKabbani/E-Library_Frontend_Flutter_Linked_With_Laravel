
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_library/E-Library/Categore_Book.dart';
import 'package:e_library/E-Library/Custom_Data.dart';
import 'package:e_library/E-Library/Deatels_Book.dart';
import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


Future<bool> restoreDelete(String token, int id) async {
  url = 'http://10.0.2.2:8000/api/restoreDelete/$id';
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



Future<bool> forceDelete(String token, int id) async {
  url = 'http://10.0.2.2:8000/api/forceDelete/$id';
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


class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {

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

  List<Map> myData = CustomData.mydata;
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {
    for (var item in List.generate(showDeleteList['Delete'].length, (index) => index)) item : false
  };


  selectAllAtOnceGo() {
    print(selectedItem.length);
    bool isFalseAvailable = selectedItem.containsValue(false);
    selectedItem.updateAll((key, value) => isFalseAvailable);

    setState(() {
      isSelectItem = selectedItem.containsValue(true);
    });

    // استدعاء تابع الاستعادة لجميع العناصر المحددة

  }

  Future<void> restoreSelectedItems() async {
    List<int> idsToRestore = [];

    // جمع جميع الـ IDs للعناصر المحددة
    for (var index in selectedItem.keys) {
      if (selectedItem[index] == true) {
        // هنا نفترض أن لديك قائمة showDeleteList تحتوي على العناصر المحذوفة
        int id = showDeleteList['Delete'][index]['id'];
        idsToRestore.add(id);
      }
    }

    // استدعاء تابع الاستعادة لكل ID
    for (int id in idsToRestore) {
      bool success = await restoreDelete(token, id);
      if (success) {
        print('تم استعادة العنصر ذو ID: $id');
      } else {
        print('فشل في استعادة العنصر ذو ID: $id');
      }
    }
  }


  Future<void> deleteSelectedItems() async {
    List<int> idsToRestore = [];

    // جمع جميع الـ IDs للعناصر المحددة
    for (var index in selectedItem.keys) {
      if (selectedItem[index] == true) {
        // هنا نفترض أن لديك قائمة showDeleteList تحتوي على العناصر المحذوفة
        int id = showDeleteList['Delete'][index]['id'];
        idsToRestore.add(id);
      }
    }

    // استدعاء تابع الاستعادة لكل ID
    for (int id in idsToRestore) {
      bool success = await forceDelete(token, id);
      if (success) {
        print('تم حذف العنصر ذو ID: $id');
      } else {
        print('فشل في حذف العنصر ذو ID: $id');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            217.0), // Change the height of the app bar
        child: AppBar(
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:
              Radius.circular(60), // Change the shape of the app bar
            ),
          ),
          flexibleSpace: Container(
            width: MediaQuery.of(context).size.width,
            height: 280,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/dele.png'),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.purple,
                    Colors.purpleAccent,
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
          ),
          title: const Text('Recycle Bin',style: TextStyle(color: Color(
              0xFFF8BBD0)),),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFF8BBD0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: Container(
        child: Column(children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _mainUI1(isSelectItem),
              const SizedBox(width: 50),
              TextButton(
                  onPressed: () {
                    selectAllAtOnceGo();
                  },
                  child: const Text(
                    'SELECT ALL',
                    style: TextStyle(color: Colors.purple, fontSize: 19),
                  )),
            ],
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:showDeleteList['Delete'].length,
              itemBuilder: (context, index) {
                Map data = myData[index];
                print(index);
                selectedItem[index] = selectedItem[index] ?? false;
                bool? isSelectedData = selectedItem[index];

                return InkWell(
                  onLongPress: () {
                    setState(() {
                      selectedItem[index] = !isSelectedData!;
                      isSelectItem = selectedItem.containsValue(true);
                    });
                  },
                  onTap: ()async {
                    if (isSelectItem) {
                      setState(() {
                        selectedItem[index] = !isSelectedData!;
                        isSelectItem = selectedItem.containsValue(true);
                      });
                    } else {

                      bookInfo = await details(
                          token,  showDeleteList['Delete'][index]['id']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Deatels()),
                      );
                    }
                  },
                  child: Container(
                    margin:
                    const EdgeInsets.only(bottom: 5, left: 10, right: 10),

                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFFE1BEE7),
                              Color(0xFFE3F2FD),
                              Color(0xFFBBDEFB),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.all(Radius.circular(30))),

                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin:
                        const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 SizedBox(
                                  height: 110,
                                  width: 80,
                                  child:  CachedNetworkImage(
                                    imageUrl: 'http://10.0.2.2:8000/${showDeleteList['Delete'][index]['image']}',
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
                                  double.parse(showDeleteList['Delete'][index]['rate'].toString()),))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 207,
                                  child: Text(
                                    showDeleteList['Delete'][index]['name'],
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
                                    showDeleteList['Delete'][index]['author'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black87),
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
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )),
                                    Row(
                                      children: [
                                        Text(
                                          showDeleteList['Delete'][index]['price'],
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.purpleAccent),
                                          textAlign: TextAlign.start,
                                        ),
                                        const Icon(
                                          Icons.money_off,
                                          color: Colors.purpleAccent,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            _mainUI(isSelectedData!, data),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }

  Widget _mainUI(bool isSelected, Map ourdata) {
    if (isSelectItem) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Colors.purple,
      );
    } else {
      return Container();
    }
  }

  Widget _mainUI1(bool isSelected) {
    if (isSelectItem) {
      return Row(
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.blue[50],
                      title: const Text('Delete Confirmation'),
                      titleTextStyle: const TextStyle(color: Colors.purple),
                      content: const Text('Are you sure you want to delete ?'),
                      contentTextStyle: const TextStyle(color: Colors.black54),
                      actions: [
                        MaterialButton(
                          onPressed: () {
                            deleteSelectedItems();
                            Navigator.of(context).pop();
                          },
                          textColor: Colors.purple,
                          child: const Text('OK'),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          textColor: Colors.purple,
                          child: const Text('CANCEL'),
                        )
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          IconButton(
            onPressed: () {
              restoreSelectedItems();
            },
            icon: const Icon(
              Icons.replay_circle_filled_outlined,
              color: Colors.green,
              size: 30,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.grey,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.replay_circle_filled_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      );
    }
  }
}
