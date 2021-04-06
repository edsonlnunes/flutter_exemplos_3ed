import 'dart:convert';

class User {
  int? id;
  String? name;
  String? email;
  String? cep;
  String? address;
  String? pathImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.cep,
    required this.address,
    required this.pathImage,
  });

  User.empty();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'cep': cep,
      'address': address,
      'file_path': pathImage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      cep: map['cep'],
      address: map['address'],
      pathImage: map['file_path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, cep: $cep, address: $address, pathImage: $pathImage)';
  }
}
