
class StajTuru{
  String stajTuru;
  int id;


  StajTuru({required this.stajTuru,required this.id});

  factory StajTuru.fromJSON(Map map){
    return StajTuru(stajTuru: map['staj_turu'], id:int.parse( map['id']));
  }

}