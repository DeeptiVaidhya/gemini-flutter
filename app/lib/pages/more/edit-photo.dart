
import 'package:flutter/material.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';

class EditPhoto extends StatefulWidget {
  final dynamic fileName;
  const EditPhoto({
    Key? key,
    required this.fileName
  }) : super(key: key);
  
  @override
  _EditPhotoState createState() => _EditPhotoState();
}

class _EditPhotoState extends State<EditPhoto> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg.png",
          width: width,
          height: height,
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
                '/more',
                skiplink = false,
                '',
                headingtext = 'Edit my info',
                isMsgActive =false,        
                isNotificationActive=false,
                context),
            body: SingleChildScrollView(
                child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:40,bottom: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(    
                        width: 200.0,height: 200.0, 
                        child: Image.memory(widget.fileName, width: 200.0,height: 200.0, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 26,left: 30,right: 30),
                    child: Text('We love your photo!',style: AppCss.blue26semibold,textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:const EdgeInsets.only(left: 54, right: 54),
                  child: Text(
                    'But if you want to try another one, click “choose a new photo” below.',
                    style: AppCss.grey14regular,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50, right: 30,bottom: 78,top: 90),
                  child: buttion(
                    btnwidth = 295,
                    btnheight = 44,
                    btntext = 'Choose a new photo'.toUpperCase(),
                    AppCss.blue14bold,
                    AppColors.LIGHT_ORANGE,
                    btntypesubmit = true, () {  
                      Navigator.pop(context,true);           
                    // var url="edit-profile";                              
                    // Navigator.of(context).pushReplacement(
                    //   new MaterialPageRoute( 
                    //   settings:  RouteSettings(name:url),
                    //   builder: (context) => new EditProfile()
                    //   )
                    // );
                  }, 13, 11, 43, 42, context),
                ),
              ]),
            ))),
      ],
    );
  }
}