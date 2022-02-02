import 'package:flutter/material.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gemini/services/auth.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:html';

late int btnwidth;
late int btnheight;
late String btntextstyle;
late String btntext;
late String btnbgcolor;
late bool btntypesubmit;
late String onpressfunction;
late int paddingtop;
late int paddingbottom;
late int paddingleft;
late int paddingright;

//button
buttion(
    btnwidth,
    btnheight,
    btntext,
    btntextstyle,
    btnbgcolor,
    simplebtn,
    onpressfunction,
    paddingtop,
    paddingbottom,
    paddingleft,
    paddingright,
    context) {
  return InkWell(
    hoverColor: btnbgcolor,
    borderRadius: BorderRadius.circular(100),
    onTap: onpressfunction,
    child: Container(
      width: btnwidth,
      height: btnheight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: btnbgcolor,
      ),
      child: btntypesubmit
          ? Container(
              margin: EdgeInsets.only(top: paddingtop, bottom: paddingbottom),
              alignment: Alignment.center,
              child: Text(btntext,
                  style: btntextstyle, textAlign: TextAlign.center),
            )
          : Row(children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    paddingleft, paddingtop, paddingright, paddingbottom),
                child: Text(btntext, style: btntextstyle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17, bottom: 16, right: 20),
                child: CircleAvatar(
                  child: Icon(Icons.done, color: btnbgcolor, size: 20),
                  backgroundColor: AppColors.PRIMARY_COLOR,
                ),
              )
            ]),
    ),
  );
}

// Show Loader
// final GlobalKey<State> _keyLoader = new GlobalKey<State>();
// loader(context, _keyLoader);

// Hide Loader
// Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

Future<void> loader(BuildContext context, GlobalKey key) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: AppColors.PRIMARY_COLOR,
                children: <Widget>[
                  Center(
                    child: Column(children: [
                      CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              AppColors.DEEP_GREY.withOpacity(0.7)),
                          strokeWidth: 2.0),
                      SizedBox(

                        height: 10,
                      ),
                      Text(
                        "Please Wait....",
                        style: AppCss.mediumgrey14light,
                      )
                    ]),
                  )
                ]));
      });
}

// Show toast message
toast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      webBgColor: "linear-gradient(to right, #357B40, #357B40)",
      textColor: Colors.white);
}

errortoast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      webBgColor: "linear-gradient(to right, #CC0000, #CC0000)",
      textColor: Colors.white);
}

// Show Modal Popup
Future<void> modalPopup(BuildContext context, Color barriercolor,
    Widget popupcontent, double popupwidth, double popupheight, int i, var type,
    [clearFilter]) async {
  return showDialog<void>(
      barrierColor: barriercolor,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          contentPadding: const EdgeInsets.all(10),
          content: SingleChildScrollView(
            child: Container(
              width: popupwidth,
              height: popupheight,
              child: Column(
                children: <Widget>[
                  (type == "library")
                      ? ListView(
                          scrollDirection: Axis.vertical,
                          physics: PageScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 50),
                                  child: InkWell(
                                      child: Text(
                                        'Clear filters',
                                        style: AppCss.green12semibold,
                                      ),
                                      onTap: () {
                                        clearFilter('');
                                      }),
                                ),
                                title: Text(
                                  'Filters',
                                  style: AppCss.blue16semibold,
                                ),
                                trailing: IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: Icon(GeminiIcon.close,
                                      size: 10, color: AppColors.DEEP_BLUE),
                                ),
                              ),
                            ])
                      : Align(
                          alignment: Alignment(1.05, -0.35),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.close,
                              color: AppColors.DEEP_BLUE,
                            ),
                          ),
                        ),
                  popupcontent
                ],
              ),
            ),
          ),
        );
      });
}

checkLoginToken(context) async {
  final data = await checkLogin(<String, dynamic>{});
  final LocalStorage storage = new LocalStorage('gemini');
  if (data['status'] == "error") {
    storage.clear();
    Navigator.pushNamed(context, '/signin');
    errortoast(data['msg']);
  }
}

isVarEmpty(val, {title}) {
  if (val == null || val == "undefind" || val == "") {
    return "";
  }
  return val;
}

isEmptyArray(val) {
  if (val != 'undefined' || val.length == 0 || val == null) {
    return "";
  }
  return val;
}

isImageCheck(val) {
  if (val == null || val == "") {
    return "https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png";
  }
  return val;
}

getUrl() {
  var uri = Uri.dataFromString(window.location.href);
  var params = uri.pathSegments[5];
  print(uri.pathSegments[5]);
  return params;
}

dateTimeFormate(datetime, {dateFormat = ''}) {
  // tz.initializeTimeZones();
  // final DateTime now = DateTime.now();
  // final timeZone = tz.getLocation('America/Chicago');
  // America/Chicago
  // DateTime d5 = tz.TZDateTime.from(now, timeZone);
  // DateTime d4 = tz.TZDateTime.from(d2, timeZone);
  // DateTime d2 = DateTime.parse(datetime);

  DateTime d1 = DateTime.now();
  DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime, true);
  DateTime d2 = dateTime.toLocal();

  var minutes = int.parse((d1.difference(d2)).inMinutes.toString());
  var hours = int.parse((d1.difference(d2)).inHours.toString());
  var days = int.parse((d1.difference(d2)).inDays.toString());

  if (dateFormat.isNotEmpty) {
    return DateFormat(dateFormat).format(d2);
  }

  if (minutes == 0) {
    return "Posted Just Now";
  } else if (minutes < 60) {
    return (d1.difference(d2)).inMinutes.toString() + " min ago";
  } else if (hours < 24) {
    datetime = (d1.difference(d2)).inHours.toString();
    return (d1.difference(d2)).inHours.toString() + " hours ago";
  } else if (days < 7) {
    return DateFormat('EEEE').format(d2) +
        ' @ ' +
        DateFormat('h:mm a').format(d2);
  } else {
    return DateFormat('MMM  d, yyyy').format(d2);
  }
}