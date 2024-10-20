import 'package:e_library/E-Library/Deatels_Book.dart';
import 'package:e_library/Provider/App_theme.dart';
import 'package:e_library/E-Library/Custom_Data.dart';

import 'package:flutter/material.dart';

import 'Custom_Data.dart';

List<Map> myData = CustomData.mydata;
bool isSelectItem = false;
Map<int, bool> selectedItem = {
  for (var item in List.generate(10000, (index) => index)) item: false
};
bool isFavorite = true;

Widget buildListView() {
  return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: myData.length,
      itemBuilder: (context, index) {
        Map data = myData[index];
        print(index);

        return StatefulBuilder(
          builder: (context, setInnerState) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Deatels()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
              // width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                  gradient: colors(context).gradient1,
                  borderRadius: BorderRadius.all(Radius.circular(30))),

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 110,
                            width: 80,
                            child: Image(
                              image: AssetImage('assets/cover.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
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
                          )
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 207,
                            child: Text(
                              myData[index]['name'],
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
                              myData[index]['author'],
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
                                  onPressed: () {isFavorite = !isFavorite;},
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  )),
                              Row(
                                children: [
                                  Text(
                                    myData[index]['price'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
