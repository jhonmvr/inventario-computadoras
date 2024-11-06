
class Computer {
  final int? id;
  final String procesador;
  final String ram;
  final String discoDuro;

  Computer({this.id, required this.procesador, required this.ram, required this.discoDuro});

  // Convert a Computer object into a Map object.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'procesador': procesador,
      'ram': ram,
      'discoDuro': discoDuro,
    };
  }

  // Extract a Computer object from a Map object.
  factory Computer.fromMap(Map<String, dynamic> map) {
    return Computer(
      id: map['id'],
      procesador: map['procesador'],
      ram: map['ram'],
      discoDuro: map['discoDuro'],
    );
  }

  @override
  String toString() {
    return 'Computer{id: $id, procesador: $procesador, ram: $ram, discoDuro: $discoDuro}';
  }
}
