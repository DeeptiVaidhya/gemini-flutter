import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';

class PrevisitIntroduction extends StatefulWidget {
  PrevisitIntroduction({Key? key}) : super(key: key);

  @override
  _PrevisitIntroductionState createState() => _PrevisitIntroductionState();
}

class _PrevisitIntroductionState extends State<PrevisitIntroduction> {
  _previsitQuestionList() {
    Navigator.of(context).pushNamed("/classes");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Image.asset("images/bg.png",
        height: height,
        width: width,
        fit: BoxFit.cover,
        ),

        Scaffold(
           appBar: header(
                logedin = false,
                back = true,
                logo = false,
                skip = false,
                backlink = true,
                '/home',
                skiplink = false,
                '',
                headingtext = 'Pre-visit questionnaire', isMsgActive =false,         isNotificationActive=false,
                context),
                body: Container(
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:161,bottom: 24,left: 30,right: 30),
                        child: Text("Welcome to the pre-visit questionnaire for module xx",
                        textAlign:TextAlign.center,
                        style: AppCss.blue26semibold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 120,left: 30,right: 30),
                          child: Center(
                            child: Text("Need some text for a brief into to the questionnaire ….. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.",
                            textAlign:TextAlign.center,
                            style: AppCss.grey14regular
                            ),
                          ),
                      ),
                      Padding(
                      padding: const EdgeInsets.only(bottom: 78,left: 50,right: 30),
                      child:buttion(
                        btnwidth = 295,
                        btnheight = 44,
                        btntext = 'START'.toUpperCase(),
                        AppCss.blue14bold,
                        AppColors.LIGHT_ORANGE,
                        btntypesubmit = true, () {
                         _previsitQuestionList();
                        },13,13,73,72, context),
                      ),
                    ],
                  ),
                  ),
                ),
        )
      ],
    );
  }
}