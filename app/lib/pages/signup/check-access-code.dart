import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini/pages/signup/create-your-account.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:page_transition/page_transition.dart';

class CheckAccessCode extends StatefulWidget {
  @override
  _CheckAccessCodeState createState() => _CheckAccessCodeState();
}

class _CheckAccessCodeState extends State<CheckAccessCode> {
  
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final LocalStorage storage = new LocalStorage('gemini');
  final LocalStorage storageAccessCode = new LocalStorage('gemini-accesscode');
  final LocalStorage storageCreateAccount = new LocalStorage('gemini-create-account');

  final _key = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _accesscodeFormKey =
      GlobalKey<FormFieldState>();
  var  accessCode;
  bool _secureText = true;
  bool _isAccessCodeDoneIconEnabled = false;
  bool _isNextButtonEnabled = false;

  bool _isFormFieldValid() {
    return ((_accesscodeFormKey.currentState!.isValid));
  }

  bool _isAccessCodeFormFieldValid() {
    return ((_accesscodeFormKey.currentState!.isValid));
  }

  @override
  void initState() {
    storageCreateAccount.clear();
    if (storageAccessCode.getItem('title') != null) {
      _isNextButtonEnabled = true;
    }
    super.initState();
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  _submitLogin() {
    storageAccessCode.setItem('accessCode', _accesscodeFormKey.currentState!.value);	
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      signindata();
    }
  }

  signindata() async {
    loader(context, _keyLoader); //invoking login
    final data = await checkAccessCode(<String, dynamic>{"access_code": accessCode});
    if (data['status'] == "success") {
      setState(() {
        //storage.setItem('userdata', jsonEncode(data));
        Navigator.of(context, rootNavigator: true).pop();
        toast(data['msg']);
        Navigator.pushNamed(context, '/signup');
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: CreateYourAccount(accessCode: accessCode, key: null,),
          ),
        );
      });
    } else {
      setState(() {
        _key.currentState?.reset();
        _isNextButtonEnabled = false;
        _isAccessCodeDoneIconEnabled = false;
        Navigator.of(context, rootNavigator: true).pop();
      });
      errortoast(data['msg']);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: header(
            logedin = false,
            back = true,
            logo = true,
            skip = false,
            backlink = true,
            '/',
            skiplink = false,
            '',
            headingtext = '', isMsgActive =false,         isNotificationActive=false,
            context),
        body: Container(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 375,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Form(
                          key: _key,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:const EdgeInsets.fromLTRB(20, 24.32, 20, 0),
                                child: Text("Enter your access code",style: AppCss.blue26semibold,textAlign: TextAlign.center),
                              ),
                              Padding(
                                padding:const EdgeInsets.fromLTRB(30, 32, 30, 87),
                                child: Text("Please enter your one-time access code that you were given when you signed up for GEMINI",style: AppCss.grey14regular,textAlign: TextAlign.center),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                                child: TextFormField(
                                  key: _accesscodeFormKey,
                                  autovalidateMode:AutovalidateMode.onUserInteraction,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                                  ],
                                  cursorColor: AppColors.MEDIUM_GREY2,
                                  initialValue:(storageAccessCode.getItem('accessCode') != null)	
                                  ? storageAccessCode.getItem('accessCode'): null,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                            'Access code field is required')
                                  ]),
                                  onChanged: (value) {
                                    setState(() {
                                      _accesscodeFormKey.currentState!
                                          .validate();
                                      _isAccessCodeDoneIconEnabled =
                                          _isAccessCodeFormFieldValid();
                                      _isNextButtonEnabled =
                                          _isFormFieldValid();
                                    });
                                  },
                                  onSaved: (e) => accessCode = e!,
                                  style: AppCss.grey12regular,
                                  decoration: InputDecoration(
                                    errorStyle:AppCss.red10regular,
                                    filled: true,
                                    fillColor: AppColors.PRIMARY_COLOR,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.MEDIUM_GREY1,
                                          width: 0.0),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Access code",
                                    hintStyle: AppCss.mediumgrey12regular,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.MEDIUM_GREY1,
                                          width: 0.0),
                                    ),
                                    suffixIcon: _isAccessCodeDoneIconEnabled
                                        ? Icon(Icons.done,
                                            color: AppColors.EMERALD_GREEN)
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 180),
                                child: buttion(
                                    btnwidth = 295,
                                    btnheight = 44,
                                    btntext = 'NEXT',
                                    _isNextButtonEnabled
                                        ? AppCss.blue14bold
                                        : AppCss.white14bold,
                                    _isNextButtonEnabled
                                        ? AppColors.LIGHT_ORANGE
                                        : AppColors.LIGHT_GREY,
                                    btntypesubmit = true,
                                    _isNextButtonEnabled
                                        ? () {
                                            _submitLogin();
                                          }
                                        : null,                                    
                                    13,
                                    13,
                                    73,
                                    72,
                                    context)
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 24, bottom: 34),
                                child: Container(
                                  width: 235,
                                  child: Row(
                                    children: [
                                      Text('Already have an account?',
                                          style: AppCss.grey12regular),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: InkWell(
                                            child: Text('Sign in',
                                                style: AppCss.green12regular),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/signin");
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            )),
      )
    ]);
  }
}
