import 'package:expence_tracker/modal/widget/expenses.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

var kcolorschme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 32, 187, 222));
var kDarkcolorschme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 205, 184, 127));
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //  .then((fn) => );
  runApp(
    MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kDarkcolorschme.onPrimaryContainer,
              foregroundColor: kDarkcolorschme.onPrimary),
          colorScheme: kDarkcolorschme,
          cardTheme: const CardTheme().copyWith(
              color: kDarkcolorschme.primary,
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkcolorschme.primary,
                  foregroundColor: kDarkcolorschme.onPrimary)),
        ),
        theme: ThemeData().copyWith(
            colorScheme: kcolorschme,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kcolorschme.onPrimaryContainer,
                foregroundColor: kcolorschme.onPrimary),
            cardTheme: const CardTheme().copyWith(
                color: kcolorschme.primaryContainer,
                margin: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 3.0)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kcolorschme.primary)),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: kcolorschme.primary))),
        themeMode: ThemeMode.dark,
        home: const Expenses()),
  );
}
