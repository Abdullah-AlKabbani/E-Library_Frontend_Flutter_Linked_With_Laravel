// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/log_in/Otp.dart';

var url = 'http://10.0.2.2:8000/api/login';


Future<bool> forget(String token,String email) async {
  const url = 'http://10.0.2.2:8000/api/forget';
  final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "email":email,

      }
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
TextEditingController emailController = TextEditingController();
class Verify extends StatelessWidget {
  const Verify(BuildContext context, {Key? key}) : super(key: key);
  static const String _title = 'Verify';

  @override
  Widget build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: Scaffold(
          backgroundColor: const Color(0xFFE3F2FD),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(
                250.0), // Change the height of the app bar
            child: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom:
                  Radius.circular(30), // Change the shape of the app bar
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/verify.jpg'), // Add an image as the background
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Verify'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFE3F2FD),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          body: MyVerify(),
        ));
  }
}

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {

  @override
  Widget build(context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Enter yor email to send reset code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                          fontFamily: 'RobotoCondensed'),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    cursorColor: Colors.purple,
                    decoration:  InputDecoration(
                      focusedBorder:const OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      enabledBorder:  const OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.purple),
                      ),
                      filled: true,
                      fillColor: Colors.blue[100],
                      labelStyle:  const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 3, color: Colors.purple)),
                      labelText: 'Email',

                      icon: Icon(Icons.email, color: Colors.purple),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  height: 50,
                  width: 250,
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
                  child: MaterialButton(
                    //color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () async {

                      bool check_forget = await forget(token, emailController.text,);

                      if(check_forget) {
                        const snackBar = SnackBar(
                          content: Text(
                            'A reset code will be sent to your email',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 325,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  Otp(context),
                            ),
                          );
                        });
                      }
                      else{
                        const snackBar = SnackBar(
                          content: Text(
                              textAlign: TextAlign.center,
                              'There is error: the code dose not sent'),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 350,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }



                    },

                    child: const Text(
                      'Send Message',
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
        ));
  }
}
