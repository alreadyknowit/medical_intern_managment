import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:internship_managing_system/student/not%20managed/accepted_forms.dart';
import 'package:internship_managing_system/student/screens/drafts.dart';
import 'package:internship_managing_system/student/not%20managed/notifications.dart';
import 'package:internship_managing_system/student/not%20managed/rejected_forms.dart';
import 'package:internship_managing_system/student/screens/sent_forms.dart';
import 'package:internship_managing_system/student/not%20managed/settings.dart';

import 'form_page.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  var currentPage = DrawerSections.hastaEtkilesim;
  Text? title;


  @override
  Widget build(BuildContext context) {
    dynamic container;
    if (currentPage == DrawerSections.hastaEtkilesim) {
      title = const Text("Hasta Etkileşim Formu");
      container = const FormPage();
    } else if (currentPage == DrawerSections.taslaklar) {
      title = const Text("Taslaklar");
      container = Drafts();
    } else if (currentPage == DrawerSections.gonderilenFormlar) {
      title = const Text("Gönderilen Fromlar");
      container = const SentForms();
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

    int counter = 5;
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: title,
      ),
      body: container,
      drawer: Drawer(

        child: ListView(
          children: [myDrawerList(counter)],
        ),
      ),
    );
  }

  Widget myDrawerList(int counter) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(0, "Internship Application", FontAwesomeIcons.bookMedical, false),
          const Divider(),
          menuItem(1, "Hasta Etkileşim Kaydı", FontAwesomeIcons.map,
              currentPage == DrawerSections.hastaEtkilesim ? true : false),
          const Divider(),
          menuItem(2, "Onay Bekleyen Formlar", FontAwesomeIcons.ellipsisH,
              currentPage == DrawerSections.gonderilenFormlar ? true : false),
          menuItem(3, "Onaylanan Formlar", FontAwesomeIcons.heart,
              currentPage == DrawerSections.onaylananFormlar ? true : false),
          menuItem(4, "Reddedilen Formlar", FontAwesomeIcons.exclamationTriangle,
              currentPage == DrawerSections.reddedilenFormlar ? true : false),
          menuItem(5, "Taslaklar($counter)",  FontAwesomeIcons.database,
              currentPage == DrawerSections.taslaklar ? true : false),
          const Divider(),
          menuItem(6, "Ayarlar", FontAwesomeIcons.wrench,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(7, "Bildirimler", FontAwesomeIcons.bell,
              currentPage == DrawerSections.notifications ? true : false),
          const Divider(),
          menuItem(8, "Gizlilik Politikası", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(9, "Geri Bildirim", FontAwesomeIcons.comment,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ?const Color(0xff5f5f5) :const Color(0xf000000),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.hastaEtkilesim;
            } else if (id == 2) {
              currentPage = DrawerSections.gonderilenFormlar;
            } else if (id == 3) {
              currentPage = DrawerSections.onaylananFormlar;
            } else if (id == 4) {
              currentPage = DrawerSections.reddedilenFormlar;
            } else if (id == 5) {
              currentPage = DrawerSections.taslaklar;
            } else if (id == 6) {
              currentPage = DrawerSections.settings;
            } else if (id == 7) {
              currentPage = DrawerSections.notifications;
            } else if (id == 8) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 9) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: ICON_COLOR
                ),
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
  gonderilenFormlar,
  onaylananFormlar,
  reddedilenFormlar,
  taslaklar,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}
