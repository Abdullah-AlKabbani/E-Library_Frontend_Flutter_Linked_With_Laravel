// This program was made By Abdullah AL-Kabbani in 2023 AD.
// Warehouse Management System.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/log_in/Forget.dart';
import 'package:e_library/log_in/Verify.dart';

var url = 'http://10.0.2.2:8000/api/login';


Future<bool> otp(String token,String email, String code) async {
  const url = 'http://10.0.2.2:8000/api/interCode';
  final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "email":email,
        "intercode":code
      }
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

class Otp extends StatelessWidget {
  const Otp(BuildContext context, {Key? key}) : super(key: key);
  static const String _title = 'Reset Code';

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
                        'assets/reset.jpg'), // Add an image as the background
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text('Reset Code'),
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
          body: MyOtp(),
        ));
  }
}

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  List<String> otpValues = List.filled(6,'');


  Widget _textFieldOTP({required bool first, required bool last, required int index}) {
    return Container(
      width: 40,
      child: TextField(
        onChanged: (value) {
          otpValues[index] = value; // تحديث قيمة القائمة
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus(); // الانتقال إلى الخانة التالية
          } else if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus(); // العودة إلى الخانة السابقة
          }
        },
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }




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
                    child: const Text(
                      'Enter the 6-digit code ',
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
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _textFieldOTP(first: true, last: false,index: 0),
                            _textFieldOTP(first: false, last: false,index: 1),
                            _textFieldOTP(first: false, last: false,index: 2),
                            _textFieldOTP(first: false, last: false,index: 3),
                            _textFieldOTP(first: false, last: false,index: 4),
                            _textFieldOTP(first: false, last: true,index: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
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
                  child: MaterialButton(
                    //color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () async {
                      String otpCode = otpValues.join(''); // دمج القيم في سلسلة نصية واحدة

                      print(otpCode);
                      print(otpCode.runtimeType);


                      bool checkOtp = await otp(token, emailController.text,otpCode);

                      if(checkOtp) {
                        const snackBar = SnackBar(
                          content: Text(
                            'Now You Can Change Password',
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
                              builder: (context) =>  Forget(context),
                            ),
                          );
                        });
                      }
                      else{
                        const snackBar = SnackBar(
                          content: Text(
                              textAlign: TextAlign.center,
                              'Pleas Inter The Right Code'),
                          backgroundColor: Colors.purpleAccent,
                          behavior: SnackBarBehavior.floating,
                          width: 350,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }




                    },

                    child: const Text(
                      'Verify',
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
