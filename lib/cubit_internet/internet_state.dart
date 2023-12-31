part of 'internet_cubit.dart';

enum ConnectionType {
  connected,
}

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}
class EmulatorDetected extends InternetState {}