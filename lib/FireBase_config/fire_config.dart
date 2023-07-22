import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config_keys.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._() : _remoteConfig = FirebaseRemoteConfig.instance;

  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() => _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig;

  String get welcomeMessage => _remoteConfig.getString(FirebaseRemoteConfigKeys.welcomeMessage);





  Future<void> _setConfigSettings() async => _remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 1),
    ),
  );
  Future<void> _setDefaults() async => _remoteConfig.setDefaults(
    const {
      FirebaseRemoteConfigKeys.welcomeMessage: 'Default message.',
    },
  );

  Future<void> fetchAndActivate() async {
    bool updated = await _remoteConfig.fetchAndActivate();

  }


  Future<String> getLinkFromRemoteConfig() async {
    final link = _remoteConfig.getString('fire_remote_config');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedLink', link);
   print(link);
    return link;
  }


  Future<void> initialize() async {
    try {
      await _setConfigSettings();
      await _setDefaults();
      await fetchAndActivate();
      debugPrint('Firebase Remote Config initialized successfully');
    } catch (e) {
      debugPrint('Error initializing Firebase Remote Config: $e');
    }
  }
}
final message = FirebaseRemoteConfigService().welcomeMessage;
