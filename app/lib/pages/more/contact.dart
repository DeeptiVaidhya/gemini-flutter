import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gemini/pages/more/contact-thanks.dart';
import 'package:gemini/pages/more/more.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:page_transition/page_transition.dart';

class Contact extends StatefulWidget {
  @override
  __ContactState createState() => __ContactState();
}

class __ContactState extends State<Contact> {
  final _contactkey = new GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormFieldState> _nameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailaddKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneNoKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _msgKey = GlobalKey<FormFieldState>();
  late String name, email, phoneno, msg;
  bool _isNextButtonEnabled = false;
  bool isPhoneNumber = false;
  bool isEmail = false;

  bool _isFormFieldValid() {    
    if (_nameKey.currentState!.value.length > 0 && _msgKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelEmailValid() {
    if (_emailaddKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelPhoneNumberValid() {
    if (_phoneNoKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  submit() async {
    loader(context, _keyLoader); //invoking login
    final data = await contactUs(<String, dynamic>{
      "name": _nameKey.currentState!.value,
      "email": _emailaddKey.currentState!.value,
      "message": _msgKey.currentState!.value,
      "phone_number": _phoneNoKey.currentState!.value,
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();        
      });
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ContactThanks(),
        ),
      );
      toast(data['msg']);
    } else {      
      if (data['is_valid'] == false) {	
        setState(() {	
          Navigator.of(context, rootNavigator: true).pop();	
        });
        Navigator.pushNamed(context, '/signin');
      } else {
        if(data['status'] == "error" && data['email']){
          setState(() {	
            Navigator.of(context, rootNavigator: true).pop();	
          });
          Navigator.pushNamed(context, '/contact');
          errortoast(data['msg']);
        }else{
          setState(() {	
            Navigator.of(context, rootNavigator: true).pop();	
          });
          Navigator.pushNamed(context, '/home');
          errortoast(data['msg']);
        }
        
      }
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
              skip = true,
              backlink = true,
              '/more',
              skiplink = false,
              '/',
              headingtext = 'Contact', 
              isMsgActive =false,    
              isNotificationActive=false,
              context),
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                        maxWidth: 500,
                      ),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Container(
                      
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: _contactkey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:30.0),
                              child: Container(
                                width: 500,
                                padding: EdgeInsets.only(top: 10, left: 18, bottom: 10, right: 18),
                                child: TextFormField(
                                  key: _nameKey,
                                  cursorColor: AppColors.MEDIUM_GREY2,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Name field is required'),
                                  ]),
                                  style: AppCss.grey12regular,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.PRIMARY_COLOR,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.MEDIUM_GREY1, width: 0.0),
                                    ),
                                    contentPadding: EdgeInsets.all(8),
                                    hintText: "Your name",
                                    hintStyle: AppCss.mediumgrey12light,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.MEDIUM_GREY1, width: 0.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _isNextButtonEnabled = _isFormFieldValid();
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 500,
                              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              padding: EdgeInsets.only(
                                  top: 10, left: 18, bottom: 10, right: 18),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                key: _emailaddKey,
                                cursorColor: AppColors.MEDIUM_GREY2,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: ''),
                                  EmailValidator(errorText: '')
                                ]),
                                onSaved: (e) => email = e!,
                                onChanged: (value) {
                                  setState(() {
                                    _emailaddKey.currentState!.validate();
                                    isEmail = _isLabelEmailValid();
                                    _isNextButtonEnabled = _isFormFieldValid();
                                  });
                                },
                                style: AppCss.grey12light,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.PRIMARY_COLOR,
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Your email address",
                                  hintStyle: AppCss.mediumgrey12light,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1, width: 0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1, width: 0.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 500,
                              padding: EdgeInsets.only(top: 10, left: 18, bottom: 10, right: 18),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                key: _phoneNoKey,
                                cursorColor: AppColors.MEDIUM_GREY2,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                                autocorrect: true,
                                validator: MultiValidator([
                                  MinLengthValidator(10, errorText: ''),
                                  PatternValidator(r'^(?:[+0][1-9])?[0-9]{10,12}$',errorText: '')
                                ]),
                                style: AppCss.grey12regular,
                                onChanged: (value) {
                                  setState(() {
                                    _phoneNoKey.currentState!.validate();
                                    isPhoneNumber =_isLabelPhoneNumberValid();
                                    _isNextButtonEnabled = _isFormFieldValid();
                                  });
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.PRIMARY_COLOR,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.MEDIUM_GREY1, width: 0.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Your phone number",
                                  hintStyle: AppCss.mediumgrey12light,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1, width: 0.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 500,
                              padding: EdgeInsets.only(top: 10, left: 18, bottom: 10, right: 18),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 8,
                                key: _msgKey,
                                cursorColor: AppColors.MEDIUM_GREY2,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: 'Text field is required'),
                                ]),
                                style: AppCss.grey12regular,
                                onChanged: (value) {
                                    setState(() {
                                      _isNextButtonEnabled = _isFormFieldValid();
                                    });
                                  },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.PRIMARY_COLOR,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1, width: 0.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Please enter your message here",
                                  hintStyle: AppCss.mediumgrey12light,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1, width: 0.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: buttion(
                                    btnwidth = 295,
                                    btnheight = 44,
                                    btntext = 'Send my message'.toUpperCase(),
                                    _isNextButtonEnabled
                                        ? AppCss.blue14bold
                                        : AppCss.white14semibold,
                                    _isNextButtonEnabled
                                        ? AppColors.LIGHT_ORANGE
                                        : AppColors.LIGHT_GREY,
                                    btntypesubmit = true,
                                    _isNextButtonEnabled
                                    ? () {submit();}
                                    : null,12,12,77,77,
                                    context)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top:24,bottom: 40),
                        child: MaterialButton(
                          onPressed: () {               
                            var url="/more";                              
                            Navigator.of(context).pushReplacement(
                              new MaterialPageRoute( 
                              settings:  RouteSettings(name:url),
                              builder: (context) => new More(
                              ) 
                              )
                            );
                          },
                          child: Text("Cancel",style: AppCss.green12semibold,textAlign: TextAlign.center),
                        ),
                      ),
                  ])),
            ),
          )),
      ],
    );
  }
}
