import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class CustomCheckBoxGroupEmociones extends StatefulWidget {
  final String title;
  final Emociones grupoEmociones;

  const CustomCheckBoxGroupEmociones({
    super.key,
    required this.title, 
    required this.grupoEmociones,
  });

  @override
  State<CustomCheckBoxGroupEmociones> createState() => _CustomCheckBoxGroupEmocionesState();
}

class _CustomCheckBoxGroupEmocionesState extends State<CustomCheckBoxGroupEmociones> {

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
  Widget build(BuildContext context) {

    final TextEditingController controller = TextEditingController(text: widget.grupoEmociones.porcentajeCreenciaAntes?.toString() ?? "");

    return ExpansionTile(
        title: Text(widget.title),
        children: [
          for (int i = 0; i < widget.grupoEmociones.listaEmociones.length; i++)
            CheckboxListTile(
              title: Text(widget.grupoEmociones.listaEmociones[i]),
              value: widget.grupoEmociones.seleccionEmociones[i], 
              onChanged: (bool? value) => setState(() {
                widget.grupoEmociones.seleccionEmociones[i] = value ?? widget.grupoEmociones.seleccionEmociones[i];
              })
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Intensidad de las emociones (0 - 100)%"),
                hintText: "Ej. 50 (sin decimales ni %)"
              ),
              onChanged: (value) {
                widget.grupoEmociones.porcentajeCreenciaAntes = int.tryParse(value);
              },
              validator: validarPorcentaje,
            ),
            SizedBox(height: 10),
        ],
    );
  }
}