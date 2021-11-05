import 'dart:html';
import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/audio/audio.dart';
import 'package:gemini/pages/video/video.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/pages/widget/popup-content.dart';
import 'package:gemini/services/class.dart';

class MindPractice extends StatefulWidget {
  bool audioStop = false;
  String practiceId;
  String type;
  MindPractice({Key? key,  required this.practiceId, required this.type}): super(key: key);

  @override
  _MindPracticeState createState() => _MindPracticeState();
}

class _MindPracticeState extends State<MindPractice> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var audioState;
  bool isPlay =false;
  var isMuted =1;
  var practiceFileList = [];	
  var fileUrl;
  var totalTime;
  var currentTime;
  var posSec;
  var durSec;
  int timerCounter = 0;
  var practiceResourceId;
  var practiceType;
  var practiceId;
  var practiceTitle;

  @override
  void initState() {
   // var urlParam =getUrl(); 
    //practiceId=isVarEmpty(urlParam)!=''?urlParam:widget.practiceId;
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));	
    fileData();	
    super.initState();
  }

  Future<void> fileData() async {
    try { 
    final data = await practiceDetails(<String, dynamic>{"practice_id": widget.practiceId});	
    if (data['status'] == "success") {	
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();	
        practiceFileList = data['data']['practice_content'];
        practiceTitle = data['data']['title'];
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
          headingtext = 'Mind practice',
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
                  padding:const EdgeInsets.only(top: 28, left: 20, right: 20),
                  child: Text(
                    isVarEmpty(practiceTitle).toString(),style: AppCss.blue20semibold,textAlign: TextAlign.center,
                  )),
                // DefaultPlayer(),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 17, left: 20, right: 20, top: 16),
                  child: Text(
                    'Please listen to the following audio clip to complete the activity.',
                    style: AppCss.grey14regular,
                    textAlign: TextAlign.center,
                  ),
                ),
                practiceFileList.isEmpty ? Container() : 
                Column(
                  children: [
                    ListView.separated(	
                      separatorBuilder: (BuildContext context, int index) =>	
                      Container(margin: EdgeInsets.only(bottom: 6)),
                      shrinkWrap: true,		
                      physics: NeverScrollableScrollPhysics(),	
                      scrollDirection: Axis.vertical,                      
                      itemCount: practiceFileList.length,	
                      itemBuilder: (context, index) {
                        practiceType = practiceFileList[index]['type'];
                        return Column(
                          children: [
                            (practiceType == "AUDIO") ? Container(
                              margin: EdgeInsets.only(left: 20,right: 20,top: 16), 
                              child: AudioPlay(practiceResourceId: practiceFileList[index]['practice_resource_id']!, url: practiceFileList[index]['url']!,title:practiceFileList[index]['title']!, audioStop: widget.audioStop)
                            ) : Container(),
                            (practiceType == "VIDEO") ? Container(
                            margin: EdgeInsets.only(left: 20,right: 20,top: 16), 
                            child: Video(practiceResourceId: practiceFileList[index]['practice_resource_id']!, url: practiceFileList[index]['url']!)
                          ) : Container(),
                          ],
                        );
                      }
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 33, left: 54, right: 46),
                      child: buttion(
                          btnwidth = 295,
                          btnheight = 44,
                          btntext = 'I’m done WITH this PRACTICE'.toUpperCase(),
                          AppCss.blue14bold,
                          AppColors.LIGHT_ORANGE,
                          btntypesubmit = true,
                          () { 
                          modalPopup(context, AppColors.DEEP_BLUE, PracticePopupcontent('mind'), 335, 422, 1,"",(){});
                          },
                          12,12,33,32,
                          context),
                    ),

                  ],
                ), 
              ]
            ),
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

