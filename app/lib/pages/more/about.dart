import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
            logedin = true,
            back = true,
            logo = false,
            skip = false,
            backlink = true,
            '/more',
            skiplink = false,
            '',
            headingtext = 'About', isMsgActive =false,         isNotificationActive=false,
            context),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 375),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                      child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("About GEMINI", style: AppCss.blue26semibold)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 17, 20, 0),
                      padding: const EdgeInsets.fromLTRB(20, 17, 20, 5),
                      width: 335,
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: AppColors.MEDIUM_GREY2,
                        borderRadius: new BorderRadius.circular(12.0),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 17, 20, 35),
                      child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat pharetra nunc, ac vestibulum purus fringilla sit amet. Proin ullamcorper tempus ligula quis feugiat. Phasellus ultrices lorem turpis, a aliquam ligula blandit gravida. Phasellus at ex nec tellus dictum pellentesque. Cras et purus ac ligula finibus egestas ac in Leo. Mauris luctus ullamcorper eros, eget placerat turpis tincidunt ut. Ut faucibus sapien ac quam sodales, ut venenatis nisi facilisis. \n\nAenean ac tincidunt ex. Sed scelerisque consequat lacinia. Quisque finibus urna nisi, non blandit felis euismod at. In pellentesque arcu non sapien semper, in vehicula diam hendrerit. Maecenas cursus leo a mollis dictum. Nulla condimentum dui vitae risus sollicitudin ullamcorper. Quisque efficitur nisl vitae erat tincidunt fermentum. Aliquam at massa a dolor varius euismod eu id tellus. Nulla vitae risus ac lorem lacinia iaculis eu nec tellus. Fusce ac diam et ex porta aliquet. Suspendisse pulvinar convallis fermentum. Ut ac euismod ligula. Sed ornare cursus leo a egestas. Vestibulum velit nulla, hendrerit vel egestas condimentum, volutpat non ante. Duis porttitor libero eget enim faucibus, non vulputate massa mattis. Duis odio velit, congue vel elit eget, pharetra commodo dui.",
                          style: AppCss.grey12regular),
                    ),
                  ]),
            ),
          ),
        ),
       floatingActionButton: floatingactionbuttion(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: footer(
              ishomepageactive = false,
              isclassespageactive = false,
              islibyrarypageactive = false,
              ismorepageactive = true,
              context)),
    ]);
  }
}

