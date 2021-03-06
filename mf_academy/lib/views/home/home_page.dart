import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/user.dart';
import 'package:mf_academy/views/attendance/attendance_list.dart';
import 'package:mf_academy/views/auth/login.dart';
import 'package:mf_academy/views/cadet/cadet_list.dart';
import 'package:mf_academy/views/cadet_doc/cadet_doc_list.dart';
import 'package:mf_academy/views/notice/notice_list.dart';
import 'package:mf_academy/views/notifications/notifications_list.dart';
import 'package:mf_academy/views/program/program_list.dart';
import 'package:mf_academy/views/result/result_list.dart';
import 'package:mf_academy/views/utils/pdf_viewer.dart';
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
                    text: "MARINE FISHERIES",
                    textColor: Xarvis.appBgColor,
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
          /*PopupMenuButton<DrawerOptions>(
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
                case DrawerOptions.officerAdminList:
                  Get.to(() => const GlobalPdfViewer(
                      url: "${Xarvis.kURL}/storage/employee/employee.pdf"));
                  break;
                case DrawerOptions.cadetList:
                  Get.to(() => const CadetList(type: 1));
                  break;
                case DrawerOptions.cadetActivities:
                  Get.to(() => const CadetList(
                        type: 2,
                        title: "Recent Cadet Activities",
                      ));
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: DrawerOptions.homepage,
                child: PopUpMenuItemChildDesign(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Xarvis.genericText(
                          text: Xarvis.loggedInUser?.name ?? "No name",
                          textColor: Xarvis.appBgColor,
                          fontWeight: FontWeight.bold),
                      Xarvis.genericText(
                          text: Xarvis.loggedInUser?.phoneNo ?? "No phone",
                          textColor: Xarvis.appBgColor,
                          fontSize: 14),
                    ],
                  ),
                ),
              ),
              PopupMenuItem<DrawerOptions>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: DrawerOptions.homepage,
                child: PopUpMenuItemChildDesign(
                  child: Xarvis.genericText(
                      text: "Home Page", textColor: Xarvis.appBgColor),
                ),
              ),
              PopupMenuItem<DrawerOptions>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: DrawerOptions.noticeList,
                child: PopUpMenuItemChildDesign(
                  child: Xarvis.genericText(
                      text: "General Notice", textColor: Xarvis.appBgColor),
                ),
              ),
              PopupMenuItem<DrawerOptions>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: DrawerOptions.programList,
                child: PopUpMenuItemChildDesign(
                  child: Xarvis.genericText(
                      text: "Program List", textColor: Xarvis.appBgColor),
                ),
              ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: DrawerOptions.cadetList,
                  child: PopUpMenuItemChildDesign(
                    child: Xarvis.genericText(
                        text: "Cadet List", textColor: Xarvis.appBgColor),
                  ),
                ),
              PopupMenuItem<DrawerOptions>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: DrawerOptions.officerAdminList,
                child: PopUpMenuItemChildDesign(
                  child: Xarvis.genericText(
                      text: "Officers and Admin List", textColor: Xarvis.appBgColor),
                ),
              ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: DrawerOptions.cadetActivities,
                  child: PopUpMenuItemChildDesign(
                    child: Xarvis.genericText(
                        text: "Recent Cadet Activities", textColor: Xarvis.appBgColor),
                  ),
                ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: DrawerOptions.resultList,
                  child: PopUpMenuItemChildDesign(
                    child: Xarvis.genericText(
                        text: "Cadet Results", textColor: Xarvis.appBgColor),
                  ),
                ),
              if (_user?.role == 1 || _user?.role == 3)
                PopupMenuItem<DrawerOptions>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: DrawerOptions.notificationList,
                  child: PopUpMenuItemChildDesign(
                    child: Xarvis.genericText(
                        text: "Message", textColor: Xarvis.appBgColor),
                  ),
                ),
              if (_user?.role == 2)
                PopupMenuItem<DrawerOptions>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: DrawerOptions.attendanceList,
                  child: PopUpMenuItemChildDesign(
                    child: Xarvis.genericText(
                        text: "Attendance", textColor: Xarvis.appBgColor),
                  ),
                ),
              if (_user == null)
                PopupMenuItem<DrawerOptions>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: DrawerOptions.login,
                  child: Xarvis.genericText(
                      text: "Login", textColor: Xarvis.appBgColor),
                ),
              if (_user != null)
                PopupMenuItem<DrawerOptions>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: DrawerOptions.logout,
                  child: Xarvis.genericText(
                      text: "Logout", textColor: Xarvis.appBgColor),
                ),
            ],
          ),*/
          IconButton(
            onPressed: () {
              Get.dialog(
                Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: Get.width*0.5,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Xarvis.fair,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Material(
                            color: Xarvis.fair,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_user != null)
                                  InkWell(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Xarvis.genericText(
                                          text: Xarvis.loggedInUser?.name ?? "No name",
                                          textColor: Xarvis.appBgColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Xarvis.genericText(
                                          text: Xarvis.loggedInUser?.phoneNo ?? "No phone",
                                          textColor: Xarvis.appBgColor,
                                          fontSize: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (_user != null)
                                  const Divider(color: Xarvis.appBgColor,),
                                PopUpMenuSingleItemUI(label: "Homepage", onTap: (){Get.back();}),
                                const Divider(color: Xarvis.appBgColor,),
                                PopUpMenuSingleItemUI(label: "General Notice", onTap: (){
                                  Get.toNamed(NoticeList.id);
                                },),
                                const Divider(color: Xarvis.appBgColor,),
                                PopUpMenuSingleItemUI(label: "Program List", onTap: (){
                                  Get.toNamed(ProgramList.id);
                                },),
                                const Divider(color: Xarvis.appBgColor,),
                                if (_user != null)
                                  PopUpMenuSingleItemUI(label: "Cadet List", onTap: (){
                                  Get.to(() => const CadetList(type: 1));
                                },),
                                if (_user != null)
                                  const Divider(color: Xarvis.appBgColor,),
                                PopUpMenuSingleItemUI(label: "Officers and Admin List", onTap: (){
                                  Get.to(() => const GlobalPdfViewer(
                                      url: "${Xarvis.kURL}/storage/employee/employee.pdf"));
                                },),
                                const Divider(color: Xarvis.appBgColor,),
                                if (_user != null)
                                  PopUpMenuSingleItemUI(label: "Recent Cadet Activities", onTap: (){
                                  Get.to(() => const CadetList(
                                    type: 2,
                                    title: "Recent Cadet Activities",
                                  ));
                                },),
                                if (_user != null)
                                  const Divider(color: Xarvis.appBgColor,),
                                if (_user != null)
                                  PopUpMenuSingleItemUI(label: "Cadet Results", onTap: (){
                                  Get.toNamed(ResultList.id);
                                },),
                                if (_user != null)
                                  const Divider(color: Xarvis.appBgColor,),
                                  PopUpMenuSingleItemUI(label: "Cadet Doc List", onTap: (){
                                    Get.toNamed(CadetDocList.id);
                                  },),
                                  const Divider(color: Xarvis.appBgColor,),
                                if (_user?.role == 1 || _user?.role == 3)
                                  PopUpMenuSingleItemUI(label: "Message", onTap: (){
                                  Get.toNamed(NotificationsList.id);
                                },),
                                if (_user?.role == 1 || _user?.role == 3)
                                  const Divider(color: Xarvis.appBgColor,),
                                if (_user?.role == 2 || _user?.role == 4)
                                  PopUpMenuSingleItemUI(label: "Attendance", onTap: (){
                                  Get.toNamed(AttendanceList.id);
                                },),
                                if (_user?.role == 2)
                                  const Divider(color: Xarvis.appBgColor,),
                                if (_user?.role == 2 && GetPlatform.isAndroid)
                                  PopUpMenuSingleItemUI(
                                    label: "Safety GPS Pro",
                                    onTap: ()async{
                                      appOpener(Xarvis.kSafetyGPSProAppId);
                                    },
                                  ),
                                if (_user?.role == 2  && GetPlatform.isAndroid)
                                  const Divider(color: Xarvis.appBgColor,),
                                // PopUpMenuSingleItemUI(label: "BMFA Warriors", onTap: ()async{
                                //   appOpener(Xarvis.kBMFAWarriorsAppId);
                                // },),
                                //   const Divider(color: Xarvis.appBgColor,),
                                if (_user == null)
                                  PopUpMenuSingleItemUI(label: "Login", onTap: (){
                                  Get.toNamed(Login.id);
                                },),
                                if (_user != null)
                                  PopUpMenuSingleItemUI(label: "Logout", onTap: (){
                                  Xarvis.logoutKicker();
                                },),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                barrierColor: Colors.transparent,
              );
            },
            icon: const Icon(Icons.menu, color: Xarvis.appBgColor,),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/banner.jpeg",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Xarvis.customHeight(20),

                  ///History
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Xarvis.dark),
                              ),
                            ),
                            child: Xarvis.genericText(
                              text: "History:",
                              textColor: Xarvis.dark,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Xarvis.genericText(
                            text: Xarvis.homeText,
                            maxLines: 3,
                            overflow: TextOverflow.clip,
                            height: 1,
                            fontSize: 14),
                        Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async {
                                Get.dialog(
                                  Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: Center(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 20, right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Xarvis.fair,
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                child: Xarvis.genericText(
                                                  text: Xarvis.homeText,
                                                  maxLines: 10000,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Xarvis.genericText(
                                                      text: "Okay",
                                                      textColor: Xarvis
                                                          .appBgColorLight)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: Xarvis.appBgColor),
                                  ),
                                ),
                                child: Xarvis.genericText(
                                  text: "Read more...",
                                  textColor: Xarvis.appBgColor,
                                  fontSize: 14,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),

                  ///Vision
                  Expanded(
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Xarvis.dark),
                                ),
                              ),
                              child: Xarvis.genericText(
                                text: "Vision:",
                                textColor: Xarvis.dark,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Xarvis.genericText(
                              text: Xarvis.visionText,
                              maxLines: 50,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Xarvis.customHeight(10),

                  ///Objectives
                  Expanded(
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Xarvis.dark),
                                ),
                              ),
                              child: Xarvis.genericText(
                                text: "Objectives:",
                                textColor: Xarvis.dark,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Xarvis.genericText(
                              text: Xarvis.objectivesText,
                              maxLines: 50,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Xarvis.customHeight(10),
                ],
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

  void appOpener(String appId)async{
    try {
      ///checks if the app is installed on your mobile device
      bool isInstalled = await DeviceApps.isAppInstalled(appId);
      if (isInstalled) {
        DeviceApps.openApp(appId);
      } else {
        ///if the app is not installed it lunches google play store so you can install it from there
        if(await canLaunch("market://details?id="+appId)){
          await launch("market://details?id="+appId);
        }
      }
    } catch (e) {
      Xarvis.logger.e(e);
    }
  }

}

class PopUpMenuSingleItemUI extends StatelessWidget {
  final String label;
  final Function() onTap;
  const PopUpMenuSingleItemUI({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: onTap,
        child: Xarvis.genericText(
            text: label, textColor: Xarvis.appBgColor),
      ),
    );
  }
}
