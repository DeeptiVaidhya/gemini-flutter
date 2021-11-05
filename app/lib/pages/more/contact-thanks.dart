import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';

class ContactThanks extends StatefulWidget {
  @override
  ContactThanksState createState() => ContactThanksState();
}

class ContactThanksState extends State<ContactThanks> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: header(
        logedin = true,
        back = true,
        logo = false,
        skip = true,
        backlink = true,
        '/more',
        skiplink = false,
        '/',
        headingtext = 'Contact us', 
        isMsgActive =false,    
        isNotificationActive=false,
      context),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      width: 125,
                      height: 125,
                      decoration: new BoxDecoration(
                        color: Color(0xFFCEECFF),
                        borderRadius: new BorderRadius.circular(100),
                      ),
                    )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 16, left: 54, right: 54),
                    child: Text('Thank you for your message',
                      style: AppCss.blue26semibold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 27, left: 54, right: 54),
                  child: Text(
                    'Someone will get back to your query shortly,',
                    style: AppCss.grey10light,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 77, bottom: 20),
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
                          top: 12, bottom: 12, left: 40, right: 39),
                      child: Text("Go back to my homepage".toUpperCase(),
                          style: AppCss.blue14bold,
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
