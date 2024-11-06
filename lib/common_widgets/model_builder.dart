import 'package:flutter/material.dart';
import 'package:computadoras/models/model.dart';

class ModelBuilder extends StatelessWidget {
  const ModelBuilder({
    Key? key,
    required this.future,
  }) : super(key: key);
  final Future<List<Model>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Model>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final model = snapshot.data![index];
              return _buildModelCard(model, context);
            },
          ),
        );
      },
    );
  }

  Widget _buildModelCard(Model model, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              alignment: Alignment.center,
              child: Text(
                model.id.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(model.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
