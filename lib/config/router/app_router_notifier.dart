import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/auth/presentation/providers/auth_provider.dart';

class GoRouterNotifier extends ChangeNotifier {

  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value){
    _authStatus = value;
    notifyListeners();
  }

}

final goRouterNotifierProvider = Provider((ref) {
  final AuthNotifier authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});