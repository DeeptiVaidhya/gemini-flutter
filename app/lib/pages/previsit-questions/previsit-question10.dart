import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';


class PrevisitQuestion10 extends StatefulWidget {
  @override
  _PrevisitQuestion10State createState() => _PrevisitQuestion10State();
}


class _PrevisitQuestion10State extends State<PrevisitQuestion10> {

   _home() {
    Navigator.of(context).pushNamed("/home");
  }

  int _n = 0;
  void add() {
  setState(() {
    _n++;
  });
}

  void minus() {
  setState(() {
    if (_n != 0) 
      _n--;
  });
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

        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: header(
            logedin = false,
            back = true,
            logo = false,
            skip = false,
            backlink = true,
            '/',
            skiplink = false,
            '',
            headingtext = 'Question 10 of 20', isMsgActive =false,         isNotificationActive=false,
            context
            ),
          body: new Container(
            child: new Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:55,bottom: 13,left: 20,right: 20),                    
                    child: Text('How many cigarettes do you smoke a day?',
                    textAlign:TextAlign.center,
                    style: AppCss.blue26semibold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 108,left: 34,right: 34),
                    child: Center(
                        child: Text('Please select one of the choices below.',
                        textAlign:TextAlign.center,
                        style: AppCss.grey10light
                        ),
                    ),
                  ),
                  new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right:30.0),
                      child: new FloatingActionButton(
                        mini: true,
                        onPressed: minus,
                        child: new Icon(Icons.remove, color: Colors.black),
                        backgroundColor: Colors.white,),
                    ),

                    new Text('$_n',style: AppCss.grey78bold),

                    Padding(
                      padding: const EdgeInsets.only(left:30.0),
                      child: new FloatingActionButton(
                        mini: true,
                        onPressed: add,
                        child: new Icon(Icons.add, color: Colors.black,),
                        backgroundColor: AppColors.LIGHT_ORANGE,),
                    ),
                  ],
                ),
                new Padding(
                  padding: const EdgeInsets.only(top:102,bottom: 78,left: 50,right: 30),
                    child:buttion(
                  btnwidth = 295,
                  btnheight = 44,
                  btntext = 'NEXT',
                  AppCss.blue14bold,
                  AppColors.LIGHT_ORANGE,
                  btntypesubmit = true,
                  () {
                    _home();
                  },13,13,73,72, 
                  context) ,
                ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
