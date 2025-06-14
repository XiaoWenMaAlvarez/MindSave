import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class CustomGrupoEmocionesCompleto extends StatelessWidget {
  final String title;
  final Emociones grupoEmociones;

  const CustomGrupoEmocionesCompleto({
    super.key,
    required this.title, 
    required this.grupoEmociones,
  });

  @override
  Widget build(BuildContext context) {

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

      TextStyle subtitleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: Colors.green,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 16,
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
            ],
            if(emocionesSeleccionadas.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Intensidad de las emociones antes: ", 
                        style: subtitleStyle,
                        children: [
                          TextSpan(
                            text: "${grupoEmociones.porcentajeCreenciaAntes}%",
                            style: bodyStyle
                          )
                        ]
                      )
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "Intensidad de las emociones después: ", 
                        style: subtitleStyle,
                        children: [
                          TextSpan(
                            text: "${grupoEmociones.porcentajeCreenciaDespues}%",
                            style: bodyStyle
                          )
                        ]
                      )
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
        ],
    );
  }

}


