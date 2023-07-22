import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

import '../check_emul.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetDisconnected()) {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((connectivityResult) async {
      try {
        bool isEmulator = await checkIsEmu();
        if (isEmulator) {
          emit(EmulatorDetected());
        } else {
          if (connectivityResult != ConnectivityResult.none) {
            emitInternetConnected(ConnectionType.connected);
          } else {
            emitInternetDisconnected();
          }
        }
      } catch (e) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());




  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
