import 'package:flutter/material.dart';

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({super.key});

  @override
  State<MedicamentosPage> createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  static const Color azulPrincipal = Color(0xFF1565C0);
  static const Color azulClaro = Color(0xFFE3F2FD);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color textoPrincipal = Color(0xFF172033);
  static const Color textoSecundario = Color(0xFF607D8B);
  static const Color verde = Color(0xFF2E7D32);
  static const Color rojo = Color(0xFFC62828);

  final TextEditingController _buscarController = TextEditingController();

  String _filtroEstado = 'Todos';
  String _filtroPresentacion = 'Todas';

  final List<_Medicamento> _medicamentos = [
    _Medicamento(
      id: 'MED-001',
      nombre: 'Amoxicilina',
      principioActivo: 'Amoxicilina',
      concentracion: '500 mg',
      presentacion: 'Cápsula',
      laboratorio: 'Laboratorios XYZ',
      estado: true,
    ),
    _Medicamento(
      id: 'MED-002',
      nombre: 'Paracetamol',
      principioActivo: 'Paracetamol',
      concentracion: '500 mg',
      presentacion: 'Tableta',
      laboratorio: 'Farmalab',
      estado: true,
    ),
    _Medicamento(
      id: 'MED-003',
      nombre: 'Omeprazol',
      principioActivo: 'Omeprazol',
      concentracion: '20 mg',
      presentacion: 'Cápsula',
      laboratorio: 'Medifarma',
      estado: true,
    ),
    _Medicamento(
      id: 'MED-004',
      nombre: 'Losartán',
      principioActivo: 'Losartán potásico',
      concentracion: '50 mg',
      presentacion: 'Tableta',
      laboratorio: 'Genfar',
      estado: true,
    ),
    _Medicamento(
      id: 'MED-005',
      nombre: 'Ibuprofeno',
      principioActivo: 'Ibuprofeno',
      concentracion: '400 mg',
      presentacion: 'Tableta',
      laboratorio: 'Medifarma',
      estado: false,
    ),
    _Medicamento(
      id: 'MED-006',
      nombre: 'Azitromicina',
      principioActivo: 'Azitromicina',
      concentracion: '500 mg',
      presentacion: 'Tableta',
      laboratorio: 'Farmalab',
      estado: true,
    ),
  ];

  @override
  void dispose() {
    _buscarController.dispose();
    super.dispose();
  }

  List<_Medicamento> get _medicamentosFiltrados {
    final texto = _buscarController.text.trim().toLowerCase();

    return _medicamentos.where((medicamento) {
      final coincideBusqueda =
          texto.isEmpty ||
          medicamento.nombre.toLowerCase().contains(texto) ||
          medicamento.principioActivo.toLowerCase().contains(texto) ||
          medicamento.concentracion.toLowerCase().contains(texto) ||
          medicamento.laboratorio.toLowerCase().contains(texto);

      final coincideEstado =
          _filtroEstado == 'Todos' ||
          (_filtroEstado == 'Activos' && medicamento.estado) ||
          (_filtroEstado == 'Inactivos' && !medicamento.estado);

      final coincidePresentacion =
          _filtroPresentacion == 'Todas' ||
          medicamento.presentacion == _filtroPresentacion;

      return coincideBusqueda && coincideEstado && coincidePresentacion;
    }).toList();
  }

  int get _total => _medicamentos.length;

  int get _activos =>
      _medicamentos.where((medicamento) => medicamento.estado).length;

  int get _inactivos =>
      _medicamentos.where((medicamento) => !medicamento.estado).length;

  int get _presentaciones => _medicamentos
      .map((medicamento) => medicamento.presentacion)
      .toSet()
      .length;

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
          'Medicamentos',
          style: TextStyle(color: textoPrincipal, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Actualizar',
            icon: const Icon(Icons.refresh_outlined, color: textoPrincipal),
            onPressed: () {
              setState(() {});
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: azulPrincipal,
        foregroundColor: Colors.white,
        onPressed: _mostrarNuevoMedicamento,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo medicamento'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _construirEncabezado(),
                    const SizedBox(height: 24),
                    _construirResumen(),
                    const SizedBox(height: 24),
                    _construirFiltros(),
                    const SizedBox(height: 20),
                    _construirLista(),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _construirEncabezado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Catálogo de medicamentos',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Administra los medicamentos disponibles para las recetas médicas.',
          style: TextStyle(fontSize: 14, color: textoSecundario),
        ),
      ],
    );
  }

  Widget _construirResumen() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ancho = constraints.maxWidth;

        if (ancho < 700) {
          return Column(
            children: [
              _tarjetaResumen(
                titulo: 'Total',
                valor: '$_total',
                icono: Icons.medication_outlined,
                color: azulPrincipal,
              ),
              const SizedBox(height: 12),
              _tarjetaResumen(
                titulo: 'Activos',
                valor: '$_activos',
                icono: Icons.check_circle_outline,
                color: verde,
              ),
              const SizedBox(height: 12),
              _tarjetaResumen(
                titulo: 'Inactivos',
                valor: '$_inactivos',
                icono: Icons.block_outlined,
                color: rojo,
              ),
              const SizedBox(height: 12),
              _tarjetaResumen(
                titulo: 'Presentaciones',
                valor: '$_presentaciones',
                icono: Icons.inventory_2_outlined,
                color: Colors.orange.shade700,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _tarjetaResumen(
                titulo: 'Total',
                valor: '$_total',
                icono: Icons.medication_outlined,
                color: azulPrincipal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _tarjetaResumen(
                titulo: 'Activos',
                valor: '$_activos',
                icono: Icons.check_circle_outline,
                color: verde,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _tarjetaResumen(
                titulo: 'Inactivos',
                valor: '$_inactivos',
                icono: Icons.block_outlined,
                color: rojo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _tarjetaResumen(
                titulo: 'Presentaciones',
                valor: '$_presentaciones',
                icono: Icons.inventory_2_outlined,
                color: Colors.orange.shade700,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _tarjetaResumen({
    required String titulo,
    required String valor,
    required IconData icono,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icono, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(fontSize: 13, color: textoSecundario),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
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

  Widget _construirFiltros() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buscar y filtrar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textoPrincipal,
            ),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 700) {
                return Column(
                  children: [
                    _campoBusqueda(),
                    const SizedBox(height: 12),
                    _filtroEstadoWidget(),
                    const SizedBox(height: 12),
                    _filtroPresentacionWidget(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(flex: 2, child: _campoBusqueda()),
                  const SizedBox(width: 12),
                  Expanded(child: _filtroEstadoWidget()),
                  const SizedBox(width: 12),
                  Expanded(child: _filtroPresentacionWidget()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _campoBusqueda() {
    return TextField(
      controller: _buscarController,
      onChanged: (_) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: 'Buscar por nombre, principio activo...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _buscarController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _buscarController.clear();
                  setState(() {});
                },
              )
            : null,
        filled: true,
        fillColor: fondo,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _filtroEstadoWidget() {
    return DropdownButtonFormField<String>(
      initialValue: _filtroEstado,
      decoration: InputDecoration(
        labelText: 'Estado',
        filled: true,
        fillColor: fondo,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'Todos', child: Text('Todos')),
        DropdownMenuItem(value: 'Activos', child: Text('Activos')),
        DropdownMenuItem(value: 'Inactivos', child: Text('Inactivos')),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _filtroEstado = value;
        });
      },
    );
  }

  Widget _filtroPresentacionWidget() {
    final presentaciones = [
      'Todas',
      'Tableta',
      'Cápsula',
      'Jarabe',
      'Suspensión',
      'Crema',
      'Inyectable',
    ];

    return DropdownButtonFormField<String>(
      initialValue: _filtroPresentacion,
      decoration: InputDecoration(
        labelText: 'Presentación',
        filled: true,
        fillColor: fondo,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: presentaciones
          .map(
            (presentacion) => DropdownMenuItem(
              value: presentacion,
              child: Text(presentacion),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _filtroPresentacion = value;
        });
      },
    );
  }

  Widget _construirLista() {
    final medicamentos = _medicamentosFiltrados;

    if (medicamentos.isEmpty) {
      return _construirEstadoVacio();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Medicamentos registrados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textoPrincipal,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: azulClaro,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${medicamentos.length}',
                style: const TextStyle(
                  color: azulPrincipal,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...medicamentos.map(_construirTarjetaMedicamento),
      ],
    );
  }

  Widget _construirTarjetaMedicamento(_Medicamento medicamento) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _mostrarDetalleMedicamento(medicamento),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: azulClaro,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.medication_outlined,
                  color: azulPrincipal,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            medicamento.nombre,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: textoPrincipal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _estadoBadge(medicamento.estado),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${medicamento.principioActivo} • ${medicamento.concentracion}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: textoSecundario,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${medicamento.presentacion} • ${medicamento.laboratorio}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.chevron_right, color: textoSecundario),
            ],
          ),
        ),
      ),
    );
  }

  Widget _estadoBadge(bool activo) {
    final color = activo ? verde : rojo;
    final texto = activo ? 'Activo' : 'Inactivo';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _construirEstadoVacio() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: azulClaro,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.medication_outlined,
              size: 34,
              color: azulPrincipal,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No se encontraron medicamentos',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: textoPrincipal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Prueba con otro término de búsqueda o cambia los filtros.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: textoSecundario),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalleMedicamento(_Medicamento medicamento) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: azulClaro,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.medication_outlined,
                        color: azulPrincipal,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicamento.nombre,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: textoPrincipal,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            medicamento.id,
                            style: const TextStyle(
                              fontSize: 12,
                              color: textoSecundario,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _estadoBadge(medicamento.estado),
                  ],
                ),
                const SizedBox(height: 24),
                _filaDetalle('Principio activo', medicamento.principioActivo),
                _filaDetalle('Concentración', medicamento.concentracion),
                _filaDetalle('Presentación', medicamento.presentacion),
                _filaDetalle('Laboratorio', medicamento.laboratorio),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _mostrarEditarMedicamento(medicamento);
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Editar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: medicamento.estado ? rojo : verde,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _cambiarEstado(medicamento);
                        },
                        icon: Icon(
                          medicamento.estado
                              ? Icons.block_outlined
                              : Icons.check_circle_outline,
                        ),
                        label: Text(
                          medicamento.estado ? 'Desactivar' : 'Activar',
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

  Widget _filaDetalle(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 145,
            child: Text(
              titulo,
              style: const TextStyle(fontSize: 13, color: textoSecundario),
            ),
          ),
          Expanded(
            child: Text(
              valor,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textoPrincipal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _cambiarEstado(_Medicamento medicamento) {
    setState(() {
      medicamento.estado = !medicamento.estado;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          medicamento.estado
              ? 'Medicamento activado correctamente.'
              : 'Medicamento desactivado correctamente.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _mostrarNuevoMedicamento() {
    final nombreController = TextEditingController();
    final principioController = TextEditingController();
    final concentracionController = TextEditingController();
    final laboratorioController = TextEditingController();

    String presentacion = 'Tableta';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Nuevo medicamento',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _campoDialogo(
                      controller: nombreController,
                      label: 'Nombre comercial',
                      icono: Icons.medication_outlined,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: principioController,
                      label: 'Principio activo',
                      icono: Icons.science_outlined,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: concentracionController,
                      label: 'Concentración',
                      icono: Icons.straighten_outlined,
                      hint: 'Ej. 500 mg',
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: presentacion,
                      decoration: InputDecoration(
                        labelText: 'Presentación',
                        prefixIcon: const Icon(Icons.inventory_2_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Tableta',
                          child: Text('Tableta'),
                        ),
                        DropdownMenuItem(
                          value: 'Cápsula',
                          child: Text('Cápsula'),
                        ),
                        DropdownMenuItem(
                          value: 'Jarabe',
                          child: Text('Jarabe'),
                        ),
                        DropdownMenuItem(
                          value: 'Suspensión',
                          child: Text('Suspensión'),
                        ),
                        DropdownMenuItem(value: 'Crema', child: Text('Crema')),
                        DropdownMenuItem(
                          value: 'Inyectable',
                          child: Text('Inyectable'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setDialogState(() {
                          presentacion = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: laboratorioController,
                      label: 'Laboratorio',
                      icono: Icons.business_outlined,
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulPrincipal,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (nombreController.text.trim().isEmpty ||
                        principioController.text.trim().isEmpty ||
                        concentracionController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa los campos obligatorios.'),
                        ),
                      );
                      return;
                    }

                    final nuevo = _Medicamento(
                      id: 'MED-${(_medicamentos.length + 1).toString().padLeft(3, '0')}',
                      nombre: nombreController.text.trim(),
                      principioActivo: principioController.text.trim(),
                      concentracion: concentracionController.text.trim(),
                      presentacion: presentacion,
                      laboratorio: laboratorioController.text.trim().isEmpty
                          ? 'No especificado'
                          : laboratorioController.text.trim(),
                      estado: true,
                    );

                    setState(() {
                      _medicamentos.add(nuevo);
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Medicamento registrado correctamente.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() {
      nombreController.dispose();
      principioController.dispose();
      concentracionController.dispose();
      laboratorioController.dispose();
    });
  }

  void _mostrarEditarMedicamento(_Medicamento medicamento) {
    final nombreController = TextEditingController(text: medicamento.nombre);
    final principioController = TextEditingController(
      text: medicamento.principioActivo,
    );
    final concentracionController = TextEditingController(
      text: medicamento.concentracion,
    );
    final laboratorioController = TextEditingController(
      text: medicamento.laboratorio,
    );

    String presentacion = medicamento.presentacion;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Editar medicamento',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _campoDialogo(
                      controller: nombreController,
                      label: 'Nombre comercial',
                      icono: Icons.medication_outlined,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: principioController,
                      label: 'Principio activo',
                      icono: Icons.science_outlined,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: concentracionController,
                      label: 'Concentración',
                      icono: Icons.straighten_outlined,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: presentacion,
                      decoration: InputDecoration(
                        labelText: 'Presentación',
                        prefixIcon: const Icon(Icons.inventory_2_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Tableta',
                          child: Text('Tableta'),
                        ),
                        DropdownMenuItem(
                          value: 'Cápsula',
                          child: Text('Cápsula'),
                        ),
                        DropdownMenuItem(
                          value: 'Jarabe',
                          child: Text('Jarabe'),
                        ),
                        DropdownMenuItem(
                          value: 'Suspensión',
                          child: Text('Suspensión'),
                        ),
                        DropdownMenuItem(value: 'Crema', child: Text('Crema')),
                        DropdownMenuItem(
                          value: 'Inyectable',
                          child: Text('Inyectable'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setDialogState(() {
                          presentacion = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: laboratorioController,
                      label: 'Laboratorio',
                      icono: Icons.business_outlined,
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulPrincipal,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (nombreController.text.trim().isEmpty ||
                        principioController.text.trim().isEmpty ||
                        concentracionController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa los campos obligatorios.'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      medicamento.nombre = nombreController.text.trim();
                      medicamento.principioActivo = principioController.text
                          .trim();
                      medicamento.concentracion = concentracionController.text
                          .trim();
                      medicamento.presentacion = presentacion;
                      medicamento.laboratorio =
                          laboratorioController.text.trim().isEmpty
                          ? 'No especificado'
                          : laboratorioController.text.trim();
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Medicamento actualizado correctamente.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text('Guardar cambios'),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() {
      nombreController.dispose();
      principioController.dispose();
      concentracionController.dispose();
      laboratorioController.dispose();
    });
  }

  Widget _campoDialogo({
    required TextEditingController controller,
    required String label,
    required IconData icono,
    String? hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icono),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _Medicamento {
  final String id;
  String nombre;
  String principioActivo;
  String concentracion;
  String presentacion;
  String laboratorio;
  bool estado;

  _Medicamento({
    required this.id,
    required this.nombre,
    required this.principioActivo,
    required this.concentracion,
    required this.presentacion,
    required this.laboratorio,
    required this.estado,
  });
}
