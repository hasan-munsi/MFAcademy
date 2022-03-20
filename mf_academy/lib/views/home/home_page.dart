import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/enums.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/user.dart';
import 'package:mf_academy/views/attendance/attendance_list.dart';
import 'package:mf_academy/views/auth/login.dart';
import 'package:mf_academy/views/global_views/webview.dart';
import 'package:mf_academy/views/notice/notice_list.dart';
import 'package:mf_academy/views/notifications/notifications_list.dart';
import 'package:mf_academy/views/program/program_list.dart';
import 'package:mf_academy/views/result/result_list.dart';
import 'package:mf_academy/views/utils/social_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  static const String id = "/HomePage";

  HomePage({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final User? _user = Xarvis.loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset("assets/images/logo.png", width: 50),
            Xarvis.customWidth(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Xarvis.genericText(
                    text: "MARINE FISHERIES", textColor: Xarvis.appBgColor,
                height: 1),
                Xarvis.genericText(
                  text: "ACADEMY",
                  textColor: Xarvis.appBgColorLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1,
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<DrawerOptions>(
            onSelected: (DrawerOptions result) {
              switch (result) {
                case DrawerOptions.login:
                  Get.toNamed(Login.id);
                  break;
                case DrawerOptions.programList:
                  Get.toNamed(ProgramList.id);
                  break;
                case DrawerOptions.notificationList:
                  Get.toNamed(NotificationsList.id);
                  break;
                case DrawerOptions.resultList:
                  Get.toNamed(ResultList.id);
                  break;
                case DrawerOptions.noticeList:
                  Get.toNamed(NoticeList.id);
                  break;
                case DrawerOptions.attendanceList:
                  Get.toNamed(AttendanceList.id);
                  break;
                case DrawerOptions.logout:
                  Xarvis.logoutKicker();
                  break;
                default:
                  break;
              }
            },
            icon: const Icon(
              Icons.menu,
              color: Xarvis.appBgColor,
            ),
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<DrawerOptions>>[
              PopupMenuItem<DrawerOptions>(
                value: DrawerOptions.homepage,
                child: Xarvis.genericText(
                    text: "Home Page", textColor: Xarvis.appBgColor),
              ),
              PopupMenuItem<DrawerOptions>(
                value: DrawerOptions.programList,
                child: Xarvis.genericText(
                    text: "Program", textColor: Xarvis.appBgColor),
              ),
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.resultList,
                  child: Xarvis.genericText(
                      text: "Result", textColor: Xarvis.appBgColor),
                ),
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.noticeList,
                  child: Xarvis.genericText(
                      text: "Notice", textColor: Xarvis.appBgColor),
                ),
                  if (_user?.role == 1 || _user?.role == 3)
                    PopupMenuItem<DrawerOptions>(
                      value: DrawerOptions.notificationList,
                      child: Xarvis.genericText(
                          text: "Notification", textColor: Xarvis.appBgColor),
                    ),
              if (_user?.role == 2)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.attendanceList,
                  child: Xarvis.genericText(
                      text: "Attendance", textColor: Xarvis.appBgColor),
                ),
              if (_user == null)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.login,
                  child: Xarvis.genericText(
                      text: "Login", textColor: Xarvis.appBgColor),
                ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  value: DrawerOptions.logout,
                  child: Xarvis.genericText(
                      text: "Logout", textColor: Xarvis.appBgColor),
                ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Xarvis.customHeight(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Xarvis.genericText(
                          text: "Welcome to",
                          textColor: Xarvis.dark,
                          height: 1,
                          fontSize: 24,
                        ),
                        Xarvis.customWidth(10),
                        Xarvis.genericText(
                          text: "MFA",
                          textColor: Xarvis.appBgColorLight,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          height: 1,
                        ),
                      ],
                    ),
                    Xarvis.customHeight(20),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("assets/images/banner.jpeg", width: double.infinity, height: 200, fit: BoxFit.cover,),
                    ),
                    Xarvis.customHeight(10),
                    Xarvis.customHeight(20),

                    Xarvis.genericText(
                      text: Xarvis.homeText,
                      maxLines: 5,
                    ),
                    Xarvis.customHeight(10),
                    Xarvis.customHeight(20),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Xarvis.getGlobalButton(
                          action: () async {
                            Get.dialog(
                              Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.9,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Xarvis.fair,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            physics: const BouncingScrollPhysics(),
                                            child: Xarvis.genericText(
                                                text: Xarvis.homeText,
                                                maxLines: 10000,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(onPressed: (){
                                            Get.back();
                                          }, child: Xarvis.genericText(text: "Okay", textColor: Xarvis.appBgColorLight)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          height: 35,
                          borderRadius: 50,
                          child: Xarvis.genericText(
                              text: "Read more",
                              textColor: Xarvis.fair,
                              fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 120,
              child: SocialButtons(),
            )
          ],
        ),
      ),
    );
  }
}
