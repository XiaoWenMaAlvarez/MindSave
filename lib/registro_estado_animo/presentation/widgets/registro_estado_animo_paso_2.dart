import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/registro_estado_animo/presentation/widgets/widgets.dart';

class RegistroEstadoAnimoPaso2 extends StatefulWidget {
  final RegistroEstadoAnimo registroEstadoAnimo;
  final GlobalKey<FormState> formKey;

  const RegistroEstadoAnimoPaso2(this.registroEstadoAnimo, this.formKey, {super.key});

  @override
  State<RegistroEstadoAnimoPaso2> createState() => _RegistroEstadoAnimoPaso2State();
}

class _RegistroEstadoAnimoPaso2State extends State<RegistroEstadoAnimoPaso2> {

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 16,
    );

    List<Emociones> gruposEmociones = [
      widget.registroEstadoAnimo.grupoEmociones.grupo1,
      widget.registroEstadoAnimo.grupoEmociones.grupo2,
      widget.registroEstadoAnimo.grupoEmociones.grupo3,
      widget.registroEstadoAnimo.grupoEmociones.grupo4,
      widget.registroEstadoAnimo.grupoEmociones.grupo5,
      widget.registroEstadoAnimo.grupoEmociones.grupo6,
      widget.registroEstadoAnimo.grupoEmociones.grupo7,
      widget.registroEstadoAnimo.grupoEmociones.grupo8,
      widget.registroEstadoAnimo.grupoEmociones.grupo9,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text("Emociones", style: titleStyle),
          const SizedBox(height: 10),
          Text("Seleccione las palabras que describan sus sentimientos en ese momento y califique cada sentimiento en una escala que va del 0% (nada en absoluto) al 100% (extremadamente).", style: bodyStyle),
          const SizedBox(height: 15),
          Form(
            key: widget.formKey,
            child: Column(
              children: [
                for(int i = 0; i < gruposEmociones.length; i++)
                  CustomCheckBoxGroupEmociones(
                    title: "Grupo ${i+1}", 
                    grupoEmociones: gruposEmociones[i], 
                  ),
                
                EmocionesPersonalizadasCheckBoxGroup(
                  grupoEmociones: widget.registroEstadoAnimo.grupoEmociones.grupo10, 
                ),
              ],
            )
          ),
          
        ],
      ),
    );
  }
}