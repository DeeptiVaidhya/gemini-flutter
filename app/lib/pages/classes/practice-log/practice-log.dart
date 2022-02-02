import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/services/home.dart';
import 'package:gemini/pages/widget/helper.dart';

class PracticeLogTab extends StatefulWidget {
  final String classId;
  const PracticeLogTab({Key? key,required this.classId}) : super(key: key);
  @override
  PracticeLogTabState createState() => new PracticeLogTabState();
}

class PracticeLogTabState extends State<PracticeLogTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();	
  var praticeLog;
  var remainPractices;
  var mindPractices;
  var bodyPractices;
  bool isDone = false;
	
  @override
  void initState() {
    checkLoginToken(context);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();	
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));	
    classDetail();	
  }	 

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  
  Future<void> classDetail() async {
    try { 
    final data = await getPracticeLog(<String, dynamic>{});	
    //if (data["data"]?.isEmpty ?? true) {  
    if (data['status'] == "success") {	
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();	
        praticeLog = data['data']['pratice_log'];
        remainPractices= data['data']['remain_practices'];
        mindPractices= data['data']['pratice_log']['mind'];
        bodyPractices= data['data']['pratice_log']['body'];
      });	
    } else {	
     if (data['is_valid'] == false) {	
        setState(() {	
          Navigator.of(context, rootNavigator: true).pop();	
        });
        Navigator.pushNamed(context, '/signin');
      } else {	
        setState(() {	
          Navigator.of(context, rootNavigator: true).pop();	
        });
        errortoast(data['msg']);	
      }	
    }	
    //}
   } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
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
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 375,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [              
                  Container(
                    margin: EdgeInsets.only(top:10,left: 20,right: 20),
                    child: Text("You need to do $remainPractices more practices in total to complete each practice’s goals",style: AppCss.grey12regular,
                    ),
                  ),  
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top:20,left: 20,right: 20),
                    child: Text("Mind Practices ($mindPractices/6)",style: AppCss.blue18semibold,textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:20,left: 40,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (mindPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                        (mindPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                         (mindPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                        (mindPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                        (mindPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                        (mindPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                      ],
                    ),
                  ), 

                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top:20,left: 20,right: 20),
                    child: Text("Body Practices ($bodyPractices/6)",style: AppCss.blue18semibold,textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:20,left: 40,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (bodyPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                        (bodyPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                         (bodyPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                        (bodyPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                        (bodyPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                        (bodyPractices == 0) ? 
                        Opacity(
                          opacity:0.5,
                          child: SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                          fit: BoxFit.fill),
                        ):SvgPicture.asset("assets/images/icons/meditation/meditation.svg",width: 22.5,height: 30,
                        fit: BoxFit.fill),
                      ],
                    ),
                  ), 
                  // ListView.separated(
                  //   separatorBuilder: (BuildContext context, int index) =>
                  //   Container(margin: EdgeInsets.only(bottom: 16)),
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: praticeLog.length,
                  //   itemBuilder: (context, index) {
                  //     libraryID = libraryList[index]['id'];
                  //     return Container(
                  //     );
                  //   }
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
      ]
    );
  }
}