import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/journal/journal.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';

class JournalComplete extends StatefulWidget {	
   final String postId;
  const JournalComplete({Key? key,required this.postId}) : super(key: key);
  @override	
  _JournalCompleteState createState() => _JournalCompleteState();	
}	

class _JournalCompleteState extends State<JournalComplete> {
 
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(	
          "assets/images/bg.png",	
          height: height,	
          width: width,	
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
            '/journal',
            skiplink = false,
            '/',
            headingtext = 'Journal', isMsgActive =false,         isNotificationActive=false,
            context),
        body: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 100),
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
                              top: 35,
                              left: 3,
                              right: 3,
                              child: SvgPicture.asset('assets/images/jaurnal/icon-journal.svg',width: 80.0,height: 91.45,),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.55, bottom: 16, left: 30, right: 30),
                          child: Text(
                            'Keep up the good work!',
                            style: AppCss.blue26semibold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 27, left: 54, right: 54),
                        child: Text('You have completed XX entries in this class. Complete YY more to reach the target.',
                          style: AppCss.grey12regular,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 120, bottom: 78, left: 38, right: 57),
                        child: buttion(
                        btnwidth = 295,
                        btnheight = 44,
                        btntext = 'go back to my journal'.toUpperCase(),
                        AppCss.blue14bold,
                        AppColors.LIGHT_ORANGE,
                        btntypesubmit = true, () {
                        var postId = isVarEmpty(widget.postId);                 
                        var url="journal/$postId";                              
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute( 
                          settings:  RouteSettings(name:url),
                          builder: (context) => new Journal(postId: postId)
                          )
                        ); 
                        }, 12, 12, 41, 60, context),
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
