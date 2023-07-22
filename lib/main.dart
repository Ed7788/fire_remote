import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:upgames.pinplays/route/route.dart';
import 'FireBase_config/fire_config.dart';
import 'cubit_internet/internet_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  await FirebaseRemoteConfigService().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final InternetCubit internetCubit = InternetCubit(
      connectivity: Connectivity());

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => internetCubit,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: homeRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }

}

