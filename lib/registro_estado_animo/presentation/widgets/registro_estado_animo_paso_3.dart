import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';
import 'package:mindsave/registro_estado_animo/presentation/widgets/widgets.dart';

class RegistroEstadoAnimoPaso3 extends StatefulWidget {
  final RegistroEstadoAnimo registroEstadoAnimo;
  final GlobalKey<FormState> formKey;

  const RegistroEstadoAnimoPaso3(this.registroEstadoAnimo, this.formKey, {super.key});

  @override
  State<RegistroEstadoAnimoPaso3> createState() => _RegistroEstadoAnimoPaso3State();
}

class _RegistroEstadoAnimoPaso3State extends State<RegistroEstadoAnimoPaso3> {

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text("Pensamientos negativos", style: titleStyle),
          const SizedBox(height: 10),
          Text("Determine cuáles son los pensamientos negativos que lo acosan cuando siente las emociones descritas en el paso anterior", style: bodyStyle),
          const SizedBox(height: 10),
          Text("Indique en qué medida se cree usted cada uno de estos pensamientos, según una escala que va del 0% (nada en absoluto) al 100% (completamente).", style: bodyStyle),
          const SizedBox(height: 10),
          PensamientosNegativosGroup(
            pensamientos: widget.registroEstadoAnimo.listaPensamientos,
            formKey: widget.formKey
          ),
        ],
      ),
    );
  }
}