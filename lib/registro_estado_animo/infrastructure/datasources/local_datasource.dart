import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mindsave/registro_estado_animo/domain/datasources/registro_estado_animo_datasource.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class RegistroEstadoDeAnimoLocalDatasource extends RegistroEstadoAnimoDatasource{

  late Future<SharedPreferences> preferencesStore;

  Future<SharedPreferences> initSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  RegistroEstadoDeAnimoLocalDatasource() {
    preferencesStore = initSharedPreferences();
  }

  @override
  Future<int> saveRegistroEstadoDeAnimo(RegistroEstadoAnimo registroEstadoAnimo) async {
    final localStorage = await preferencesStore;
    List<String> listaRegistrosEstadoAnimoCodificados = localStorage.getStringList("registrosEstadosAnimo") ?? [];
    
    registroEstadoAnimo.id = await _getNewId();
    Map<String, dynamic> registroEstadoAnimoJson = registroEstadoAnimo.toJson();
    String registroEstadoAnimoCodificado = jsonEncode(registroEstadoAnimoJson);

    listaRegistrosEstadoAnimoCodificados.add(registroEstadoAnimoCodificado);
    localStorage.setStringList("registrosEstadosAnimo", listaRegistrosEstadoAnimoCodificados);
    return registroEstadoAnimo.id;
  }

  @override
  Future<List<RegistroEstadoAnimo>> getRegistroEstadoDeAnimo({int page = 1}) async {
    final localStorage = await preferencesStore;
    List<String> listaRegistrosEstadoAnimoCodificados = localStorage.getStringList("registrosEstadosAnimo") ?? [];

    List<Map<String, dynamic>> listaRegistrosEstadoAnimoJson = List.from(
      listaRegistrosEstadoAnimoCodificados.map(
        (String registroCodificado) => jsonDecode(registroCodificado)
      )
    );

    List<RegistroEstadoAnimo> listaRegistrosEstadoAnimo = List.from(
      listaRegistrosEstadoAnimoJson.map(
        (Map<String, dynamic> registroJson) => RegistroEstadoAnimo.fromJson(registroJson)
      )
    );

    return listaRegistrosEstadoAnimo;
  }
  
  @override
  Future<void> editarRegistroEstadoDeAnimoDeHoy(RegistroEstadoAnimo nvoRegistroEstadoAnimo) async {
    final localStorage = await preferencesStore;
    List<String> listaRegistrosEstadoAnimoCodificados = localStorage.getStringList("registrosEstadosAnimo") ?? [];

    List<Map<String, dynamic>> listaRegistrosEstadoAnimoJson = List.from(
      listaRegistrosEstadoAnimoCodificados.map(
        (String registroCodificado) => jsonDecode(registroCodificado)
      )
    );

    List<RegistroEstadoAnimo> listaRegistrosEstadoAnimo = List.from(
      listaRegistrosEstadoAnimoJson.map(
        (Map<String, dynamic> registroJson) => RegistroEstadoAnimo.fromJson(registroJson)
      )
    );

    listaRegistrosEstadoAnimo = listaRegistrosEstadoAnimo.map((RegistroEstadoAnimo registroEstadoAnimo) {
      if(registroEstadoAnimo.id != nvoRegistroEstadoAnimo.id) return registroEstadoAnimo;
      return nvoRegistroEstadoAnimo;
    }).toList();


    listaRegistrosEstadoAnimoJson = List.from(
      listaRegistrosEstadoAnimo.map(
        (RegistroEstadoAnimo registroEstadoAnimo) => registroEstadoAnimo.toJson()
      )
    );

    listaRegistrosEstadoAnimoCodificados = List.from(
      listaRegistrosEstadoAnimoJson.map(
        (Map<String, dynamic> registroJson) => jsonEncode(registroJson)
      )
    );

    await localStorage.setStringList("registrosEstadosAnimo", listaRegistrosEstadoAnimoCodificados);

    return;
  }
  
  
  @override
  Future<void> eliminarRegistroEstadoDeAnimoDeHoy(int id) async {
    final localStorage = await preferencesStore;
    List<String> listaRegistrosEstadoAnimoCodificados = localStorage.getStringList("registrosEstadosAnimo") ?? [];

    List<Map<String, dynamic>> listaRegistrosEstadoAnimoJson = List.from(
      listaRegistrosEstadoAnimoCodificados.map(
        (String registroCodificado) => jsonDecode(registroCodificado)
      )
    );

    List<RegistroEstadoAnimo> listaRegistrosEstadoAnimo = List.from(
      listaRegistrosEstadoAnimoJson.map(
        (Map<String, dynamic> registroJson) => RegistroEstadoAnimo.fromJson(registroJson)
      )
    );

    listaRegistrosEstadoAnimo.removeWhere((RegistroEstadoAnimo registroEstadoAnimo) => 
      registroEstadoAnimo.id == id
    );

    listaRegistrosEstadoAnimoJson = List.from(
      listaRegistrosEstadoAnimo.map(
        (RegistroEstadoAnimo registroEstadoAnimo) => registroEstadoAnimo.toJson()
      )
    );

    listaRegistrosEstadoAnimoCodificados = List.from(
      listaRegistrosEstadoAnimoJson.map(
        (Map<String, dynamic> registroJson) => jsonEncode(registroJson)
      )
    );

    localStorage.setStringList("registrosEstadosAnimo", listaRegistrosEstadoAnimoCodificados);

    return;
  }

  Future<int> _getNewId() async {
    final localStorage = await preferencesStore;
    List<String> listaRegistrosEstadoAnimoCodificados = localStorage.getStringList("registrosEstadosAnimo") ?? [];

    if(listaRegistrosEstadoAnimoCodificados.isEmpty) return 1;

    Map<String, dynamic> lastRecord = jsonDecode(listaRegistrosEstadoAnimoCodificados.last);

    int lastId = lastRecord["id"];

    return lastId + 1;
  }
  
  @override
  Future<RegistroEstadoAnimo?> getRegistroEstadoDeAnimoById(int id) async {
    final localStorage = await preferencesStore;
    List<String> listaRegistrosEstadoAnimoCodificados = localStorage.getStringList("registrosEstadosAnimo") ?? [];

    List<Map<String, dynamic>> listaRegistrosEstadoAnimoJson = List.from(
      listaRegistrosEstadoAnimoCodificados.map(
        (String registroCodificado) => jsonDecode(registroCodificado)
      )
    );

    List<RegistroEstadoAnimo> listaRegistrosEstadoAnimo = List.from(
      listaRegistrosEstadoAnimoJson.map(
        (Map<String, dynamic> registroJson) => RegistroEstadoAnimo.fromJson(registroJson)
      )
    );

    if(listaRegistrosEstadoAnimo.any((RegistroEstadoAnimo r) => r.id == id)){
      return listaRegistrosEstadoAnimo.firstWhere((RegistroEstadoAnimo r) => r.id == id);
    }
    return null;
  }

  
}