class Coordinator {
  int id;
  String coordinatorName;
  int oasisId;

  Coordinator(
      {required this.id, required this.coordinatorName, required this.oasisId});

  factory Coordinator.fromJson(Map<String, dynamic> map) {
    return Coordinator(
      id: map['id'],
      coordinatorName: map['name'],
      oasisId: map['oasisId'],
    );
  }
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': coordinatorName, 'oasisId': oasisId};
}
