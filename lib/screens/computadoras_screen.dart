import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/computadora.dart';

class ComputadorasScreen extends StatefulWidget {
  @override
  _ComputadorasScreenState createState() => _ComputadorasScreenState();
}

class _ComputadorasScreenState extends State<ComputadorasScreen> {
  late Future<List<Computadora>> _computadoras;

  @override
  void initState() {
    super.initState();
    _computadoras = DatabaseHelper().fetchComputadoras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Computadoras')),
      body: FutureBuilder<List<Computadora>>(
        future: _computadoras,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se obtienen los datos
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Muestra un mensaje de error si ocurre algún problema
            return Center(
                child: Text('Error al cargar datos: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Muestra un mensaje si no hay computadoras en la lista
            return Center(child: Text('No hay computadoras registradas'));
          } else {
            // Muestra la lista de computadoras si todo está bien
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final computadora = snapshot.data![index];
                return ListTile(
                  title: Text('Procesador: ${computadora.procesador}'),
                  subtitle: Text(
                      'RAM: ${computadora.ram} - Disco: ${computadora.discoDuro}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await DatabaseHelper().deleteComputadora(computadora.id!);
                      setState(() {
                        _computadoras = DatabaseHelper().fetchComputadoras();
                      });
                    },
                  ),
                  onTap: () {
                    // Lógica para editar una computadora o abrir su detalle
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navega a la pantalla para añadir una nueva computadora
        },
      ),
    );
  }
}
