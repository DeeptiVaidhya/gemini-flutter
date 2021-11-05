import 'package:flutter/material.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/more/more.dart';
import 'package:gemini/pages/more/public-profile.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/profile.dart';
import 'package:page_transition/page_transition.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final GlobalKey<State> _keyLoading = new GlobalKey<State>();

  var firstName;
  var lastName;
  var emailAdd;
  var profilePicture;
  var userId;

  @override
  void initState() {
    super.initState();
    checkLoginToken(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoading));
    Future.delayed(Duration.zero, () {
      getUserDetails();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getUserDetails() async {
    try {
      final data = await getUserProfile(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          userId = data['data']['id'];
          firstName = data['data']['first_name'];
          lastName = data['data']['last_name'];
          profilePicture = data['data']['profile_picture'];
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
          Navigator.pushNamed(context, '/edit-profile');
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
          headingtext = 'My Account Details', 
          isMsgActive =false,       
          isNotificationActive=false,
          context),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.transparent,
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                  children: [
                    (profilePicture!=null) ? 
                    Container(
                      margin: EdgeInsets.only(top:18,left: 20, right: 20,),
                      child : ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: (profilePicture!="") ? Image.network(profilePicture.toString(),height: 100.0,width: 100.0,fit: BoxFit.cover) : Container(height: 100.0,width: 100.0,
                          decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.TRANSPARENT),
                          child: Icon(GeminiIcon.profile,size: 60, color: AppColors.PRIMARY_COLOR)),
                        ),
                    ): Container(
                      margin: EdgeInsets.only(top:18,left: 20, right: 20,),
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.TRANSPARENT),
                      child: Container(
                      alignment: Alignment.center,
                      child: new Icon(GeminiIcon.profile,size: 60, color: AppColors.PRIMARY_COLOR)),
                    ),
                    Container(
                      margin : const EdgeInsets.only(top:10,bottom: 13.0,left: 20, right: 20,),
                      child:Image.asset("assets/images/icons/award-icon.png",width: 23.86,height: 29),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("8",style: AppCss.blue14semibold),
                            Container(
                              width: 71,height: 35,
                              child: Text("Consecutive days logged in", style: TextStyle(height:0.6,fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY1, fontSize: 8.0, fontWeight: w500),textAlign: TextAlign.center),
                            )
                          ],
                        ),
                        VerticalDivider(
                          width: 15.0,
                          color: Colors.transparent,
                        ),
                        Column(
                          children: <Widget>[
                            Text("0",style: AppCss.blue14semibold),
                            Container(width: 58,child: Text("Meditation minutes", style: TextStyle(height:0.6,fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY1, fontSize: 8.0, fontWeight: w500),textAlign: TextAlign.center))
                          ],
                        ),
                        VerticalDivider(
                          width: 15.0,
                          color: Colors.transparent,
                        ),
                        Column(
                          children: <Widget>[
                            Text("0",style: AppCss.blue14semibold),
                            Container(width: 58,height: 25,child: Text("Milestones", style:TextStyle(height:0.6,fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY1, fontSize: 8.0, fontWeight: w500),textAlign: TextAlign.center)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 117),
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),                        
                        boxShadow: [
                          BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                        ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            physics: PageScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB))),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shadowColor: Color(0xFF3333331A),
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    elevation: 1.0,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: ListTile(
                                      title: Text('My public profile',
                                          style: AppCss.blue16semibold),
                                      trailing: Icon(
                                          Icons.keyboard_arrow_right,
                                          color: AppColors.DEEP_BLUE,
                                          size: 30),
                                      selected: true,
                                      onTap: () {          
                                        var url="/public-profile/$userId";                              
                                        Navigator.of(context).pushReplacement(
                                          new MaterialPageRoute( 
                                          settings: RouteSettings(name:url),
                                          builder: (context) => new PublicProfile(buddyUserId:userId,type: "account", postId: "")
                                        )
                                      );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFFEBEBEB))),
                                ),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  shadowColor: Color(0xFF3333331A),
                                  semanticContainer: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  elevation: 1.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: ListTile(
                                    title: Text('My health check-in records',
                                        style: AppCss.blue16semibold),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: AppColors.DEEP_BLUE, size: 30),
                                    selected: true,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: More(key: null,),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFFEBEBEB))),
                                ),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  shadowColor: Color(0xFF3333331A),
                                  semanticContainer: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  elevation: 1.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: ListTile(
                                    title: Text('My providers',
                                        style: AppCss.blue16semibold),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: AppColors.DEEP_BLUE, size: 30),
                                    selected: true,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: More(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFFEBEBEB))),
                                ),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  shadowColor: Color(0xFF3333331A),
                                  semanticContainer: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  elevation: 1.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: ListTile(
                                    title: Text('My group sessions',
                                        style: AppCss.blue16semibold),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: AppColors.DEEP_BLUE, size: 30),
                                    selected: true,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: More(key: null,),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  shadowColor: Color(0xFF3333331A),
                                  semanticContainer: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  elevation: 1.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: ListTile(
                                    title: Text('My activity',
                                        style: AppCss.blue16semibold),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: AppColors.DEEP_BLUE, size: 30),
                                    selected: true,
                                    onTap: () {
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ]),
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
