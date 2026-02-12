import 'package:dio/dio.dart';
import 'package:mindsave/auth/domain/domain.dart';
import 'package:mindsave/auth/infrastructure/errors/auth_errors.dart';
import 'package:mindsave/config/constants/environment.dart';

class AuthDatasourceImpl extends AuthDatasource {

  late final Dio dio;

  AuthDatasourceImpl(){
    dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrlBase
      )
    );
  }

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final Response response = await dio.get("/api/auth/check-status",
        options: Options(
          headers: {
            "Authorization": "Bearer $token"
          }
        )
      );
      final User user = User.fromObject(response.data);
      return user;
    } on DioException catch (e) {
      if(e.response?.statusCode == 401) throw WrongCredentials();
      throw CustomError("Error de Dio desconocido", 1);
    } catch(e) {
      throw CustomError("Error desconocido", 2);
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post("/api/auth/login", data: {
        "email": email,
        "password": password
      });
      return User.fromObject(response.data);
    } on DioException catch (e) {
      if(e.response?.statusCode == 400) throw WrongCredentials();
      if(e.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();
      throw CustomError("Error de Dio desconocido", 1);
    } catch(e) {
      throw CustomError("Error que no es de Dio en la petición desconocido", 1);
    }
  }

  @override
  Future<User> register(String email, String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }

}
