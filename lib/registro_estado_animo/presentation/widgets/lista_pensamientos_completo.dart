import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class ListaPensamientosCompleto extends StatelessWidget {

  final String title;
  final Pensamiento pensamiento;

  const ListaPensamientosCompleto({super.key,
    required this.title,
    required this.pensamiento,
  });

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).colorScheme.primary;

    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    TextStyle subtitleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: Colors.green,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 16,
    );

    List<String> distorsiones = Pensamiento.listaDistorsiones;
    List<String> distorsionesIdentificadas = [];
    for(int i = 0; i < pensamiento.distorsionesIdentificadas.length; i++){
      if(pensamiento.distorsionesIdentificadas[i]){
        distorsionesIdentificadas.add(distorsiones[i]);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(title, style: titleStyle),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: "Pensamiento negativo: ", 
              style: subtitleStyle,
              children: [
                TextSpan(
                  text: pensamiento.pensamientoNegativo,
                  style: bodyStyle
                )
              ]
            )
          ),
          SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: "Porcentaje de creencia antes: ", 
              style: subtitleStyle,
              children: [
                TextSpan(
                  text: "${pensamiento.porcentajeCreenciaPensamientoNegativoAntes}%",
                  style: bodyStyle
                )
              ]
            )
          ),
          SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: "Porcentaje de creencia después: ", 
              style: subtitleStyle,
              children: [
                TextSpan(
                  text: "${pensamiento.porcentajeCreenciaPensamientoNegativoDespues}%",
                  style: bodyStyle
                )
              ]
            )
          ),
          SizedBox(height: 10),
          Text("Distorsiones identificadas: ", style: subtitleStyle),
          SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.0,
            children: [
              if(distorsionesIdentificadas.isEmpty) 
                Text("No se han identificado distorsiones por ahora"),
              for(int i = 0; i < distorsionesIdentificadas.length; i++)
                Text("- ${distorsionesIdentificadas[i]}")
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: "Pensamiento positivo: ", 
                  style: subtitleStyle,
                  children: [
                    TextSpan(
                      text: pensamiento.pensamientoPositivo,
                      style: bodyStyle
                    )
                  ]
                )
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "Porcentaje de creencia: ", 
                  style: subtitleStyle,
                  children: [
                    TextSpan(
                      text: "${pensamiento.porcentajeCreenciaPensamientoPositivo}%",
                      style: bodyStyle
                    )
                  ]
                )
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider()
        ],
      ),
    );
  }
}