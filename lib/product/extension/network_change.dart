import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkResult {
  on,
  off;

  static NetworkResult checkConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.other:
        return NetworkResult.on;
      case ConnectivityResult.none:
        return NetworkResult.off;
    }
  }
}

typedef NetworkChangeCallback = void Function(NetworkResult result);

abstract class INetworkChangeManager {
  Future<NetworkResult> checkNetwork();
  void handleNetworkChange(NetworkChangeCallback onChange);
  void dispose();
}

class NetworkManager extends INetworkChangeManager {
  static late final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _subscription;
  NetworkManager() {
    _connectivity = Connectivity();
  }

  @override
  Future<NetworkResult> checkNetwork() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    return NetworkResult.checkConnectivityResult(result);
  }

  @override
  void handleNetworkChange(NetworkChangeCallback onChange) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      onChange.call(NetworkResult.checkConnectivityResult(event));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}
