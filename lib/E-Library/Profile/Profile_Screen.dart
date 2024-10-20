import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_library/E-Library/Home_Screen.dart';
import 'package:e_library/E-Library/Profile/ProfileMenuWidget.dart';
import 'package:e_library/E-Library/Profile/UpdateProfileScreen.dart';
import 'package:e_library/Provider/App_theme_provider.dart';
import 'package:e_library/Provider/App_theme.dart';
import 'package:e_library/log_in/FirstRoute.dart';
import 'package:e_library/Provider/Localization.dart';
import 'package:e_library/E-Library/Profile/Add_Book.dart';
import 'package:e_library/E-Library/Soft_Delete.dart';
import 'package:e_library/E-Library/Notifications.dart';
import 'package:e_library/E-Library/My_Favorite.dart';
import 'package:e_library/E-Library/warehouse/warehouse.dart';

import 'package:flutter/material.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




bool _islanguage = false;

class Profile extends ConsumerWidget {
  const Profile(BuildContext context, {super.key});
  @override
  Widget build(context, WidgetRef ref) {
    return MaterialApp(
      title: 'My Profile',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(context, ref.watch(appThemeProvider)),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: _MyProfile(),
    );
  }
}

class _MyProfile extends ConsumerWidget {

  Widget buildSectionTitle(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 30,fontFamily: 'Raleway',fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink[100],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      width: 300,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(context, WidgetRef ref) {
    var isDarkMode = ref.watch(appThemeProvider);

    var userDetails = [
      'Name : ${profileInfo['user']['name']}',
      'Details:${profileInfo['user']['deatils']}',
      'Birth Date:${profileInfo['user']['birthDate']}',
      'Location:${profileInfo['user']['location']} ',
      'Phone:${profileInfo['user']['phone_n']}',
      'Number of books:${profileInfo['bookCount']}'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Color(0xFFF8BBD0), fontSize: 30,fontFamily: 'Lucida Calligraphy Font',fontStyle: FontStyle.italic,fontWeight: FontWeight.w700)
      )),
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

                Map<String, dynamic> myMap3 = await getNumberOfProuduct(token);
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
                  Container(
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:  CachedNetworkImage(
                          height: 120,
                          width: 120,
                          imageUrl: 'http://10.0.2.2:8000/${profileInfo['user']['image']}',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url,
                              error) =>
                              Image.asset(
                                "assets/ic_profile.jpeg",
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                          fit: BoxFit.cover,
                        )
                        //Image(image: AssetImage('assets/ic_profile.jpeg'))
                    ),
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
                      child: const Icon(
                        LineAwesomeIcons.pencil_square,
                        color: Color(0xFFF8BBD0),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
               Text(profileInfo['user']['name'], style: TextStyle(fontSize: 30),),
              Text(profileInfo['user']['email'],
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: colors(context).home1,
                      onPrimary: const Color(0xFFF8BBD0),
                      side: BorderSide.none,
                      shape: const StadiumBorder()
                  ),

                  child: const Text("Edit Profile",
                      style: TextStyle(fontSize: 25)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              buildSectionTitle('User details'),
              buildContainer(
                child: ListView.builder(
                  itemCount: userDetails.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          userDetails[index],
                          style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: myBottomAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Book',
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => addBook()),
          );
        },
        child: const Icon(Icons.add, size: 40,color:Color(0xFFF8BBD0)),
      ),
    );
  }
}
