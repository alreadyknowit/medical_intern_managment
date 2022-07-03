import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internship_managing_system/attending_physician//widget/form_card_widget.dart';
import 'package:internship_managing_system/attending_physician/provider/feedback_position_provider.dart';
import 'package:internship_managing_system/attending_physician/screens/history.dart';
import 'package:internship_managing_system/attending_physician/services/AttendingDatabaseHelper.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:provider/provider.dart';
import '../../model/PatientLog.dart';
import '../../model/ProcedureLog.dart';

class AttendingPhysicianMain extends StatefulWidget {
  @override
  _AttendingPhysicianMainState createState() => _AttendingPhysicianMainState();
}

class _AttendingPhysicianMainState extends State<AttendingPhysicianMain> {
  final AttendingDatabaseHelper _dbHelper = AttendingDatabaseHelper();
  List<PatientLog> formList = [];
  List<ProcedureLog> procedureList = [];
  bool isProcedure=false;

  bool isLoading = false;

  getForms() async {
    setState(() {
      isLoading = true;
    });
    formList = await _dbHelper.fetchFormsFromDatabase('waiting').then((value) {
      setState(() {
        isLoading = false;
      });
      return value;
    });

    procedureList =
        await _dbHelper.fetchTibbiFormsFromDatabase('waiting').then((value) {
      setState(() {
        isLoading = false;
      });
      return value;
    });
  }

  @override
  void initState() {
    getForms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: buildAppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: isLoading
                  ? spinkit
                  : isProcedure ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  procedureList.isEmpty
                      ? const Center(
                    child: Text('Başka form kalmadı...'),
                  )
                      : Stack(
                    children: procedureList.map((e) => buildForm(null, e),).toList(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                      child: Text(
                        "Onaylamak için sağa doğru, reddetmek için sola doğru kaydırın.",
                        textAlign: TextAlign.center,
                        style: TEXT_STYLE.copyWith(fontSize: 14),
                      )),
                ],
              )
                  :
              Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        formList.isEmpty
                            ? const Center(
                                child: Text('Başka form kalmadı...'),
                              )
                            : Stack(
                                children: formList.map((e) => buildForm(e,null),).toList(),
                              ),
                        const SizedBox(
                          height: 40,
                        ),
                        Expanded(
                            child: Text(
                          "Onaylamak için sağa doğru, reddetmek için sola doğru kaydırın.",
                          textAlign: TextAlign.center,
                          style: TEXT_STYLE.copyWith(fontSize: 14),
                        )),
                      ],
                    ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: getForms,
            backgroundColor: PRIMARY_BUTTON_COLOR,
            child: const Icon(Icons.refresh),
          ),
        );
      });

  Widget buildForm(PatientLog? form, ProcedureLog? procedure) {
    bool isFormInFocus;
    if(form != null){
      final formIndex = formList.indexOf(form);
       isFormInFocus = formIndex == formList.length - 1;
      print(isFormInFocus);

      return buildListener(form,null, isFormInFocus);
    }else{
      final formIndex = procedureList.indexOf(procedure!);
       isFormInFocus = formIndex == formList.length - 1;
      print(isFormInFocus);
      return buildListener(null,procedure, isFormInFocus);
    }


  }

  Listener buildListener(PatientLog? form,ProcedureLog? procedure, bool isFormInFocus) {

    return form != null ? Listener(
      onPointerMove: (pointerEvent) {
        final provider =
        Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        final provider =
        Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      onPointerUp: (_) {
        final provider =
        Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      child: Draggable(
        child: FormCardWidget(form: form,procedure: null, isFormInFocus: isFormInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: FormCardWidget(form: form,procedure: null, isFormInFocus: isFormInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, form,null),
      ),
    ) : Listener(
      onPointerMove: (pointerEvent) {
        final provider =
        Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        final provider =
        Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      onPointerUp: (_) {
        final provider =
        Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      child: Draggable(
        child: FormCardWidget(form: null,procedure: procedure, isFormInFocus: isFormInFocus=true),
        feedback: Material(
          type: MaterialType.transparency,
          child: FormCardWidget(form: null,procedure: procedure, isFormInFocus: isFormInFocus=true),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, null,procedure),
      ),
    )
    ;
  }

  double onDragEnd(DraggableDetails details, PatientLog? form, ProcedureLog? procedure) {
    const minimumDrag = 100;
    if (details.offset.dx > minimumDrag ) {
      if(form != null){
        form.setStatus('accept');
        _dbHelper.updateFormStatus(form);
        setState(() => formList.remove(form));
      }else{
        procedure!.setStatus('accept');
        _dbHelper.updateProcedureStatus(procedure);
        setState(() => procedureList.remove(procedure));
      }
    } else if (details.offset.dx < -minimumDrag) {
     if(form != null){
       form.setStatus('reject');
       _dbHelper.updateFormStatus(form);
       setState(() => formList.remove(form));
     }else{
       procedure!.setStatus('reject');
       _dbHelper.updateProcedureStatus(procedure);
       setState(() => procedureList.remove(procedure));
     }
    }
    return details.offset.dx;
//TODO:When scrolling the form the "Onayla" and "Reddet" writings should be invisible.
  }

  AppBar buildAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            child:
                Icon(Icons.history, color: BACKGROUND_COLOR.withOpacity(0.8)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => const HistoryForms()));
            },
          ),
          const SizedBox(width: 16),
        ],
        leading: InkWell(
            onTap: () {
              setState(() {
                isProcedure = !isProcedure;
              });
            },
            child:
                Icon(FontAwesomeIcons.swift, color: BACKGROUND_COLOR.withOpacity(0.8),size: 40,)),
        title: FaIcon(
          FontAwesomeIcons.bookMedical,
          color: BACKGROUND_COLOR.withOpacity(0.8),
          size: 40,
        ),
      );
}
