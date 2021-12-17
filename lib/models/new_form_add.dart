import 'package:internship_managing_system/models/form_data.dart';

class FormAdd{


  List<FormData> _list =[];
  void addNewFormToList(FormData form){
    _list.add(form);

  }

  List<FormData> getForms(){
    return _list;
  }
}