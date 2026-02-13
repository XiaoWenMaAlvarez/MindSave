
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/auth/infrastructure/errors/auth_errors.dart';
import 'package:mindsave/auth/infrastructure/infrastructure.dart';

import '../../../home/infrastructure/services/services.dart';
import '../../domain/domain.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = "",
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final LocalStorageService localStorageService;


  AuthNotifier({
    required this.authRepository,
    required this.localStorageService
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  _setLoggedUser(User user) async {
    await localStorageService.setKeyValue("token", user.token);
    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user,
      errorMessage: "",
    );
  }

  Future<void> logout([String? errorMessage]) async {
    await localStorageService.removeKey("token");

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage ?? "",
    );
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
      return true;
    } on WrongCredentials {
      await logout("Credenciales incorrectas");
      return false;
    } on ConnectionTimeout {
      await logout("Conexión perdida");
      return false;
    } on EmailNotVerified {
      await logout("Cuenta aún no activada, por favor, revise su bandeja de entrada y siga las instrucciones para activarla");
      return false;
    } catch(e) {
      await logout("Error al iniciar sesión");
      return false;
    }
  }

  Future<String?> registerUser(String email, String password, String name) async {
    try {
      final String? result = await authRepository.register(email, password, name);
      return result;
    } on ConnectionTimeout {
      return "Conexión perdida";
    }catch(e) {
      return "Error al crear cuenta";
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      final String? result = await authRepository.resetPassword(email);
      return result;
    } on ConnectionTimeout {
      return "Conexión perdida";
    }catch(e) {
      return "Error al restablecer la contraseña";
    }
  }

  void checkAuthStatus() async{
    final String? token = await localStorageService.getValue<String>("token");
    if(token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout();
    }

  }

}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoriesImpl(AuthDatasourceImpl());
  final localStorageService = LocalStorageServiceImpl();
  return AuthNotifier(
    authRepository: authRepository,
    localStorageService: localStorageService,
  );
});

