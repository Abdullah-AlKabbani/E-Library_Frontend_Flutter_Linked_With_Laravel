// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'dart:convert';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/log_in/Sign_up.dart';
import 'package:e_library/log_in/Verify.dart';
import 'package:e_library/Provider/Localization.dart';


var url = 'http://10.0.2.2:8000/api/login';

int myID = 0;

Map<String, dynamic> showTopRate = {};

Future<Map<String, dynamic>> topRate(String token) async {
  url = 'http://10.0.2.2:8000/api/getTopRate';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> booksList = jsonDecode(response.body);
    var topBooks = booksList['topBooks'];

    return {
      'topBooks': topBooks,
    };
  } else {
    throw Exception('Failed to get books');
  }
}

Future<Map<String, dynamic>> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/login'),
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String token = data['token'];
    final int myId = data['id'];

    // Store token in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    return {
      'id': myId,
      'token': token,
    };
  } else {
    throw Exception('Failed to login: ${response.body}');
  }
}


String token = '';
class FirstRoute extends StatelessWidget {
  const FirstRoute(BuildContext context, {Key? key}) : super(key: key);
  static const String _title = 'Log in';

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: _title,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            foregroundColor:
            Color(0xFFE3F2FD), //here you can give the text color
          )),
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
            body: MyStatefulWidget(),
          ),
        ],
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
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
                  height: 90,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Welcome To Our E-Library ..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFE3F2FD),
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                          fontFamily: 'Jokerman'),
                    )),
                const SizedBox(
                  height: 60,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Enter Username and Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFFE3F2FD),
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          fontFamily: 'Lucida Calligraphy Font',
                          fontStyle: FontStyle.italic),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController1,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      filled: true,
                      fillColor: Colors.blue[100],
                      labelStyle: const TextStyle(color: Colors.purple),
                      border: const OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 3, color: Colors.purple)),
                      labelText: 'User name',
                      icon: Icon(Icons.person, color: Colors.blue[100]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: !_isvisible,
                    controller: passwordController1,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.blue[100],
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        border: const OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 3, color: Colors.purple)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.purple),
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
                TextButton(
                  onPressed: ()async {


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  Verify(context),
                      ),
                    );
                  },
                  child: const Text('Forgot Password',
                      style: TextStyle(
                          color: Color(0xFFE3F2FD),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: 250,
                  alignment: Alignment.center,
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
                    textColor: Colors.white,
                    onPressed: () async {


                      if (nameController1.text == '' ||
                          passwordController1.text == '') {
                        const snackBar = SnackBar(
                          content: Text(
                              textAlign: TextAlign.center,
                              'You need to fill in all fields before we can proceed'),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 350,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (nameController1.text != '' &&
                          passwordController1.text != '') {
                        var response = await http.post(Uri.parse(url), body: {
                          "email": nameController1.text,
                          "password": passwordController1.text
                        });

                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        if (response.statusCode == 200) {
                          Map<String, dynamic> Mymap = await login(
                              nameController1.text, passwordController1.text);
                          token = Mymap['token'].toString();
                          showTopRate = await topRate(token);
                          myID = int.parse(Mymap['id'].toString());
                          Map<String, dynamic> myMap2 = await money(token);
                          myMoney = myMap2['wallet'];
                          print(myMoney);

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(context),
                            ),
                          );
                        } else if (response.statusCode == 201) {
                          const snackBar = SnackBar(
                            content: Text(
                                textAlign: TextAlign.center,
                                'Check your email or password and try again'),
                            backgroundColor: Colors.purpleAccent,
                            behavior: SnackBarBehavior.floating,
                            width: 350,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        } else if (response.statusCode == 400) {
                          const snackBar = SnackBar(
                            content: Text(
                                textAlign: TextAlign.center,
                                'Check your email or password and try again'),
                            backgroundColor: Colors.purpleAccent,
                            behavior: SnackBarBehavior.floating,
                            width: 350,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        }
                      }
                    },
                    child:  Text(
                      AppStrings().LOGIN,
                      style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Does not have account?',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE3F2FD))),
                    TextButton(
                      child: const Text('Sign Up',
                          style: TextStyle(
                              color: Color(0xFFE3F2FD),
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  Sign_Up(context),
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
