import 'package:flutter/material.dart';

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        color1: isDarkTheme ? Colors.redAccent : Colors.deepOrange,
        color2: isDarkTheme ? Colors.lightGreen : Colors.pinkAccent,
        color3: isDarkTheme ? Colors.amber : Colors.amber[900],
        color4: isDarkTheme ? const Color(0xFF29022A) : Colors.purple[100],
        color5: isDarkTheme ? Colors.amber : Colors.purple,
        color6: isDarkTheme ? Colors.cyan : Colors.indigo,
        color7: isDarkTheme ? Colors.pinkAccent : Colors.lightGreen,
        appBar1: isDarkTheme ? const Color(0xFF29022A) : Colors.purple,
        home1: isDarkTheme ? Colors.purple[300] : Colors.purple,

        gradient1: isDarkTheme ? const LinearGradient(
            colors: [
              Color(0xFF89578F),
              Color(0xFF6A9196),
              Color(0xFF3A566B),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
        )
        :  const LinearGradient(
            colors: [
              Color(0xFFE1BEE7),
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
        ),

      ),

    ],
    scaffoldBackgroundColor: isDarkTheme ? const Color(0xFF130013) : const Color(0xFFE3F2FD),
    primaryColor: isDarkTheme ? const Color(0xFFF8BBD0) : Colors.purple,
    textTheme:
    Theme.of(context).textTheme
        .copyWith(
      titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
    )
        .apply(
      bodyColor: isDarkTheme ?  const Color(0xFFF8BBD0) : Colors.purple,
      displayColor: Colors.grey,
    ),



    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
          isDarkTheme ? const Color(0xFF370538) : Colors.purple),
    ),

    listTileTheme: ListTileThemeData(
        iconColor: isDarkTheme ? const Color(0xFF370538) : Colors.purple
    ),

    appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme ? const Color(0xFF370538) : Colors.purple,
        iconTheme: const IconThemeData(color: Color(0xFFF8BBD0)),

    ),


    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: isDarkTheme ? const Color(0xFF370538) : Colors.purple),


    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: isDarkTheme ? const Color(0xFF370538) : Colors.purple),
  );
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final Color? color4;
  final Color? color5;
  final Color? color6;
  final Color? color7;
  final Color? appBar1;
  final Color? home1;
  final Gradient? gradient1;

  const AppColors({
    required this.color1,
    required this.color2,
    required this.color3,
    required this.color4,
    required this.color5,
    required this.color6,
    required this.color7,
    required this.appBar1,
    required this.home1,
    required this.gradient1,
  });

  @override
  AppColors copyWith({
    Color? color1,
    Color? color2,
    Color? color3,
    Color? color4,
    Color? color5,
    Color? color6,
    Color? color7,
    Color? appBar1,
    Color? home1,
    Gradient? gradient1,

  }) {
    return AppColors(
      color1: color1 ?? this.color1,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
      color4: color4 ?? this.color4,
      color5: color5 ?? this.color5,
      color6: color6 ?? this.color6,
      color7: color7 ?? this.color7,
      appBar1: appBar1 ?? this.appBar1,
      home1: home1 ?? this.home1,
      gradient1: gradient1 ?? this.gradient1,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      color1: Color.lerp(color1, other.color1, t),
      color2: Color.lerp(color2, other.color2, t),
      color3: Color.lerp(color3, other.color3, t),
      color4: Color.lerp(color4, other.color4, t),
      color5: Color.lerp(color5, other.color5, t),
      color6: Color.lerp(color6, other.color6, t),
      color7: Color.lerp(color7, other.color7, t),
      appBar1: Color.lerp(appBar1, other.appBar1, t),
      home1: Color.lerp(home1, other.home1, t),
      gradient1: Gradient.lerp(gradient1, other.gradient1, t),
    );
  }
}
