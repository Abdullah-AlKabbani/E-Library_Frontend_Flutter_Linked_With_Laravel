import 'dart:convert';
import 'dart:async';

import 'package:e_library/E-Library/Deatels_Book.dart';
import 'package:e_library/E-Library/Search.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/E-Library/Profile/Profile_Screen.dart';
import 'package:e_library/E-Library/Soft_Delete.dart';
import 'package:e_library/E-Library/Notifications.dart';
import 'package:e_library/E-Library/My_Favorite.dart';
import 'package:e_library/E-Library/Categore_Book.dart';
import 'package:e_library/E-Library/warehouse/warehouse.dart';
import 'package:e_library/Provider/App_theme_provider.dart';
import 'package:e_library/Provider/App_theme.dart';
import 'package:e_library/Provider/Localization.dart';
import 'package:e_library/E-Library/Categore_Book.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';


int categoryID = 0;

int num_product = 0;
bool myIsPaid = false;
int myMoney = 0;
late List<String> listNameProducts;


Map<String, dynamic> showSearchList = {};
Future<Map<String,dynamic>> showSearche(String token,String searchTerm) async {
  const url = 'http://10.0.2.2:8000/api/searchBooks';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: {
      'searchTerm': searchTerm,
    },
  );


  print('Response body: ${response.body}');

  final Map<String, dynamic> search = jsonDecode(response.body);
  var list = search['Book'];


  if (response.statusCode == 200) {
    return {
      'Book': list,
    };
  }
  else{
    return{
      'Book': list,
    };
  }
}


Future<bool> paid(String token) async {
  const url = 'http://10.0.2.2:8000/api/paid';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Map<String, dynamic> profileInfo = {};

Future<Map<String,dynamic>> profil(String token,int id) async {
  url = 'http://10.0.2.2:8000/api/userProfil/$id';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },

  );

  print('Response body: ${response.body}');
  final Map<String, dynamic> user = jsonDecode(response.body);

  Map list = user['user'];
  int count = user['bookCount'];

  if (response.statusCode == 200) {
    return {
      'user': list,
      'bookCount':count
    };
  }
  else{
    return{
      'user': list,
      'bookCount':count
    };
  }
}


Future<Map<String, dynamic>> money(String token) async {
  const url = 'http://10.0.2.2:8000/api/mony';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final int money = data['wallet'];

    return {
      'wallet': money,
    };
  }

  else {
    throw Exception('Failed to get number of products');
  }
}

Future<void> messageShowAlertDialog(BuildContext dialogContext, String message) async {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text('Operation Status:',
        style: TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        )),

    content: Text(message),

    actions: <Widget>[
      ElevatedButton(
        onPressed: () async {
          Navigator.of(dialogContext).pop();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.purple, // Background color
        ),
        child: const Text(
          'Ok',
          style: TextStyle(fontSize: 20,color: Color(0xFFF8BBD0)),
        ),
      ),
    ],
    backgroundColor: Colors.purple[100],
  );

  return showDialog(
    context: dialogContext,
    builder: (BuildContext dialogContext) {
      return alert;
    },
  );
}

Future<Map<String, dynamic>> isPaid(String token) async {
  const url = 'http://10.0.2.2:8000/api/isPaid';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  print("**************************");
  final Map<String, dynamic> data = jsonDecode(response.body);
  final bool myispaid = data['status'];
  print(myispaid);
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    return {
      'status': myispaid,
    };
  }

  else {
    throw Exception('Failed to get number of products');
  }
}

Future<Map<String, dynamic>> getNumberOfProuduct(String token) async {
  const url = 'http://10.0.2.2:8000/api/count';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final int numProduct = data['num_products'];

    return {
      'num_products': numProduct,
    };
  }

  else {
    throw Exception('Failed to get number of products');
  }
}

Future<Map<String, List<String>>> nameProducts(String token) async {
  const url = 'http://10.0.2.2:8000/api/name';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<String> nameProducts = data['name_products'].cast<String>();

    return {
      'name_products': nameProducts,
    };
  }
  else{
    throw Exception('Failed to get name of products');
  }
}


Map<String, dynamic> showDeleteList = {};
Future<Map<String, dynamic>> delete(String token) async {
  url = 'http://10.0.2.2:8000/api/showDelete';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> booksList = jsonDecode(response.body);
    var Delete = booksList['Delete'];

    return {
      'Delete': Delete,
    };
  } else {
    throw Exception('Failed to get books');
  }
}

Map<String, dynamic> showFavoriteList = {};
Future<Map<String, dynamic>> favorite(String token) async {
  url = 'http://10.0.2.2:8000/api/showFavorite';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> booksList = jsonDecode(response.body);
    var favorite = booksList['favorite'];

    return {
      'favorite': favorite,
    };
  } else {
    throw Exception('Failed to get books');
  }
}


Map<String, dynamic> showNotificationList = {};
Future<Map<String,dynamic>> showNotification(String token) async {
  const url = 'http://10.0.2.2:8000/api/getNotification';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Response body: ${response.body}');

  final Map<String, dynamic> Notification = jsonDecode(response.body);
  var list = Notification['Notification'];


  if (response.statusCode == 200) {
    return {
      'Notification': list,
    };
  }
  else{
    return{
      'Notification': list,
    };
  }
}

Future<bool> logout(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  const url = 'http://10.0.2.2:8000/api/logout';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Clear the token after logout
    await prefs.remove('token');
    return true;
  } else {
    print('Logout failed: ${response.body}');
    return false;
  }
}

Map<String, dynamic> showBooksList = {};
Future<Map<String, dynamic>> Book(String token, int id) async {
  url = 'http://10.0.2.2:8000/api/list/$id';
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $token',
  },);

  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final Map<String, dynamic> booksList = jsonDecode(response.body);
    var books = booksList['books'];

    return {
      'books': books,
    };
  } else {
    throw Exception('Failed to get books');
  }
}


bool _islanguage = false;

class MyHomePage extends ConsumerWidget {
  const MyHomePage(BuildContext context, {super.key});
  @override
  Widget build(context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Light/Dark Theme',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(context, ref.watch(appThemeProvider)),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: _MyHomePageState(),
    );
  }
}

class _MyHomePageState extends ConsumerWidget {
  TextEditingController searchController = TextEditingController();

  Widget? _star(double num) {
    int num1 = num.round();
    if (num1 == 1) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    } else if (num1 == 2) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    } else if (num1 == 3) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    } else if (num1 == 4) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    } else if (num1 == 5) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ],
      );
    }else if (num1 == 0) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    }
  }

  @override
  Widget build(context, WidgetRef ref) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      _selectedIndex = index;
    }

    var isDarkMode = ref.watch(appThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings().Home,
            style: const TextStyle(color: Color(0xFFF8BBD0), fontSize: 30,fontFamily: 'Lucida Calligraphy Font',fontStyle: FontStyle.italic,fontWeight: FontWeight.w700)),
      ),
      drawer: Drawer(
        backgroundColor: colors(context).color4,
        child: ListView(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(1), // Border radius
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      "assets/ic_profile.jpeg",
                      fit: BoxFit.fill,
                      width: 120,
                      height: 120,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 60),
              alignment: Alignment.center,
              child: Text(
                AppStrings().MY_PROFILE,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListTile(
              leading: Icon(isDarkMode ? Icons.brightness_3 : Icons.sunny,
                  color: colors(context).color3),
              title: Text(
                isDarkMode ? AppStrings().Dark_mode : AppStrings().Light_mode,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Consumer(builder: (context, ref, child) {
                return Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    activeColor: colors(context).color5,
                    onChanged: (value) {
                      ref.read(appThemeProvider.notifier).state = value;
                    },
                    value: isDarkMode,
                  ),
                );
              }),
            ),
            ListTile(
              leading: Icon(Icons.translate, color: colors(context).color1),
              title: Text(AppStrings().CHANGE_LANGUAGE,
                  style: Theme.of(context).textTheme.titleMedium),
              trailing: Consumer(builder: (context, ref, child) {
                return Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    activeColor: colors(context).color5,
                    onChanged: (value) async {
                      if (context.locale.languageCode == 'en') {
                        await context.setLocale(const Locale('ar'));
                        _islanguage = true;
                      } else {
                        await context.setLocale(const Locale('en'));
                        _islanguage = false;
                      }
                    },
                    value: _islanguage,
                  ),
                );
              }),
            ),
            ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: colors(context).color2,
                ),
                title: Text(
                  AppStrings().FAVORITE,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () async{
                  showFavoriteList = await favorite(token);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  favoriteList(),
                    ),
                  );
                }
            ),
            ListTile(
                leading: Icon(Icons.notifications, color: colors(context).color7),
                title: Text(
                  AppStrings().Notification,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () async{
                  showNotificationList = await showNotification(token);

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Notifications(),
                    ),
                  );
                }
            ),
            ListTile(
                leading: Icon(Icons.delete, color: colors(context).color5),
                title: Text(
                  AppStrings().DELETE,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onTap: () async{
                  showDeleteList = await delete(token);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Delete(),
                    ),
                  );
                }
            ),
            ListTile(
              leading: Icon(Icons.warehouse, color: colors(context).color6),
              title: Text(AppStrings().Library_Warehouse,
                  style: Theme.of(context).textTheme.titleMedium),
              onTap: () async{

                Map<String, dynamic> myMap3 = await isPaid(token);
                myIsPaid = myMap3['status'];
                print(num_product);

                if(!myIsPaid){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            backgroundColor: Colors.blue[50],
                            title: const Text('Payment Confirmation',style: TextStyle(fontSize:20 )),
                            titleTextStyle: const TextStyle(color: Colors.purple),
                            content:  Text('you want subscribe in Library warehouse service for 100,000 ?'),
                            contentTextStyle: const TextStyle(color: Colors.black54),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                textColor: Colors.purple,
                                child: const Text('CANCEL'),
                              ),
                              MaterialButton(
                                onPressed: () async{
                                  await paid(token);

                                  Map<String, dynamic> myMap2 = await money(token);
                                  myMoney = myMap2['wallet'];

                                  Navigator.of(context).pop();

                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Warehouse()),
                                  );
                                },
                                textColor: Colors.purple,
                                child: const Text('OK'),
                              ),

                            ]
                        );
                      });
                }

                else{
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Warehouse()),
                  );
                }

                Map<String, dynamic> myMap2 = await getNumberOfProuduct(token);
                num_product = myMap2['num_products'];
                print(num_product);

                Map<String, dynamic> myMap = await nameProducts(token);
                listNameProducts = myMap['name_products'].cast<String>();
                print(listNameProducts);
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on, color: colors(context).color3),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings().Wallet,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  StatefulBuilder(
                    builder: (context, setInnerState) => InkWell(
                      onTap: (){
                        setInnerState(() => myMoney = myMoney);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.purple, // Purple color
                          borderRadius: BorderRadius.circular(20), // Oval shape
                        ),
                        child: Text(
                          '$myMoney', // Your double number here
                          style: TextStyle(color: const Color(0xFFF8BBD0),fontWeight: FontWeight.w900), // Pink color for text
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                AppStrings().LOGOUT,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () async{
                bool check_logout = await logout(token);

                if (check_logout) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirstRoute(context),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/home.webp'),
                      fit: BoxFit.fitHeight),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  )),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 1.0,
                    thickness: 2,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppStrings().Categories,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 25),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 1.0,
                    thickness: 2,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            // القسم العلوي - List View أفقي
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              height: 186,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    gradient: colors(context).gradient1,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal, // تحديد الاتجاه إلى أفقي
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            AppStrings().HISTORY,
                            style: const TextStyle(
                                color: Color(0xFF29022A),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800),
                          ),
                          InkWell(
                            child: Container(
                              width: 200,
                              height: 120,
                              margin: const EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset('assets/histo.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            onTap: () async{
                              categoryID = 1;
                              showBooksList = await Book(token,categoryID);

                              // ignore: use_build_context_synchronously

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookList(context,category: AppStrings().HISTORY)),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(AppStrings().PROGRAMING,
                              style: const TextStyle(
                                  color: Color(0xFF29022A),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w800)),
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 200,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset('assets/prog.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            onTap: ()async {
                              categoryID = 2;
                              showBooksList = await Book(token,categoryID);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookList(context,category: AppStrings().PROGRAMING)),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppStrings().LITERAL,
                            style: const TextStyle(
                                color: Color(0xFF29022A),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800),
                          ),

                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 200,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset('assets/adab.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            onTap: ()async {
                              categoryID = 3;
                              showBooksList = await Book(token,categoryID);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookList(context,category: AppStrings().LITERAL)),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppStrings().SEANCE,
                            style: const TextStyle(
                                color: Color(0xFF29022A),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800),
                          ),
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 200,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset('assets/siance.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            onTap: ()async {
                              categoryID = 4;
                              showBooksList = await Book(token,categoryID);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookList(context, category: AppStrings().SEANCE)),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppStrings().NOVEL,
                            style: const TextStyle(
                                color: Color(0xFF29022A),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800),
                          ),
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 200,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset('assets/Novele.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            onTap: () async{
                              categoryID = 5;
                              showBooksList = await Book(token,categoryID);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookList(context,category: AppStrings().NOVEL)),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppStrings().SELF_DEVELOPMENT,
                            style: const TextStyle(
                                color: Color(0xFF29022A),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800),
                          ),
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 200,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset('assets/self.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            onTap: ()async {
                              categoryID = 6;
                              showBooksList = await Book(token,categoryID);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookList(context, category: AppStrings().SELF_DEVELOPMENT)),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 1.0,
                    thickness: 2,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppStrings().TOPRATING,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 25),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    height: 1.0,
                    thickness: 2,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            // القسم السفلي - Form Fields
            Expanded(
              child: ListView.builder(

                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount:showTopRate['topBooks'].length,
                  itemBuilder: (context, index) {




                    return StatefulBuilder(

                      builder: (context, setInnerState) =>

                          InkWell(
                            onTap: () async{
                              bookInfo = await details(
                                  token,showTopRate['topBooks'][index]['id']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Deatels()),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 5, left: 20, right: 20),
                              // width: MediaQuery.of(context).size.width,

                              decoration: BoxDecoration(
                                  gradient: colors(context).gradient1,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30))),

                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(

                                              height: 110,
                                              width: 80,
                                              child: CachedNetworkImage(
                                                imageUrl: 'http://10.0.2.2:8000/${showTopRate['topBooks'][index]['image']}',
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget: (context, url,
                                                    error) =>
                                                    Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(child: _star(
                                              double.parse(showTopRate['topBooks'][index]['rate'].toString())),)
                                        ],
                                      ),
                                      const SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 207,
                                            child: Text(
                                                showTopRate['topBooks'][index]['name'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          SizedBox(
                                            width: 207,
                                            child: Text(
                                                showTopRate['topBooks'][index]['author'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    myComment(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.comment_outlined,
                                                    color: Colors.black38,
                                                  )),

                                              Icon(
                                                color: showTopRate['topBooks'][index]['isFavorite'] ? Colors.red : Colors.grey,
                                                showTopRate['topBooks'][index]['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                                              ),

                                              Row(
                                                children: [
                                                  Text(
                                              showTopRate['topBooks'][index]['price'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.w800,
                                                        color:
                                                        Colors.purpleAccent),
                                                    textAlign: TextAlign
                                                        .start,
                                                  ),
                                                  const Icon(
                                                    Icons.money_off,
                                                    color: Colors
                                                        .purpleAccent,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    );
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: myBottomAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search',
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.blue[50],
                  title: const Text('Search'),
                  titleTextStyle: const TextStyle(color: Colors.purple),
                  content: const Text('Search with book name or author name.'),
                  contentTextStyle: const TextStyle(color: Colors.black54),
                  actions: [
                    TextField(
                      onChanged: (value) {},
                      controller: searchController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                            const BorderSide(color: Colors.purple, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.purple),
                          ),
                          filled: true,
                          fillColor: Colors.blue[100],
                          labelStyle: const TextStyle(color: Colors.purple),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.purple)),
                          labelText: 'Search',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: Colors.purple[300],
                            ),
                            onPressed: () {},
                          )),
                    ),

                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () async{
                            showSearchList = await showSearche(token,searchController.text);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(),
                              ),
                            );
                          },
                          textColor: Colors.purple,
                          child: const Text('OK'),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          textColor: Colors.purple,
                          child: const Text('CANCEL'),
                        )
                      ],
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.search_sharp, size: 40,color:Color(0xFFF8BBD0)),
      ),

    );

  }
}

BottomAppBar myBottomAppBar(BuildContext context){
  return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: colors(context).appBar1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  MyHomePage(context),
                  ),
                );
              },
              icon: const Icon(Icons.home,size: 30, color:  Color(0xFFF8BBD0))
          ),
          IconButton(
              onPressed: ()async {
                print("myid = " + "$myID");
                profileInfo = await profil(token,myID);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  Profile(context),
                  ),
                );
              },
              icon: const Icon(Icons.account_circle_sharp, size: 30, color: Color(0xFFF8BBD0))
          )
        ],
      )
  );
}