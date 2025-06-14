import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class CustomFormPensamientoPositivo extends StatelessWidget {

  final String title;
  final Pensamiento pensamiento;
  final GlobalKey<FormState> formKey;

  const CustomFormPensamientoPositivo({super.key,
    required this.title,
    required this.pensamiento,
    required this.formKey
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController pensamientoController = TextEditingController(text: pensamiento.pensamientoPositivo ?? "");
    final TextEditingController porcentajePensamientoPositivoController = TextEditingController(
      text: pensamiento.porcentajeCreenciaPensamientoPositivo == null ? "" : pensamiento.porcentajeCreenciaPensamientoPositivo.toString()
    );
    final TextEditingController porcentajePensamientoNegativoController = TextEditingController(
      text: pensamiento.porcentajeCreenciaPensamientoNegativoDespues == null ? "" : pensamiento.porcentajeCreenciaPensamientoNegativoDespues.toString()
    );

    final Color primaryColor = Theme.of(context).colorScheme.primary;

    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 20,
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
          Text(title, style: titleStyle),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              text: "Descripción: ", 
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
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Agregue un pensamiento positivo", style: subtitleStyle),
                SizedBox(height: 15),
                TextFormField(
                  controller: pensamientoController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Pensamiento positivo"),
                    hintText: "Ej. Tengo derecho a cometer errores"
                  ),
                  validator: isValidoPensamientoPositivo,
                  onChanged: (String? value){
                    pensamiento.pensamientoPositivo = value ?? "";
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: porcentajePensamientoPositivoController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("% de creencia en el pensamiento positivo"),
                    hintText: "Ej. 90"
                  ),
                  onChanged: (String? value) {
                    try {
                      if(validarPorcentajePensamientoPositivo(value) == null){
                        pensamiento.porcentajeCreenciaPensamientoPositivo = int.parse(value!);
                      }
                    } catch (e) {
                      return;
                    }
                  },
                  validator: validarPorcentajePensamientoPositivo,
                ),

                SizedBox(height: 15),
                Text("Vuelva a calificar su creencia en su pensamiento negativo", style: subtitleStyle),
                SizedBox(height: 15),
                TextFormField(
                  controller: porcentajePensamientoNegativoController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("% de creencia en el pensamiento negativo"),
                    hintText: "Ej. 10"
                  ),
                  onChanged: (String? value) {
                    try {
                      if(validarPorcentajePensamientoNegativo(value) == null){
                        pensamiento.porcentajeCreenciaPensamientoNegativoDespues = int.parse(value!);
                      }
                    } catch (e) {
                      return;
                    }
                  },
                  validator: validarPorcentajePensamientoNegativo,
                ),
              ],
            ),
          ),
          
          Divider()
        ],
      ),
    );
  }
}

String? validarPorcentajePensamientoNegativo(String? value) {
    if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
    try {
      int numberValue = int.parse(value);
      if(numberValue < 0 || numberValue > 100) return "El valor debe estar entre 0 y 100";
      return null;
    } catch(e) {
      return "El valor debe ser un número entero (sin decimales)";
    }
  }

  String? validarPorcentajePensamientoPositivo(String? value) {
    if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
    try {
      int numberValue = int.parse(value);
      if(numberValue <= 0 || numberValue > 100) return "El valor debe estar entre 1 y 100";
      return null;
    } catch(e) {
      return "El valor debe ser un número entero (sin decimales)";
    }
  }

  String? isValidoPensamientoPositivo (String? value) {
      if(value == null || value.trim() == ""){
        return "No puede agregar un pensamiento vacío";
      }
      return null;
    } 