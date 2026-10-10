class Paciente {
  final String id;
  final String nombres;
  final String apellidos;
  final String dni;
  final DateTime fechaNacimiento;
  final String sexo;
  final String telefono;
  final String correo;
  final String direccion;

  Paciente({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.fechaNacimiento,
    required this.sexo,
    required this.telefono,
    required this.correo,
    required this.direccion,
  });

  String get nombreCompleto => '$nombres $apellidos';

  int get edad {
    final hoy = DateTime.now();

    int edad = hoy.year - fechaNacimiento.year;

    if (hoy.month < fechaNacimiento.month ||
        (hoy.month == fechaNacimiento.month &&
            hoy.day < fechaNacimiento.day)) {
      edad--;
    }

    return edad;
  }
}