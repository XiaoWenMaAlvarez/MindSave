import 'dart:convert';

import 'package:mindsave/testBreveEstadoAnimo/domain/datasources/test_breve_estado_de_animo_datasource.dart';
import 'package:mindsave/testBreveEstadoAnimo/domain/entities/test_breve_estado_de_animo.dart';
import 'package:mindsave/testBreveEstadoAnimo/infrastructure/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mappers/test_breve_estado_de_animo_mapper.dart';

class TestBreveEstadoDeAnimoLocalDatasource extends TestBreveEstadoDeAnimoDatasource{

  late Future<SharedPreferences> preferencesStore;

  TestBreveEstadoDeAnimoLocalDatasource() {
    preferencesStore = initSharedPreferences();
  }

  Future<SharedPreferences> initSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }
  

  void _codificarYGuardarTestsEnLocal(List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimoDecodificado, SharedPreferences localStorage) {
    List<Map<String, dynamic>> nvoTestsBreveEstadoDeAnimoJSON = testsBreveEstadoDeAnimoDecodificado.map(
      (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) => testBreveEstadoDeAnimo.toJson())
      .toList();
    
    List<String> nvoTestsBreveEstadoDeAnimoCodificado = nvoTestsBreveEstadoDeAnimoJSON.map(
      (Map<String, dynamic> testBreveEstadoDeAnimoJSON) => jsonEncode(testBreveEstadoDeAnimoJSON)
      ).toList();

    localStorage.setStringList("testsBreveEstadoDeAnimo", nvoTestsBreveEstadoDeAnimoCodificado);

    return;
  }


  @override
  Future<void> saveTestBreveEstadoDeAnimo(TestBreveEstadoDeAnimo nvoTestBreveEstadoDeAnimo) async {
    final localStorage = await preferencesStore;

    List<String> testsBreveEstadoDeAnimoCodificado = localStorage.getStringList("testsBreveEstadoDeAnimo") ?? [];

    List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimoDecodificado = testsBreveEstadoDeAnimoCodificado.map((String testBreveEstadoDeAnimoStr) {
      Map<String, dynamic> testBreveEstadoDeAnimoJSON = jsonDecode(testBreveEstadoDeAnimoStr);
      return TestBreveEstadoDeAnimo.fromJson(testBreveEstadoDeAnimoJSON);
    }).toList();

    testsBreveEstadoDeAnimoDecodificado.add(nvoTestBreveEstadoDeAnimo);

    _codificarYGuardarTestsEnLocal(testsBreveEstadoDeAnimoDecodificado, localStorage);

    return;
  }

  
  @override
  Future<List<TestBreveEstadoDeAnimo>> getTestBreveEstadoDeAnimoByYear(int year) async {
    final localStorage = await preferencesStore;

    List<String> testsBreveEstadoDeAnimoCodificado = localStorage.getStringList("testsBreveEstadoDeAnimo") ?? [];

    List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimoDecodificado = testsBreveEstadoDeAnimoCodificado.map((String testBreveEstadoDeAnimoStr) {
      Map<String, dynamic> testBreveEstadoDeAnimoJSON = jsonDecode(testBreveEstadoDeAnimoStr);
      
      TestBreveEstadoDeAnimoResponse testBreveEstadoDeAnimoResponse = TestBreveEstadoDeAnimoResponse.fromJson(testBreveEstadoDeAnimoJSON);
      
      return TestBreveEstadoDeAnimoMapper.testBreveEstadoDeAnimoDBToEntity(testBreveEstadoDeAnimoResponse);
    }).toList();

    List<TestBreveEstadoDeAnimo> retorno = testsBreveEstadoDeAnimoDecodificado.where((TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) {
      return testBreveEstadoDeAnimo.fechaCreacion.year == year;
    }).toList();

    return retorno;
  }

  
  @override
  Future<bool> isTestBreveRealizadoHoy() async {
    final localStorage = await preferencesStore;

    List<String> testsBreveEstadoDeAnimoCodificado = localStorage.getStringList("testsBreveEstadoDeAnimo") ?? [];

    List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimoDecodificado = testsBreveEstadoDeAnimoCodificado.map((String testBreveEstadoDeAnimoStr) {
      Map<String, dynamic> testBreveEstadoDeAnimoJSON = jsonDecode(testBreveEstadoDeAnimoStr);
      
      TestBreveEstadoDeAnimoResponse testBreveEstadoDeAnimoResponse = TestBreveEstadoDeAnimoResponse.fromJson(testBreveEstadoDeAnimoJSON);
      
      return TestBreveEstadoDeAnimoMapper.testBreveEstadoDeAnimoDBToEntity(testBreveEstadoDeAnimoResponse);
    }).toList();

    return testsBreveEstadoDeAnimoDecodificado.any(
      (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) => 
      testBreveEstadoDeAnimo.fechaCreacion.year == DateTime.now().year && 
      testBreveEstadoDeAnimo.fechaCreacion.month == DateTime.now().month &&
      testBreveEstadoDeAnimo.fechaCreacion.day == DateTime.now().day
    );
  }

  
  @override
  Future<TestBreveEstadoDeAnimo?> getTodayTestBreveEstadoDeAnimo() async {
    final localStorage = await preferencesStore;

    List<String> testsBreveEstadoDeAnimoCodificado = localStorage.getStringList("testsBreveEstadoDeAnimo") ?? [];

    List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimoDecodificado = testsBreveEstadoDeAnimoCodificado.map((String testBreveEstadoDeAnimoStr) {
      Map<String, dynamic> testBreveEstadoDeAnimoJSON = jsonDecode(testBreveEstadoDeAnimoStr);
      
      TestBreveEstadoDeAnimoResponse testBreveEstadoDeAnimoResponse = TestBreveEstadoDeAnimoResponse.fromJson(testBreveEstadoDeAnimoJSON);
      
      return TestBreveEstadoDeAnimoMapper.testBreveEstadoDeAnimoDBToEntity(testBreveEstadoDeAnimoResponse);
    }).toList();

    bool isTestBreveRealizadoHoy = testsBreveEstadoDeAnimoDecodificado.any(
      (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) => 
      testBreveEstadoDeAnimo.fechaCreacion.year == DateTime.now().year && 
      testBreveEstadoDeAnimo.fechaCreacion.month == DateTime.now().month &&
      testBreveEstadoDeAnimo.fechaCreacion.day == DateTime.now().day
    );
    
    if(!isTestBreveRealizadoHoy){
      return null;
    }

    TestBreveEstadoDeAnimo retorno = testsBreveEstadoDeAnimoDecodificado.firstWhere(
      (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) => 
      testBreveEstadoDeAnimo.fechaCreacion.year == DateTime.now().year && 
      testBreveEstadoDeAnimo.fechaCreacion.month == DateTime.now().month &&
      testBreveEstadoDeAnimo.fechaCreacion.day == DateTime.now().day
    );

    return retorno;
  }

  
  @override
  Future<void> eliminarTestBreveEstadoDeAnimoDeHoy() async {
    final localStorage = await preferencesStore;

    List<String> testsBreveEstadoDeAnimoCodificado = localStorage.getStringList("testsBreveEstadoDeAnimo") ?? [];

    List<TestBreveEstadoDeAnimo> testsBreveEstadoDeAnimoDecodificado = testsBreveEstadoDeAnimoCodificado.map((String testBreveEstadoDeAnimoStr) {
      Map<String, dynamic> testBreveEstadoDeAnimoJSON = jsonDecode(testBreveEstadoDeAnimoStr);
      
      TestBreveEstadoDeAnimoResponse testBreveEstadoDeAnimoResponse = TestBreveEstadoDeAnimoResponse.fromJson(testBreveEstadoDeAnimoJSON);
      
      return TestBreveEstadoDeAnimoMapper.testBreveEstadoDeAnimoDBToEntity(testBreveEstadoDeAnimoResponse);
    }).toList();

    bool isTestBreveRealizadoHoy = testsBreveEstadoDeAnimoDecodificado.any(
      (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) => 
      testBreveEstadoDeAnimo.fechaCreacion.year == DateTime.now().year && 
      testBreveEstadoDeAnimo.fechaCreacion.month == DateTime.now().month &&
      testBreveEstadoDeAnimo.fechaCreacion.day == DateTime.now().day
    );
    
    if(!isTestBreveRealizadoHoy){
      return;
    }

    testsBreveEstadoDeAnimoDecodificado.removeWhere(
      (TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) => 
      testBreveEstadoDeAnimo.fechaCreacion.year == DateTime.now().year && 
      testBreveEstadoDeAnimo.fechaCreacion.month == DateTime.now().month &&
      testBreveEstadoDeAnimo.fechaCreacion.day == DateTime.now().day
    );

    _codificarYGuardarTestsEnLocal(testsBreveEstadoDeAnimoDecodificado, localStorage);

    return;
  }

  
  @override
  Future<void> editarTestBreveEstadoDeAnimoDeHoy(TestBreveEstadoDeAnimo testBreveEstadoDeAnimo) async {
    await eliminarTestBreveEstadoDeAnimoDeHoy();
    await saveTestBreveEstadoDeAnimo(testBreveEstadoDeAnimo);
    return;
  }
  
}
