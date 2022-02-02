import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/home/home.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';

class ReadingFinishLater extends StatefulWidget {
  final String title;
  const ReadingFinishLater({Key? key, this.title=""}): super(key: key);

  @override
  _ReadingFinishLaterState createState() => _ReadingFinishLaterState();
}

class _ReadingFinishLaterState extends State<ReadingFinishLater> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          child: FractionallySizedBox(
            heightFactor: 1.0,
            widthFactor: 1.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      Scaffold(
        appBar: header(
          logedin = true,
          back = true,
          logo = false,
          skip = false,
          backlink = true,
          '/home',
          skiplink = false,
          '/',
          headingtext = widget.title, isMsgActive =false,         isNotificationActive=false,
          context),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: width,
              height: height,
              constraints: BoxConstraints(
                maxWidth: 375,
              ),
              child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 70,bottom: 40),
                      child: Stack(
                        children: <Widget>[
                          Container(                                    
                            width: 125,
                            height: 125,
                            decoration: new BoxDecoration(
                              color: Color(0xFFCEECFF),
                              borderRadius: new BorderRadius.circular(100),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            left: 3,
                            right: 3,
                            child: SvgPicture.asset('assets/images/icons/learning/learning.svg',width: 120.95,height: 120.1,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 22, left: 30, right: 30),
                      child: Text(
                        'You’ve chosen to finish reading later.',
                        style: AppCss.blue26semibold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 27, left: 54, right: 54),
                      child: Text('Since you don’t have your learning notifications set up, do you want to us to send you a notification to remind you to finish reading your learning topics?',
                        style: AppCss.grey14regular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 39, bottom: 78, left: 50, right: 50),
                      child: buttion(
                        btnwidth = 295,
                        btnheight = 44,
                        btntext = 'Yes, set up notifications'.toUpperCase(),
                        AppCss.blue14bold,
                        AppColors.LIGHT_ORANGE,
                        btntypesubmit = true, () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: Home(),
                              ),
                            );
                        },12,12,33,52, context),
                    ),
                  ]),
            ),
          ),
        ),
      ),
      ]
    );
  }
}
