class AttendingPhysicianModel{

  String name;
  int id;
  int klinikID;
//TODO: uzmanlık alanı eklenecek Ortopedi,Pediatri vb.

AttendingPhysicianModel({required this.name,required this.id,required this.klinikID});

factory AttendingPhysicianModel.fromJSON(Map<String,dynamic> map){
  
  return AttendingPhysicianModel(name: map['doktor_ad'], id: int.parse(map['id']), klinikID: int.parse(map['klinik_id']));
}
}