// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

//import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/E-Library/warehouse/warehouse.dart';
import 'package:e_library/E-Library/Home_Screen.dart';



Future<bool> addProducts(String token, String product, String size, String category, String color) async {
  const url = 'http://10.0.2.2:8000/api/product';
  final response = await http.post(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    "product": product,
    "siz": size,
    "colore": color,
    "type": category,
  });

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

TextEditingController nameProductController = TextEditingController();

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
      home: const GenerateQRCode(),
    );
  }
}

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  GenerateQRCodeState createState() => GenerateQRCodeState();
}

class GenerateQRCodeState extends State<GenerateQRCode> {
  TextEditingController sizeAreaController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  Color mycolor = Colors.amberAccent;

  String dropdownvalueCategoury = 'Stationery';
  // List of items in our dropdown menu
  var itemsCategory = [
    'School tools',
    'Stationery',
    'Pens',
    'Notebooks',
    'books',
    'Magazines',
    'bags',
    'stories',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text("Add Products",
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
      body: StatefulBuilder(
        builder: (context, setInnerState) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Enter Products Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameProductController,
                  cursorColor: Colors.purple,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.purple)),
                    labelText: 'Product Name',
                    icon: Icon(Icons.inventory, color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: sizeAreaController,
                  cursorColor: Colors.purple,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.purple)),
                    labelText: 'Product Size',
                    icon: Icon(Icons.view_in_ar_outlined, color: Colors.purple),
                  ),
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
                      'Product Category -> ',
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    DropdownButton(
                      dropdownColor: Colors.purple[100],
                      // Initial Value
                      value: dropdownvalueCategoury,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.purple,
                      ),

                      // Array list of items
                      items: itemsCategory.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setInnerState(() => dropdownvalueCategoury = newValue!);
                      },
                      hint: const Text("Select Category"),
                    ),
                  ],
                ),
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
                    width: 150,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                          Icon(Icons.color_lens, color: Color(0xFFF8BBD0),),
                          SizedBox(width: 10),
                          Text("Product Color", style: TextStyle(color: Color(0xFFF8BBD0),fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                        ],
                      ),
                    )
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Pick a color!'),
                          backgroundColor: Colors.purple[100],
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: mycolor, //default color
                              onColorChanged: (Color color) {
                                //on color picked
                                setState(() {
                                  mycolor = color;
                                });
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors
                                    .purple[800], // Background color
                              ),
                              child: const Text('DONE'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); //dismiss the color picker
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                  padding: const EdgeInsets.all(20),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                      height: 20,
                      width: 200,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:const [
                            Icon(Icons.qr_code, color: Color(0xFFF8BBD0)),
                            SizedBox(width: 10),
                            Text('GENERATE QR CODE',style: TextStyle(color: Color(0xFFF8BBD0),fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                          ],
                        ),
                      )
                  ),

                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        QRImage()));
                  }
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                  padding: const EdgeInsets.all(20),
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                      height: 20,
                      width: 150,
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
                    bool check_add_product = await addProducts(token, nameProductController.text, sizeAreaController.text, dropdownvalueCategoury ,mycolor.toString());

                    if(check_add_product) {
                      const snackBar = SnackBar(
                        content: Text(
                            textAlign: TextAlign.center,
                            'Product added successfully'),
                        backgroundColor: Colors.purpleAccent,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Map<String, dynamic> myMap2 = await getNumberOfProuduct(token);
                      num_product = myMap2['num_products'];
                      print(num_product);

                      n1 = num_product;

                      Map<String, dynamic> myMap = await nameProducts(token);
                      listNameProducts = myMap['name_products'].cast<String>();
                      print(listNameProducts);

                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text(
                            textAlign: TextAlign.center,
                            'There is error: Product dose not added'),
                        backgroundColor: Colors.purpleAccent,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QRImage extends StatefulWidget {


  final TextEditingController controller = nameProductController;

  @override
  State<QRImage> createState() => _QRImageState();
}

class _QRImageState extends State<QRImage> {

  // For android and ios
  // recall with: saveQRImage();

  /*
  GlobalKey globalKey = GlobalKey();

  Future<void> saveQRImage() async {
    try {
      RenderRepaintBoundary? boundary = globalKey.currentContext.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        return;
      }
      if (boundary!.debugNeedsPaint) {
        await Future.delayed(Duration(milliseconds: 20));
        return saveQRImage();
      }
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
      await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      Uint8List pngBytes = byteData.buffer.asUint8List();



      final result = await ImageGallerySaver.saveImage(pngBytes);
      print('Image saved to gallery: $result');
    } catch (e) {
      print(e.toString());
    }
  }
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text("QR Product",
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              QrImage(
                data: widget.controller.text,
                size: 280,
                // You can include embeddedImageStyle Property if you
                //wanna embed an image from your Asset folder
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: const Size(
                    100,
                    100,
                  ),
                ),
                gapless: false,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
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
                          width: 110,
                          child: Row(
                            children:const [
                              Icon(Icons.save, color: Color(0xFFF8BBD0)),
                              SizedBox(width: 10),
                              Text('SAVE QR',style: TextStyle(color: Color(0xFFF8BBD0),fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                            ],
                          )
                      ),

                      onPressed: () async {

                        // Dowmload form web.
                        /*
                        final qrImageData = QrImage(
                          data: widget.controller.text,
                          size: 280,
                          // You can include embeddedImageStyle Property if you
                          //wanna embed an image from your Asset folder
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: const Size(
                              100,
                              100,
                            ),
                          ),
                          gapless: false,
                        );
                        // final blob = Blob([qrImageData.buffer.asUint8List()], 'image/png');
                        final blob = Blob([qrImageData], 'image/png');
                        final url = Url.createObjectUrlFromBlob(blob);
                        AnchorElement(href: url)
                          ..setAttribute('download', 'qr_image.png')
                          ..click();
                        Url.revokeObjectUrl(url);
                        */
                      }
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                      padding: const EdgeInsets.all(20),
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                          height: 20,
                          width: 110,
                          child: Row(
                            children:const [
                              Icon(Icons.share, color: Color(0xFFF8BBD0)),
                              SizedBox(width: 10),
                              Text('Share QR',style: TextStyle(color: Color(0xFFF8BBD0),fontWeight: FontWeight.w600,fontSize: 17),textAlign: TextAlign.center,),
                            ],
                          )
                      ),

                      onPressed: () async {

                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}