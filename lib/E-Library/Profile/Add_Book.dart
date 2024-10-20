import 'dart:io';

import 'package:e_library/log_in/FirstRoute.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


Future<bool> addBookAPI(String token,String name,String author, int price, String description, String type) async {
  String price1 = price.toString();
  const url = 'http://10.0.2.2:8000/api/UploadBook';
  final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "name": name,
        "author": author,
        "descreption":description,
        "price":price1,
        "type":type,

      }
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

String pdfPath = "/data/user/0/com.example.e_library/cache/d5c7d6d9-0ae2-421e-ad2c-bbc3ae25f45d/IMG_20240818_195945.jpg";
String coverImagePath ="/data/user/0/com.example.e_library/cache/file_picker/IMG_20240818_195945.jpg";

class addBook extends StatefulWidget {
  const addBook({super.key});

  @override
  addBookState createState() => addBookState();
}

class addBookState extends State<addBook> {
  TextEditingController nameBookController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  String dropdownvalueTypeBook = 'History';
  // List of items in our dropdown menu
  var itemsEmployee = [
    'History',
    'Programing',
    'Literal',
    'Science',
    'Novel',
    'Self Development',
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );

    if (result != null) {
      setState(() {
        pdfPath = result.files.single.path!;
      });
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        coverImagePath = image.path;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text('Add Book',
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
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.purpleAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  image: DecorationImage(
                    image: AssetImage('assets/addBook.png'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Center(
                      child: Text('Add Your Book Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFFE3F2FD),
                          ))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: nameBookController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8BBD0),
                      labelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.purple)),
                      labelText: 'Book Name',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.drive_file_rename_outline_rounded,
                          color: Colors.purple,
                        ),
                        onPressed: () {},
                      )),
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: authorController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8BBD0),
                      labelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.purple)),
                      labelText: 'Author Name',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.person,
                          color: Colors.purple,
                        ),
                        onPressed: () {},
                      )),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: TextField(
                        controller: priceController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.purple, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purple),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF8BBD0),
                            labelStyle: const TextStyle(color: Colors.purple),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.purple)),
                            labelText: 'Price',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.money_off,
                                color: Colors.purple,
                              ),
                              onPressed: () {},
                            )),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: TextField(
                        controller: phoneController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.purple, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purple),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF8BBD0),
                            labelStyle: const TextStyle(color: Colors.purple),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.purple)),
                            labelText: 'Phone Number',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.phone,
                                color: Colors.purple,
                              ),
                              onPressed: () {},
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: descriptionController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF8BBD0),
                      labelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.purple)),
                      labelText: 'Description',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.menu_book,
                          color: Colors.purple,
                        ),
                        onPressed: () {},
                      )),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text(
                      'The type of book is -> ',
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      dropdownColor: Colors.pink[100],
                      // Initial Value
                      value: dropdownvalueTypeBook,
                      focusColor: Colors.purple[100],
                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.purple,
                      ),

                      // Array list of items
                      items: itemsEmployee.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setInnerState(() => dropdownvalueTypeBook = newValue!);
                      },
                      hint: const Text("Select Category"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                      ),
                      onPressed: pickPdf,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            // <-- Icon
                            color: Color(0xFFF8BBD0),
                            Icons.picture_as_pdf,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Upload Book',
                            style: TextStyle(color: Color(0xFFF8BBD0)),
                          ), // <-- Text
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                      ),
                      onPressed: pickImage,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            // <-- Icon
                            color: Color(0xFFF8BBD0),
                            Icons.photo_camera,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Image Cover',
                            style: TextStyle(color: Color(0xFFF8BBD0)),
                          ), // <-- Text
                        ],
                      ),
                    ),
                    //if (coverImagePath != null) Text("File Path: $coverImagePath"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFE100FB),
                      Colors.purple,
                      Color(0xFF560085),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(80),
                ),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: FlatButton(
                  //color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: () async {
                    print('**************************************************');
                    print(coverImagePath);
                    print(pdfPath);
                    bool check_add_book = await addBookAPI(
                        token,
                        nameBookController.text,
                        authorController.text,
                        int.parse(priceController.text),
                        descriptionController.text,
                        //pdfPath.toString(),
                        //coverImagePath.toString(),
                        dropdownvalueTypeBook
                    );

                    if(check_add_book) {
                      const snackBar = SnackBar(
                        content: Text(
                            textAlign: TextAlign.center,
                            'Book Added Successfully'),
                        backgroundColor: Colors.purpleAccent,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text(
                            textAlign: TextAlign.center,
                            'You Cant Add This Book'),
                        backgroundColor: Colors.purpleAccent,
                        behavior: SnackBarBehavior.floating,
                        width: 350,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },

                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Color(0xFFE3F2FD),
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
