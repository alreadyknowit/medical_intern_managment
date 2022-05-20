import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/Course.dart';
import 'package:internship_managing_system/model/Institute.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:internship_managing_system/student/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';
import '../services/StudentDatabaseHelper.dart';

class FilteringDropDown extends StatefulWidget {
  var logs;
  Function changeInstitute;
  Function changeCourse;
  Function changeSpecialities;
  Function changeAttendingPhysician;

  FilteringDropDown(this.logs, this.changeInstitute, this.changeCourse,
      this.changeSpecialities, this.changeAttendingPhysician);
  @override
  _FilteringDropDownState createState() => _FilteringDropDownState();
}

class _FilteringDropDownState extends State<FilteringDropDown> {
  late int id;
  late int idCourse;
  late int idSpecialities;
  List<Institute> institutes = [];
  List<Course> courses = [];
  List<Speciality> specialities = [];
  List<AttendingPhysician> attendingList = [];
  String? _selectedInstitute = "Ins1";
  String? _selectedAttending = "";
  String? _selectedCourse = "Course1";
  String? _selectedSpeciality = "";

  final PatientLog _patientLog = PatientLog();
  final ProcedureLog _procedureLog = ProcedureLog();

  @override
  void initState() {
    _getInstitues();
    _getCourses();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(
              "Institute",
              style: TEXT_STYLE,
            ),
            Padding(
              padding: const EdgeInsets.all(PADDING_VALUE),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButtonFormField(
                    key: PageStorageKey<BuildContext>(context),
                    decoration: const InputDecoration(border: InputBorder.none),
                    isExpanded: true,
                    validator: (val) => val == null ? 'Institute Name' : null,
                    value: _selectedInstitute,
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: ICON_COLOR,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: Colors.grey[800],
                    style: TEXT_STYLE,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedInstitute = newValue.toString();
                        for (int i = 0; i < institutes.length; i++) {
                          if (institutes[i].instituteName == _selectedInstitute)
                            id = institutes[i].id;
                        }
                        if (newValue is Institute) {
                          if (widget.logs == _patientLog) {
                            Provider.of<PatientLog>(context, listen: false)
                                .setInstute(newValue);
                            widget.changeInstitute(newValue);
                          } else if (widget.logs == _procedureLog) {
                            Provider.of<ProcedureLog>(context, listen: false)
                                .setInstute(newValue);
                            widget.changeInstitute(newValue);
                          }
                        }
                        //_selectedInstitute != newValue;

                        print(newValue);
                      });
                    },
                    items: institutes.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.instituteName),
                        value: item.instituteName,
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(
              "Courses",
              style: TEXT_STYLE,
            ),
            Padding(
              padding: const EdgeInsets.all(PADDING_VALUE),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButtonFormField(
                    key: PageStorageKey<BuildContext>(context),
                    decoration: const InputDecoration(border: InputBorder.none),
                    isExpanded: true,
                    validator: (val) => val == null ? 'Course Name' : null,
                    value: _selectedCourse,
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: ICON_COLOR,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: Colors.grey[800],
                    style: TEXT_STYLE,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCourse = newValue.toString();
                        for (int i = 0; i < courses.length; i++) {
                          if (courses[i].courseName == _selectedCourse) {
                            idCourse = courses[i].id;
                          }
                        }
                        _getSpecialities(idCourse);
                        if (newValue is Course) {
                          if (widget.logs == _patientLog) {
                            Provider.of<PatientLog>(context, listen: false)
                                .setCourse(newValue);
                            widget.changeCourse(newValue);
                          } else if (widget.logs == _procedureLog) {
                            Provider.of<ProcedureLog>(context, listen: false)
                                .setCourse(newValue);
                            // widget.changeCourse(newValue);
                          }
                        }
                        _selectedCourse != newValue;
                      });

                      print(newValue);
                    },
                    items: courses.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.courseName),
                        value: item.courseName,
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(
              "Specialities",
              style: TEXT_STYLE,
            ),
            Padding(
              padding: const EdgeInsets.all(PADDING_VALUE),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButtonFormField(
                    key: PageStorageKey<BuildContext>(context),
                    decoration: const InputDecoration(border: InputBorder.none),
                    isExpanded: true,
                    validator: (val) =>
                        val == null ? 'Specialities Name' : null,
                    value: _selectedSpeciality,
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: ICON_COLOR,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: Colors.grey[800],
                    style: TEXT_STYLE,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSpeciality = newValue.toString();
                        for (int i = 0; i < specialities.length; i++) {
                          if (specialities[i].name == _selectedSpeciality) {
                            idSpecialities = specialities[i].id;
                          }
                        }
                        _getAttendings(id, idSpecialities);
                        if (newValue is Speciality) {
                          if (widget.logs == _patientLog) {
                            Provider.of<PatientLog>(context, listen: false)
                                .setSpeciality(newValue);
                            widget.changeSpecialities(newValue);
                          } else if (widget.logs == _procedureLog) {
                            Provider.of<ProcedureLog>(context, listen: false)
                                .setSpeciality(newValue);
                            widget.changeSpecialities(newValue);
                          }
                        }
                        //   _selectedSpeciality != newValue;
                        print(newValue);
                      });
                    },
                    items: specialities.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.name),
                        value: item.name,
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(
              "Attending Physician",
              style: TEXT_STYLE,
            ),
            Padding(
              padding: const EdgeInsets.all(PADDING_VALUE),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButtonFormField(
                    key: PageStorageKey<BuildContext>(context),
                    decoration: const InputDecoration(border: InputBorder.none),
                    isExpanded: true,
                    validator: (val) => val == null
                        ? 'Lütfen Attending Physician giriniz'
                        : null,
                    value: _selectedAttending,
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: ICON_COLOR,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: Colors.grey[800],
                    style: TEXT_STYLE,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedAttending = newValue.toString();
                        if (newValue is AttendingPhysician) {
                          if (widget.logs == _patientLog) {
                            Provider.of<PatientLog>(context, listen: false)
                                .setAttendingPhysician(newValue);
                            widget.changeCourse(newValue);
                          } else if (widget.logs == _procedureLog) {
                            Provider.of<ProcedureLog>(context, listen: false)
                                .setAttendingPhysician(newValue);
                            widget.changeAttendingPhysician(newValue);
                          }
                        }
                        //  _selectedAttending != newValue;
                      });
                    },
                    items: attendingList.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.attendingName),
                        value: item.attendingName,
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Future _getInstitues() async {
    await StudentDatabaseHelper().fetchInstitute().then((response) {
//      print(data);
      setState(() {
        institutes = response;
        _selectedInstitute = institutes[0].instituteName;
      });
      /*  institutes.forEach((element) {
        print(element.instituteName);
      });*/
    });
  }

  Future _getCourses() async {
    await StudentDatabaseHelper().fetchCourses().then((response) {
//      print(data);
      setState(() {
        courses = response;
        _selectedCourse = courses[0].courseName;
      });
    });
  }

  Future _getSpecialities(int id) async {
    await StudentDatabaseHelper().fetchSpeciality().then((response) {
      List<Speciality> newList = [];

      setState(() {
        for (int i = 0; i < response.length; i++) {
          if (response[i].courseId == id) {
            newList.add(response[i]);
            specialities = newList;
          }
        }

        _selectedSpeciality = specialities[0].name;
      });
    });

    return specialities;
  }

  Future _getAttendings(int id, int? idSpecialities) async {
    await StudentDatabaseHelper().fetchAttendingPhysicians().then((response) {
      List<AttendingPhysician> newList = [];

      setState(() {
        for (int i = 0; i < response.length; i++) {
          if (response[i].instituteId == id &&
              response[i].specialityId == idSpecialities) {
            newList.add(response[i]);
            attendingList = newList;
          }
        }

        _selectedAttending = attendingList[0].attendingName;
      });
    });

    return attendingList;
  }
}
