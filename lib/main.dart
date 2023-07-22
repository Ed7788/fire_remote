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

// return FutureBuilder<bool>(
//   future: checkIsEmu(),
//   builder: (context, emulatorSnapshot) {
//     if (emulatorSnapshot.connectionState ==
//         ConnectionState.waiting) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     } else if (emulatorSnapshot.hasError) {
//       return const Center(
//         child: Text('Error checking emulator status'),
//       );
//     }
//     final isEmulator = emulatorSnapshot.data ?? false;
//     if (isEmulator) {
//       // If it's an emulator, navigate to QuizGame
//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         _navigateToQuizGame();
//       });
//       // Since we are navigating, we can return an empty Container
//       // or any other widget. The build method won't complete normally.
//       return Container();
//     } else {
//       // Internet is connected, but the link is not available and it's not an emulator
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Internet is Connected',
//             style: TextStyle(fontSize: 24),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             "Leave here, maybe wanna play?",
//             style: TextStyle(fontSize: 20),
//           ),
//           // If you want the "Game" button, you can uncomment this
//           // ElevatedButton(
//           //   onPressed: () {
//           //     Navigator.push(
//           //       context,
//           //       MaterialPageRoute(
//           //         builder: (context) => const QuizGame(),
//           //       ),
//           //     );
//           //   },
//           //   child: const Text('Game'),
//           // ),
//         ],
//       );
//     }
//   },
// );