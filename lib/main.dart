import 'package:animated_food_menu/presentation/home_screen.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:const  Color(0xffeed6d4),
        primaryColorDark:const  Color(0xffa88683),
        primaryColorLight:const  Color(0xffbd9b9a),
        iconTheme: const IconThemeData(
          color: Color(0xffb69c9b)
        )
      ),
      home: HomeScreen(

      ),
    );
  }
}
