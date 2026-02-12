import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessfulRegisterScreen extends StatelessWidget {
  const SuccessfulRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: primaryColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );

    TextStyle bodyStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 16,
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
            SizedBox(height: 50),
            Text('Cuenta creada con éxito', style: titleStyle),
            SizedBox(height: 30),
            Image.asset("assets/img/icon.png", width: size.width * 0.8, fit: BoxFit.cover),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text("Hemos enviado un correo de activación al email que nos proporcionaste", style: bodyStyle),
            ),
            SizedBox(height: 30),
            FilledButton(
              onPressed: () => context.go("/login"),
              child: Text ("Volver al inicio de sesión")
            ),
            SizedBox(height: 50),
          ],
          ),
        ),
      ),
    );
  }
}