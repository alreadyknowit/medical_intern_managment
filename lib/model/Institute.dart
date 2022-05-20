class Institute {
  int id;
  String instituteName;

  Institute({required this.id, required this.instituteName});

  factory Institute.fromJSON(Map<String, dynamic> map) {
    return Institute(id: map['id'], instituteName: map['name']);
  }
  Map<String, dynamic> toJson() => {'id': id, 'name': instituteName};
}
