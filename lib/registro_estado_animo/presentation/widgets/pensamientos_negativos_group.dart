import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/registro_estado_animo/domain/entities/entities.dart';

class PensamientosNegativosGroup extends StatefulWidget {
  final List<Pensamiento> pensamientos;
  final GlobalKey<FormState> formKey;

  const PensamientosNegativosGroup({
    super.key,
    required this.pensamientos,
    required this.formKey
  });

  @override
  State<PensamientosNegativosGroup> createState() => _PensamientosNegativosGroupState();
}

class _PensamientosNegativosGroupState extends State<PensamientosNegativosGroup> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String nvoPensamientoNegativo;

  @override
  void initState() {
    nvoPensamientoNegativo = "";
    super.initState();
  }

  String? validarPorcentaje(String? value) {
    if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
    try {
      int numberValue = int.parse(value);
      if(numberValue <= 0 || numberValue > 100) return "El valor debe estar entre 1 y 100";
      return null;
    } catch(e) {
      return "El valor debe ser un número entero (sin decimales)";
    }
  }

  _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _mostrarMensajeEliminarPensamiento(BuildContext context, List<Pensamiento> pensamientos, int index) async {
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('Eliminar pensamiento negativo'),
        content: Text('¿Está seguro que desea eliminar el pensamiento "${pensamientos.length > index ? pensamientos[index].pensamientoNegativo : ""}"?'),
        actions: [
          FilledButton(
            onPressed: () async {
              pensamientos.removeAt(index);
              if(context.mounted) {
                _showSnackBar(context, 'Pensamiento negativo eliminado');
                context.pop();
              } 
            }, 
            child: const Text('Si, eliminar')
          ),

          TextButton(
            onPressed: () => context.pop(), 
            child: const Text('No, cancelar')
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final focusNode = FocusNode();

    TextStyle subTitleStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
      color: primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    List<TextEditingController> controladoresPensamientosNegativos = [
      for(int i = 0; i < widget.pensamientos.length; i ++) 
        TextEditingController(text: widget.pensamientos[i].pensamientoNegativo)
    ];

    List<TextEditingController> controladoresPorcentajeCreencias = [
      for(int i = 0; i < widget.pensamientos.length; i ++) 
        TextEditingController(text: widget.pensamientos[i].porcentajeCreenciaPensamientoNegativoAntes.toString())
    ];

    String? isValidoPensamientoNegativo (String? value) {
      if(value == null || value.trim() == ""){
        return "No puede agregar un pensamiento vacío";
      }
      return null;
    } 

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        
        Form(
          key: widget.formKey,
          child: Column(
            children: [
              for(int i = 0; i < widget.pensamientos.length; i++)
          ...[ Row(
            children: [
              Text("Pensamiento ${i+1}", style: subTitleStyle),
              Spacer(),
              IconButton( 
                icon: Icon(Icons.delete, color: primaryColor),
                onPressed: () async {
                  await _mostrarMensajeEliminarPensamiento(context, widget.pensamientos, i);
                  setState((){});
                },
              )
            ],
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: controladoresPensamientosNegativos[i],
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (String? value) {
              if(isValidoPensamientoNegativo(value) == null){
                if(widget.pensamientos.length > i){
                  widget.pensamientos[i].pensamientoNegativo = value!;
                }
              }
            },
            validator: (String? value){
              if(value == null || value == "" || value.trim() == "") return "El campo es obligatorio";
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
              controller: controladoresPorcentajeCreencias[i],
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Porcentaje de creencia (0 - 100)"),
              ),
              onChanged: (String? value) {
                try {
                  if(validarPorcentaje(value) == null && widget.pensamientos.length > i){
                    widget.pensamientos[i].porcentajeCreenciaPensamientoNegativoAntes = int.parse(value!);
                  }
                } catch (e) {
                  return;
                }
              },
              validator: validarPorcentaje,
            ),
            SizedBox(height: 50),
            ]],
          ),



        ),
            
          SizedBox(height: 10),
          
          Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Agregar nuevo pensamiento", style: subTitleStyle),
                SizedBox(height: 10),

                TextFormField(
                  focusNode: focusNode,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ej. No puedo permitirme fallar otra vez"
                  ),
                  validator: isValidoPensamientoNegativo,
                  onChanged: (String? value){
                    nvoPensamientoNegativo = value ?? nvoPensamientoNegativo;
                  },
                  onTapOutside: (event) => focusNode.unfocus(),
                ),

                SizedBox(height: 10),

                Center(
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.add),
                    label: const Text("Agregar pensamiento"),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        widget.pensamientos.add(Pensamiento(pensamientoNegativo: nvoPensamientoNegativo, porcentajeCreenciaPensamientoNegativoAntes: 0));
                        _formKey.currentState!.reset();
                        setState(() {});
                      }
                    },
                  ),
                ),

              ]
            ) 
          ),

          SizedBox(height: 50,)
      ],
    );
  }
}