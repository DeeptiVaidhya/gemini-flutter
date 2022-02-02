import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';

class AboutTeam extends StatefulWidget {
  const AboutTeam({Key? key}) : super(key: key);
  @override
  _AboutTeamState createState() => _AboutTeamState();
}

class _AboutTeamState extends State<AboutTeam> {
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
          appBar: header(
            logedin = true,
            back = true,
            logo = false,
            skip = false,
            backlink = true,
            '/more',
            skiplink = false,
            '/health-check-in',
            headingtext = 'About', isMsgActive =false,         isNotificationActive=false,
            context),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 375,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,                
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0,17,0,0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child:Text("About the Team",style: AppCss.blue26semibold)
                        ),
                      ),
                      Column(
                      children: <Widget>[                   
                        Container(
                          margin: EdgeInsets.fromLTRB(0,18,0,0),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png'), fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text("Kelly Smith",style: AppCss.blue18semibold),
                        ),
                        Text("Director",style: AppCss.grey14regular),
                        Container(
                         padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat pharetra nunc, ac vestibulum purus fringilla sit amet. Proin ullamcorper tempus ligula quis feugiat. Phasellus ultrices lorem turpis",style: AppCss.grey12regular,textAlign: TextAlign.center),
                        ),
                     ]
                    ),
                    Column(
                      children: <Widget>[                    
                        Container(
                          margin: EdgeInsets.fromLTRB(0,18,0,0),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png'), fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text("Nile Morin",style: AppCss.blue18semibold),
                        ),
                        Text("Director",style: AppCss.grey14regular),
                        Container(
                         padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat pharetra nunc, ac vestibulum purus fringilla sit amet. Proin ullamcorper tempus ligula quis feugiat. Phasellus ultrices lorem turpis",style: AppCss.grey12regular,textAlign: TextAlign.center),
                        ),
                     ]
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0,18,0,0),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png'), fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text("Conan Nairn",style: AppCss.blue18semibold),
                        ),
                        Text("Director",style: AppCss.grey14regular),
                        Container(
                         padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat pharetra nunc, ac vestibulum purus fringilla sit amet. Proin ullamcorper tempus ligula quis feugiat. Phasellus ultrices lorem turpis",style: AppCss.grey12regular,textAlign: TextAlign.center),
                        ),
                     ]
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0,18,0,0),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png'), fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text("Roberto Holden",style: AppCss.blue18semibold),
                        ),
                        Text("Director",style: AppCss.grey14regular),
                        Container(
                         padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat pharetra nunc, ac vestibulum purus fringilla sit amet. Proin ullamcorper tempus ligula quis feugiat. Phasellus ultrices lorem turpis",style: AppCss.grey12regular,textAlign: TextAlign.center),
                        ),
                     ]
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0,18,0,0),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png'), fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text("Jasmine Campbell",style: AppCss.blue18semibold),
                        ),
                        Text("Director",style: AppCss.grey14regular),
                        Container(
                         padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consequat pharetra nunc, ac vestibulum purus fringilla sit amet. Proin ullamcorper tempus ligula quis feugiat. Phasellus ultrices lorem turpis",style: AppCss.grey12regular,textAlign: TextAlign.center),
                        ),
                     ]
                    ),
                  ]
            ),
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