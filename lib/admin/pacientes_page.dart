import 'package:flutter/material.dart';

class PacientesPage extends StatefulWidget {
  const PacientesPage({super.key});

  @override
  State<PacientesPage> createState() => _PacientesPageState();
}

class _PacientesPageState extends State<PacientesPage> {
  static const Color azulPrincipal = Color(0xFF1565C0);
  static const Color azulClaro = Color(0xFFE3F2FD);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color textoPrincipal = Color(0xFF172033);
  static const Color textoSecundario = Color(0xFF607D8B);
  static const Color verde = Color(0xFF2E7D32);
  static const Color rojo = Color(0xFFC62828);

  final TextEditingController _buscarController = TextEditingController();

  String _estadoSeleccionado = 'Todos';

  final List<_PacienteAdmin> _pacientes = [
    _PacienteAdmin(
      id: '1',
      nombres: 'Juan',
      apellidos: 'Pérez',
      dni: '74563218',
      fechaNacimiento: DateTime(1991, 5, 12),
      sexo: 'Masculino',
      telefono: '999999999',
      correo: 'juan@email.com',
      direccion: 'Lima',
      activo: true,
    ),
    _PacienteAdmin(
      id: '2',
      nombres: 'María',
      apellidos: 'López',
      dni: '72345671',
      fechaNacimiento: DateTime(1984, 8, 20),
      sexo: 'Femenino',
      telefono: '988888888',
      correo: 'maria@email.com',
      direccion: 'Lima',
      activo: true,
    ),
    _PacienteAdmin(
      id: '3',
      nombres: 'Pedro',
      apellidos: 'García',
      dni: '71234567',
      fechaNacimiento: DateTime(1978, 2, 15),
      sexo: 'Masculino',
      telefono: '977777777',
      correo: 'pedro@email.com',
      direccion: 'Lima',
      activo: false,
    ),
    _PacienteAdmin(
      id: '4',
      nombres: 'Ana',
      apellidos: 'Torres',
      dni: '76543210',
      fechaNacimiento: DateTime(1995, 11, 8),
      sexo: 'Femenino',
      telefono: '966666666',
      correo: 'ana@email.com',
      direccion: 'San Miguel',
      activo: true,
    ),
    _PacienteAdmin(
      id: '5',
      nombres: 'Carlos',
      apellidos: 'Ramírez',
      dni: '70876543',
      fechaNacimiento: DateTime(1988, 3, 25),
      sexo: 'Masculino',
      telefono: '955555555',
      correo: 'carlos@email.com',
      direccion: 'Miraflores',
      activo: true,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _buscarController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _buscarController.dispose();
    super.dispose();
  }

  List<_PacienteAdmin> get _pacientesFiltrados {
    final texto = _buscarController.text.trim().toLowerCase();

    return _pacientes.where((paciente) {
      final coincideBusqueda =
          texto.isEmpty ||
          paciente.nombreCompleto.toLowerCase().contains(texto) ||
          paciente.dni.toLowerCase().contains(texto);

      final coincideEstado =
          _estadoSeleccionado == 'Todos' ||
          (_estadoSeleccionado == 'Activos' && paciente.activo) ||
          (_estadoSeleccionado == 'Inactivos' && !paciente.activo);

      return coincideBusqueda && coincideEstado;
    }).toList();
  }

  int get _totalPacientes => _pacientes.length;

  int get _pacientesActivos =>
      _pacientes.where((paciente) => paciente.activo).length;

  int get _pacientesInactivos =>
      _pacientes.where((paciente) => !paciente.activo).length;

  int get _pacientesMasculinos =>
      _pacientes.where((paciente) => paciente.sexo == 'Masculino').length;

  int get _pacientesFemeninos =>
      _pacientes.where((paciente) => paciente.sexo == 'Femenino').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: textoPrincipal),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pacientes',
          style: TextStyle(color: textoPrincipal, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: azulPrincipal,
        foregroundColor: Colors.white,
        onPressed: _mostrarNuevoPaciente,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Nuevo paciente'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final ancho = constraints.maxWidth;
            final padding = ancho >= 900 ? 32.0 : 16.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(padding, 20, padding, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _encabezado(),
                  const SizedBox(height: 20),
                  _resumen(ancho),
                  const SizedBox(height: 24),
                  _busqueda(),
                  const SizedBox(height: 12),
                  _filtros(),
                  const SizedBox(height: 24),
                  _tituloLista(),
                  const SizedBox(height: 12),
                  _listaPacientes(ancho),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _encabezado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gestión de pacientes',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Administra los datos personales y el acceso de los pacientes.',
          style: TextStyle(fontSize: 14, color: textoSecundario),
        ),
      ],
    );
  }

  Widget _resumen(double ancho) {
    final datos = [
      _ResumenPaciente(
        titulo: 'Total pacientes',
        valor: '$_totalPacientes',
        icono: Icons.people_outline,
        color: azulPrincipal,
      ),
      _ResumenPaciente(
        titulo: 'Activos',
        valor: '$_pacientesActivos',
        icono: Icons.check_circle_outline,
        color: verde,
      ),
      _ResumenPaciente(
        titulo: 'Inactivos',
        valor: '$_pacientesInactivos',
        icono: Icons.block_outlined,
        color: rojo,
      ),
      _ResumenPaciente(
        titulo: 'Mujeres / Hombres',
        valor: '$_pacientesFemeninos / $_pacientesMasculinos',
        icono: Icons.people_alt_outlined,
        color: Colors.deepPurple,
      ),
    ];

    if (ancho >= 800) {
      return Row(
        children: datos.map((dato) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _tarjetaResumen(dato),
            ),
          );
        }).toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: datos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        return _tarjetaResumen(datos[index]);
      },
    );
  }

  Widget _tarjetaResumen(_ResumenPaciente dato) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: dato.color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(dato.icono, color: dato.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dato.titulo,
                  style: const TextStyle(fontSize: 12, color: textoSecundario),
                ),
                const SizedBox(height: 4),
                Text(
                  dato.valor,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: textoPrincipal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _busqueda() {
    return TextField(
      controller: _buscarController,
      decoration: InputDecoration(
        hintText: 'Buscar por nombre o DNI',
        prefixIcon: const Icon(Icons.search, color: textoSecundario),
        suffixIcon: _buscarController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _buscarController.clear();
                },
                icon: const Icon(Icons.clear),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE7ECF2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: azulPrincipal),
        ),
      ),
    );
  }

  Widget _filtros() {
    return Wrap(
      spacing: 10,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE7ECF2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _estadoSeleccionado,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: const ['Todos', 'Activos', 'Inactivos'].map((estado) {
                return DropdownMenuItem(value: estado, child: Text(estado));
              }).toList(),
              onChanged: (valor) {
                if (valor == null) return;

                setState(() {
                  _estadoSeleccionado = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _tituloLista() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Pacientes registrados',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        Text(
          '${_pacientesFiltrados.length} resultados',
          style: const TextStyle(fontSize: 13, color: textoSecundario),
        ),
      ],
    );
  }

  Widget _listaPacientes(double ancho) {
    if (_pacientesFiltrados.isEmpty) {
      return _estadoVacio();
    }

    if (ancho >= 900) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _pacientesFiltrados.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.45,
        ),
        itemBuilder: (context, index) {
          return _tarjetaPaciente(_pacientesFiltrados[index]);
        },
      );
    }

    return Column(
      children: _pacientesFiltrados.map((paciente) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _tarjetaPaciente(paciente),
        );
      }).toList(),
    );
  }

  Widget _tarjetaPaciente(_PacienteAdmin paciente) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _mostrarDetallePaciente(paciente),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE7ECF2)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: azulClaro,
              child: Text(
                paciente.iniciales,
                style: const TextStyle(
                  color: azulPrincipal,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          paciente.nombreCompleto,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: textoPrincipal,
                          ),
                        ),
                      ),
                      _estadoBadge(paciente.activo),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.badge_outlined,
                        size: 15,
                        color: textoSecundario,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'DNI ${paciente.dni}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.cake_outlined,
                        size: 15,
                        color: textoSecundario,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${paciente.edad} años',
                        style: const TextStyle(
                          fontSize: 12,
                          color: textoSecundario,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        size: 15,
                        color: textoSecundario,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        paciente.telefono,
                        style: const TextStyle(
                          fontSize: 12,
                          color: textoSecundario,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: textoSecundario),
          ],
        ),
      ),
    );
  }

  Widget _estadoBadge(bool activo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: activo ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        activo ? 'Activo' : 'Inactivo',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: activo ? verde : rojo,
        ),
      ),
    );
  }

  Widget _estadoVacio() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: const Column(
        children: [
          Icon(Icons.people_outline, size: 52, color: Color(0xFF90A4AE)),
          SizedBox(height: 14),
          Text(
            'No se encontraron pacientes',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: textoPrincipal,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Prueba con otro nombre, DNI o estado.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: textoSecundario),
          ),
        ],
      ),
    );
  }

  void _mostrarDetallePaciente(_PacienteAdmin paciente) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9E0E7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 22),
                CircleAvatar(
                  radius: 34,
                  backgroundColor: azulClaro,
                  child: Text(
                    paciente.iniciales,
                    style: const TextStyle(
                      fontSize: 20,
                      color: azulPrincipal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  paciente.nombreCompleto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: textoPrincipal,
                  ),
                ),
                const SizedBox(height: 6),
                _estadoBadge(paciente.activo),
                const SizedBox(height: 22),
                _filaDetalle(Icons.badge_outlined, 'DNI', paciente.dni),
                _filaDetalle(
                  Icons.cake_outlined,
                  'Fecha de nacimiento',
                  _formatearFecha(paciente.fechaNacimiento),
                ),
                _filaDetalle(
                  Icons.person_outline,
                  'Edad / sexo',
                  '${paciente.edad} años · ${paciente.sexo}',
                ),
                _filaDetalle(
                  Icons.phone_outlined,
                  'Teléfono',
                  paciente.telefono,
                ),
                _filaDetalle(Icons.email_outlined, 'Correo', paciente.correo),
                _filaDetalle(
                  Icons.location_on_outlined,
                  'Dirección',
                  paciente.direccion,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _mostrarEditarPaciente(paciente);
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Editar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: azulPrincipal,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _cambiarEstado(paciente);
                        },
                        icon: Icon(
                          paciente.activo
                              ? Icons.block_outlined
                              : Icons.check_circle_outline,
                        ),
                        label: Text(paciente.activo ? 'Desactivar' : 'Activar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: paciente.activo ? rojo : verde,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filaDetalle(IconData icono, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: azulClaro,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icono, size: 19, color: azulPrincipal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(fontSize: 11, color: textoSecundario),
                ),
                const SizedBox(height: 2),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textoPrincipal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _cambiarEstado(_PacienteAdmin paciente) {
    setState(() {
      paciente.activo = !paciente.activo;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          paciente.activo
              ? 'Paciente activado correctamente.'
              : 'Paciente desactivado correctamente.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _mostrarNuevoPaciente() {
    final nombresController = TextEditingController();
    final apellidosController = TextEditingController();
    final dniController = TextEditingController();
    final telefonoController = TextEditingController();
    final correoController = TextEditingController();
    final direccionController = TextEditingController();

    DateTime fechaNacimiento = DateTime(1990, 1, 1);
    String sexo = 'Masculino';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Nuevo paciente',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textoPrincipal,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _campoDialogo(
                      controller: nombresController,
                      label: 'Nombres',
                      icono: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: apellidosController,
                      label: 'Apellidos',
                      icono: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: dniController,
                      label: 'DNI',
                      icono: Icons.badge_outlined,
                      teclado: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    _selectorFecha(context, fechaNacimiento, (fecha) {
                      setDialogState(() {
                        fechaNacimiento = fecha;
                      });
                    }),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: sexo,
                      decoration: InputDecoration(
                        labelText: 'Sexo',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const ['Masculino', 'Femenino'].map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          sexo = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: telefonoController,
                      label: 'Teléfono',
                      icono: Icons.phone_outlined,
                      teclado: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: correoController,
                      label: 'Correo',
                      icono: Icons.email_outlined,
                      teclado: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: direccionController,
                      label: 'Dirección',
                      icono: Icons.location_on_outlined,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nombresController.text.trim().isEmpty ||
                        apellidosController.text.trim().isEmpty ||
                        dniController.text.trim().isEmpty ||
                        telefonoController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa los campos obligatorios.'),
                        ),
                      );
                      return;
                    }

                    final nuevoPaciente = _PacienteAdmin(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      nombres: nombresController.text.trim(),
                      apellidos: apellidosController.text.trim(),
                      dni: dniController.text.trim(),
                      fechaNacimiento: fechaNacimiento,
                      sexo: sexo,
                      telefono: telefonoController.text.trim(),
                      correo: correoController.text.trim(),
                      direccion: direccionController.text.trim(),
                      activo: true,
                    );

                    setState(() {
                      _pacientes.add(nuevoPaciente);
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Paciente registrado correctamente.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulPrincipal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text('Registrar'),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() {
      nombresController.dispose();
      apellidosController.dispose();
      dniController.dispose();
      telefonoController.dispose();
      correoController.dispose();
      direccionController.dispose();
    });
  }

  void _mostrarEditarPaciente(_PacienteAdmin paciente) {
    final nombresController = TextEditingController(text: paciente.nombres);
    final apellidosController = TextEditingController(text: paciente.apellidos);
    final dniController = TextEditingController(text: paciente.dni);
    final telefonoController = TextEditingController(text: paciente.telefono);
    final correoController = TextEditingController(text: paciente.correo);
    final direccionController = TextEditingController(text: paciente.direccion);

    DateTime fechaNacimiento = paciente.fechaNacimiento;
    String sexo = paciente.sexo;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Editar paciente',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textoPrincipal,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _campoDialogo(
                      controller: nombresController,
                      label: 'Nombres',
                      icono: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: apellidosController,
                      label: 'Apellidos',
                      icono: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: dniController,
                      label: 'DNI',
                      icono: Icons.badge_outlined,
                      teclado: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    _selectorFecha(context, fechaNacimiento, (fecha) {
                      setDialogState(() {
                        fechaNacimiento = fecha;
                      });
                    }),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: sexo,
                      decoration: InputDecoration(
                        labelText: 'Sexo',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const ['Masculino', 'Femenino'].map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          sexo = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: telefonoController,
                      label: 'Teléfono',
                      icono: Icons.phone_outlined,
                      teclado: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: correoController,
                      label: 'Correo',
                      icono: Icons.email_outlined,
                      teclado: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: direccionController,
                      label: 'Dirección',
                      icono: Icons.location_on_outlined,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nombresController.text.trim().isEmpty ||
                        apellidosController.text.trim().isEmpty ||
                        dniController.text.trim().isEmpty ||
                        telefonoController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa los campos obligatorios.'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      paciente.nombres = nombresController.text.trim();
                      paciente.apellidos = apellidosController.text.trim();
                      paciente.dni = dniController.text.trim();
                      paciente.fechaNacimiento = fechaNacimiento;
                      paciente.sexo = sexo;
                      paciente.telefono = telefonoController.text.trim();
                      paciente.correo = correoController.text.trim();
                      paciente.direccion = direccionController.text.trim();
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Información del paciente actualizada.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulPrincipal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text('Guardar cambios'),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() {
      nombresController.dispose();
      apellidosController.dispose();
      dniController.dispose();
      telefonoController.dispose();
      correoController.dispose();
      direccionController.dispose();
    });
  }

  Widget _campoDialogo({
    required TextEditingController controller,
    required String label,
    required IconData icono,
    TextInputType? teclado,
  }) {
    return TextField(
      controller: controller,
      keyboardType: teclado,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _selectorFecha(
    BuildContext context,
    DateTime fecha,
    ValueChanged<DateTime> onChanged,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        final seleccionada = await showDatePicker(
          context: context,
          initialDate: fecha,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (seleccionada != null) {
          onChanged(seleccionada);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Fecha de nacimiento',
          prefixIcon: const Icon(Icons.calendar_today_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(_formatearFecha(fecha)),
      ),
    );
  }

  String _formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');

    return '$dia/$mes/${fecha.year}';
  }
}

class _PacienteAdmin {
  final String id;
  String nombres;
  String apellidos;
  String dni;
  DateTime fechaNacimiento;
  String sexo;
  String telefono;
  String correo;
  String direccion;
  bool activo;

  _PacienteAdmin({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.fechaNacimiento,
    required this.sexo,
    required this.telefono,
    required this.correo,
    required this.direccion,
    required this.activo,
  });

  String get nombreCompleto => '$nombres $apellidos';

  int get edad {
    final hoy = DateTime.now();

    int edad = hoy.year - fechaNacimiento.year;

    if (hoy.month < fechaNacimiento.month ||
        (hoy.month == fechaNacimiento.month && hoy.day < fechaNacimiento.day)) {
      edad--;
    }

    return edad;
  }

  String get iniciales {
    final nombre = nombres.trim();
    final apellido = apellidos.trim();

    final primera = nombre.isNotEmpty ? nombre[0].toUpperCase() : '';

    final segunda = apellido.isNotEmpty ? apellido[0].toUpperCase() : '';

    if (primera.isEmpty && segunda.isEmpty) {
      return 'P';
    }

    return '$primera$segunda';
  }
}

class _ResumenPaciente {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;

  _ResumenPaciente({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
  });
}
