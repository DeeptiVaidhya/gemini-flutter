import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:localstorage/localstorage.dart';

class ThanksHealthCheckIn extends StatefulWidget {
  @override
  _ThanksHealthCheckInState createState() => _ThanksHealthCheckInState();
}

class _ThanksHealthCheckInState extends State<ThanksHealthCheckIn> {
  final LocalStorage loginC = new LocalStorage('gemini_login');	
  
  @override
  Widget build(BuildContext context) {
     return Stack(children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: header(
          logedin = false,
          back = true,
          logo = false,
          skip = false,
          backlink = true,
          '/weight-health-check-in',
          skiplink = true,
          '',
          headingtext = '', 
          isMsgActive =false,  
          isNotificationActive=false,
          context
        ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 375),
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Container(
                    width: 125,
                    height: 125,
                    decoration: new BoxDecoration(
                      color: Color(0xFFCEECFF),
                      borderRadius: new BorderRadius.circular(100),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 16, left: 30, right: 30),
                      child: Text(
                        'Thanks for completing your first check in!',
                        style: AppCss.blue26semibold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  Padding(
                  padding: const EdgeInsets.only(top: 141),
                  child: buttion(
                      btnwidth = 295,
                      btnheight = 44,
                      btntext = 'BACK TO DASHBOARD',
                      AppCss.blue14bold,
                      AppColors.LIGHT_ORANGE,
                      btntypesubmit = true,
                      () {
                        loginC.clear();
                        Navigator.of(context).pushReplacementNamed("/home");
                      },
                      12,
                      12,
                      30,
                      29,
                      context)
                  ),
                ]),
          ),
        ),
      ),
    )

     ]
     );
  }
}
