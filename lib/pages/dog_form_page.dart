import 'package:flutter/material.dart';

import 'package:computadoras/models/model.dart';
import 'package:computadoras/models/computer.dart';
import 'package:computadoras/services/database_service.dart';

import '../common_widgets/age_slider.dart';
import '../common_widgets/model_selector.dart';
import '../common_widgets/color_picker.dart';

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
  static final List<Model> _models = [];

  final DatabaseService _databaseService = DatabaseService();

  int _selectedAge = 0;
  int _selectedColor = 0;
  int _selectedModel = 0;

  @override
  void initState() {
    super.initState();
    if (widget.computer != null) {
      _nameController.text = widget.computer!.name;
      _selectedAge = widget.computer!.ram;
      _selectedColor = _colors.indexOf(widget.computer!.color);
    }
  }

  Future<List<Model>> _getModels() async {
    final models = await _databaseService.models();
    if (_models.length == 0) _models.addAll(models);
    if (widget.computer != null) {
      _selectedModel = _models.indexWhere((e) => e.id == widget.computer!.modelId);
    }
    return _models;
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final ram = _selectedAge;
    final color = _colors[_selectedColor];
    final model = _models[_selectedModel];

    // Add save code here
    widget.computer == null
        ? await _databaseService.insertComputer(
            Computer(name: name, ram: ram, color: color, modelId: model.id!),
          )
        : await _databaseService.updateComputer(
            Computer(
              id: widget.computer!.id,
              name: name,
              ram: ram,
              color: color,
              modelId: model.id!,
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
              selectedAge: _selectedAge.toDouble(),
              onChanged: (value) {
                setState(() {
                  _selectedAge = value.toInt();
                });
              },
            ),
            SizedBox(height: 16.0),
            // Color Picker
            ColorPicker(
              colors: _colors,
              selectedIndex: _selectedColor,
              onChanged: (value) {
                setState(() {
                  _selectedColor = value;
                });
              },
            ),
            SizedBox(height: 24.0),
            // Model Selector
            FutureBuilder<List<Model>>(
              future: _getModels(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading models...");
                }
                return ModelSelector(
                  models: _models.map((e) => e.name).toList(),
                  selectedIndex: _selectedModel,
                  onChanged: (value) {
                    setState(() {
                      _selectedModel = value;
                    });
                  },
                );
              },
            ),
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
