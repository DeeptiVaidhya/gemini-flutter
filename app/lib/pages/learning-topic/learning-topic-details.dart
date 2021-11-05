import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/learning-topic/learning-topic.dart';
import 'package:gemini/pages/learning-topic/reading-finish-later.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/learning.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gemini/services/class.dart';

class LearningTopicDetails extends StatefulWidget {
  final String topicId;
  final String title;
  final String classId;

  const LearningTopicDetails({Key? key, required this.topicId, required this.title, required this.classId}): super(key: key);
  @override
  __LearningTopicDetailsState createState() => __LearningTopicDetailsState();
}

class __LearningTopicDetailsState extends State<LearningTopicDetails> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var learningTitle;
  var resource;
  var text; 
  var image;
  var detailsList = [];
  var resourcePath;
  var resourceType;
  var websiteUrl;
  var websiteTitle;
  var topicId;
  var learntopicId;
  var classId;

  @override
  void initState() {
    classId = isVarEmpty(widget.classId);
    topicId = isVarEmpty(widget.topicId);
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    learningTopicDetailsPost();    
    super.initState();
  }

  Future<void> learningTopicDetailsPost() async {
    try {
    final data = await getLearningTopicsDetailsPost(<String, dynamic>{"topic_id": topicId});
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
        learningTitle = data['data']['topics']['title'];
        detailsList = data['data']['topics']['detail'];    
      });
    } else {
      if (data['is_valid']) {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
        toast(data['msg']);
      } else {
        Navigator.pushNamed(context, '/');
        errortoast(data['msg']);
      }
    }
  } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }

  Future<void> updateClass(id) async {
    try { 
    final data = await updateClassTask(<String, dynamic>{"class_topic_id": id});	
    if (data['status'] == "success") {
       Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: LearningTopic(key: null,classId: widget.classId, type: 'learning'),
          ),
        ); 
    } else {	
      Navigator.of(context, rootNavigator: true).pop();	
      errortoast(data['msg']);
    }	
   } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }

//  Widget ? htmlCustomRenderer(dom.Node node) {
//     if (node is dom.Element) {
//       switch (node.localName) {
//         case "li":
//           return customListItem(node);
//       }
//     }
//     return null ;
//   }

//     Wrap  customListItem(dom.Element node) {
//       return Wrap(
//         crossAxisAlignment: WrapCrossAlignment.center,
//         spacing: 4,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 10),
//             child: CircleAvatar(
//               radius: 2,
//             ),
//           ),
//           Text(node.text)
//         ],
//       );
//     }

   _launchURL(url) async { 
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        appBar: header(
          logedin = true,
          back = true,
          logo = false,
          skip = false,
          backlink = true, 
          '/learning-topics/$classId',
          skiplink = false,
          '/',
          headingtext = widget.title, 
          isMsgActive =false,         isNotificationActive=false,
          context
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 100, left: 20, right: 20),
                  child: Container( 
                    width: 500,
                    decoration: BoxDecoration(
                      color: AppColors.PRIMARY_COLOR,
                      borderRadius: new BorderRadius.circular(10.0),                            
                      boxShadow: [
                        BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(left:10,top: 30),
                              child: Text(isVarEmpty(learningTitle),style: AppCss.blue20semibold,)
                            ),
                            detailsList.length <=0? 
                            Container(): 
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: detailsList.length,
                              itemBuilder: (context, index) {                           
                              image = (detailsList[index]['image'] !=null) ? detailsList[index]['image']['path'] : '';
                              text = (detailsList[index]['text'] !=null) ? detailsList[index]['text']['text'] : '';
                              resourcePath = (detailsList[index]['resource'] !=null) ? detailsList[index]['resource']: '';
                              resourceType =  (detailsList[index]['resource'] !=null) ? detailsList[index]['resource']['type'] : '';
                              websiteUrl = (detailsList[index]['resource'] !=null) ? detailsList[index]['resource']['path']: '';
                              websiteTitle = (detailsList[index]['resource'] !=null) ? detailsList[index]['resource']['title']: '';
                              return Column(
                              children: <Widget>[                               
                                (image.isEmpty) ? Container() : 
                                Container(
                                  margin: const EdgeInsets.only(top: 24),                                  
                                  child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),child: Image.network(isImageCheck(image),width: 295.0, height: 295.0, fit: BoxFit.fill)),
                                ),
                                (isVarEmpty(text) !=null) ? 
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),  
                                  child: Html(
                                    data:  isVarEmpty(text),       
                                    style: {
                                    'blockquote': Style(
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    'body':Style(color: AppColors.DEEP_GREY,fontFamily: "Poppins",fontSize: FontSize(12.0),fontWeight: w400,textAlign: TextAlign.justify),
                                    'p':Style(color: AppColors.DEEP_GREY,fontFamily: "Poppins",fontSize: FontSize(12.0),fontWeight: w400,textAlign: TextAlign.justify,margin: EdgeInsets.only(top: 5,bottom: 5)),
                                    'h1':Style(color: AppColors.DEEP_BLUE,fontFamily: "Poppins",fontSize: FontSize(20.0),fontWeight: w600,textAlign: TextAlign.justify),
                                    'h2':Style(color: AppColors.DEEP_BLUE,fontFamily: "Poppins",fontSize: FontSize(18.0),fontWeight: w600,textAlign: TextAlign.justify),
                                    'h3':Style(color: AppColors.DEEP_BLUE,fontFamily: "Poppins",fontSize: FontSize(12.0),fontWeight: w600,textAlign: TextAlign.justify),
                                    'h4':Style(color: AppColors.DEEP_BLUE,fontFamily: "Poppins",fontSize: FontSize(12.0),fontWeight: w600,textAlign: TextAlign.justify),
                                    'h5':Style(color: AppColors.DEEP_BLUE,fontFamily: "Poppins",fontSize: FontSize(12.0),fontWeight: w600,textAlign: TextAlign.justify),
                                    'h6':Style(color: AppColors.DEEP_BLUE,fontFamily: "Poppins",fontSize: FontSize(12.0),fontWeight: w600,textAlign: TextAlign.justify),
                                    'li':Style(color: AppColors.DEEP_GREY,fontFamily: "Poppins",fontSize: FontSize(12.0),fontWeight: w400,textAlign: TextAlign.justify,margin: EdgeInsets.only(top: 8)),
                                    'ul':Style(color: AppColors.DEEP_GREEN,fontFamily: "Poppins",fontWeight: FontWeight.w300,  fontSize: FontSize(18.0),textAlign: TextAlign.justify,margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10)),
                                    'a':Style(color: AppColors.DEEP_GREEN,fontFamily: "Poppins",fontSize: FontSize(12.0),fontWeight: w600,textAlign: TextAlign.justify,textDecoration: TextDecoration.none,margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10)),
                                  },
                                )) : Container(),
                                (isVarEmpty(resourceType.toString()) == "WEBSITE") ?
                                Container(
                                  margin: EdgeInsets.only(top:20),
                                  child: Row(
                                    children: [
                                    SvgPicture.asset('assets/images/icons/link.svg',width: 13,height: 13,),
                                    Material(
                                      color: Colors.transparent,
                                      child: MaterialButton( 
                                      onPressed: () {
                                        _launchURL(websiteUrl);
                                      },
                                      textColor: AppColors.DEEP_GREEN,
                                      child: Text("$websiteTitle",style: AppCss.green12semibold),
                                      ),
                                    ),
                                    ],                                 
                                  ),
                                ) : Container(),
                              ]
                              );
                              }
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Text("Have you finished reading this topic?" , style: AppCss.grey10light,),
                            ),                          
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 7.0),
                              child: buttion(
                                btnwidth = 275,
                                btnheight = 36,
                                btntext = 'Yes! I’m done with this topic'
                                    .toUpperCase(),
                                AppCss.blue13bold,
                                AppColors.PALE_BLUE,
                                btntypesubmit = true,
                                () {
                                  updateClass(widget.topicId);
                                },9, 8,23,21,context),
                            ),
                            Container(
                              width: 275,
                              height: 36,
                              margin: const EdgeInsets.only(bottom: 30),
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: AppColors.DEEP_BLUE,
                                      width: 2,
                                      style: BorderStyle.solid
                                    ),
                                  borderRadius: BorderRadius.circular(100)
                                  ), 
                                color: AppColors.PRIMARY_COLOR,
                                child: MaterialButton(                                      
                                padding: const EdgeInsets.fromLTRB(55, 9, 55, 9),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ReadingFinishLater(title: widget.title),
                                    ),
                                  );
                                },
                                textColor: AppColors.DEEP_BLUE,
                                child: Text("No, I will FINISH later".toUpperCase(),style: AppCss.blue13bold),
                                ),
                              ),
                          ),                             
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
       floatingActionButton: floatingactionbuttion(context),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: footer(
            ishomepageactive = false,
            isclassespageactive = true,
            islibyrarypageactive = false,
            ismorepageactive = false,
            context)),
    ]);
  }
}

