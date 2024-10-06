class Ingrediente {
  final String nombre;
  final String cantidad;
  final int platilloId;

  Ingrediente({required this.nombre, required this.cantidad, required this.platilloId});

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'cantidad': cantidad,
      'platillo_id': platilloId, // Asegúrate de que 'platillo_id' coincida con la columna en la tabla
    };
  }

  static Ingrediente fromMap(Map<String, dynamic> map) {
    return Ingrediente(
      nombre: map['nombre'],
      cantidad: map['cantidad'],
      platilloId: map['platillo_id'], // Asegúrate de que 'platillo_id' coincida con la columna en la tabla
    );
  }
}
