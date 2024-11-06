import 'package:flutter/material.dart';

class ModelSelector extends StatelessWidget {
  const ModelSelector({
    Key? key,
    required this.models,
    required this.selectedIndex,
    required this.onChanged,
  }) : super(key: key);
  final List<String> models;
  final int selectedIndex;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select model',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 40.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: models.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onChanged(index),
                child: Container(
                  height: 40.0,
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  margin: const EdgeInsets.only(right: 12.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 3.0,
                      color:
                          selectedIndex == index ? Colors.teal : Colors.black,
                    ),
                  ),
                  child: Text(models[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
