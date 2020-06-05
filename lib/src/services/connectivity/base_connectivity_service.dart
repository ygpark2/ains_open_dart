import 'dart:async';

import 'package:ains_open_dart/src/services/connectivity/connectivity_state.dart';

abstract class BaseConnectivityService {
  Stream<ConnectivityState> get onConnectivityChanged;
  Future<ConnectivityState> checkConnectivityState();
  Future<bool> get hasConnection;
}
