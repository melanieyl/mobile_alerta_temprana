class FotoIncidente {
  int id;
  String path;
  FotoIncidente({required this.id, required this.path});
}

final fotos_general_categories = [
  FotoIncidente(id: 3, path: "imgs/general_categories/incendio_forestal.jpg"),
  FotoIncidente(id: 4, path: "imgs/general_categories/incendio_estructural.jpg"),
  FotoIncidente(id: 5, path: "imgs/general_categories/inundacion.jpg"),
  FotoIncidente(id: 6, path: "imgs/general_categories/deslizamiento.jpg"),
  FotoIncidente(id: 7, path: "imgs/general_categories/helada.jpg"),
  FotoIncidente(id: 8, path: "imgs/general_categories/sequia.jpg"),
  FotoIncidente(id: 8, path: "imgs/general_categories/terremoto.jpg"),
  FotoIncidente(id: 9, path: "imgs/general_categories/desaparecidos.jpg"),
  FotoIncidente(id: 10, path: "imgs/general_categories/conflictos_sociales.jpg"),
];


final fotos_incendios_estructurales = [
  FotoIncidente(id: 3, path: "imgs/incendio_estructural/1.jpg"),
  FotoIncidente(id: 4, path: "imgs/incendio_estructural/2.jpg"),
  FotoIncidente(id: 5, path: "imgs/incendio_estructural/3.jpg"),
  FotoIncidente(id: 6, path: "imgs/incendio_estructural/4.jpg"),
  FotoIncidente(id: 7, path: "imgs/incendio_estructural/5.jpg"),
];
final fotos_incendios_forestales = [
  FotoIncidente(id: 1, path: "imgs/incendio_forestal/1.jpg"),
  FotoIncidente(id: 2, path: "imgs/incendio_forestal/2.jpg"),
];
final fotos_inundaciones = [
  FotoIncidente(id: 8, path: "imgs/inundaciones/1.jpg"),
  FotoIncidente(id: 9, path: "imgs/inundaciones/2.jpg"),
  FotoIncidente(id: 10, path: "imgs/inundaciones/3.jpg"),
];

final fotos_conflictos_sociales = [
  FotoIncidente(id: 11, path: "imgs/conflctos_sociales/1.jpg"),
];

