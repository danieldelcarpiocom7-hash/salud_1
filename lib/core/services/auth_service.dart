class AuthService {
  Future<String?> login(String correo, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simula conexión

    // Usuarios de prueba (luego se reemplaza por API REST)
    if (correo == 'admin' && password == '1234') return 'admin';
    if (correo == 'medico' && password == '1234') return 'medico';
    if (correo == 'paciente' && password == '1234') return 'paciente';

    return null; // credenciales inválidas
  }
}