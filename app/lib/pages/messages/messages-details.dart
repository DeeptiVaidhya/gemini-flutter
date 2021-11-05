import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';
class MessagesDetails extends StatefulWidget {
  final String messageContent;
  final String messageType;
  final String text;
  final String imagepath;
  final String type;
  const MessagesDetails({
    Key? key,
    required this.messageContent,
    required this.messageType, required this.text, required this.imagepath, required this.type
  }) : super(key: key);
  @override
  _MessagesDetailsState createState() => _MessagesDetailsState();
}


class _MessagesDetailsState extends State<MessagesDetails> {
  var currentSelectedValue;
  final _key = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _msgTextFormKey = GlobalKey<FormFieldState>();
  var msgText;

  void initState() {  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MessagesDetails> messages = [
      MessagesDetails(messageContent: "Lorem ipsum dolor", messageType: "receiver", imagepath: '', key: null, text: '', type: '',),
      MessagesDetails(messageContent: "Nulla quam nulla, euismod at libero vitae et", messageType: "sender",key: null, text: '', type: '', imagepath: '',),
      MessagesDetails(messageContent: "Suspendisse potenti. Aenean eget erat vel felis luctus pharetra ac ut sapien.", messageType: "receiver",imagepath: '', key: null, text: '', type: ''),
      MessagesDetails(messageContent: "Fusce turpi esta a", messageType: "sender",imagepath: '', key: null, text: '', type: ''),
      MessagesDetails(messageContent: "Lorem ipsum dolor sit amet, conse tetur sadipscing elitr, sed diam nonumy", messageType: "sender",imagepath: '', key: null, text: '', type: ''),
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
                maxWidth: 500,
              ),
              child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 20,top:22),
                      child: ListView.builder(
                        itemCount: messages.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return Container(
                            padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                            child: Align(
                              alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (messages[index].messageType  == "receiver"?AppColors.PRIMARY_COLOR:AppColors.DEEP_GREEN),
                                ),
                                padding: EdgeInsets.only(left: 11,right: 9,top: 11,bottom: 11),
                                child: messages[index].messageType  == "receiver" ? Text(messages[index].messageContent, style: AppCss.grey12regular) : Text(messages[index].messageContent, style: AppCss.white12regular),
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
        bottomNavigationBar: Container(
          constraints: BoxConstraints(
            maxWidth: 500,
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
                              //submitMessage();
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
