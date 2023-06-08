
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme= ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black, size: 30),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey),
              // is not restarted.
              primarySwatch: Colors.blue,
            );

ThemeData darkTheme= ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor('333739'),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light),
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                iconTheme: const IconThemeData(color: Colors.white, size: 30),
                elevation: 0.0,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey),
              // is not restarted.
              primarySwatch: Colors.blue,
            );