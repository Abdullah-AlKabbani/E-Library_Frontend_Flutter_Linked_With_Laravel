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

Future<Map<String, dynamic>> import(String token, String product, String importDate, String amount) async {
  const url = 'http://10.0.2.2:8000/api/import';
  final response = await http.post(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "date": importDate,
    "product": product,
    "import": amount,
  });

  print('Response body: ${response.body}');

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


Future<Map<String, dynamic>> editSize(String token, String product, String amount) async {
  const url = 'http://10.0.2.2:8000/api/edit_siz';
  final response = await http.post(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "product": product,
    "new_siz": amount,
  });

  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String message = data['message'];

    return {
      'message': message,
    };
  } else {
    throw Exception('Failed to inventory products');
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
        scaffoldBackgroundColor: Colors.white,
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
      home: const ImportScreen(),
    );
  }
}

class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  ImportScreenState createState() => ImportScreenState();
}

class ImportScreenState extends State<ImportScreen> {

  final List<TextEditingController> _controllerImport = [
    for (int i = 0; i <= 100; i++) TextEditingController()
  ];

  final List<TextEditingController> _controllerSize = [
  for (int i = 0; i <= 100; i++) TextEditingController()
  ];


  DateTime importDate = DateTime(2023, 1, 1);

  String dropdownvalueCategoury = 'Housewares';
  // List of items in our dropdown menu
  var itemsCategory = [
    'Housewares',
    'Work Tools',
    'School Tools',
    'Electronic Tools',
    'Foods',
    'Clothes & Fabrics',
    'Accessories',
    'Maintenance',
    'Toys'
  ];

  String nameProduct = 'Product 1';
  // List of items in our dropdown menu
  var itemsNameProduct = [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
    'Product 5',
    'Product 6',
    'Product 7',
    'Product 8',
    'Product 9'
  ];

  void _ShowEditSize(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.purple[100],
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
            padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
            child: StatefulBuilder(
              builder: (context, setInnerState) => SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Edit Size Screen',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  fontFamily: 'Lucida Calligraphy Font',
                                  fontStyle: FontStyle.italic
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
                                    controller: _controllerSize[i],
                                    cursorColor: Colors.purple,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple)),
                                      labelText: listNameProducts[i],
                                      icon: const Icon(Icons.business_center,
                                          color: Colors.purple),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.purple,
                          thickness: 1.5,
                          height: 15,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async{
                                  String message = '';
                                  for (int i=0; i<n1 ; i++) {
                                    if(_controllerSize[i].text != '') {
                                      Map<String, dynamic> Mymap = await editSize(
                                          token,
                                          listNameProducts[i],
                                          _controllerSize[i].text
                                      );
                                      message =
                                      '$message${Mymap['message']}\n';
                                    }
                                  }
                                  print('*******');
                                  print(message);
                                  messageShowAlertDialog(context, message);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.purple, // Background color
                                ),
                                child: const Text(
                                  'Check',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20,color: Color(0xFFF8BBD0)),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                onPressed: () async{
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.purple, // Background color
                                ),
                                child: const Text(
                                  'Cancel',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20,color: Color(0xFFF8BBD0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFFE3F2FD),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: const Text("Import",
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
                            'Enter import quantities of products',
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
                                  controller: _controllerImport[i],
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
                                  'Select Import Date',
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
                                initialDateTime: DateTime(2023, 1, 1),
                                onDateTimeChanged: (
                                    DateTime newDateTime) {
                                  importDate = newDateTime;
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                          if(_controllerImport[i].text != '') {
                                            Map<String,
                                                dynamic> Mymap = await import(
                                                token,
                                                listNameProducts[i],
                                                importDate.toString(),
                                                _controllerImport[i].text
                                            );
                                            message =
                                            '$message${Mymap['message']}\n';
                                          }
                                        }
                                        print('*******');
                                        print(message);
                                        messageShowAlertDialog(context, message);
                                      }
                                  ),
                                  const SizedBox(
                                    width: 10,
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
                                                Icon(Icons.edit, color: Color(0xFFF8BBD0)),
                                                SizedBox(width: 10),
                                                Text('edit size',style: TextStyle(color: Color(0xFFF8BBD0),fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          )
                                      ),

                                      onPressed: () async {
                                        _ShowEditSize(context);
                                      }
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
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

  /*
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        centerTitle: true,
        title: const Text('Add Products',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            )),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.deepPurple,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      body: StatefulBuilder(
        builder: (context, setInnerState) => SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Container(
                  width: 375,
                  decoration: BoxDecoration(
                      color: Colors.purple[100],
                      border: Border.all(
                        color: Colors.deepPurple,
                        width: 3
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Enter import quantities of products',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w600,
                                fontSize: 25),
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
                                  controller: _controllerImport[i],
                                  cursorColor: Colors.purple,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.purple)),
                                    labelText: listNameProducts[i],
                                    icon: const Icon(
                                        Icons.business_center,
                                        color: Colors.amber),
                                  ),
                                ),
                              ),
                          ],
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
                                  'Select Import Date',
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
                                initialDateTime: DateTime(2023, 1, 1),
                                onDateTimeChanged: (
                                    DateTime newDateTime) {
                                  importDate = newDateTime;
                                },
                              ),
                            ),
                            const Divider(
                              color: Colors.purple,
                              thickness: 1.5,
                              height: 15,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RaisedButton(
                                      padding: const EdgeInsets.all(20),
                                      color: Colors.amber,
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
                                                Icon(Icons.upload, color: Colors.purple),
                                                SizedBox(width: 10),
                                                Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          )
                                      ),

                                      onPressed: () async {
                                        Navigator.pop(context);
                                      }
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  RaisedButton(
                                      padding: const EdgeInsets.all(20),
                                      color: Colors.amber,
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
                                                Icon(Icons.edit, color: Colors.purple),
                                                SizedBox(width: 10),
                                                Text('edit size',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          )
                                      ),

                                      onPressed: () async {
                                        TextEditingController sizeController = TextEditingController();
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible: false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              // <-- SEE HERE
                                              backgroundColor: Colors.amber[100],
                                              title: const Text(
                                                'Edit size area of product',
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 20),
                                                textAlign: TextAlign.center,
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'Select Product Name: :',
                                                            style: TextStyle(
                                                                color: Colors.purple,
                                                                fontWeight: FontWeight.w900,
                                                                fontSize: 20),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          DropdownButton(
                                                            dropdownColor: Colors.purple[100],
                                                            // Initial Value
                                                            value: nameProduct,

                                                            // Down Arrow Icon
                                                            icon: const Icon(
                                                              Icons.keyboard_arrow_down,
                                                              color: Colors.amber,
                                                            ),

                                                            // Array list of items
                                                            items: listNameProducts.map((String items) {
                                                              return DropdownMenuItem(
                                                                value: items,
                                                                child: Text(items),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String? newValue) {
                                                              setInnerState(() => nameProduct = newValue!);
                                                            },
                                                            hint: const Text("Select Product Name:"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextField(
                                                      cursorColor: Colors.purpleAccent,
                                                      controller: sizeController,
                                                      decoration:
                                                      const InputDecoration(hintText: 'New Size'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.amber[800], // Background color
                                                  ),
                                                  child: const Text(
                                                    'Submit',
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        Navigator.pop(context);
                                      }
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
  */
}
