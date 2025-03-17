import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class AppTheme{
  static ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0
      ),



      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor:Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true, // Show text label when selected
        showUnselectedLabels: true, // Show text label when unselected
        type: BottomNavigationBarType.fixed, // Ensures all items stay visible
      ),


      textTheme: TextTheme(

        bodySmall: TextStyle(
          fontWeight:FontWeight.w400,
          fontSize: 14.sp,
          color: Colors.black,
        ),


      )
  );
}