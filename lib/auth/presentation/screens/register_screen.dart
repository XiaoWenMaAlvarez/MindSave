import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindsave/auth/presentation/providers/auth_provider.dart';

String? _validarEmail(String? value) {
  if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if(!emailRegExp.hasMatch(value)) return "No tiene formato de correo electrónico";
  return null;
}

String? _validarPassword(String? value) {
  if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
  if(value.trim().length < 6) return "Se requieren al menos 6 caracteres";
  //final RegExp passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>_\-\\[\]/+=~`]).{8,}$');
  //if(!passwordRegExp.hasMatch(value)) return "La contraseña debe tener mayúsculas, minúsculas, números y caracteres especiales";
  return null;
}

String? _validarNombre(String? value) {
  if(value == null || value.isEmpty || value.trim().isEmpty) return "El campo es obligatorio";
  if(value.trim().length < 2) return "Se requieren al menos 2 caracteres";
  return null;
}


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _RegisterScreenBody(),
    );
  }
}

class _RegisterScreenBody extends ConsumerStatefulWidget {
  const _RegisterScreenBody();

  @override
    _RegisterScreenBodyState createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends ConsumerState<_RegisterScreenBody> {
  String email = "";
  String password = "";
  String repeatPassword = "";
  String name = "";

  bool obscureTextPassword = true;
  bool obscureTextRepeatPassword = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final focusNodeEmail = FocusNode();
  final focusNodePassword = FocusNode();
  final focusNodeName = FocusNode();
  final focusNodeRepeatPassword = FocusNode();

  void unfocus(){
    if(focusNodeEmail.hasFocus) focusNodeEmail.unfocus();
    if(focusNodePassword.hasFocus) focusNodePassword.unfocus();
    if(focusNodeName.hasFocus) focusNodeName.unfocus();
    if(focusNodeRepeatPassword.hasFocus) focusNodeRepeatPassword.unfocus();
  }

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
            Text('Crear cuenta', style: titleStyle),
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
                    TextFormField(
                      focusNode: focusNodeName,
                      decoration: const InputDecoration(
                        label: Text("Nombre completo"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline)
                      ),
                      validator: _validarNombre,
                      onChanged: (value) {
                        if(_validarNombre(value) == null) {
                          name = value;
                          return;
                        }
                        name = "";
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: obscureTextPassword,
                      focusNode: focusNodePassword,
                      decoration: InputDecoration(
                        label: Text("Contraseña"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            obscureTextPassword ? Icons.visibility_off:  Icons.visibility,
                          ),
                          onTap: () {
                            setState(() {
                              obscureTextPassword = !obscureTextPassword;
                            });
                          },
                        )
                      ),
                      onChanged: (value) {
                        if(_validarPassword(value) == null) {
                          password = value;
                          return;
                        }
                        password = "";
                      },
                      validator: _validarPassword,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: obscureTextRepeatPassword,
                      focusNode: focusNodeRepeatPassword,
                      decoration: InputDecoration(
                        label: Text("Repita la contraseña"),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: GestureDetector(
                          child: Icon(
                            obscureTextRepeatPassword ? Icons.visibility_off:  Icons.visibility,
                          ),
                          onTap: () {
                            setState(() {
                              obscureTextRepeatPassword = !obscureTextRepeatPassword;
                            });
                          },
                        )
                      ),
                      onChanged: (value) {
                        if(_validarPassword(value) == null) {
                          repeatPassword = value;
                          return;
                        }
                        repeatPassword = "";
                      },
                      validator: _validarPassword,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isLoading? null :() async {
                          unfocus();
                          if(password != repeatPassword) {
                            showSnackBar(context, "Las contraseñas no coinciden");
                            return;
                          }
                          if(!_formKey.currentState!.validate()) return;
                          setState(() {
                            isLoading = true;
                          });
                          String? result = await ref.read(authProvider.notifier).registerUser(email, password, name);
                          setState(() {
                            isLoading = false;
                          });
                          if(result != null && context.mounted) {
                            final String errorMessage = result.trim();
                            final String snackBarMessage = errorMessage != "" ? errorMessage: "Error al crear cuenta";
                            showSnackBar(context, snackBarMessage);
                            return;
                          }
                          if(context.mounted) context.go("/successful-register");
                        },
                        child: Text(isLoading? "Cargando...": "Crear cuenta"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () => context.go("/login"),
              child: Text ("¿Ya tienes cuenta? Inicia sesión")
            ),
            SizedBox(height: 50)
          ],
          ),
        ),
      ),
    );
  }
}