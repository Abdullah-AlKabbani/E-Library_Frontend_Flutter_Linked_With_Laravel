// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/log_in/Otp.dart';
import 'package:e_library/log_in/Verify.dart';
var url = 'http://10.0.2.2:8000/api/login';


Future<bool> changPassword(String token,String email,String password, String passwordConfig) async {
  const url = 'http://10.0.2.2:8000/api/changPassword';
  final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "email":email,
        "password":password,
        "password_confirmation":passwordConfig
      }
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

class Forget extends StatelessWidget {
  const Forget(BuildContext context, {Key? key}) : super(key: key);
  static const String _title = 'Change Password';

  @override
  Widget build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                foregroundColor: Colors.purple//here you can give the text color
            )
        ),

        title: _title,
        home: Scaffold(
          backgroundColor: const Color(0xFFE3F2FD),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(
                420.0), // Change the height of the app bar
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
                        'assets/Forget.jpg'), // Add an image as the background
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Reset Code'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          body: MyForget(),
        ));
  }
}

class MyForget extends StatefulWidget {
  const MyForget({Key? key}) : super(key: key);

  @override
  State<MyForget> createState() => _MyForgetState();
}

class _MyForgetState extends State<MyForget> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  bool _isvisible = false;

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
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Enter new password ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                          fontFamily: 'RobotoCondensed'),
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: !_isvisible,
                    controller: passwordController,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                        focusedBorder:const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF8BBD0),
                        enabledBorder:  const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'Password',
                        labelStyle:  TextStyle(color: Colors.purple),
                        icon:  Icon(Icons.lock, color: Colors.purple),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.purple[400],
                          ),
                          onPressed: () {
                            setState(() {
                              _isvisible = !_isvisible;
                            });
                          },
                        )),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: !_isvisible,
                    controller: passwordController2,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                        focusedBorder:const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF8BBD0),
                        enabledBorder:  const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'Confirm Password',
                        labelStyle:  TextStyle(color: Colors.purple),
                        icon:  Icon(Icons.lock_clock, color: Colors.purple),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.purple[400],
                          ),
                          onPressed: () {
                            setState(() {
                              _isvisible = !_isvisible;
                            });
                          },
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                      if (passwordController.text == '' ||
                          passwordController2.text == '') {

                        const snackBar = SnackBar(
                          content: Text(
                            'You need to fill in all fields before we can proceed',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 325,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      }else if(passwordController.text != '' &&
                          passwordController2.text != ''){

                        bool check_change = await changPassword(token,emailController.text, passwordController.text,passwordController2.text);
                        if(check_change){
                          const snackBar = SnackBar(
                            content: Text(
                              'Password changed successfully ^_^',
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
                                builder: (context) => FirstRoute(context),
                              ),
                            );
                          });
                        }
                      }

                    },
                    child: const Text(
                      'Confirm',
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

  Widget _textFieldOTP({required bool first, last}) {
    return Container(
      width: 60,
      padding: EdgeInsets.all(5),
      height: 75,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
