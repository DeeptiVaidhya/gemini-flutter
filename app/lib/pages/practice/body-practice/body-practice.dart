import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/audio/audio.dart';
import 'package:gemini/pages/video/video.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/pages/widget/popup-content.dart';
import 'package:gemini/services/class.dart';

class BodyPractice extends StatefulWidget {
  bool audioStop = false;
  final String practiceId;
  String type;
  BodyPractice({Key? key, required this.practiceId,required this.type}): super(key: key);
  @override
  _BodyPracticeState createState() => _BodyPracticeState();
}

class _BodyPracticeState extends State<BodyPractice> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  bool isPlay =false;
  var title;
  var practiceFileList = [];	
  var type;
  var practiceId;

  @override
  void initState() {
    // var urlParam =getUrl(); 
    // practiceId=isVarEmpty(urlParam)!=''?urlParam:widget.practiceId;
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));	
    videoData();
    super.initState();	
  }

  Future<void> videoData() async {
    try { 
    final data = await practiceDetails(<String, dynamic>{"practice_id": widget.practiceId});	
    if (data['status'] == "success") {	
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();	
        practiceFileList = data['data']['practice_content'];
      });	

    } else {	
      if (data['is_valid']) {	
        setState(() {	
          Navigator.of(context, rootNavigator: true).pop();	
        });	
        toast(data['msg']);	
      } else {	
        Navigator.of(context, rootNavigator: true).pop();		
        errortoast(data['msg']);	
      }	
    }	
   } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
       appBar: header(
          logedin = true,
          back = true,
          logo = false,
          skip = false,
          backlink = true,
          (widget.type =="home") ? "/home" : "/classes", 
          skiplink = false,
          '',
          headingtext = 'Body practice',
          isMsgActive =false,
          isNotificationActive=false,
          context, (op) {
            setState(() {
              widget.audioStop = true;
            });
          }),
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
                      padding: const EdgeInsets.only(top: 28, bottom: 3, left: 20, right: 20),
                      child: Text("title",style: AppCss.blue20semibold,textAlign: TextAlign.center,
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 17, left: 20, right: 20),
                      child: Text('Please listen to the following audio and watch the video to complete this activity.',
                      style: AppCss.grey14regular,textAlign: TextAlign.center,
                      ),
                    ), 
                   ListView.separated(	
                    separatorBuilder: (BuildContext context, int index) =>	
                    Padding(padding: EdgeInsets.only(bottom: 6)),	
                    physics: NeverScrollableScrollPhysics(),	
                    scrollDirection: Axis.vertical,	
                    shrinkWrap: true,	
                    itemCount: practiceFileList.length,	
                    itemBuilder: (context, index) {
                      type = practiceFileList[index]['type'];
                      return Column(
                        children: [
                          (type == "AUDIO") ? Container(
                          margin: EdgeInsets.only(left: 20,right: 20,top: 16), 
                          child: AudioPlay(practiceResourceId: practiceFileList[index]['practice_resource_id']!, url: practiceFileList[index]['url']!,title:practiceFileList[index]['title']!, audioStop: widget.audioStop,audioCallback : (e){})
                        ) : Container(),
                          (type == "VIDEO") ? Container(
                            margin: EdgeInsets.only(left: 20,right: 20,top: 16), 
                            child: Video(practiceResourceId: practiceFileList[index]['practice_resource_id']!, url: practiceFileList[index]['url']!)
                          ) : Container(),
                        ],
                      );
                    }
                    ), 
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 14, left: 54, right: 46),
                      child: buttion(
                        btnwidth = 295,
                        btnheight = 44,
                        btntext = 'I’m done WITH this PRACTICE'.toUpperCase(),
                        AppCss.blue14bold,
                        AppColors.LIGHT_ORANGE,
                        btntypesubmit = true, () {
                          modalPopup(context, AppColors.DEEP_BLUE, PracticePopupcontent('body'), 335, 422, 1,"",(){});
                        },                 
                        12,12,15,13,context
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30, 0, 45, 22),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/home");	
                        },
                        child: Text("Take me back to the class",
                        style: AppCss.green12semibold,
                        textAlign: TextAlign.center),
                      ),
                    ),

                  ]),
            ),
          ),
        ),
      ),
       floatingActionButton: floatingactionbuttion(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: footer(
            ishomepageactive = false,
            isclassespageactive = true,
            islibyrarypageactive = false,
            ismorepageactive = false,
            context),
    );
  }
}
