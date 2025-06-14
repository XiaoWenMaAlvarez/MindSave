import 'package:flutter/material.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';


class RegistroEstadoAnimoPaso1 extends StatefulWidget {
  final RegistroEstadoAnimo registroEstadoAnimo;
  final GlobalKey<FormState> formKey;

  const RegistroEstadoAnimoPaso1(this.registroEstadoAnimo, this.formKey, {super.key});

  @override
  State<RegistroEstadoAnimoPaso1> createState() => _RegistroEstadoAnimoPaso1State();
}

class _RegistroEstadoAnimoPaso1State extends State<RegistroEstadoAnimoPaso1> {
  late TextEditingController _controller; 

  @override
  void initState() {
    _controller = TextEditingController(text: widget.registroEstadoAnimo.sucesoTrastornador);  
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

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
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text( "Suceso trastornador", style: titleStyle),
            const SizedBox(height: 10),
            Text( "Detalle la fecha en la que ocurrió dicho suceso, si ocurrió hoy, puede saltarse este paso.", style: bodyStyle),
            const SizedBox(height: 15),
            DatePicker(widget.registroEstadoAnimo),
            const SizedBox(height: 15),
            Text( "Breve descripción de cualquier momento en que se sintiera angustiado o trastornado.", style: bodyStyle),
            const SizedBox(height: 15),
            TextFormField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (String? value) => widget.registroEstadoAnimo.sucesoTrastornador = value ?? "", 
              validator: (String? value) {
                if(value == null || value.trim() == ""){
                  return "El campo es obligatorio";
                }
                return null;
              },          
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}


class DatePicker extends StatefulWidget {
  final RegistroEstadoAnimo registroEstadoAnimo;

  const DatePicker(this.registroEstadoAnimo, {super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final _fechaController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.registroEstadoAnimo.fecha,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
      _fechaController.text = '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
      widget.registroEstadoAnimo.fecha = pickedDate ?? DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = widget.registroEstadoAnimo.fecha;
    _fechaController.text = '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: <Widget>[
        TextFormField(
          controller: _fechaController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Fecha seleccionada',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today_outlined)
          ),
        ),
        OutlinedButton(onPressed: _selectDate, child: const Text('Seleccionar fecha')),
      ],
    );
  }
}