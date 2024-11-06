import 'dart:convert';

class Model {
  final int? id;
  final String name;
  final String description;

  Model({
    this.id,
    required this.name,
    required this.description,
  });

  // Convert a Model into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each model when using the print statement.
  @override
  String toString() => 'Model(id: $id, name: $name, description: $description)';
}
