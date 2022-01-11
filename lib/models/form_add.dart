import 'package:flutter/cupertino.dart';
import 'package:internship_managing_system/models/form_data.dart';


class FormAdd with ChangeNotifier{

  final List<FormData> _list =[];
  void addNewFormToList(FormData form){
    _list.add(form);
    notifyListeners();
  }


  void updateUserList(int index,FormData data){
    _list.removeAt(index);
    _list.insert(index, data);
    notifyListeners();
  }
  void deleteFormInstance(int index){
    _list.removeAt(index);
    notifyListeners();
  }
  List<FormData> getForms()=>_list;
}