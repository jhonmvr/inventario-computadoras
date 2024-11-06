import 'package:flutter/material.dart';

import '../models/model.dart';
import '../services/database_service.dart';

class ModelFormPram extends StatefulWidget {
  const ModelFormPram({Key? key}) : super(key: key);

  @override
  _ModelFormPramState createState() => _ModelFormPramState();
}

class _ModelFormPramState extends State<ModelFormPram> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final DatabaseService _databaseService = DatabaseService();

  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descController.text;

    await _databaseService
        .insertModel(Model(name: name, description: description));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new model'),
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
                hintText: 'Enter name of the model here',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descController,
              maxLines: 7,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description about the model here',
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: _onSave,
                child: Text(
                  'Save the Model',
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
