class Institute {
  int id;
  String instituteName;

  Institute({required this.id, required this.instituteName});

  factory Institute.fromJSON(Map<String, dynamic> map) {
    return Institute(id: map['id'], instituteName: map['name']);
  }
  Map<String, dynamic> toJson() => {'id': id, 'name': instituteName};

  Map<String, dynamic> toMap() =>
      { 'institute_id':id,
        'institute_name': instituteName};

  factory Institute.fromMap(Map<String, dynamic> map) {
    return Institute(id: map['institute_id'], instituteName: map['institute_name']);
  }
}
