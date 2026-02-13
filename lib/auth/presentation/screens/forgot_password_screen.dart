import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';


String? _validarEmail(String? value) {
  if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if(!emailRegExp.hasMatch(value)) return "No tiene formato de correo electrónico";
  return null;
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _ForgotPasswordScreenBody(),
    );
  }
}

class _ForgotPasswordScreenBody extends ConsumerStatefulWidget {
  const _ForgotPasswordScreenBody();

  @override
  __ForgotPasswordScreenBodyState createState() => __ForgotPasswordScreenBodyState();
}

class __ForgotPasswordScreenBodyState extends ConsumerState<_ForgotPasswordScreenBody> {
  String email = "";

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final focusNodeEmail = FocusNode();

  void showSnackBar(BuildContext context, String message){ 
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Restablecer contraseña', style: titleStyle),
            SizedBox(height: 30),
            Image.asset("assets/img/icon.png", width: size.width * 0.8, fit: BoxFit.cover),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: focusNodeEmail,
                      decoration: const InputDecoration(
                        label: Text("Correo electrónico"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined)
                      ),
                      validator: _validarEmail,
                      onChanged: (value) {
                        if(_validarEmail(value) == null) {
                          email = value;
                          return;
                        }
                        email = "";
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isLoading? null :() async {
                          if(focusNodeEmail.hasFocus) focusNodeEmail.unfocus();
                          if(!_formKey.currentState!.validate()) return;
                          setState(() {
                            isLoading = true;
                          });
                          String? result = await ref.read(authProvider.notifier).resetPassword(email);
                          setState(() {
                            isLoading = false;
                          });
                          if(result != null && context.mounted) {
                            final String errorMessage = result.trim();
                            final String snackBarMessage = errorMessage != "" ? errorMessage: "Error al intentar recuperar contraseña";
                            showSnackBar(context, snackBarMessage);
                            return;
                          }
                          if(context.mounted) showSnackBar(context, "Se ha enviado un correo de recuperación de contraseña al email proporcionado");
                        },
                        child: Text(isLoading? "Cargando...": "Recuperar contraseña"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () => context.go("/login"),
              child: Text ("Volver al login")
            ),
            SizedBox(height: 50)
          ],
          ),
        ),
      ),
    );
  }
}