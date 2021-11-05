import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/learning-topic/reading-finish-later.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/learning.dart';
import 'package:page_transition/page_transition.dart';
class LibraryDetails extends StatefulWidget {
  final String topicId;
  final String title;

  const LibraryDetails({Key? key, required this.topicId, this.title=""}): super(key: key);
  @override
  LibraryDetailsState createState() => LibraryDetailsState();
}

class LibraryDetailsState extends State<LibraryDetails> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var learningTitle;
  var htmlData;
  @override
  void initState() {    
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    learningTopicDetailsPost();
    super.initState();
  }

  learningTopicDetailsPost() async {
    final data = await getLearningTopicsDetailsPost(
        <String, dynamic>{"topic_id": widget.topicId});
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
        learningTitle = data['data']['topics']['title'];
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
  }

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
        appBar: header(
            logedin = true,
            back = true,
            logo = false,
            skip = false,
            backlink = true,
            '/library',
            skiplink = false,
            '/',
            headingtext = "What are some ways that I can decrease inflammation?",
            isMsgActive =false,
            isNotificationActive=false,
            context),
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
                      child: Column(
                        children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "What causes inflammation?",
                            style: AppCss.blue20semibold,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 25, 20, 64.95),                          
                          child: ClipRRect(borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset("assets/images/library-details.png",
                                width: 295.0, height: 295.0, fit: BoxFit.fill),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,top:5,right: 20.0),
                          child: Text("Inflammation is the body’s way of signaling that something inside of you is hurt or needs attention. Inflammation can be acute (temporary, for instance when you have a scraped knee), or it can be chronic. When inflammation is acute it can help you heal. But when it is chronic it can lead to or aggravate many illnesses. We will discuss ways to help reduce this chronic inflammation.",style: AppCss.grey12regular),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(top: 30.0, bottom: 7.0),
                          child: buttion(
                              btnwidth = 275,
                              btnheight = 36,
                              btntext = 'Yes! I’m done with this topic'
                                  .toUpperCase(),
                              AppCss.blue13bold,
                              AppColors.PALE_BLUE,
                              btntypesubmit = true,
                              () {},
                              9,
                              8,
                              23,
                              21,
                              context),
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
                        
                      ]),
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