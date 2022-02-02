import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/more/about-team.dart';
import 'package:gemini/pages/more/about.dart';
import 'package:gemini/pages/more/account-details.dart';
import 'package:gemini/pages/more/edit-profile.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/auth.dart';
import 'package:gemini/services/profile.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  final LocalStorage storage = new LocalStorage('gemini'); 
  final GlobalKey<State> _keyLoading = new GlobalKey<State>();

  var firstName;
  var lastName;
  var emailAdd;
  var profilePicture;

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
   
  logOut() async {	
    final data = await logout(<String, dynamic>{});	
    if (data['status'] == "success") {
      storage.clear();	
      Navigator.pushNamed(context, '/signin');	
    } else {
      if (data['is_valid']) {	
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
          backgroundColor: Colors.transparent,
          appBar: header(
            logedin = true,
            back = true,
            logo = false,
            skip = false,
            backlink = true,
            '/home',
            skiplink = false,
            '/',
            headingtext = 'More', isMsgActive =false, 
            isNotificationActive=false,
            context),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 375,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("My Details & Settings",
                          style: AppCss.blue18semibold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR,
                        borderRadius: new BorderRadius.circular(10.0),                           
                        boxShadow: [
                          BoxShadow( color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 2),
                        )
                        ],
                        ),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          physics: PageScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom:BorderSide(color: Color(0xFFEBEBEB))),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(top:20,bottom: 20,left: 10,right: 14),
                                  leading: (profilePicture!=null) ?
                                  Container(
                                    height: 60.0,
                                    width: 60.0,
                                    child: (profilePicture!="") ? CircleAvatar(
                                    radius: 100.0,
                                    backgroundColor: AppColors.PRIMARY_COLOR,
                                    backgroundImage: NetworkImage(profilePicture.toString()) 
                                    ):Container(
                                      height: 60.0,width: 60.0,
                                      decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.TRANSPARENT),
                                      alignment: Alignment.center,
                                      child: new Icon(GeminiIcon.profile,size: 30, color: AppColors.PRIMARY_COLOR)
                                    )
                                  ) :
                                  Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.TRANSPARENT),     
                                    child : Container(
                                      alignment: Alignment.center,
                                      child: new Icon(GeminiIcon.profile,size: 30, color: AppColors.PRIMARY_COLOR)),
                                  ),
                                 title:(storage.getItem('name') != null) ? Text(storage.getItem('name'),
                                 style: AppCss.blue16semibold) : Text("My Profile",style: AppCss.blue16semibold),
                                 subtitle:Text('My Profile',style:AppCss.grey12regular),                                         
                                  trailing: Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute( 
                                      settings:  RouteSettings(name:"/account-details"),
                                      builder: (context) => new AccountDetails() 
                                      )
                                    );                                   
                                  },
                                ),
                              ),
                            ), 
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Color(0xFFEBEBEB))),
                              ),
                              child: Card(
                                margin: EdgeInsets.zero,
                                shadowColor: Color(0xFF3333331A),
                                semanticContainer: true,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                elevation: 1.0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom :10.0,top:15),
                                    child: Text('My account details',
                                        style: AppCss.blue16semibold),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
                                  selected: true,
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute( 
                                    settings: const RouteSettings(name: '/edit-profile'),
                                    builder: (context) => new EditProfile(key: null),
                                    )); 
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                elevation: 1.0,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom :16.0,top:15),
                                    child: Text('Notifications settings',
                                        style: AppCss.blue16semibold),
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      color: AppColors.DEEP_BLUE, size: 30),
                                  selected: true,
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     type: PageTransitionType.fade,
                                    //     child: NotificationSetting(),
                                    //   ),
                                    // );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 17),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("GEMINI details",
                                style: AppCss.blue18semibold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),                       
                        boxShadow: [
                          BoxShadow(
                          color: AppColors.SHADOWCOLOR,
                          spreadRadius: 0,
                            blurRadius: 7,
                           offset: Offset(0, 4),
                          )
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
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFFEBEBEB))),
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
                                      title: Text('About GEMINI',
                                          style: AppCss.blue16semibold),
                                      trailing: Icon(
                                          Icons.keyboard_arrow_right,
                                          color: AppColors.DEEP_BLUE,
                                          size: 30),
                                      selected: true,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: About(),
                                          ),
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
                                    title: Text('About the team',
                                        style: AppCss.blue16semibold),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: AppColors.DEEP_BLUE, size: 30),
                                    selected: true,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: AboutTeam(),
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
                                    title: Text('Contact us',
                                        style: AppCss.blue16semibold),
                                    trailing: Icon(Icons.keyboard_arrow_right,
                                        color: AppColors.DEEP_BLUE, size: 30),
                                    selected: true,
                                    onTap: () {
                                      Navigator.pushNamed(context, "/contact");
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
                                    title: Text('Terms & Conditions',
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
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20, right: 20,bottom: 20),
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
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
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              Container(
                                child: ListTile(
                                  title: Text('Sign out',style: AppCss.blue16semibold),
                                 trailing: SvgPicture.asset('assets/images/logout.svg',width: 20,height: 20,),
                                  selected: true,
                                  onTap: () {
                                    logOut();
                                  },
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
