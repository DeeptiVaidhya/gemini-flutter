import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var currentSelectedValue;
  var notidicationsList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    notificationList();
  }

  Future<void> notificationList() async {
    try {
    final data = await messageNotification(<String, dynamic>{});
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
        notidicationsList = data['data']['notification'];
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

    final List<Map<String, dynamic>> _notificationItem = [
    {
      "title": "Monica Chavez wants to be your buddy",
      "subtitle" : "22 hours ago",
      "image": "https://pub1.brightoutcome-dev.com/gemini/admin/assets/uploads/images/6114c1a7c4b6f.png",
      "icon": Image.asset('images/icons/close/close.png',width: 16,height: 16,),
      "type": true,
    },
    {
      "title": "Don’t forget to fill out your Health Check-in form to bring to your virtual visit tomorrow.",        
      "subtitle" : "12 mins ago",
      "image": "https://pub1.brightoutcome-dev.com/gemini/admin/assets/uploads/images/6114c1a7c4b6f.png",
      "icon": Image.asset('assets/images/icons/close/close.png',width: 16,height: 16,),
      "type": false,
    },
    {
      "title": "This week’s virtual visit will take place tomorrow at 2pm.",
      "subtitle" : "2 mins ago",
      "image": "https://pub1.brightoutcome-dev.com/gemini/admin/assets/uploads/images/6114c1a7c4b6f.png",
      "icon": Image.asset('assets/images/icons/close/close.png',width: 16,height:16,),
      "type": false,
    },
    {
      "title": "Vanness Gomes accepted your buddy request.",
      "subtitle" : "2 mins ago",
      "image": "https://pub1.brightoutcome-dev.com/gemini/admin/assets/uploads/images/6114c1a7c4b6f.png",
      "icon": Image.asset('assets/images/icons/close/close.png',width: 16,height: 16,),
      "type": false,
    },
    {
      "title": "Olivia Miller liked your post in Orientation.",
      "subtitle" : "2 mins ago",
      "image": "https://pub1.brightoutcome-dev.com/gemini/admin/assets/uploads/images/6114c1a7c4b6f.png",
      "icon": Image.asset('assets/images/icons/close/close.png',width: 16,height: 16,),
      "type": false,
    },

    {
      "title": "Vanness Gomes accepted your buddy request..",
      "subtitle" : "2 mins ago",
      "image": "https://pub1.brightoutcome-dev.com/gemini/admin/assets/uploads/images/6114c1a7c4b6f.png",
      "icon": Image.asset('assets/images/icons/close/close.png',width: 16,height: 16,),
      "type": false,
    },

    {
      "title": "Don’t forget to fill out your Health Check-in form to bring to your virtual visit tomorrow.",
      "subtitle" : "2 mins ago",
      "image": "https://pub1.brightoutcome-dev.com/gemini/admin/assets/uploads/images/6114c1a7c4b6f.png",
      "icon": Image.asset('assets/images/icons/close/close.png',width: 16,height: 16,),
      "type": false,
    },
];
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
          '/home',
          skiplink = false,
          '/',
          headingtext = 'Notifications',
          isMsgActive =false,
          isNotificationActive =true,
          context),
        backgroundColor: Colors.transparent,        
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                children: [
                  Container(
                    width: 500,
                    margin : const EdgeInsets.only(top:20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left:90,bottom: 18),
                            child: Text("Mark all as read", style: AppCss.green12semibold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(left:10,bottom: 19,right: 10),
                            child: Text("|", style: AppCss.mediumgrey10bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right:94.0,bottom: 18),
                            child: Text("Delete all", style: AppCss.green12semibold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    margin: const EdgeInsets.only(left:20.0,right: 20,bottom: 40),
                    child: _notificationItem.isEmpty ? 
                    Container(
                      margin: const EdgeInsets.only(top:250,bottom: 250,left: 40,right: 40),
                      child: Text("You have no notifications to read",style: AppCss.grey12medium,textAlign: TextAlign.center),
                    ) :
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => 
                      Container(margin: EdgeInsets.only(bottom: 16)),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                        itemCount: _notificationItem.length,
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                              color: AppColors.PRIMARY_COLOR,
                              borderRadius: new BorderRadius.circular(8.0),                            
                                boxShadow: [
                                  BoxShadow(
                                  color: AppColors.SHADOWCOLOR,
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  offset: Offset(0, 3)
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: new BorderRadius.circular(8.0),
                                child: Container(
                                 decoration: BoxDecoration(
                                  border: Border(left: BorderSide(color: AppColors.EMERALD_GREEN, width: 6.0))
                                 ),
                                 child: Column(
                                   children: [
                                   ListTile(
                                    contentPadding: EdgeInsets.only(left:19,bottom: 18,right: 10,top:5),
                                    leading: ConstrainedBox(
                                      constraints:BoxConstraints(minWidth: 40, minHeight: 40),
                                      child: Image.asset('assets/images/profile/Ellipse-17.png',width: 40,
                                      height: 40,fit: BoxFit.cover)
                                    ),
                                    title : Container(
                                      margin:EdgeInsets.only(top:10,right: 50),
                                      child: Text(_notificationItem[index]['title'],style: AppCss.          grey12medium)
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin:EdgeInsets.only(bottom:12),
                                          child: Text(_notificationItem[index]['subtitle'],style: AppCss.mediumgrey8medium)),
                                         _notificationItem[index]['type'] ? 
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 80,height: 26,
                                                child: MaterialButton(
                                                  splashColor: AppColors.TRANSPARENT,
                                                  focusColor:AppColors.DEEP_GREEN,
                                                  clipBehavior: Clip.none,
                                                  height: 26,minWidth: 80,
                                                  onPressed: () => null,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text('ACCEPT',style: AppCss.white11bold),
                                                    ],
                                                  ),
                                                  color: AppColors.DEEP_GREEN,
                                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)
                                                  )
                                                ),
                                              ),
                                              SizedBox(width: 8),

                                              Container(
                                               width: 80,height: 26,
                                                child: MaterialButton(
                                                  height: 26,                                                  
                                                  minWidth: 80,
                                                  onPressed: () => null,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text('DECLINE',style: AppCss.green11bold),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  color: AppColors.PRIMARY_COLOR,
                                                  shape: RoundedRectangleBorder(side: BorderSide(
                                                    color: AppColors.DEEP_GREEN,
                                                    width: 1,
                                                    style: BorderStyle.solid
                                                  ), borderRadius: BorderRadius.circular(100)),
                                                  ),
                                              ),

                                              //   MaterialButton(
                                              //     height: 26,minWidth: 80,
                                              //   onPressed: () {
                                              //   },
                                              //   child: Container(
                                              //     width: 49,
                                              //     height: 16,
                                              //    // padding: EdgeInsets.only(top:5,bottom: 6),
                                              //     child: Text("DECLINE",style: AppCss.green11bold,textAlign: TextAlign.center),
                                              //   ),
                                              //   textColor: AppColors.PRIMARY_COLOR,
                                              //   shape: RoundedRectangleBorder(side: BorderSide(
                                              //     color: AppColors.DEEP_GREEN,
                                              //     width: 1,
                                              //     style: BorderStyle.solid
                                              //   ), borderRadius: BorderRadius.circular(100)),
                                              // ),
                                            ]
                                          ) : Container(),
                                      ],                                       
                                    ), 
                                    trailing: Container(
                                      width: 19,
                                      height: 19,
                                      child: CircleAvatar(
                                        child: SvgPicture.asset('assets/images/icons/close/close.svg',width: 6,height: 6),
                                        backgroundColor: Color(0xFFF4F9FD),
                                      ),
                                    ),  
                                    onTap: () {
                                     
                                    },
                                   ),
                                    
                                   ]
                                 ),                                  
                                  ),
                              ),
                          );
                      },
                    ),
                  ),
                ],
              ),
          ),
        ),
        floatingActionButton: floatingactionbuttion(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: footer(        
            ishomepageactive = false,
            isclassespageactive = false,
            islibyrarypageactive = false,
            ismorepageactive = false,
            context),
        ),
    ]);
  }
}
