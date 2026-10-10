import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'admin/home_admin_page.dart';
import 'medico/home_medico_page.dart';
import 'paciente/home_paciente_page.dart';

void main() {
  runApp(const PortalClinicaApp());
}

class PortalClinicaApp extends StatelessWidget {
  const PortalClinicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/homeAdmin': (context) => const HomeAdminPage(),
        '/homeMedico': (context) => const HomeMedicoPage(),
        '/homePaciente': (context) => const HomePacientePage(),
      },
    );
  }
}