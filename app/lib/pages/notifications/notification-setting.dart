import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gemini/pages/widget/header.dart';

class NotificationSetting extends StatefulWidget {
  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool healthnotification = false;
  bool learningnotification = false;
  bool bodypracticenotification = false;
  bool mindpracticenotification = false;
  bool communitynotification = false;
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF3F9FD),
      appBar: header(
          logedin = false,
          back = true,
          logo = true,
          skip = false,
          backlink = true,
          '/home',
          skiplink = false,
          '',
          headingtext = '', isMsgActive =false,         isNotificationActive=false,
          context),
      body: Container(
        height: height,
        width: width,
        padding: new EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 17),
                  child: Text(
                      "Turn on notifications to get the most out of GEMINI",
                      style: AppCss.blue20semibold,
                      textAlign: TextAlign.center)),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
                  child: Text(
                      "You will be able to change these preferences later in your account settings.",
                      style: AppCss.grey12regular,
                      textAlign: TextAlign.center)),
                       
              Container(
                width: 335,
                height: 65,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.LIGHT_GREY)),
                ),
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 16),
                child: Row(
                  children: <Widget>[
                  Container(                    
                    width: 241,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Health Check-in Notifications",
                            style: AppCss.blue16semibold,
                            textAlign: TextAlign.left,
                          ),
                          Text("Lorem ipsum dolor sit amet",
                              style: AppCss.grey12regular,
                              textAlign: TextAlign.left),
                        ]),
                  ), 
                  Container(
                    width: 94,
                    padding: new EdgeInsets.only(left: 25),
                    child: Column(children: <Widget>[
                      FlutterSwitch(
                        width: 56.0,
                        height: 33.0,
                        valueFontSize: 10.0,
                        toggleSize: 23.0,
                        value: healthnotification,
                        borderRadius: 30.0,
                        activeTextFontWeight: w700,
                        inactiveTextFontWeight: w700,
                        activeColor: AppColors.DEEP_BLUE,
                        inactiveColor: AppColors.DEEP_BLUE,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            healthnotification = val;
                          });
                        },
                      )
                    ]),
                  ),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.LIGHT_GREY)),
                ),
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 16),
                width: 335,
                height: 65,
                child: Row(children: <Widget>[
                  Container(
                    width: 241,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Learning Notifications",
                              style: AppCss.blue16semibold,
                              textAlign: TextAlign.left),
                          Text("Lorem ipsum dolor sit amet",
                              style: AppCss.grey12regular,
                              textAlign: TextAlign.left),
                        ]),
                  ),
                  Container(
                    width: 94,
                    padding: new EdgeInsets.only(left: 25),
                    child: Column(children: <Widget>[
                      FlutterSwitch(
                        width: 56.0,
                        height: 33.0,
                        valueFontSize: 10.0,
                        toggleSize: 23.0,
                        value: learningnotification,
                        borderRadius: 30.0,
                        activeTextFontWeight: w700,
                        inactiveTextFontWeight: w700,
                        activeColor: AppColors.DEEP_BLUE,
                        inactiveColor: AppColors.DEEP_BLUE,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            learningnotification = val;
                          });
                        },
                      )
                    ]),
                  ),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.LIGHT_GREY)),
                ),
                 margin: const EdgeInsets.fromLTRB(0, 5, 0, 16),
                width: 335,
                height: 65,
                child: Row(children: <Widget>[
                  Container(
                    width: 241,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Body Practice Notifications",
                              style: AppCss.blue16semibold,
                              textAlign: TextAlign.left),
                          Text("Lorem ipsum dolor sit amet",
                              style: AppCss.grey12regular,
                              textAlign: TextAlign.left),
                        ]),
                  ),
                  Container(
                    width: 94,
                    padding: new EdgeInsets.only(left: 25),
                    child: Column(children: <Widget>[
                      FlutterSwitch(
                        width: 56.0,
                        height: 33.0,
                        valueFontSize: 10.0,
                        toggleSize: 23.0,
                        value: bodypracticenotification,
                        borderRadius: 30.0,
                        activeTextFontWeight: w700,
                        inactiveTextFontWeight: w700,
                        activeColor: AppColors.DEEP_BLUE,
                        inactiveColor: AppColors.DEEP_BLUE,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            bodypracticenotification = val;
                          });
                        },
                      )
                    ]),
                  ),
                ]),
              ),
              Container(
                 decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.LIGHT_GREY)),
                ),
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 16),
                width: 335,
                height: 65,
                child: Row(children: <Widget>[
                  Container(
                    width: 241,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Mind Practice Notifications",
                              style: AppCss.blue16semibold,
                              textAlign: TextAlign.left),
                          Text("Lorem ipsum dolor sit amet",
                              style: AppCss.grey12regular,
                              textAlign: TextAlign.left),
                        ]),
                  ),
                  Container(
                    width: 94,
                    padding: new EdgeInsets.only(left: 25),
                    child: Column(children: <Widget>[
                      FlutterSwitch(
                        width: 56.0,
                        height: 33.0,
                        valueFontSize: 10.0,
                        toggleSize: 23.0,
                        value: mindpracticenotification,
                        borderRadius: 30.0,
                        activeTextFontWeight: w700,
                        inactiveTextFontWeight: w700,
                        activeColor: AppColors.DEEP_BLUE,
                        inactiveColor: AppColors.DEEP_BLUE,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            mindpracticenotification = val;
                          });
                        },
                      )
                    ]),
                  ),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.LIGHT_GREY)),
                ),
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 16),
                width: 335,
                height: 65,
                child: Row(children: <Widget>[
                  Container(
                    width: 241,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Community Notifications",
                              style: AppCss.blue16semibold,
                              textAlign: TextAlign.left),
                          Text("Lorem ipsum dolor sit amet",
                              style: AppCss.grey12regular,
                              textAlign: TextAlign.left),
                        ]),
                  ),
                  Container(
                    width: 94,
                    padding: new EdgeInsets.only(left: 25),
                    child: Column(children: <Widget>[
                      FlutterSwitch(
                        width: 56.0,
                        height: 33.0,
                        valueFontSize: 10.0,
                        toggleSize: 23.0,
                        value: communitynotification,
                        borderRadius: 30.0,
                        activeTextFontWeight: w700,
                        inactiveTextFontWeight: w700,
                        activeColor: AppColors.DEEP_BLUE,
                        inactiveColor: AppColors.DEEP_BLUE,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            communitynotification = val;
                          });
                        },
                      )
                    ]),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 37),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/home");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(22),
                      ),
                      primary: AppColors.LIGHT_ORANGE),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 12, left: 88, right: 87),
                    child: Text("SAVE",
                        style: AppCss.blue14bold, textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
