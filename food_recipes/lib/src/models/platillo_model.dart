class Platillo {
  final int? id;
  final String nombre;

  Platillo({this.id, required this.nombre});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  factory Platillo.fromMap(Map<String, dynamic> map) {
    return Platillo(
      id: map['id'],
      nombre: map['nombre'],
    );
  }
}
