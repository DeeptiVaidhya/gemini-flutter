import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';

class CreateMessages extends StatefulWidget {
  final String userId;
  const CreateMessages({Key? key, required this.userId}) : super(key: key);
  @override
  _CreateMessagesState createState() => _CreateMessagesState();
}
class _CreateMessagesState extends State<CreateMessages> {
  var currentSelectedValue;
  final _key = new GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormFieldState> _msgTextFormKey = GlobalKey<FormFieldState>();
  var msgText;

  void initState() {  
    //WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    super.initState();
  }

  submitMessage() async {
    loader(context, _keyLoader); //invoking login
    final data = await sendMessage(<String, dynamic>{
      "receiver_user_id": widget.userId,
      "message": _msgTextFormKey.currentState!.value,
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();             
        var url="/messages/"; 
        Navigator.pushNamed(context, url);
      });
      toast(data['msg']);
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
        Navigator.pushNamed(context, '/home');
        errortoast(data['msg']);
      }	
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
          headingtext = 'Messagess',
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
                    margin: EdgeInsets.only(top:235,bottom: 241),
                    child: Text("Create\nfirst message…",style: AppCss.blue20semibold,textAlign: TextAlign.center,),
                  )
                ],
                ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
           constraints: BoxConstraints(
                maxWidth: 375,
              ),
          child: Form(
              key: _key,
              child: Container(
                margin: EdgeInsets.only(top:10,bottom:20,left: 20,right: 20),
                child: Container(
                  height: 44,                
                  child: TextFormField(
                    key: _msgTextFormKey,
                     onSaved: (e) => msgText = e!,
                      style: AppCss.grey12regular,
                      onChanged: (value) {
                        //var isValid = value.length > 0;
                        //replyText = value;
                        //onReplyChange(replyOnPostId, replyText, isValid); 
                      },
                      //onSaved: (e) => value = e!,
                      decoration: InputDecoration(
                        contentPadding:EdgeInsets.only(left: 11.57, top: 10, bottom: 9),
                        hintText: 'Write your message',
                        hintStyle: AppCss.mediumgrey12light,
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(color: AppColors.LIGHT_GREY),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: AppColors.LIGHT_GREY),
                        ),
                        suffixIcon: Container(
                          padding: EdgeInsets.fromLTRB(0, 6.46, 6.0, 5.98),
                          width: 32,
                          height: 32,
                          child: MaterialButton(
                            shape: CircleBorder(),
                            color: AppColors.LIGHT_GREY,
                            padding: EdgeInsets.fromLTRB(7, 9, 9, 8),
                            onPressed: () {
                              submitMessage();
                            },
                            child: Image.asset('assets/images/icons/send/send.png',width: 15.0,height: 12.5,
                            color: AppColors.PRIMARY_COLOR),
                          )))),
                ),
              ),
            ),
        ),        
        ),
    ]);
  }
}
