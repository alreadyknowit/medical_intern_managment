import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internship_managing_system/student/screens/t%C4%B1bbi_etkilesim_kayd%C4%B1.dart';

import '../../shared/constants.dart';
import '../not_managed/notifications.dart';
import '../not_managed/settings.dart';
import '../services/SQFLiteHelper.dart';
import 'accepted_forms.dart';
import 'drafts.dart';
import 'form_page.dart';
import 'pending_forms.dart';
import 'rejected_forms.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  //TODO: The list item counter is not refreshing when it changed.
  var currentPage = DrawerSections.hastaEtkilesim;
  Text? title;
  final SQFLiteHelper _helper = SQFLiteHelper.instance;
  @override
  void initState() {
    super.initState();
    getCounter();
  }

  //int counter = 0;
  getCounter() async {
    return await _helper.getForms().then((value) => value.length);
  }

  @override
  Widget build(BuildContext context) {
    dynamic container;
    if (currentPage == DrawerSections.hastaEtkilesim) {
      title = const Text("Hasta Etkileşim Formu");
      container = const FormPage();
    } else if (currentPage == DrawerSections.taslaklar) {
      title = const Text("Taslaklar");
      container = Drafts();
    } else if (currentPage == DrawerSections.tibbiUygulama) {
      title = const Text("Tıbbi Uygulama Kaydı");
      container = TibbiUygulama();
    } else if (currentPage == DrawerSections.gonderilenFormlar) {
      title = const Text("Onay Bekleyen Fromlar");
      container = const PendingForms();
    } else if (currentPage == DrawerSections.onaylananFormlar) {
      title = const Text("Onaylanan Formlar");
      container = const AcceptedForms();
    } else if (currentPage == DrawerSections.reddedilenFormlar) {
      title = const Text("Reddedilen Formlar");
      container = const RejectedForms();
    } else if (currentPage == DrawerSections.settings) {
      title = const Text("Ayarlar");
      container = const Settings();
    } else if (currentPage == DrawerSections.notifications) {
      title = const Text("Bildirimler");
      container = const Notifications();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: title,
      ),
      body: container,
      drawer: Drawer(
        child: ListView(
          children: [myDrawerList(getCounter())],
        ),
      ),
    );
  }

  Widget myDrawerList(Future<dynamic> res) {
    int counter = 0;

    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(
              0, "Internship Application", FontAwesomeIcons.bookMedical, false),
          const Divider(),
          menuItem(1, "Hasta Etkileşim Kaydı", FontAwesomeIcons.map,
              currentPage == DrawerSections.hastaEtkilesim ? true : false),
          menuItem(2, "Tıbbi Uygulama Kaydı", FontAwesomeIcons.map,
              currentPage == DrawerSections.tibbiUygulama ? true : false),
          const Divider(),
          menuItem(3, "Onay Bekleyen Formlar", FontAwesomeIcons.ellipsisH,
              currentPage == DrawerSections.gonderilenFormlar ? true : false),
          menuItem(4, "Onaylanan Formlar", FontAwesomeIcons.heart,
              currentPage == DrawerSections.onaylananFormlar ? true : false),
          menuItem(
              5,
              "Reddedilen Formlar",
              FontAwesomeIcons.exclamationTriangle,
              currentPage == DrawerSections.reddedilenFormlar ? true : false),
          menuItem(6, "Taslaklar(0})", FontAwesomeIcons.database,
              currentPage == DrawerSections.taslaklar ? true : false),
          const Divider(),
          menuItem(7, "Ayarlar", FontAwesomeIcons.wrench,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(8, "Bildirimler", FontAwesomeIcons.bell,
              currentPage == DrawerSections.notifications ? true : false),
          const Divider(),
          menuItem(9, "Gizlilik Politikası", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(10, "Geri Bildirim", FontAwesomeIcons.comment,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? const Color(0xff5f5f5) : const Color(0xf000000),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.hastaEtkilesim;
            } else if (id == 2) {
              currentPage = DrawerSections.tibbiUygulama;
            } else if (id == 3) {
              currentPage = DrawerSections.gonderilenFormlar;
            } else if (id == 4) {
              currentPage = DrawerSections.onaylananFormlar;
            } else if (id == 5) {
              currentPage = DrawerSections.reddedilenFormlar;
            } else if (id == 6) {
              currentPage = DrawerSections.taslaklar;
            } else if (id == 7) {
              currentPage = DrawerSections.settings;
            } else if (id == 8) {
              currentPage = DrawerSections.notifications;
            } else if (id == 9) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 10) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(icon, size: 20, color: ICON_COLOR),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TEXT_STYLE,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  hastaEtkilesim,
  tibbiUygulama,
  gonderilenFormlar,
  onaylananFormlar,
  reddedilenFormlar,
  taslaklar,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}
