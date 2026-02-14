import 'package:dio/dio.dart';

import 'package:mindsave/config/constants/environment.dart';
import 'package:mindsave/test_breve_estado_animo/domain/datasources/test_breve_estado_de_animo_datasource.dart';
import 'package:mindsave/test_breve_estado_animo/domain/entities/test_breve_estado_de_animo.dart';
import 'package:mindsave/test_breve_estado_animo/infrastructure/models/models.dart';
import '../mappers/test_breve_estado_de_animo_mapper.dart';

class TestBreveEstadoDeAnimoAPIDatasource extends TestBreveEstadoDeAnimoDatasource{

  late final Dio dio;
  final String accessToken;

  TestBreveEstadoDeAnimoAPIDatasource({
    required this.accessToken
  }){
    dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrlBase,
        headers: {
          "Authorization": "Bearer $accessToken"
        }
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
    final response = await dio.get("/api/test-breve-estado-de-animo/by-year/$year");
    
    final List<Map<String, dynamic>> testsBreveEstadoDeAnimoResponseJson = List<Map<String, dynamic>>.from(response.data);

    final List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimoEntities = testsBreveEstadoDeAnimoResponseJson.map(
      (Map<String, dynamic> testBreveResponse) => _fromJsonToEntity(testBreveResponse)
    ).toList();

    return testsBreveEstadoDeAnimoEntities;    
  }

  @override
  Future<TestBreveEstadoDeAnimo?> getTodayTestBreveEstadoDeAnimo() async{
    final today = DateTime.now();
    final year = today.year;
    final month = today.month;
    final day = today.day;
    final response = await dio.get("/api/test-breve-estado-de-animo/by-date/$year/$month/$day");
    if(response.data == null) return null;
    return _fromJsonToEntity(response.data);
  }

  @override
  Future<void> editarTestBreveEstadoDeAnimoDeHoy(TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) async {
    Map<String, dynamic> nvoTestBreveJson = _fromEntityToJson(testBreveEstadoDeAnimo);

    final response = await dio.put("/api/test-breve-estado-de-animo/", data: {
      ...nvoTestBreveJson,
      "idUsuario": "65f1a2b3c4d5e6f7a8b9c0d1"
    });

    if(response.statusCode != 200) {
      throw Exception("Error al editar el test breve estado de ánimo");
    }

    return;
  }

  @override
  Future<void> eliminarTestBreveEstadoDeAnimoDeHoy() async {
    final today = DateTime.now();
    final year = today.year;
    final month = today.month;
    final day = today.day;
    await dio.delete("/api/test-breve-estado-de-animo/$year/$month/$day");
    return;
  }

}
