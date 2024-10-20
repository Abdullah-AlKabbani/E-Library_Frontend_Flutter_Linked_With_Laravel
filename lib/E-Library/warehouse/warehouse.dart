// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/E-Library/warehouse/display.dart';
import 'package:e_library/E-Library/warehouse/add_products.dart';
import 'package:e_library/E-Library/warehouse/import.dart';
import 'package:e_library/E-Library/warehouse/Export.dart';
import 'package:e_library/E-Library/warehouse/corrupted.dart';
import 'package:e_library/E-Library/warehouse/add_employee.dart';
import 'package:e_library/E-Library/Home_Screen.dart';

int n1 = num_product;

String dropdownvalueImplement = 'Export';
// List of items in our dropdown menu
var itemsImplement = ['Import', 'Export', 'Corrupted', 'Recent Quantity'];

// table row
List<Map<String, dynamic>> tableData = [
  {'product': 'P2', 'amount': '183', 'date': 'Now'},
];

List<Map<String, dynamic>> data  = [
  {'product': 'P2', 'amount': '183', 'date': 'Now'},
];

Future<Map<String, dynamic>> inventory(String token, String product, String amount) async {
  const url = 'http://10.0.2.2:8000/api/inventory';
  final response = await http.post(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "product": product,
    "inventory": amount,
  });

  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String message = data['message'];
    final String cost = data['Price'].toString();

    return {
      'message': message,
      'Price': cost
    };
  } else {
    throw Exception('Failed to inventory products');
  }
}

Future<Map<String, dynamic>> review(String token, String method, String startDate, String endDate) async {
  url = 'http://10.0.2.2:8000/api/review/$method';
  http.Response response;

  if(method != "Recent Quantity") {
    response = await http.post(Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
        body: {"date1": startDate, "date2": endDate});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      var list = data['movement'];

      return {
        'movement': list,
      };
    } else if (response.statusCode == 201 || response.statusCode == 202){
      final Map<String, dynamic> data = jsonDecode(response.body);
      var message = data['message'];

      return {
        'message': message,
      };
    }
    else {
      throw Exception('Failed to Review products');
    }

  }

  else{
    response = await http.post(Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'});

    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      var list = data['movement'];

      return {
        'movement': list,
      };
    }
    else if (response.statusCode == 201){
      final Map<String, dynamic> data = jsonDecode(response.body);
      var message = data['message'];

      return {
        'message': message,
      };
    }
    else {
      throw Exception('Failed to Review Recant products');
    }
  }
}

Future<Map<String, dynamic>> price(String token, String product, String price) async {
  const url = 'http://10.0.2.2:8000/api/cost';
  final response = await http.post(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "product": product,
    "price": price,
  });

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String message = data['message'];
    final String cost = data['Price'].toString();

    return {
      'message': message,
      'Price': cost,
    };
  } else {
    throw Exception('Failed to Find Price products');
  }
}



class Warehouse extends StatefulWidget {
  @override
  _WarehouseState createState() => _WarehouseState();
}

class _WarehouseState extends State<Warehouse> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyWarehouse());
  }
}

class MyWarehouse extends StatefulWidget {

  @override
  State<MyWarehouse> createState() => _MyWarehouseState();
}

class _MyWarehouseState extends State<MyWarehouse> {
  final List<TextEditingController> _controllerInventory = [
    for (int i = 0; i <= 100; i++) TextEditingController()
  ];

  final List<TextEditingController> _controllerFinancValue = [
    for (int i = 0; i <= 100; i++) TextEditingController()
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController sizController = TextEditingController();
  TextEditingController colorController = TextEditingController();

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

  DateTime startDate = DateTime(2023,1,1);
  DateTime endDate = DateTime(2023,1,1);


  void _ShowInventory(BuildContext ctx) {
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
                          'Enter Inventory quantities of products',
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
                                controller: _controllerInventory[i],
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
                                if(_controllerInventory[i].text != '') {
                                  Map<String, dynamic> Mymap = await inventory(
                                      token,
                                      listNameProducts[i],
                                      _controllerInventory[i].text
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
                              style: TextStyle(fontSize: 20, color: Color(0xFFF8BBD0)),
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

  void _ShowFinancialValue(BuildContext ctx) {
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
                          'Enter the product price to calculate the current value',
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
                                controller: _controllerFinancValue[i],
                                cursorColor: Colors.purple,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.purple)),
                                  labelText: listNameProducts[i],
                                  icon: const Icon(Icons.monetization_on,
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
                            onPressed: () async {
                              String message = '';
                              int sum = 0;
                              for (int i=0; i<n1 ; i++) {
                                if(_controllerFinancValue[i].text != '') {
                                  Map<String, dynamic> Mymap = await price(
                                      token,
                                      listNameProducts[i],
                                      _controllerFinancValue[i].text
                                  );
                                  message = '$message${Mymap['message']}\n';
                                  sum = sum + int.parse(Mymap['Price'].toString());
                                }
                              }
                              message = '${message}Total price of products is: $sum';
                              print(message);
                              messageShowAlertDialog(context, message);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple, // Background color
                            ),
                            child: const Text(
                              'Check',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, color: Color(0xFFF8BBD0)),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple, // Background color
                            ),
                            child: const Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, color: Color(0xFFF8BBD0)),
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

  void _ShowReview(BuildContext ctx) {
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
                          'Enter Review Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownButton(
                      dropdownColor: Colors.purple[100],
                      // Initial Value
                      value: dropdownvalueImplement,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.purple,
                      ),

                      // Array list of items
                      items: itemsImplement.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setInnerState(() => dropdownvalueImplement = newValue!);
                      },
                      hint: const Text("Select Product Name:"),
                    ),
                    const Divider(
                      color: Colors.purple,
                      thickness: 1.5,
                      height: 15,
                    ),
                    if (dropdownvalueImplement != "Recent Quantity")
                      Center(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Select Start Date',
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
                                initialDateTime: startDate,
                                onDateTimeChanged: (DateTime newDateTime) {
                                  startDate = newDateTime;
                                },
                              ),
                            ),
                            const Divider(
                              color: Colors.purple,
                              thickness: 1.5,
                              height: 15,
                            ),
                            Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Select End Date',
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
                                initialDateTime: endDate,
                                onDateTimeChanged: (DateTime newDateTime) {
                                  endDate = newDateTime;
                                },
                              ),
                            ),
                            const Divider(
                              color: Colors.purple,
                              thickness: 1.5,
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {

                              Map<String, dynamic> Mymap = await review(
                                  token,
                                  dropdownvalueImplement,
                                  startDate.toString(),
                                  endDate.toString()
                              );

                              tableData = (Mymap["movement"] as List).map((dynamic item) => item as Map<String, dynamic>).toList();
                              print('******');
                              print(tableData);

                              /*
                              if(dropdownvalueImplement == "Recent Quantity"){
                                data = dataRecent;
                              }
                              else if(dropdownvalueImplement == "Export"){
                                data = dataExport;
                              }
                              */

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Display()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple, // Background color
                            ),
                            child: const Text(
                              'Submit',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20,color: Color(0xFFF8BBD0)),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple, // Background color
                            ),
                            child: const Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20,color:Color(0xFFF8BBD0)),
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
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/Untitled.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            //backgroundColor: Colors.amber[100],
            appBar: AppBar(
              backgroundColor: Colors.purple,
              centerTitle: true,
              title: const Text("Warehouse Screen",
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
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(context)),
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                  child: Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.all(25),
                    alignment: Alignment.center,
                    child: const Text(
                      'Warehouse Keeper Feature',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30,color: Color(0xFFF3E5F5),fontWeight: FontWeight.w900,fontFamily: 'Lucida Calligraphy Font', fontStyle: FontStyle.italic),
                    )),
                    Container(
                      margin: EdgeInsets.all(25),
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFFBBDEFB),
                            Color(0xFFF8BBD0),
                            Colors.purple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        //color: Colors.purple,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Employees()),
                          );
                        },
                        child: const Text(
                          'Add Employee',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),
                        ),
                      ),
                    ),
                Container(
                  margin: const EdgeInsets.all(25),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFBBDEFB),
                        Color(0xFFF8BBD0),
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    //color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GenerateQRCode()),
                      );
                    },
                    child: const Text(
                      'Add Products',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFBBDEFB),
                        Color(0xFFF8BBD0),
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      //color: Colors.purple,
                      textColor: Colors.white,
                      onPressed: () {
                        if (n1 == 0) {
                          const snackBar = SnackBar(
                            content: Text(
                              'You don'
                              't have product yet, please enter your product first ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFFF8BBD0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic),
                            ),
                            backgroundColor: Colors.purpleAccent,
                            behavior: SnackBarBehavior.floating,
                            width: 325,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ImportScreen()),
                          );
                        }
                      },
                      child: const Text(
                        'Import Product',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFBBDEFB),
                        Color(0xFFF8BBD0),
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    //color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () {
                      if (n1 == 0) {
                        const snackBar = SnackBar(
                          content: Text(
                            'You don'
                            't have product yet, please enter your product first ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 325,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExportScreen()),
                        );
                      }
                    },
                    child: const Text(
                      'Export Product',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFBBDEFB),
                        Color(0xFFF8BBD0),
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    //color: Colors.purple,
                    textColor: const Color(0xFFF8BBD0),
                    onPressed: () {
                      if (n1 == 0) {
                        const snackBar = SnackBar(
                          content: Text(
                            'You don'
                            't have product yet, please enter your product first ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFF8BBD0),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 325,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CorruptedScreen()),
                        );
                      }
                    },
                    child: const Text(
                      'Corrupted Product',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFBBDEFB),
                        Color(0xFFF8BBD0),
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    //color: Colors.purple,
                    textColor: Color(0xFFF8BBD0),
                    onPressed: () {
                      if (n1 == 0) {
                        const snackBar = SnackBar(
                          content: Text(
                            'You don'
                            't have product yet, please enter your product first ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFF8BBD0),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 325,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        _ShowInventory(context);
                      }
                    },
                    child: const Text(
                      'Doing Inventory',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFBBDEFB),
                        Color(0xFFF8BBD0),
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    //color: Colors.purple,
                    textColor: Color(0xFFF8BBD0),
                    onPressed: () {
                      if (n1 == 0) {
                        const snackBar = SnackBar(
                          content: Text(
                            'You don'
                            't have product yet, please enter your product first ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          ),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 325,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        _ShowFinancialValue(context);
                      }
                    },
                    child: const Text(
                      'Financial value',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFBBDEFB),
                        Color(0xFFF8BBD0),
                        Colors.purple,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    //color: Colors.purple,
                    textColor: Color(0xFFF8BBD0),
                    onPressed: () {
                      _ShowReview(context);
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Display()),
                      );
                      */
                    },
                    child: const Text(
                      'Review',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0,color: Colors.deepPurple),
                    ),
                  ),
                ),
                /*
                Container(
                  margin: EdgeInsets.all(25),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.purple,
                          Colors.red,
                          Colors.amber,
                        ],
                      ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    //color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () {
                    },
                    child: const Text(
                      'Scan QR',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                */
              ])),
            )),
      ],
    );
  }
}
