import 'package:flutter/material.dart';


import 'package:computadoras/models/computer.dart';
import 'package:computadoras/services/database_service.dart';

import '../common_widgets/ram_slider.dart';

class ComputerFormPram extends StatefulWidget {
  const ComputerFormPram({Key? key, this.computer}) : super(key: key);
  final Computer? computer;

  @override
  _ComputerFormPramState createState() => _ComputerFormPramState();
}

class _ComputerFormPramState extends State<ComputerFormPram> {
  final TextEditingController _nameController = TextEditingController();
  static final List<Color> _colors = [
    Color(0xFF000000),
    Color(0xFFFFFFFF),
    Color(0xFF947867),
    Color(0xFFC89234),
    Color(0xFF862F07),
    Color(0xFF2F1B15),
  ];

  final DatabaseService _databaseService = DatabaseService();

  int _selectedRam = 0;
  String _selectedDisco = '';
  String _selectedProcesador = '';

  @override
  void initState() {
    super.initState();
    if (widget.computer != null) {
      _selectedRam = widget.computer!.ram;
      _selectedDisco = widget.computer!.discoDuro;
      _selectedProcesador = widget.computer!.procesador;
    }
  }



  Future<void> _onSave() async {
    final ram = _selectedRam;
    final disco = _selectedDisco;
    final procesador = _selectedProcesador;

    // Add save code here
    widget.computer == null
        ? await _databaseService.insertComputer(
            Computer( ram: ram,  procesador: '', discoDuro: ''),
          )
        : await _databaseService.updateComputer(
            Computer(
              id: widget.computer!.id,
              ram: ram,
              discoDuro: disco,
              procesador: procesador
            ),
          );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Computer Record'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name of the computer here',
              ),
            ),
            SizedBox(height: 16.0),
            // Age Slider
            AgeSlider(
              max: 30.0,
              selectedAge: _selectedRam.toDouble(),
              onChanged: (value) {
                setState(() {
                  _selectedRam = value.toInt();
                });
              },
            ),
            SizedBox(height: 16.0),
            // Color Picker

            SizedBox(height: 24.0),
            // Model Selector

            SizedBox(height: 24.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: _onSave,
                child: Text(
                  'Save the Computer data',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
