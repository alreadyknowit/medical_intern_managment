import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internship_managing_system/attending_physician/provider/feedback_position_provider.dart';
import 'package:internship_managing_system/attending_physician/services/MySqlHelper.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/attending_physician//widget/form_card_widget.dart';

class AttendingPhysician extends StatefulWidget {
  @override
  _AttendingPhysicianState createState() => _AttendingPhysicianState();
}

class _AttendingPhysicianState extends State<AttendingPhysician> {
  final MySqlHelper _mySqlHelper = MySqlHelper();
  List<FormData> formList = [];
  bool isLoading = false;
  getForms() async {
    setState(() {
      isLoading=true;
    });
    formList = await _mySqlHelper.fetchWaitingForms().then((value) {
      setState(() {
        isLoading = false;
      });

      return value;
    });
    print(formList.length);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getForms();
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
                    :  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            formList.isEmpty
                                ? const Center(child:Text('Başka form kalmadı...') ,)
                                : Stack(
                                    children: formList.map(buildForm).toList()),
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

  Widget buildForm(FormData form) {
    final formIndex = formList.indexOf(form);
    bool isFormInFocus = formIndex == formList.length - 1;

    return Listener(
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
        child: FormCardWidget(form: form, isFormInFocus: isFormInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: FormCardWidget(form: form, isFormInFocus: isFormInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, form),
      ),
    );
  }

  double onDragEnd(DraggableDetails details, FormData form) {
    const minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      form.setStatus('accept');
      _mySqlHelper.update(form);
      setState(() => formList.remove(form));
    } else if (details.offset.dx < -minimumDrag) {
      form.setStatus('reject');
      _mySqlHelper.update(form);
      setState(() => formList.remove(form));
    }
    return details.offset.dx;
//TODO:When scrolling the form the "Onayla" and "Reddet" writings should be invisible.
  }

  AppBar buildAppBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.notifications, color: BACKGROUND_COLOR.withOpacity(0.8)),
          const SizedBox(width: 16),
        ],
        leading: Icon(Icons.person, color: BACKGROUND_COLOR.withOpacity(0.8)),
        title: FaIcon(
          FontAwesomeIcons.bookMedical,
          color: BACKGROUND_COLOR.withOpacity(0.8),
          size: 40,
        ),
      );
}
