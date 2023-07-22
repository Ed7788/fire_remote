import 'package:device_info/device_info.dart';

Future<bool> checkIsEmu() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

  final phoneModel = androidInfo.model;
  final buildProduct = androidInfo.product;
  final buildHardware = androidInfo.hardware;

  // Your existing logic to check if it's an emulator
  return (androidInfo.fingerprint.startsWith("generic") ||
      phoneModel.contains("google_sdk") ||
      phoneModel.contains("droid4x") ||
      phoneModel.contains("Emulator") ||
      phoneModel.contains("Android SDK built for x86") ||
      androidInfo.manufacturer.contains("Genymotion") ||
      buildHardware == "goldfish" ||
      buildHardware == "vbox86" ||
      buildProduct == "sdk" ||
      buildProduct == "google_sdk" ||
      buildProduct == "sdk_x86" ||
      buildProduct == "vbox86p" ||
      androidInfo.brand.contains('google') ||
      androidInfo.board.toLowerCase().contains("nox") ||
      androidInfo.bootloader.toLowerCase().contains("nox") ||
      buildHardware.toLowerCase().contains("nox") ||
      !androidInfo.isPhysicalDevice ||
      buildProduct.toLowerCase().contains("nox") ||
      androidInfo.brand.startsWith("generic") &&
          androidInfo.device.startsWith("generic") ||
      "google_sdk" == buildProduct);
}
