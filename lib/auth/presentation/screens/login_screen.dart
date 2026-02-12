import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindsave/auth/presentation/providers/auth_provider.dart';

String? validarEmail(String? value) {
  if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if(!emailRegExp.hasMatch(value)) return "No tiene formato de correo electrónico";
  return null;
}

String? validarPassword(String? value) {
  if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
  if(value.trim().length < 6) return "Se requieren al menos 6 caracteres";
  //final RegExp passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>_\-\\[\]/+=~`]).{8,}$');
  //if(!passwordRegExp.hasMatch(value)) return "La contraseña debe tener mayúsculas, minúsculas, números y caracteres especiales";
  return null;
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends ConsumerStatefulWidget {
  const _LoginScreenBody();

  @override
    _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends ConsumerState<_LoginScreenBody> {
  String email = "";
  String password = "";
  bool obscureText = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final focusNodeEmail = FocusNode();
  final focusNodePassword = FocusNode();

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
          height: size.height,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Inicia sesión', style: titleStyle),
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
                      validator: validarEmail,
                      onChanged: (value) {
                        if(validarEmail(value) == null) {
                          email = value;
                          return;
                        }
                        email = "";
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: obscureText,
                      focusNode: focusNodePassword,
                      decoration: InputDecoration(
                        label: Text("Contraseña"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            obscureText ? Icons.visibility_off:  Icons.visibility,
                          ),
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        )
                      ),
                      onChanged: (value) {
                        if(validarPassword(value) == null) {
                          password = value;
                          return;
                        }
                        password = "";
                      },
                      validator: validarPassword,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isLoading? null :() async {
                          if(focusNodeEmail.hasFocus) focusNodeEmail.unfocus();
                          if(focusNodePassword.hasFocus) focusNodePassword.unfocus();
                          if(!_formKey.currentState!.validate()) return;
                          setState(() {
                            isLoading = true;
                          });
                          bool result = await ref.read(authProvider.notifier).loginUser(email, password);
                          setState(() {
                            isLoading = false;
                          });
                          if(!result && context.mounted) {
                            final String errorMessage = ref.read(authProvider).errorMessage;
                            final String snackBarMessage = errorMessage != "" ? errorMessage: "Error al iniciar sesión";
                            showSnackBar(context, snackBarMessage);
                          }
                        },
                        child: Text(isLoading? "Cargando...": "Iniciar sesión"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                //TODO RECUPERAR CONTRASEÑA Y CREAR CUENTA
                showSnackBar(context, "JA! EL KLO TONTO");
              },
              child: Text ("¿Olvidaste tu contraseña?")
            ),
            TextButton(
              onPressed: () {},
              child: Text ("Crear cuenta")
            )
          ],
          ),
        ),
      ),
    );
  }
}