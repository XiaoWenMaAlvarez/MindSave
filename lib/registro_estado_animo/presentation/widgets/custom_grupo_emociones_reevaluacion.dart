import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class CustomGrupoEmocionesReevaluacion extends StatelessWidget {
  final String title;
  final Emociones grupoEmociones;
  final GlobalKey<FormState> formKey;

  const CustomGrupoEmocionesReevaluacion({
    super.key,
    required this.title, 
    required this.grupoEmociones,
    required this.formKey
  });

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

    final TextEditingController controller = TextEditingController(
      text: grupoEmociones.porcentajeCreenciaDespues != null ?
        grupoEmociones.porcentajeCreenciaDespues.toString() :
        ""
      );

      List<String> emocionesSeleccionadas = [];

      for(int i = 0; i < grupoEmociones.listaEmociones.length; i++){
        if(grupoEmociones.seleccionEmociones[i]){
          emocionesSeleccionadas.add(grupoEmociones.listaEmociones[i]);
        }
      }

      if(emocionesSeleccionadas.isEmpty){
        grupoEmociones.porcentajeCreenciaDespues = 0;
      }

      TextStyle textStyleBold = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16
      );

      TextStyle textStyleTitleBold = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
      );

    return Column(
        children: [
          SizedBox(height: 10),
          Text(title, style: textStyleTitleBold,),
          SizedBox(height: 10),
          if(emocionesSeleccionadas.isEmpty) Text("No se seleccionaron emociones en este grupo"),
          if(emocionesSeleccionadas.isNotEmpty) 
          ...[
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("Emociones seleccionadas: ", style: textStyleBold),
              )
            ),
          ],
          if(emocionesSeleccionadas.isNotEmpty)
          for (int i = 0; i < emocionesSeleccionadas.length; i++)
            ...[
              CheckboxListTile(
                title: Text(emocionesSeleccionadas[i]),
                value: true, 
                onChanged: (value){}
              ),
              SizedBox(height: 10),
            ],
            if(emocionesSeleccionadas.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Intensidad de las emociones antes: ${grupoEmociones.porcentajeCreenciaAntes}%", style: textStyleBold),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Intensidad de las emociones ahora %"),
                            hintText: "Ej. 50 (sin decimales ni %)"
                          ),
                          onChanged: (value) {
                            if(validarPorcentaje(value) == null){
                              grupoEmociones.porcentajeCreenciaDespues = int.parse(value);
                            }
                          },
                          validator: validarPorcentaje,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
        ],
    );
  }

}


