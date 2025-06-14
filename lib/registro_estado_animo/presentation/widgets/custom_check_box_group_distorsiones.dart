import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class CustomCheckBoxGroupDistorsiones extends StatefulWidget {
  final String title;
  final Pensamiento pensamiento;

  const CustomCheckBoxGroupDistorsiones({
    super.key,
    required this.title, 
    required this.pensamiento,
  });

  @override
  State<CustomCheckBoxGroupDistorsiones> createState() => _CustomCheckBoxGroupDistorsionesState();
}

class _CustomCheckBoxGroupDistorsionesState extends State<CustomCheckBoxGroupDistorsiones> {
  @override
  Widget build(BuildContext context) {

    List<String> distorsiones = Pensamiento.listaDistorsiones;
    List<bool> distorsionesIdentificadas = widget.pensamiento.distorsionesIdentificadas;

    return ExpansionTile(
        title: Text(widget.title),
        children: [
          SizedBox(height: 5),
          _TextoDentroDelCheckBox("Descripción: ${widget.pensamiento.pensamientoNegativo}"),
          SizedBox(height: 5),
          for (int i = 0; i < distorsiones.length; i++)
            CheckboxListTile(
              title: Text(distorsiones[i]),
              value: distorsionesIdentificadas[i], 
              onChanged: (bool? value) => setState(() {
                distorsionesIdentificadas[i] = value ?? distorsionesIdentificadas[i];
              })
            ),
            SizedBox(height: 10),
            _TextoDentroDelCheckBox("Porcentaje de creencia: ${widget.pensamiento.porcentajeCreenciaPensamientoNegativoAntes}%"),
            SizedBox(height: 10),
        ],
    );
  }
}

class _TextoDentroDelCheckBox extends StatelessWidget {

  final String texto;

  const _TextoDentroDelCheckBox(this.texto);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold, 
      fontSize: 16
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(texto, style: textStyle),
          ],
        ),
      ),
    );
  }
}