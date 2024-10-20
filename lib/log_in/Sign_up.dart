// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/log_in/Verify.dart';

var url = 'http://10.0.2.2:8000/api/login';

Future<String> register(String email, String password, String passwordConfig, String phone, String name) async {
  const url = 'http://10.0.2.2:8000/api/register';
  final response = await http.post(Uri.parse(url), body: {
    "email": email,
    "password": password,
    "password_confirmation": passwordConfig,
    "phone_n": phone,
    "name": name,

  });
  print('Response status: ${response.statusCode}');

  if (response.statusCode == 200 || response.statusCode == 422) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String message = data['message'];

    return message;
  } else if (response.statusCode == 201){
    return 'User Created Successfully';
  } else {
    throw Exception('Failed to create Department ');
  }
}

class Sign_Up extends StatelessWidget {
  const Sign_Up(BuildContext context, {Key? key}) : super(key: key);
  static const String _title = 'Sign_Up';

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            foregroundColor: Color(0xFFE3F2FD), //here you can give the text color
          )
      ),
      home: Stack(
        children: <Widget>[
          Image.asset(
            "assets/login.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          const Scaffold(
            backgroundColor: Colors.transparent,
            body: MySignUp(),
          ),
        ],
      ),
    );
  }
}

class MySignUp extends StatefulWidget {
  const MySignUp({Key? key}) : super(key: key);

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child:  const Text(
                      'Enter your information please ..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFE3F2FD),
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                          fontFamily: 'Jokerman'
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
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
                      labelText: 'User name',

                      icon: Icon(Icons.person, color: Colors.blue[100]),
                    ),
                  ),
                ),
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

                      icon: Icon(Icons.email, color: Colors.blue[100]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
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
                        fillColor: Colors.blue[100],
                        enabledBorder:  const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'Password',
                        labelStyle:  TextStyle(color: Colors.purple),
                        icon:  Icon(Icons.lock, color: Colors.blue[100]),
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
                  height: 25,
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
                        fillColor: Colors.blue[100],
                        enabledBorder:  const OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.purple),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'Confirm Password',
                        labelStyle:  TextStyle(color: Colors.purple),
                        icon:  Icon(Icons.lock_clock, color: Colors.blue[100]),
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
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
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
                      labelText: 'Phone Number',

                      icon: Icon(Icons.phone, color: Colors.blue[100]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: 250,
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
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: MaterialButton(
                    //color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () async {

                      if (nameController.text == '' || passwordController.text == ''
                          ||  passwordController2.text == '' || emailController.text == '' || phoneController.text == '' ) {
                        const snackBar = SnackBar(
                          content: Text(
                              textAlign: TextAlign.center,
                              'You need to fill in all fields before we can proceed'),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 350,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else if (nameController.text != '' && passwordController.text != ''
                          &&  passwordController2.text != '' && emailController.text != '' && phoneController.text != '') {
                        String checkCreate = await register(
                          emailController.text,
                          passwordController.text,
                          passwordController2.text,
                          phoneController.text,
                          nameController.text,
                        );

                        var snackBar = const SnackBar(
                          content: Text(
                              textAlign: TextAlign.center,
                              'Your account created successfully ^_^'),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 350,
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                    },

                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 25.0,color: Colors.deepPurple,fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('You already have an account?',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color:Color(0xFFE3F2FD))),
                    TextButton(
                      child: const Text(
                          'Log in',
                          style: TextStyle(color: Color(0xFFE3F2FD), fontSize: 25,fontWeight: FontWeight.bold)
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  FirstRoute(context),
                            ));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
