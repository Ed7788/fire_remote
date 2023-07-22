import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../cubit_internet/internet_cubit.dart';
import 'home_page.dart';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final internetCubit = InternetCubit(connectivity: Connectivity());
  @override
  void initState() {
      Future.delayed(const Duration(seconds: 3), () async {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context){
              return const HomePage();
            }));
      });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
   return const SpinKitCubeGrid(
        duration: Duration(seconds: 1),
        color: Colors.greenAccent,
        size: 300);
  }
}