import 'package:flutter/material.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/messages/messages-details.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);
  @override
  _MessagesState createState() => _MessagesState();
}
class _MessagesState extends State<Messages> {
  var currentSelectedValue;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var msgList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    msgNotificationList();
  }

  Future<void> msgNotificationList() async {
    try {
    final data = await messageNotification(<String, dynamic>{});
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
        msgList = data['data']['notification'];
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
        Navigator.pushNamed(context, '/more');
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
          headingtext = 'Messages',
          isMsgActive =true,
          isNotificationActive=false,
          context
        ),
        backgroundColor: Colors.transparent,        
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 375,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top:18.0,left: 20,right: 20),
                    child: Container(
                      height: 33,
                      child: TextField(
                        style: AppCss.grey12regular,
                        cursorColor: AppColors.MEDIUM_GREY2,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top:8,bottom:8,left: 15),
                          hintText: "Search",
                          hintStyle: AppCss.grey12regular,
                          suffixIcon: InkWell(
                            onTap:(() {}),
                            child: Icon(GeminiIcon.search,size: 15, color: AppColors.DEEP_GREY),
                          ),
                          filled: true,
                          fillColor: AppColors.PRIMARY_COLOR,                          
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: AppColors.LIGHT_GREY),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: AppColors.LIGHT_GREY),
                          ),
                        ),
                      ),
                    ),
                  ),
                  msgList.isEmpty ? 
                  Container(
                    margin: const EdgeInsets.only(top:150,bottom: 150,left: 40,right: 40),
                    child: Text("No messages yet.",style: AppCss.grey12medium,textAlign: TextAlign.center,),
                  ) : Container(
                    margin: const EdgeInsets.only(left:20.0,right: 20,bottom: 20,top: 16),
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => Container(margin: EdgeInsets.only(bottom: 16)),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: msgList.length,
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
                                  border: Border(left: BorderSide(width: 6, color: AppColors.EMERALD_GREEN)),
                                ),
                                child: ListTile(
                                  contentPadding:EdgeInsets.only(top:10.0,left: 15.0,right: 20,bottom: 17),              
                                  leading: ConstrainedBox(
                                    constraints:BoxConstraints(minWidth: 40,minHeight: 40),
                                    child: Image.asset('assets/images/profile/Ellipse-17.png',width: 40,
                                      height: 40,
                                    )
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top:5),
                                    child: Text(isVarEmpty(msgList[index]['first_name'])+isVarEmpty(msgList[index]['last_name']) ,style: AppCss.green12semibold),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: const EdgeInsets.only(right: 10),
                                        child: Text(msgList[index]['message'],style:AppCss.grey12regular,overflow: TextOverflow.ellipsis)),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(right: 10),
                                        child: (msgList[index]['created_at'] !=null)
                                      ? Text(dateTimeFormate(msgList[index]['created_at']),
                                      style: AppCss.mediumgrey8medium) : Container(),
                                      ),
                                    ],
                                  ), 
                                  onTap: () {
                                    var buddy_user_id = isVarEmpty(msgList[index]['buddy_user_id']);                
                                    var url="/message-details/$buddy_user_id";                              
                                    Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute( 
                                      settings:  RouteSettings(name:url),
                                      builder: (context) => new MessagesDetails(
                                        buddy_user_id : buddy_user_id,
                                        ) 
                                      )
                                    );
                                  },
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
