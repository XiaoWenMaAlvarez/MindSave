import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class EmocionesPersonalizadasCheckBoxGroup extends StatefulWidget {
  final Emociones grupoEmociones;

  const EmocionesPersonalizadasCheckBoxGroup({
    super.key,
    required this.grupoEmociones
  });

  @override
  State<EmocionesPersonalizadasCheckBoxGroup> createState() => _EmocionesPersonalizadasCheckBoxGroupState();
}

class _EmocionesPersonalizadasCheckBoxGroupState extends State<EmocionesPersonalizadasCheckBoxGroup> {

  late TextEditingController _controller;  
  late TextEditingController _porcentajeController; 
  late String? _hayError;

  @override
  void initState() {
    _controller = TextEditingController(text: '');  
    _hayError = null;
    _porcentajeController = TextEditingController(text: widget.grupoEmociones.porcentajeCreenciaAntes?.toString() ?? "");
    super.initState();
  }

  String? validarPorcentaje(String? value) {
    if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
    try {
      int numberValue = int.parse(value);
      if(numberValue < 0 || numberValue > 100) return "El valor debe estar entre 0 y 100";
      return null;
    } catch(e) {
      return "El valor debe ser un número entero (sin decimales)";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _porcentajeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Emociones grupoEmociones = widget.grupoEmociones;

    bool isValidaEmocion (String? value) {
      if(value == null || value.trim() == ""){
        setState(() => _hayError = "No puede agregar una emoción vacía");
        return false;
      }
      if(grupoEmociones.listaEmociones.any((String emocion) => emocion == value)){
        setState(() => _hayError = "La emoción ya está agregada");
        return false;
      }
      setState(() => _hayError = null);
      return true;
    } 


    return ExpansionTile(
      title: Text("Otras (describir)"),
      children: [
        for (int i = 0; i < grupoEmociones.listaEmociones.length; i++)
          CheckboxListTile(
            title: Text(grupoEmociones.listaEmociones[i]),
            value: grupoEmociones.seleccionEmociones[i], 
            onChanged: (bool? value) => setState(() {
              if(value != null && !value) {
                widget.grupoEmociones.listaEmociones.removeAt(i);
                widget.grupoEmociones.seleccionEmociones.removeAt(i);
              }
            })
          ),
          SizedBox(height: 10),

          SizedBox(height: 10),
          if(grupoEmociones.listaEmociones.isNotEmpty)
            TextFormField(
              controller: _porcentajeController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Intensidad 0% - 100% (obligatorio)")
              ),
              onChanged: (String? value) {
                grupoEmociones.porcentajeCreenciaAntes = int.parse(value!);
              },
              validator: validarPorcentaje,
            ),

          SizedBox(height: 10),

          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Agregar nueva emoción (opcional)"),
              hintText: "Abrumado/a"
            ),
          ),

          if(_hayError != null) ...[
            SizedBox(height: 5),
            Text("$_hayError", style: TextStyle(color: Colors.red)),
          ],

          SizedBox(height: 5),

          OutlinedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Agregar emoción"),
            onPressed: (){
              String? emocionEscrita = _controller.value.text;
              if(isValidaEmocion(emocionEscrita)){
                widget.grupoEmociones.listaEmociones.add(emocionEscrita);
                widget.grupoEmociones.seleccionEmociones.add(true);
                _controller.text = "";
                setState(() {});
              }
            },
          ),
          SizedBox(height: 10),
      ],
    );
  }
}