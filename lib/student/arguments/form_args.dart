import 'package:internship_managing_system/model/ProcedureLog.dart';

import '../../model/PatientLog.dart ';

class FormArguments {
  PatientLog formData;
  int index;
  bool? isDeletable;
  FormArguments(
      {required this.formData, required this.index, this.isDeletable});
}

class TibbiFormArguments {
  ProcedureLog tibbiFormData;
  int index;
  bool? isDeletable;
  TibbiFormArguments(
      {required this.tibbiFormData, required this.index, this.isDeletable});
}
