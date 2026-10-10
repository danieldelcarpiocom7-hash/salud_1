import 'package:flutter/material.dart';

class MedicosPage extends StatefulWidget {
  const MedicosPage({super.key});

  @override
  State<MedicosPage> createState() => _MedicosPageState();
}

class _MedicosPageState extends State<MedicosPage> {
  static const Color azulPrincipal = Color(0xFF1565C0);
  static const Color azulClaro = Color(0xFFE3F2FD);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color textoPrincipal = Color(0xFF172033);
  static const Color textoSecundario = Color(0xFF607D8B);
  static const Color verde = Color(0xFF2E7D32);
  static const Color rojo = Color(0xFFC62828);

  final TextEditingController _buscarController = TextEditingController();

  String _especialidadSeleccionada = 'Todas';
  String _estadoSeleccionado = 'Todos';

  final List<_Medico> _medicos = [
    _Medico(
      id: '1',
      nombres: 'Carlos',
      apellidos: 'Mendoza',
      cmp: '45821',
      especialidad: 'Medicina General',
      telefono: '999888777',
      correo: 'carlos.mendoza@clinica.com',
      estado: true,
    ),
    _Medico(
      id: '2',
      nombres: 'Ana',
      apellidos: 'Torres',
      cmp: '52147',
      especialidad: 'Pediatría',
      telefono: '988777666',
      correo: 'ana.torres@clinica.com',
      estado: true,
    ),
    _Medico(
      id: '3',
      nombres: 'Luis',
      apellidos: 'Ramírez',
      cmp: '39452',
      especialidad: 'Cardiología',
      telefono: '977666555',
      correo: 'luis.ramirez@clinica.com',
      estado: true,
    ),
    _Medico(
      id: '4',
      nombres: 'Patricia',
      apellidos: 'Gómez',
      cmp: '61234',
      especialidad: 'Ginecología',
      telefono: '966555444',
      correo: 'patricia.gomez@clinica.com',
      estado: false,
    ),
    _Medico(
      id: '5',
      nombres: 'Jorge',
      apellidos: 'Vargas',
      cmp: '48763',
      especialidad: 'Dermatología',
      telefono: '955444333',
      correo: 'jorge.vargas@clinica.com',
      estado: true,
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

  List<_Medico> get _medicosFiltrados {
    final texto = _buscarController.text.trim().toLowerCase();

    return _medicos.where((medico) {
      final coincideBusqueda =
          texto.isEmpty ||
          medico.nombreCompleto.toLowerCase().contains(texto) ||
          medico.cmp.toLowerCase().contains(texto) ||
          medico.especialidad.toLowerCase().contains(texto);

      final coincideEspecialidad =
          _especialidadSeleccionada == 'Todas' ||
          medico.especialidad == _especialidadSeleccionada;

      final coincideEstado =
          _estadoSeleccionado == 'Todos' ||
          (_estadoSeleccionado == 'Activos' && medico.estado) ||
          (_estadoSeleccionado == 'Inactivos' && !medico.estado);

      return coincideBusqueda && coincideEspecialidad && coincideEstado;
    }).toList();
  }

  int get _totalMedicos => _medicos.length;

  int get _medicosActivos => _medicos.where((medico) => medico.estado).length;

  int get _medicosInactivos =>
      _medicos.where((medico) => !medico.estado).length;

  int get _especialidades =>
      _medicos.map((medico) => medico.especialidad).toSet().length;

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
          'Médicos',
          style: TextStyle(color: textoPrincipal, fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: azulPrincipal,
        foregroundColor: Colors.white,
        onPressed: _mostrarNuevoMedico,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Nuevo médico'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final ancho = constraints.maxWidth;

            final horizontalPadding = ancho >= 900 ? 32.0 : 16.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                20,
                horizontalPadding,
                100,
              ),
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
                  _listaMedicos(ancho),
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
          'Gestión de médicos',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Administra los profesionales registrados en la clínica.',
          style: TextStyle(fontSize: 14, color: textoSecundario),
        ),
      ],
    );
  }

  Widget _resumen(double ancho) {
    final tarjetas = [
      _ResumenDato(
        titulo: 'Total médicos',
        valor: '$_totalMedicos',
        icono: Icons.medical_services_outlined,
        color: azulPrincipal,
      ),
      _ResumenDato(
        titulo: 'Activos',
        valor: '$_medicosActivos',
        icono: Icons.check_circle_outline,
        color: verde,
      ),
      _ResumenDato(
        titulo: 'Inactivos',
        valor: '$_medicosInactivos',
        icono: Icons.block_outlined,
        color: rojo,
      ),
      _ResumenDato(
        titulo: 'Especialidades',
        valor: '$_especialidades',
        icono: Icons.category_outlined,
        color: Colors.deepPurple,
      ),
    ];

    if (ancho >= 800) {
      return Row(
        children: tarjetas.map((dato) {
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
      itemCount: tarjetas.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        return _tarjetaResumen(tarjetas[index]);
      },
    );
  }

  Widget _tarjetaResumen(_ResumenDato dato) {
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
            child: Icon(dato.icono, color: dato.color, size: 24),
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
                    fontSize: 22,
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
        hintText: 'Buscar por nombre, CMP o especialidad',
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
      runSpacing: 10,
      children: [_filtroEspecialidad(), _filtroEstado()],
    );
  }

  Widget _filtroEspecialidad() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _especialidadSeleccionada,
          icon: const Icon(Icons.keyboard_arrow_down),
          items:
              const [
                'Todas',
                'Medicina General',
                'Pediatría',
                'Cardiología',
                'Ginecología',
                'Dermatología',
              ].map((especialidad) {
                return DropdownMenuItem(
                  value: especialidad,
                  child: Text(especialidad),
                );
              }).toList(),
          onChanged: (valor) {
            if (valor == null) return;

            setState(() {
              _especialidadSeleccionada = valor;
            });
          },
        ),
      ),
    );
  }

  Widget _filtroEstado() {
    return Container(
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
    );
  }

  Widget _tituloLista() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Médicos registrados',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        Text(
          '${_medicosFiltrados.length} resultados',
          style: const TextStyle(fontSize: 13, color: textoSecundario),
        ),
      ],
    );
  }

  Widget _listaMedicos(double ancho) {
    if (_medicosFiltrados.isEmpty) {
      return _estadoVacio();
    }

    if (ancho >= 900) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _medicosFiltrados.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (context, index) {
          return _tarjetaMedico(_medicosFiltrados[index]);
        },
      );
    }

    return Column(
      children: _medicosFiltrados.map((medico) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _tarjetaMedico(medico),
        );
      }).toList(),
    );
  }

  Widget _tarjetaMedico(_Medico medico) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _mostrarDetalleMedico(medico),
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
                medico.iniciales,
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
                          'Dr. ${medico.nombreCompleto}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: textoPrincipal,
                          ),
                        ),
                      ),
                      _estadoBadge(medico.estado),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    medico.especialidad,
                    style: const TextStyle(
                      fontSize: 13,
                      color: azulPrincipal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.badge_outlined,
                        size: 15,
                        color: textoSecundario,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'CMP ${medico.cmp}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.phone_outlined,
                        size: 15,
                        color: textoSecundario,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        medico.telefono,
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
          Icon(
            Icons.medical_services_outlined,
            size: 52,
            color: Color(0xFF90A4AE),
          ),
          SizedBox(height: 14),
          Text(
            'No se encontraron médicos',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: textoPrincipal,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Prueba con otro nombre, CMP o filtro.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: textoSecundario),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalleMedico(_Medico medico) {
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
                    medico.iniciales,
                    style: const TextStyle(
                      fontSize: 20,
                      color: azulPrincipal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Dr. ${medico.nombreCompleto}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: textoPrincipal,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  medico.especialidad,
                  style: const TextStyle(
                    color: azulPrincipal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 22),
                _filaDetalle(Icons.badge_outlined, 'CMP', medico.cmp),
                _filaDetalle(Icons.phone_outlined, 'Teléfono', medico.telefono),
                _filaDetalle(Icons.email_outlined, 'Correo', medico.correo),
                _filaDetalle(
                  Icons.medical_services_outlined,
                  'Especialidad',
                  medico.especialidad,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _mostrarEditarMedico(medico);
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
                          _cambiarEstado(medico);
                        },
                        icon: Icon(
                          medico.estado
                              ? Icons.block_outlined
                              : Icons.check_circle_outline,
                        ),
                        label: Text(medico.estado ? 'Desactivar' : 'Activar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: medico.estado ? rojo : verde,
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

  void _cambiarEstado(_Medico medico) {
    setState(() {
      medico.estado = !medico.estado;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          medico.estado
              ? 'Médico activado correctamente.'
              : 'Médico desactivado correctamente.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _mostrarNuevoMedico() {
    final nombresController = TextEditingController();
    final apellidosController = TextEditingController();
    final cmpController = TextEditingController();
    final telefonoController = TextEditingController();
    final correoController = TextEditingController();

    String especialidad = 'Medicina General';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Nuevo médico',
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
                      controller: cmpController,
                      label: 'CMP',
                      icono: Icons.badge_outlined,
                      teclado: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: especialidad,
                      decoration: InputDecoration(
                        labelText: 'Especialidad',
                        prefixIcon: const Icon(Icons.medical_services_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          const [
                            'Medicina General',
                            'Pediatría',
                            'Cardiología',
                            'Ginecología',
                            'Dermatología',
                            'Traumatología',
                            'Neurología',
                            'Oftalmología',
                          ].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          especialidad = valor;
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
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nombresController.text.trim().isEmpty ||
                        apellidosController.text.trim().isEmpty ||
                        cmpController.text.trim().isEmpty ||
                        correoController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa los campos obligatorios.'),
                        ),
                      );
                      return;
                    }

                    final nuevoMedico = _Medico(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      nombres: nombresController.text.trim(),
                      apellidos: apellidosController.text.trim(),
                      cmp: cmpController.text.trim(),
                      especialidad: especialidad,
                      telefono: telefonoController.text.trim(),
                      correo: correoController.text.trim(),
                      estado: true,
                    );

                    setState(() {
                      _medicos.add(nuevoMedico);
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Médico registrado correctamente.'),
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
      cmpController.dispose();
      telefonoController.dispose();
      correoController.dispose();
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

  void _mostrarEditarMedico(_Medico medico) {
    final nombresController = TextEditingController(text: medico.nombres);
    final apellidosController = TextEditingController(text: medico.apellidos);
    final cmpController = TextEditingController(text: medico.cmp);
    final telefonoController = TextEditingController(text: medico.telefono);
    final correoController = TextEditingController(text: medico.correo);

    String especialidad = medico.especialidad;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Editar médico',
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
                      controller: cmpController,
                      label: 'CMP',
                      icono: Icons.badge_outlined,
                      teclado: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: especialidad,
                      decoration: InputDecoration(
                        labelText: 'Especialidad',
                        prefixIcon: const Icon(Icons.medical_services_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          const [
                            'Medicina General',
                            'Pediatría',
                            'Cardiología',
                            'Ginecología',
                            'Dermatología',
                            'Traumatología',
                            'Neurología',
                            'Oftalmología',
                          ].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          especialidad = valor;
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
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nombresController.text.trim().isEmpty ||
                        apellidosController.text.trim().isEmpty ||
                        cmpController.text.trim().isEmpty ||
                        correoController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa los campos obligatorios.'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      medico.nombres = nombresController.text.trim();
                      medico.apellidos = apellidosController.text.trim();
                      medico.cmp = cmpController.text.trim();
                      medico.especialidad = especialidad;
                      medico.telefono = telefonoController.text.trim();
                      medico.correo = correoController.text.trim();
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Información del médico actualizada.'),
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
      cmpController.dispose();
      telefonoController.dispose();
      correoController.dispose();
    });
  }
}

class _Medico {
  final String id;
  String nombres;
  String apellidos;
  String cmp;
  String especialidad;
  String telefono;
  String correo;
  bool estado;

  _Medico({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.cmp,
    required this.especialidad,
    required this.telefono,
    required this.correo,
    required this.estado,
  });

  String get nombreCompleto => '$nombres $apellidos';

  String get iniciales {
    final nombre = nombres.trim();
    final apellido = apellidos.trim();

    if (nombre.isEmpty && apellido.isEmpty) {
      return 'M';
    }

    final primeraLetra = nombre.isNotEmpty ? nombre[0].toUpperCase() : '';

    final segundaLetra = apellido.isNotEmpty ? apellido[0].toUpperCase() : '';

    return '$primeraLetra$segundaLetra';
  }
}

class _ResumenDato {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;

  _ResumenDato({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
  });
}
