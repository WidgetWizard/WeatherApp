import 'package:flutter/material.dart';
import 'package:weatherapp/product/extension/network_change.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({super.key});

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget> {
  late final INetworkChangeManager _networkChange;
  NetworkResult? _networkResult;
  @override
  void initState() {
    _networkChange = NetworkManager();
    super.initState();
    fetchFirstResult();
    _networkChange.handleNetworkChange((result) {
      _updateView(result);
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final result = await _networkChange.checkNetwork();
      _updateView(result);
    });
  }

  void _updateView(NetworkResult result) {
    setState(() {
      _networkResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      crossFadeState: _networkResult != NetworkResult.on
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: Container(
        height: 50,
        color: Colors.black,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.public_off_outlined, color: Colors.white),
            SizedBox(
              width: 10,
            ),
            Text('bağlantı yok',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
      ),
      secondChild: const SizedBox(),
    );
  }
}
