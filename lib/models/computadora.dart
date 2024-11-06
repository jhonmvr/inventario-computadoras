class Computadora {
  int? id;
  String procesador;
  String discoDuro;
  String ram;

  Computadora(
      {this.id,
      required this.procesador,
      required this.discoDuro,
      required this.ram});

  // Convertir Computadora a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'procesador': procesador,
      'discoDuro': discoDuro,
      'ram': ram,
    };
  }

  // Convertir Map a Computadora
  factory Computadora.fromMap(Map<String, dynamic> map) {
    return Computadora(
      id: map['id'],
      procesador: map['procesador'],
      discoDuro: map['discoDuro'],
      ram: map['ram'],
    );
  }
}
