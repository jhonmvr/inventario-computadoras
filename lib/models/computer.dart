import 'dart:convert';
import 'dart:ui';



class Computer {
  final int? id;
  final String procesador;
  final int ram;
  final String discoDuro;
  

  Computer({
    this.id,
    required this.procesador,
    required this.discoDuro,
    required this.ram,
  });

  // Convert a Computer into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'procesador': procesador,
      'ram': ram,
      'discoDuro': discoDuro,
      
    };
  }

  factory Computer.fromMap(Map<String, dynamic> map) {
    return Computer(
      id: map['id']?.toInt() ?? 0,
      procesador: map['procesador'] ?? '',
      ram: map['ram'] ?? '',
      discoDuro: map['discoDuro'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Computer.fromJson(String source) => Computer.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each computer when using the print statement.
  @override
  String toString() {
    return 'Computer(id: $id, procesador: $procesador, discoDuro: $discoDuro, ram: $ram)';
  }
}
