class Speciality {
  int id;
  String name;
  Speciality({required this.id, required this.name});

  factory Speciality.fromJSON(Map<String, dynamic> map) {
    return Speciality(id: map['id'], name: map['description']);
  }
  Map<String, dynamic> toJson() => {'id': id, 'description': name};
}
