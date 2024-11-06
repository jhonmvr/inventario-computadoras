
import 'package:flutter/material.dart';
import '../models/computer.dart';
import '../services/database_service.dart';

class ComputerFormScreen extends StatefulWidget {
  final Computer? computer;
  ComputerFormScreen({this.computer});

  @override
  _ComputerFormScreenState createState() => _ComputerFormScreenState();
}

class _ComputerFormScreenState extends State<ComputerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  late TextEditingController _procesadorController;
  late TextEditingController _ramController;
  late TextEditingController _discoDuroController;

  @override
  void initState() {
    super.initState();
    _procesadorController = TextEditingController(text: widget.computer?.procesador ?? '');
    _ramController = TextEditingController(text: widget.computer?.ram ?? '');
    _discoDuroController = TextEditingController(text: widget.computer?.discoDuro ?? '');
  }

  @override
  void dispose() {
    _procesadorController.dispose();
    _ramController.dispose();
    _discoDuroController.dispose();
    super.dispose();
  }

  Future<void> _saveComputer() async {
    if (_formKey.currentState!.validate()) {
      final newComputer = Computer(
        id: widget.computer?.id,
        procesador: _procesadorController.text,
        ram: _ramController.text,
        discoDuro: _discoDuroController.text,
      );
      if (widget.computer == null) {
        await _databaseService.insertComputer(newComputer);
      } else {
        await _databaseService.updateComputer(newComputer);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.computer == null ? 'Add Computer' : 'Edit Computer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _procesadorController,
                decoration: InputDecoration(labelText: 'Procesador'),
                validator: (value) => value!.isEmpty ? 'Enter processor' : null,
              ),
              TextFormField(
                controller: _ramController,
                decoration: InputDecoration(labelText: 'RAM'),
                validator: (value) => value!.isEmpty ? 'Enter RAM' : null,
              ),
              TextFormField(
                controller: _discoDuroController,
                decoration: InputDecoration(labelText: 'Disco Duro'),
                validator: (value) => value!.isEmpty ? 'Enter storage' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveComputer,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
