import 'package:flutter/material.dart';
import '../screen/home_page.dart';
import '../screen/loading_screen.dart';


const String homeRoute = '/';
const String homePage = '/home_page';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case homeRoute:
        return MaterialPageRoute(builder:(context) => const LoadingScreen());
      case homePage:
        return MaterialPageRoute(builder:(context) => const HomePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}