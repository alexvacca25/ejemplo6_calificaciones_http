class Post {
  final String id;
  final String codigo;
  final String nombre;
  final String materia;
  final String foto;
  final String n1;
  final String n2;
  final String n3;
  final String detalle;

  Post(
      {required this.id,
      required this.codigo,
      required this.nombre,
      required this.materia,
      required this.foto,
      required this.n1,
      required this.n2,
      required this.n3,
      required this.detalle});

  String get definitiva {
    var def;
    def = (double.parse(n1) * 0.30 +
            double.parse(n2) * 0.30 +
            double.parse(n3) * 0.40)
        .toStringAsFixed(2);
    return def.toString();
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      codigo: json['codigo'],
      nombre: json['nombre'],
      materia: json['materia'],
      foto: json['foto'],
      n1: json['n1'],
      n2: json['n2'],
      n3: json['n3'],
      detalle: json['detalle'],
    );
  }
}
