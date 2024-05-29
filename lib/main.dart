import 'package:curd_app/product_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
      theme:lightThemedata(),
      darkTheme: darkThemedata(), 
      home: Product_List()
    );
  }

  ThemeData lightThemedata(){
    return ThemeData(
      brightness: Brightness.light,
     
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
           style: ElevatedButton.styleFrom(
                  
                  fixedSize: Size.fromWidth(double.maxFinite),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
                ),
        )
      );
  }
ThemeData darkThemedata(){
    return ThemeData(
      brightness: Brightness.dark,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
           style: ElevatedButton.styleFrom(
                  
                  fixedSize: Size.fromWidth(double.maxFinite),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
                ),
        )
      );
  }
}

