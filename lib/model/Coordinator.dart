class Coordinator {
  int id;
  String coordinatorName;
  int oasisId;

  Coordinator(this.id, this.coordinatorName, this.oasisId);

  factory Coordinator.fromJson(Map<String, dynamic> map) =>
      Coordinator(map['id'], map['name'], map['oasisId']);

  @override
  String toString() {
    return '{id: $id, coordinatorName: $coordinatorName, oasisId: $oasisId}';
  }
}
