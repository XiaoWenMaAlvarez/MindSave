import 'package:dio/dio.dart';

import 'package:mindsave/config/constants/environment.dart';
import 'package:mindsave/test_breve_estado_animo/domain/datasources/test_breve_estado_de_animo_datasource.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/test_breve_estado_de_animo.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/models/models.dart';
import '../mappers/test_breve_estado_de_animo_mapper.dart';

class TestBreveEstadoDeAnimoAPIDatasource extends TestBreveEstadoDeAnimoDatasource{

  late final Dio dio;

  TestBreveEstadoDeAnimoAPIDatasource(){
    dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrlBase
      )
    );
  }

  
  TestBreveEstadoDeAnimo _fromJsonToEntity(Map<String, dynamic> json) {
    TestBreveEstadoDeAnimoResponse testBreveEstadoDeAnimoResponse = TestBreveEstadoDeAnimoResponse.fromJson(json);
    TestBreveEstadoDeAnimo testBreveEstadoDeAnimoEntity = TestBreveEstadoDeAnimoMapper.testBreveEstadoDeAnimoResponseToEntity(testBreveEstadoDeAnimoResponse);
    return testBreveEstadoDeAnimoEntity;
  }

  Map<String, dynamic> _fromEntityToJson(TestBreveEstadoDeAnimo testBreveEstadoDeAnimoEntity) {
    TestBreveEstadoDeAnimoResponse testBreveResponse = TestBreveEstadoDeAnimoMapper.testBreveEstadoDeAnimoEntityToResponse(testBreveEstadoDeAnimoEntity);
    Map<String, dynamic> testBreveResponseJSON = testBreveResponse.toJson();
    return testBreveResponseJSON;
  }

  @override
  Future<void> saveTestBreveEstadoDeAnimo(TestBreveEstadoDeAnimo nvoTestBreveEstadoDeAnimo) async {
    Map<String, dynamic> nvoTestBreveJson = _fromEntityToJson(nvoTestBreveEstadoDeAnimo);

    final response = await dio.post("/api/test-breve-estado-de-animo/", data: {
      ...nvoTestBreveJson,
      "idUsuario": "65f1a2b3c4d5e6f7a8b9c0d1"
    });

    if(response.statusCode != 201) {
      throw Exception("Error al guardar el test breve estado de ánimo");
    }

    return;
  }


  @override
  Future<List<TestBreveEstadoDeAnimo>> getTestBreveEstadoDeAnimoByYear(int year) async {
    // TODO: implement endpoint

    final response = await dio.get("/api/test-breve-estado-de-animo/", queryParameters: {
      "year": year,
    });

    final List<Map<String, dynamic>> testsBreveEstadoDeAnimoResponseJson = response.data;

    final List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimoEntities = testsBreveEstadoDeAnimoResponseJson.map(
      (Map<String, dynamic> testBreveResponse) => _fromJsonToEntity(testBreveResponse)
    ).toList();

    return testsBreveEstadoDeAnimoEntities;    
  }

  @override
  Future<bool> isTestBreveRealizadoHoy() async {
    // TODO: implement getTodayTestBreveEstadoDeAnimo
    final response = await dio.get("/api/test-breve-estado-de-animo/is-test-breve-realizado-hoy/", queryParameters: {
      "userID": "",
    });
    return response.data;
  }

  @override
  Future<TestBreveEstadoDeAnimo?> getTodayTestBreveEstadoDeAnimo() async{
    // TODO: implement getTodayTestBreveEstadoDeAnimo
    final response = await dio.get("/api/test-breve-estado-de-animo/get-today-test-breve-estado-de-animo/", queryParameters: {
      "userID": "",
    });

    return _fromJsonToEntity(response.data);
  }

  @override
  Future<void> editarTestBreveEstadoDeAnimoDeHoy(TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) async {
    // TODO: implement editarTestBreveEstadoDeAnimoDeHoy
    await eliminarTestBreveEstadoDeAnimoDeHoy();
    await saveTestBreveEstadoDeAnimo(testBreveEstadoDeAnimo);
    return;
  }

  @override
  Future<void> eliminarTestBreveEstadoDeAnimoDeHoy() async {
    // TODO: implement eliminarTestBreveEstadoDeAnimoDeHoy
    await dio.get("/api/test-breve-estado-de-animo/", queryParameters: {
      "userID": "",
    });
    return;
  }

  


}
