class Coordinator {
  int? _id;
  String? _coordinatorName;
  int? _oasisId;

  Coordinator(this._id, this._coordinatorName, this._oasisId);


  Map<String, dynamic> toMap() => {
    'coordinator_id': id,
    'coordinator_name': coordinatorName,
    'oasis_id': oasisId,
  };

  int? get oasisId => _oasisId;

  set oasisId(int? value) {
    _oasisId = value;
  }

  String? get coordinatorName => _coordinatorName;

  set coordinatorName(String? value) {
    _coordinatorName = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}
