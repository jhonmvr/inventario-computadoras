import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/computadora.dart';

class EditComputadoraScreen extends StatefulWidget {
  final Computadora? computadora;

  EditComputadoraScreen({this.computadora});

  @override
  _EditComputadoraScreenState createState() => _EditComputadoraScreenState();
}

class _EditComputadoraScreenState extends State<EditComputadoraScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _procesadorController;
  late TextEditingController _discoDuroController;
  late TextEditingController _ramController;

  @override
  void initState() {
    super.initState();
    _procesadorController =
        TextEditingController(text: widget.computadora?.procesador ?? '');
    _discoDuroController =
        TextEditingController(text: widget.computadora?.discoDuro ?? '');
    _ramController = TextEditingController(text: widget.computadora?.ram ?? '');
  }

  void _saveComputadora() async {
    if (_formKey.currentState!.validate()) {
      final nuevaComputadora = Computadora(
        id: widget.computadora?.id,
        procesador: _procesadorController.text,
        discoDuro: _discoDuroController.text,
        ram: _ramController.text,
      );

      if (widget.computadora == null) {
        await DatabaseHelper().insertComputadora(nuevaComputadora);
      } else {
        await DatabaseHelper().updateComputadora(nuevaComputadora);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.computadora == null
              ? 'Añadir Computadora'
              : 'Editar Computadora')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _procesadorController,
                decoration: InputDecoration(labelText: 'Procesador'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _discoDuroController,
                decoration: InputDecoration(labelText: 'Disco Duro'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _ramController,
                decoration: InputDecoration(labelText: 'RAM'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveComputadora,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
