import 'dart:convert';
import 'dart:ui';



class Computer {
  final int? id;
  final String name;
  final int ram;
  final Color color;
  final int modelId;

  Computer({
    this.id,
    required this.name,
    required this.ram,
    required this.color,
    required this.modelId,
  });

  // Convert a Computer into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ram': ram,
      'color': color.value,
      'modelId': modelId,
    };
  }

  factory Computer.fromMap(Map<String, dynamic> map) {
    return Computer(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      ram: map['ram']?.toInt() ?? 0,
      color: Color(map['color']),
      modelId: map['modelId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Computer.fromJson(String source) => Computer.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each computer when using the print statement.
  @override
  String toString() {
    return 'Computer(id: $id, name: $name, ram: $ram, color: $color, modelId: $modelId)';
  }
}
