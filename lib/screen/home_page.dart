import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgames.pinplays/screen/web_view.dart';
import '../FireBase_config/fire_config.dart';
import '../cubit_internet/internet_cubit.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> _loadLink() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedLink') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfigService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
        centerTitle: true,
      ),
      body: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // else if (state is EmulatorDetected) {
          //   return QuizGame();
          // }
          else if (state is InternetConnected) {
            return FutureBuilder<String>(
              future: _loadLink(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading data'),
                  );
                }

                final linkFromSharedPreferences = snapshot.data;
                if (linkFromSharedPreferences != null &&
                    linkFromSharedPreferences.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WebViewPage(link: linkFromSharedPreferences),
                      ),
                      (route) => false,
                    );
                  });
                } else {
                  return FutureBuilder<String>(
                    future: remoteConfig.getLinkFromRemoteConfig(),
                    builder: (context, remoteConfigSnapshot) {
                      if (remoteConfigSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (remoteConfigSnapshot.hasError) {
                        return const Center(
                          child: Text('Error loading data'),
                        );
                      }

                      final linkFromRemoteConfig = remoteConfigSnapshot.data;
                      if (linkFromRemoteConfig != null &&
                          linkFromRemoteConfig.isNotEmpty) {
                        remoteConfig.getLinkFromRemoteConfig();

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebViewPage(link: linkFromRemoteConfig),
                            ),
                            (route) => false,
                          );
                        });
                      } else {
                        return QuizGame();
                      }

                      return Container();
                    },
                  );
                }

                return Container();
              },
            );
          } else if (state is InternetDisconnected) {
            return const Center(
              child: Text(
                'No Internet Connection. Connect to Internet to continue',
                style: TextStyle(fontSize: 24),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(fontSize: 24),
              ),
            );
          }
        },
      ),
    );
  }
}
