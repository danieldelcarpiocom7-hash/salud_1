import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  static const Color azulPrincipal = Color(0xFF1565C0);
  static const Color azulClaro = Color(0xFFE3F2FD);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color textoPrincipal = Color(0xFF172033);
  static const Color textoSecundario = Color(0xFF607D8B);
  static const Color verde = Color(0xFF2E7D32);

  final TextEditingController _busquedaController = TextEditingController();

  String _filtroRol = 'Todos';

  final List<_Usuario> _usuarios = [
    _Usuario(
      id: '1',
      nombres: 'Carlos Mendoza',
      correo: 'carlos.mendoza@clinica.com',
      rol: 'Médico',
      estado: true,
      iniciales: 'CM',
    ),
    _Usuario(
      id: '2',
      nombres: 'Ana Torres',
      correo: 'ana.torres@clinica.com',
      rol: 'Médico',
      estado: true,
      iniciales: 'AT',
    ),
    _Usuario(
      id: '3',
      nombres: 'Juan Pérez',
      correo: 'juan@email.com',
      rol: 'Paciente',
      estado: true,
      iniciales: 'JP',
    ),
    _Usuario(
      id: '4',
      nombres: 'María López',
      correo: 'maria@email.com',
      rol: 'Paciente',
      estado: true,
      iniciales: 'ML',
    ),
    _Usuario(
      id: '5',
      nombres: 'Pedro García',
      correo: 'pedro@email.com',
      rol: 'Paciente',
      estado: false,
      iniciales: 'PG',
    ),
    _Usuario(
      id: '6',
      nombres: 'Administrador Principal',
      correo: 'admin@clinica.com',
      rol: 'Administrador',
      estado: true,
      iniciales: 'AP',
    ),
  ];

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  List<_Usuario> get _usuariosFiltrados {
    final texto = _busquedaController.text.trim().toLowerCase();

    return _usuarios.where((usuario) {
      final coincideBusqueda =
          texto.isEmpty ||
          usuario.nombres.toLowerCase().contains(texto) ||
          usuario.correo.toLowerCase().contains(texto);

      final coincideRol = _filtroRol == 'Todos' || usuario.rol == _filtroRol;

      return coincideBusqueda && coincideRol;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final usuarios = _usuariosFiltrados;

    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Volver',
          icon: const Icon(Icons.arrow_back, color: textoPrincipal),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Usuarios',
          style: TextStyle(color: textoPrincipal, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          children: [
            _buildEncabezado(),
            const SizedBox(height: 20),

            _buildResumen(),
            const SizedBox(height: 22),

            _buildHerramientas(),
            const SizedBox(height: 20),

            if (usuarios.isEmpty)
              _buildSinResultados()
            else
              ...usuarios.map(
                (usuario) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildUsuarioCard(context, usuario),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _mostrarNuevoUsuario(context);
        },
        backgroundColor: azulPrincipal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1_outlined),
        label: const Text(
          'Nuevo usuario',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // ============================================================
  // ENCABEZADO
  // ============================================================

  Widget _buildEncabezado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gestión de usuarios',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Administra las cuentas y los roles de acceso '
          'al sistema.',
          style: TextStyle(fontSize: 14, color: textoSecundario, height: 1.4),
        ),
      ],
    );
  }

  // ============================================================
  // RESUMEN
  // ============================================================

  Widget _buildResumen() {
    final total = _usuarios.length;
    final activos = _usuarios.where((usuario) => usuario.estado).length;
    final medicos = _usuarios
        .where((usuario) => usuario.rol == 'Médico')
        .length;
    final pacientes = _usuarios
        .where((usuario) => usuario.rol == 'Paciente')
        .length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cards = [
          _ResumenUsuario(
            titulo: 'Total',
            valor: '$total',
            icono: Icons.people_outline,
            color: azulPrincipal,
            fondo: azulClaro,
          ),
          _ResumenUsuario(
            titulo: 'Activos',
            valor: '$activos',
            icono: Icons.check_circle_outline,
            color: verde,
            fondo: const Color(0xFFE8F5E9),
          ),
          _ResumenUsuario(
            titulo: 'Médicos',
            valor: '$medicos',
            icono: Icons.medical_services_outlined,
            color: const Color(0xFF00897B),
            fondo: const Color(0xFFE0F2F1),
          ),
          _ResumenUsuario(
            titulo: 'Pacientes',
            valor: '$pacientes',
            icono: Icons.person_outline,
            color: const Color(0xFF6A1B9A),
            fondo: const Color(0xFFF3E5F5),
          ),
        ];

        if (constraints.maxWidth >= 900) {
          return Row(
            children: cards.map((card) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildResumenCard(card),
                ),
              );
            }).toList(),
          );
        }

        if (constraints.maxWidth >= 600) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.7,
            ),
            itemBuilder: (context, index) {
              return _buildResumenCard(cards[index]);
            },
          );
        }

        return Column(
          children: cards.map((card) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildResumenCard(card),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildResumenCard(_ResumenUsuario item) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E8EE)),
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: item.fondo,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icono, color: item.color, size: 23),
          ),
          const SizedBox(width: 11),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.titulo,
                style: const TextStyle(fontSize: 11, color: textoSecundario),
              ),
              const SizedBox(height: 2),
              Text(
                item.valor,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: textoPrincipal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BÚSQUEDA Y FILTROS
  // ============================================================

  Widget _buildHerramientas() {
    return Column(
      children: [
        TextField(
          controller: _busquedaController,
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Buscar por nombre o correo',
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: const Icon(Icons.search, color: textoSecundario),
            suffixIcon: _busquedaController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _busquedaController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.close),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE4E8EE)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE4E8EE)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: azulPrincipal, width: 1.5),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            const Icon(
              Icons.filter_list_outlined,
              size: 20,
              color: textoSecundario,
            ),
            const SizedBox(width: 8),
            const Text(
              'Rol:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: textoPrincipal,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _filtroRol,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE4E8EE)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE4E8EE)),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                  DropdownMenuItem(
                    value: 'Administrador',
                    child: Text('Administrador'),
                  ),
                  DropdownMenuItem(value: 'Médico', child: Text('Médico')),
                  DropdownMenuItem(value: 'Paciente', child: Text('Paciente')),
                ],
                onChanged: (valor) {
                  if (valor == null) return;

                  setState(() {
                    _filtroRol = valor;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // CARD USUARIO
  // ============================================================

  Widget _buildUsuarioCard(BuildContext context, _Usuario usuario) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        _mostrarDetalleUsuario(context, usuario);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE4E8EE)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _colorRol(usuario.rol).withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  usuario.iniciales,
                  style: TextStyle(
                    color: _colorRol(usuario.rol),
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    usuario.nombres,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    usuario.correo,
                    style: const TextStyle(
                      fontSize: 12,
                      color: textoSecundario,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildEtiquetaRol(usuario.rol),
                      const SizedBox(width: 8),
                      _buildEstado(usuario.estado),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: Color(0xFF9AA5B1)),
          ],
        ),
      ),
    );
  }

  Widget _buildEtiquetaRol(String rol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: _colorRol(rol).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        rol,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: _colorRol(rol),
        ),
      ),
    );
  }

  Widget _buildEstado(bool activo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: activo
            ? verde.withValues(alpha: 0.10)
            : Colors.grey.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        activo ? 'Activo' : 'Inactivo',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: activo ? verde : Colors.grey.shade600,
        ),
      ),
    );
  }

  Color _colorRol(String rol) {
    switch (rol) {
      case 'Administrador':
        return const Color(0xFF6A1B9A);
      case 'Médico':
        return const Color(0xFF00897B);
      case 'Paciente':
        return azulPrincipal;
      default:
        return textoSecundario;
    }
  }

  // ============================================================
  // SIN RESULTADOS
  // ============================================================

  Widget _buildSinResultados() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E8EE)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.person_search_outlined,
            size: 55,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 14),
          const Text(
            'No se encontraron usuarios',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: textoPrincipal,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Prueba con otro nombre, correo o filtro.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: textoSecundario),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DETALLE USUARIO
  // ============================================================

  void _mostrarDetalleUsuario(BuildContext context, _Usuario usuario) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFD5DAE0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: _colorRol(usuario.rol).withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    usuario.iniciales,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: _colorRol(usuario.rol),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                usuario.nombres,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: textoPrincipal,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                usuario.correo,
                style: const TextStyle(fontSize: 13, color: textoSecundario),
              ),

              const SizedBox(height: 20),

              _buildDetalleFila(Icons.badge_outlined, 'Rol', usuario.rol),

              _buildDetalleFila(Icons.email_outlined, 'Correo', usuario.correo),

              _buildDetalleFila(
                Icons.circle,
                'Estado',
                usuario.estado ? 'Activo' : 'Inactivo',
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);

                    _cambiarEstadoUsuario(context, usuario);
                  },
                  icon: Icon(
                    usuario.estado
                        ? Icons.block_outlined
                        : Icons.check_circle_outline,
                  ),
                  label: Text(
                    usuario.estado ? 'Desactivar usuario' : 'Activar usuario',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: usuario.estado
                        ? Colors.red.shade700
                        : verde,
                    side: BorderSide(
                      color: usuario.estado
                          ? Colors.red.shade300
                          : Colors.green.shade300,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetalleFila(IconData icono, String titulo, String valor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icono, size: 19, color: textoSecundario),
          const SizedBox(width: 10),
          Text(
            '$titulo:',
            style: const TextStyle(fontSize: 12, color: textoSecundario),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              valor,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textoPrincipal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CAMBIAR ESTADO
  // ============================================================

  void _cambiarEstadoUsuario(BuildContext context, _Usuario usuario) {
    setState(() {
      usuario.estado = !usuario.estado;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          usuario.estado
              ? 'Usuario activado correctamente.'
              : 'Usuario desactivado correctamente.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // NUEVO USUARIO
  // ============================================================

  void _mostrarNuevoUsuario(BuildContext context) {
    final nombresController = TextEditingController();

    final correoController = TextEditingController();

    String rolSeleccionado = 'Paciente';

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Nuevo usuario',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nombresController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre completo',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      controller: correoController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      initialValue: rolSeleccionado,
                      decoration: const InputDecoration(
                        labelText: 'Rol',
                        prefixIcon: Icon(Icons.admin_panel_settings_outlined),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Administrador',
                          child: Text('Administrador'),
                        ),
                        DropdownMenuItem(
                          value: 'Médico',
                          child: Text('Médico'),
                        ),
                        DropdownMenuItem(
                          value: 'Paciente',
                          child: Text('Paciente'),
                        ),
                      ],
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          rolSeleccionado = valor;
                        });
                      },
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
                    final nombres = nombresController.text.trim();

                    final correo = correoController.text.trim();

                    if (nombres.isEmpty || correo.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa todos los campos.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    final iniciales = _obtenerIniciales(nombres);

                    setState(() {
                      _usuarios.add(
                        _Usuario(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          nombres: nombres,
                          correo: correo,
                          rol: rolSeleccionado,
                          estado: true,
                          iniciales: iniciales,
                        ),
                      );
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Usuario registrado correctamente.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulPrincipal,
                    foregroundColor: Colors.white,
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
      correoController.dispose();
    });
  }

  String _obtenerIniciales(String nombre) {
    final partes = nombre.trim().split(RegExp(r'\s+'));

    if (partes.isEmpty) {
      return '?';
    }

    if (partes.length == 1) {
      return partes.first[0].toUpperCase();
    }

    return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
  }
}

// ============================================================
// MODELO USUARIO
// ============================================================

class _Usuario {
  final String id;
  final String nombres;
  final String correo;
  final String rol;
  bool estado;
  final String iniciales;

  _Usuario({
    required this.id,
    required this.nombres,
    required this.correo,
    required this.rol,
    required this.estado,
    required this.iniciales,
  });
}

// ============================================================
// MODELO RESUMEN
// ============================================================

class _ResumenUsuario {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;
  final Color fondo;

  _ResumenUsuario({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
    required this.fondo,
  });
}
