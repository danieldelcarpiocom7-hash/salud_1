import 'package:flutter/material.dart';
import '../core/services/auth_service.dart'; // IMPORTANTE

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool ocultarPassword = true;
  bool cargando = false;

  Future<void> iniciarSesion() async {
    final correo = correoController.text.trim();
    final password = passwordController.text.trim();

    if (correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa el correo y la contraseña')),
      );
      return;
    }

    setState(() => cargando = true);

    final tipoUsuario = await AuthService().login(correo, password);

    setState(() => cargando = false);

    if (!mounted) return;

    if (tipoUsuario == 'admin') {
      Navigator.pushReplacementNamed(context, '/homeAdmin');
    } else if (tipoUsuario == 'medico') {
      Navigator.pushReplacementNamed(context, '/homeMedico');
    } else if (tipoUsuario == 'paciente') {
      Navigator.pushReplacementNamed(context, '/homePaciente');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales inválidas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.local_hospital,
                        size: 70, color: Colors.blue),
                    const SizedBox(height: 20),
                    const Text(
                      'Portal Web de la Clínica',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ingresa a tu cuenta',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    TextField(
                      controller: correoController,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 18),

                    TextField(
                      controller: passwordController,
                      obscureText: ocultarPassword,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            ocultarPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              ocultarPassword = !ocultarPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: cargando ? null : iniciarSesion,
                        child: cargando
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Iniciar sesión'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
