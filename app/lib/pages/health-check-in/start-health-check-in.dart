import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';

class StartHealthCheckIn extends StatefulWidget {
  @override
  _StartHealthCheckInState createState() => _StartHealthCheckInState();
}

class _StartHealthCheckInState extends State<StartHealthCheckIn> {

   @override
  void initState() {
    checkLoginToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
       backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 375),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 148),
                        child: Image.asset("assets/images/health-list.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 30),
                        child: Text('Now let’s start your health check-in',
                            style: AppCss.blue26semibold,
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Text(
                            'You will be asked a few questions about your health and well-being. It will only take about 5 minutes.',
                            style: AppCss.grey14regular,
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                      padding: const EdgeInsets.only(top: 105, bottom: 78, left: 20, right: 20),
                      child: buttion(
                        btnwidth = 295,
                        btnheight = 44,
                        btntext = 'START CHECK-IN',
                        AppCss.blue14bold,
                        AppColors.LIGHT_ORANGE,
                        btntypesubmit = true, () {
                        Navigator.pushNamed(context, '/mental-checkin');
                        },13,13,73,72, context),
                    ),
                  ]),
              ),
            ),
          ),
        ),
      ),
      ]
    );
  }
}
