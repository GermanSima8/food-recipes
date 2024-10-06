class Platillo {
  final int? id;
  final String nombre;
  final int tiempoPreparacion;
  final String tipoComida;
  final String pasos;

  Platillo({
    this.id,
    required this.nombre,
    required this.tiempoPreparacion,
    required this.tipoComida,
    required this.pasos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'tiempoPreparacion': tiempoPreparacion,
      'tipoComida': tipoComida,
      'pasos': pasos,
    };
  }

  static Platillo fromMap(Map<String, dynamic> map) {
    return Platillo(
      id: map['id'],
      nombre: map['nombre'],
      tiempoPreparacion: map['tiempoPreparacion'],
      tipoComida: map['tipoComida'],
      pasos: map['pasos'],
    );
  }
}
