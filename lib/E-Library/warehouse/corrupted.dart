// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_library/log_in/FirstRoute.dart';
import 'package:flutter/rendering.dart';
import 'package:e_library/E-Library/warehouse/warehouse.dart';
import 'package:e_library/E-Library/Home_Screen.dart';





Future<Map<String, dynamic>> corrupted(String token, String product, String date, String amount , String cause) async {
  print('44444');
  const url = 'http://10.0.2.2:8000/api/lostIn';
  print('55555');
  final response = await http.post(Uri.parse(url),
      headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "date": date,
    "product": product,
    "lost": amount,
    "cause": cause,
  });
  print('66666');
  print('Response body: ${response.body}');
  print('777777');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String message = data['message'];

    return {
      'message': message,
    };
  } else {
    throw Exception('Failed to import products');
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(
          titleSmall: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontSize: 11),
        )
            .apply(
          bodyColor: Colors.black,
          displayColor: Colors.grey,
        ),
        listTileTheme: const ListTileThemeData(iconColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            iconTheme: IconThemeData(color: Colors.black54, size: 25)),
      ),
      home: const CorruptedScreen(),
    );
  }
}

class CorruptedScreen extends StatefulWidget {
  const CorruptedScreen({super.key});

  @override
  CorruptedScreenState createState() => CorruptedScreenState();
}

class CorruptedScreenState extends State<CorruptedScreen> {

  final List<TextEditingController> _controllerCorrupted = [
    for (int i = 0; i <= 100; i++) TextEditingController()
  ];

  DateTime CorruptedDate = DateTime.now();

  TextEditingController causeController = TextEditingController();


  String corruptedCause = 'Expiration';
  // List of items in our dropdown menu
  var itemsCorruptedCause = [
    'Break',
    'Expiration',
    'Humidity',
    'Rotten',
    'Theft',
    'Lost',
    'Send error',
    'Another reason',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color(0xFFE3F2FD),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: const Text("Corrupted",
              style: TextStyle(
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
        // backgroundColor: Colors.transparent,
        body: StatefulBuilder(
          builder: (context, setInnerState) => SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Enter Corrupted quantities of products',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                            ),
                          )),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < n1; i++)
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: 200,
                                child: TextField(
                                  controller: _controllerCorrupted[i],
                                  cursorColor: Colors.purple,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.purple)),
                                    labelText: listNameProducts[i],
                                    icon: const Icon(
                                        Icons.business_center,
                                        color: Colors.purple),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Text(
                              'The cause -> ',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownButton(
                              dropdownColor: Colors.purple[100],
                              // Initial Value
                              value: corruptedCause,

                              // Down Arrow Icon
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.purple,
                              ),

                              // Array list of items
                              items: itemsCorruptedCause.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setInnerState(() => corruptedCause = newValue!);
                              },
                              hint: const Text("Select Type of export algorithm"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if(corruptedCause == "Another reason")
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: causeController,
                            cursorColor: Colors.purple,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 3, color: Colors.purple)),
                              labelText: 'The cause of corrupted',
                              icon: Icon(Icons.delete, color: Colors.purple),
                            ),
                          ),
                        ),
                      const Divider(
                        color: Colors.purple,
                        thickness: 1.5,
                        height: 15,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Select Corrupted Date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25),
                                )),
                            SizedBox(
                              height: 200,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (
                                    DateTime newDateTime) {
                                  CorruptedDate = newDateTime;
                                },
                              ),
                            ),
                            const Divider(
                              color: Colors.purple,
                              thickness: 1.5,
                              height: 15,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            RaisedButton(
                                padding: const EdgeInsets.all(20),
                                color: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SizedBox(
                                    height: 20,
                                    width: 100,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:const [
                                          Icon(Icons.upload, color: Color(0xFFF8BBD0)),
                                          SizedBox(width: 10),
                                          Text('Submit',style: TextStyle(color: Color(0xFFF8BBD0),fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                                        ],
                                      ),
                                    )
                                ),

                                onPressed: () async {
                                  String message = '';
                                  for (int i=0; i<n1 ; i++) {
                                    if(_controllerCorrupted[i].text != '') {
                                      Map<String, dynamic> Mymap;
                                      if(corruptedCause != "Another reason"){
                                       Mymap = await corrupted(
                                          token,
                                          listNameProducts[i],
                                          CorruptedDate.toString(),
                                          _controllerCorrupted[i].text,
                                          corruptedCause
                                      );
                                      }
                                      else{
                                        Mymap = await corrupted(
                                            token,
                                            listNameProducts[i],
                                            CorruptedDate.toString(),
                                            _controllerCorrupted[i].text,
                                            causeController.text
                                        );
                                      }
                                      message =
                                      '$message${Mymap['message']}\n';
                                    }
                                  }
                                  print('*******');
                                  print(message);
                                  messageShowAlertDialog(context, message);
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}
