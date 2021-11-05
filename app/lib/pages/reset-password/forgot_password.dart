import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  late String code;
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {  
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final LocalStorage storage = new LocalStorage('gemini');
  final _key = new GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _emailFormKey =
      GlobalKey<FormFieldState>();
  late String email; 
  bool _isLabelEmail = false;
  bool _isSubmitButtonEnabled = false;
  bool _isEmailDoneIconEnabled = false;
  late FocusNode focusNode;

  get code => null;
  bool _isFormFieldValid() {
    return ((_emailFormKey.currentState!.isValid));
  }

  bool _isEmailFormFieldValid() {
    return ((_emailFormKey.currentState!.isValid));
  }

  bool _isLabelEmailValid() {
    if (_emailFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  
  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();  
  }

  _submit() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      forgotPasswordData();
    }
  }

  forgotPasswordData() async {
    loader(context, _keyLoader); //invoking login
    final data = await forgotPassword(<String, dynamic>{
      "email": email
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, '/signin');
      });
      toast(data['msg']);
    } else {
      setState(() {
        _key.currentState?.reset();
        _isSubmitButtonEnabled = false;
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, '/forgot-password');
        
      });
      errortoast(data['msg']);
      errortoast(data['data']['email']);
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: header(
            logedin = false,
            back = false,
            logo = true,
            skip = false,
            backlink = false,
            '/',
            skiplink = false,
            '',
            headingtext = '', isMsgActive =false,         isNotificationActive=false,
            context
          ),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24, bottom: 16, left: 20, right: 20),
                      child: Text("Forgot Password",style: AppCss.blue26semibold),
                    ),
                    Container(
                        width: 500,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, left: 18, bottom: 5, right: 18),
                          child: Text(_isLabelEmail? 'Email': '',
                          style: AppCss.grey10light,textAlign: TextAlign.left),
                        )),
                    Container(
                      width: 500,
                      padding: EdgeInsets.only(
                          top: 0, left: 18, bottom: 13, right: 18),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                        ],
                        focusNode: focusNode,
                        autovalidateMode:AutovalidateMode.onUserInteraction,
                        key: _emailFormKey,
                        cursorColor: AppColors.MEDIUM_GREY2,
                        validator: MultiValidator([
                          RequiredValidator(errorText: ''),
                          EmailValidator(errorText: '')
                        ]),
                        onChanged: (value) {
                          setState(() {
                            _emailFormKey.currentState!.validate();
                            _isEmailDoneIconEnabled =
                                _isEmailFormFieldValid();
                            _isLabelEmail = _isLabelEmailValid();
                            _isSubmitButtonEnabled = _isFormFieldValid();
                          });
                        },
                        onSaved: (e) => email = e!,
                        style: AppCss.grey12regular,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.PRIMARY_COLOR,
                          hintText: "Email address",
                          hintStyle: AppCss.mediumgrey12regular,
                          suffixIcon: _isEmailDoneIconEnabled
                          ? Icon(Icons.done,color: AppColors.EMERALD_GREEN): null,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.MEDIUM_GREY1,
                                width: 0.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.MEDIUM_GREY1,
                                width: 0.0),
                          ),
                        ),
                      ),
                    ), 
                    Padding(
                      padding: const EdgeInsets.only(top: 105),
                      child:buttion(
                        btnwidth = 295,
                        btnheight = 44,
                        btntext = 'SUBMIT',
                        _isSubmitButtonEnabled
                            ? AppCss.blue14bold
                            : AppCss.white14bold,
                        _isSubmitButtonEnabled
                            ? AppColors.LIGHT_ORANGE
                            : AppColors.LIGHT_GREY,
                        btntypesubmit = true,
                        _isSubmitButtonEnabled
                            ? () {
                                _submit();
                              }
                            : null,
                        13,
                        13,
                        92,
                        91,
                        context),

                    ),
                   
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 24),
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
              ])),
        ),
        )
      ]
      );
  }
}
