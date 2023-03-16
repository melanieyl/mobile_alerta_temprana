class Usuario {
  int id;
  String name;
  String telefono;
  String email;
  String password;
  Usuario(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.telefono});
}

List<Usuario> usuario = [
  Usuario(
      id: 1,
      name: 'Melanie',
      email: 'test1@gmail.com',
      password: '123456789',
      telefono: '77654429')
];
