
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';
import 'package:e_library/E-Library/Profile/Profile_Screen.dart';
import 'package:get/get.dart';
import 'package:e_library/Provider/App_theme.dart';

import 'package:http/http.dart' as http;


Future<bool> editProfile(String token,String name,String password, String passwordConfig, String deatils, String location, String image, String birthDate) async {
  const url = 'http://10.0.2.2:8000/api/add_employee';
  final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "name": name,
        "password": password,
        "passwordConfig":passwordConfig,
        "deatils":deatils,
        "location": location,
        "image": image,
        "birthDate":birthDate,

      }
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}



bool _islanguage = false;


class UpdateProfileScreen extends StatefulWidget {

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final ImagePicker _picker = ImagePicker();
  String? coverImagePath;



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
    TextEditingController detailsController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController configPassController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();
    bool _isvisible = false;

    DateTime selectedDate = DateTime.now();
    var formattedDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    birthDateController.text = formattedDate.toString();

    Future<void> _selectedDate(context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2025),
        helpText: 'Select birth date', // Can be used as title
        cancelText: 'Not now',
        confirmText: 'Ok',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.purple,
                onPrimary: Color(0xFFF8BBD0),
                surface: Colors.purple,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.purple[100],
            ),
            child: child!,
          );
        },
      ).then((pickedDate) {
        if (pickedDate != null) {
          setState(() async {
            selectedDate = pickedDate;
            formattedDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
            birthDateController.text = formattedDate.toString();
          });
        }
      });
    }


    //final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(LineAwesomeIcons.angle_left)),
          title: const Text("Edit Profile",
              style: TextStyle(
                  color: Color(0xFFF8BBD0),
                  fontSize: 30,
                  fontFamily: 'Lucida Calligraphy Font',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700))),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage("assets/ic_profile.jpeg"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: colors(context).home1),
                      child: IconButton(icon:Icon(LineAwesomeIcons.camera,
                          color: Color(0xFFF8BBD0), size: 20
                      ), onPressed: () { pickImage; },

                         ),
                    ),
                  ),
                ],
              ),

              // -- Form Fields
              StatefulBuilder(
                builder: (context, setInnerState) => SingleChildScrollView(
                  child: Form(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: const TextStyle(color: Colors.purple),
                              controller: fullNameController,
                              cursorColor: Colors.purple,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor:Color(0xFFF8BBD0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.purple, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                                labelStyle: TextStyle(color: Colors.purple),
                                border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.purple)),
                                labelText: 'User Name',
                                icon: Icon(Icons.person, color: Colors.purple),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: const TextStyle(color: Colors.purple),
                              obscureText: !_isvisible,
                              controller: passwordController,
                              cursorColor: Colors.purple,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:const Color(0xFFF8BBD0),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.purple, width: 2.0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.purple),
                                  ),
                                  labelStyle: TextStyle(color: Colors.purple),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 3, color: Colors.purple)),
                                  labelText: 'Password',
                                  icon: const Icon(Icons.lock, color: Colors.purple),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isvisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.purple,
                                    ),
                                    onPressed: () {
                                      setInnerState(() {
                                        _isvisible = !_isvisible;
                                      });
                                    },
                                  )),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: const TextStyle(color: Colors.purple),
                              controller: configPassController,
                              cursorColor: Colors.purple,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFF8BBD0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.purple, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                                labelStyle: TextStyle(color: Colors.purple),
                                border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.purple)),
                                labelText: 'Configuration password',
                                icon:
                                Icon(Icons.sync_lock, color: Colors.purple),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: const TextStyle(color: Colors.purple),
                              controller: detailsController,
                              cursorColor: Colors.purple,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor:Color(0xFFF8BBD0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.purple, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                                labelStyle: TextStyle(color: Colors.purple),
                                border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.purple)),
                                labelText: 'About Me',
                                icon: Icon(Icons.info_sharp, color: Colors.purple),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: const TextStyle(color: Colors.purple),
                              controller: locationController,
                              cursorColor: Colors.purple,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor:Color(0xFFF8BBD0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.purple, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                                labelStyle: TextStyle(color: Colors.purple),
                                border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.purple)),
                                labelText: 'Current Location',
                                icon: Icon(Icons.location_on, color: Colors.purple),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: const TextStyle(color: Colors.purple),
                              controller: birthDateController,
                              cursorColor: Colors.purple,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:const Color(0xFFF8BBD0),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.purple, width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                                labelStyle: const TextStyle(color: Colors.purple),
                                border: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.purple)),
                                labelText: 'Birth Date',
                                icon: const Icon(Icons.celebration, color: Colors.purple),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.date_range, color: Colors.purple,),
                                  onPressed: () {
                                     _selectedDate(context);
                                  },
                                )
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),
                          // -- Form Submit Button
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
                                bool checkUpdate = await editProfile( token,
                                    fullNameController.text,
                                    passwordController.text,
                                    configPassController.text,
                                    detailsController.text,
                                    locationController.text,
                                    coverImagePath!,
                                  birthDateController.text,
                                ); if(checkUpdate) {
                                  const snackBar = SnackBar(
                                    content: Text(
                                      'Edit profile completed successfully',
                                      textAlign: TextAlign.center,
                                    ),
                                    backgroundColor: Colors.purpleAccent,
                                    behavior: SnackBarBehavior.floating,
                                    width: 325,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar);
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Profile(context),
                                      ),
                                    );
                                  });
                                }
                                },

                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFFE3F2FD),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
