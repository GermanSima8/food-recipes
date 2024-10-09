class Platillo {
  final int? id;
  final String nombre;
  final int tiempoPreparacion;
  final String tipoComida;
  final String pasos;
  final bool favorito; // Campo nuevo

  Platillo({
    this.id,
    required this.nombre,
    required this.tiempoPreparacion,
    required this.tipoComida,
    required this.pasos,
    this.favorito = false, // Inicializado como false
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'tiempoPreparacion': tiempoPreparacion,
      'tipoComida': tipoComida,
      'pasos': pasos,
      'favorito': favorito ? 1 : 0, // Convertir a int
    };
  }

  static Platillo fromMap(Map<String, dynamic> map) {
    return Platillo(
      id: map['id'],
      nombre: map['nombre'],
      tiempoPreparacion: map['tiempoPreparacion'],
      tipoComida: map['tipoComida'],
      pasos: map['pasos'],
      favorito: map['favorito'] == 1, // Convertir a bool
    );
  }

  Platillo copyWith({
    int? id,
    String? nombre,
    int? tiempoPreparacion,
    String? tipoComida,
    String? pasos,
    bool? favorito,
  }) {
    return Platillo(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tiempoPreparacion: tiempoPreparacion ?? this.tiempoPreparacion,
      tipoComida: tipoComida ?? this.tipoComida,
      pasos: pasos ?? this.pasos,
      favorito: favorito ?? this.favorito,
    );
  }
}
