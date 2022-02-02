import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
class MessagesDetails extends StatefulWidget {
  final String buddy_user_id;
  const MessagesDetails({Key? key,required this.buddy_user_id}) : super(key: key);
  @override
  _MessagesDetailsState createState() => _MessagesDetailsState();
}


class _MessagesDetailsState extends State<MessagesDetails> {
  var currentSelectedValue;
  final _key = new GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormFieldState> _msgTextFormKey = GlobalKey<FormFieldState>();
  var msgText;
  var msgList = [];

  void initState() { 
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    chatData(); 
    super.initState();
  }

  Future<void> chatData() async {
    try {
      final data = await messageDetails(<String, dynamic>{
        "receiver_user_id": widget.buddy_user_id,
      });
      if (data['status'] == "success") {
        setState(() {          
            Navigator.of(context, rootNavigator: true).pop();
            msgList = data['data']['buddy_messages'];
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

  submitMessage() async {
    loader(context, _keyLoader); //invoking login
    final data = await sendMessage(<String, dynamic>{
      "receiver_user_id": widget.buddy_user_id,
      "message": _msgTextFormKey.currentState!.value,
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();  
        var buddy_user_id = isVarEmpty(widget.buddy_user_id);                
        var url="/message-details/$buddy_user_id";                              
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute( 
          settings:  RouteSettings(name:url),
          builder: (context) => new MessagesDetails(
            buddy_user_id : buddy_user_id,
            ) 
          )
        );
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
                      padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 20,top:22),
                      child: ListView.builder(
                        itemCount: msgList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              (msgList[index]['date'] !=null)  ? Text(dateTimeFormate(msgList[index]['date']),style: AppCss.mediumgrey10bold) : Container(),
                              (msgList[index]['message'] !=null)  ?
                              Container(
                                padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                                child: Align(
                                  alignment: (msgList[index]['message_format'] == "message_recieved" ? Alignment.topLeft: Alignment.topRight),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:(msgList[index]['message_format'] == "message_recieved") ? AppColors.PRIMARY_COLOR:AppColors.DEEP_GREEN,
                                    ),
                                    padding: EdgeInsets.only(left: 11,right: 9,top: 11,bottom: 11),
                                    child: (msgList[index]['message_format'] == "message_recieved") ?
                                    (msgList[index]['message'] !=null)  ? Text(msgList[index]['message'], style: AppCss.grey12regular) : Container() 
                                    : 
                                    (msgList[index]['message'] !=null)  ? Text(msgList[index]['message'], style: AppCss.white12regular) : Container() 
                                  ),
                                ),
                              ) : Container()
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: 375,
          child: Form(
              key: _key,
              child: Container(
                 constraints: BoxConstraints(
                  maxWidth: 375,
                ),
                margin: EdgeInsets.only(top:10,bottom:20,left: 20,right: 20),
                child: Container(
                  width: 375,
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
