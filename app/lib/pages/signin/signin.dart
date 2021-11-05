import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final LocalStorage storage = new LocalStorage('gemini');
  final _key = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _usernameFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey = GlobalKey<FormFieldState>();
  bool _isSubmitButtonEnabled = false;
  bool _incorrectPassword = false;
  late String username, password, code;
  bool _secureText = true;
  bool _isLabelPassword = false;
  bool _isLabelUsername = false;
  bool valuefirst = false;
  bool valuesecond = false;
  bool rememberme = false;

  bool _isFormFieldValid() {
    return ((_usernameFormKey.currentState!.isValid && _passwordFormKey.currentState!.isValid));
  }

  bool _isLabelUsernameValid() {
    if (_usernameFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelPasswordValid() {
    if (_passwordFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    if (storage.getItem('rememberme') != null) {
      rememberme = storage.getItem('rememberme');
      _isSubmitButtonEnabled = true;
    }
    super.initState();
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  _submitLogin() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      signindata();
    }
  }

  Future<void> signindata() async {
    try{
    loader(context, _keyLoader); //invoking login
    final data = await signIn(<String, dynamic>{
      "username": username,
      "password": password,
    });
    if (data['status'] == "success") {
      setState(() {
        if (rememberme) {
          storage.setItem('username', username);
          storage.setItem('password', password);
          storage.setItem('rememberme', rememberme);
        } else {
          storage.clear();
        }
        storage.setItem('token', data['token']);
        storage.setItem('name', data['name']);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, '/home');
      });
      toast(data['msg']);
    } else {
      if(data['status'] == "error" && data['show_msg_type'] == "label")  {
        setState(() {
          _key.currentState?.reset();
          Navigator.of(context, rootNavigator: true).pop();        
        });
        _incorrectPassword = true;        
      }else{
        setState(() {
          _key.currentState?.reset();
          _isSubmitButtonEnabled = false;
          Navigator.of(context, rootNavigator: true).pop();        
        });
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
            logedin = false,
            back = true,
            logo = true,
            skip = false,
            backlink = true,
            '/',
            skiplink = false,
            '',
            headingtext = '', 
            isMsgActive =false, 
            isNotificationActive=false,
            context
          ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:const EdgeInsets.fromLTRB(20, 24.32, 20, 0),
                      child:Text("Sign in to GEMINI",style:AppCss.blue26semibold,textAlign:TextAlign.center
                      ),
                    ),
                    Container(
                      width: 500,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 18, bottom: 5, right: 18),
                        child: Text(_isLabelUsername? 'Email address or phone number': '',
                        style: AppCss.grey10light,textAlign: TextAlign.left),
                    )),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.only(top: 0, left: 18, right: 18),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                        ],
                        initialValue: (storage.getItem('username') != null)
                            ? storage.getItem('username')
                            : null,
                        key: _usernameFormKey,                        
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: AppColors.MEDIUM_GREY2,
                        validator: MultiValidator([
                          RequiredValidator(errorText:'Username or Email Address field is required'),
                        ]),
                        onChanged: (value) {
                          setState(() {
                            _usernameFormKey.currentState!.validate();
                            _isSubmitButtonEnabled = _isFormFieldValid();
                            _isLabelUsername = _isLabelUsernameValid();
                          });
                        },
                        onSaved: (e) => username = e!,
                        style: AppCss.grey12regular,
                        decoration: InputDecoration(
                          errorStyle:AppCss.red10regular,
                          filled: true,
                          fillColor: AppColors.PRIMARY_COLOR,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.MEDIUM_GREY1, width: 0.0),
                          ),
                          hintText: "Email address or phone number",
                          hintStyle: AppCss.mediumgrey12regular,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.MEDIUM_GREY1, width: 0.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 18, bottom: 5, right: 18),
                        child: Text(_isLabelPassword ? 'Password' : '',style: AppCss.grey10light,
                        textAlign: TextAlign.left),
                    )),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.only(top: 0,left: 18, right: 18),
                      child: TextFormField(
                        obscuringCharacter: "•",
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                        ],
                        initialValue: (storage.getItem('password') != null)? storage.getItem('password')
                        : null,
                        key: _passwordFormKey,
                        cursorColor: AppColors.MEDIUM_GREY2,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Password filed is required"),
                          MinLengthValidator(8,errorText:"Password must be at least 8 digits long"),
                          PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          errorText:"Passwords must have at least one capital,numeric and special character")
                        ])                        ,
                        obscureText: _secureText,
                        onChanged: (value) {
                          setState(() {
                            _passwordFormKey.currentState!.validate();
                            _isSubmitButtonEnabled = _isFormFieldValid();
                            _isLabelPassword = _isLabelPasswordValid();
                          });
                        },
                        onSaved: (e) => password = e!,
                        style: AppCss.grey12regular,
                        decoration: InputDecoration(
                          errorStyle:AppCss.red10regular,
                          filled: true,
                          fillColor: AppColors.PRIMARY_COLOR,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.MEDIUM_GREY1, width: 0.0),
                          ),
                          hintText: "Password",
                          hintStyle: AppCss.mediumgrey12regular,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.MEDIUM_GREY1, width: 0.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            color: AppColors.DEEP_BLUE,
                            icon: _secureText ? Icon(GeminiIcon.invisible_password,size: 17, color: AppColors.DEEP_BLUE) : Icon(GeminiIcon.visible_password,size: 13, color: AppColors.DEEP_BLUE),
                          ),
                        ),
                      ),
                    ),
                    _incorrectPassword ? Container(
                      width: 500,
                      padding: const EdgeInsets.fromLTRB(20, 8, 20,1),
                      child: Text("You’ve entered an incorrect password. You have 9 attempts remaining.",style: AppCss.red10regular),
                    ) : Container(),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.only(left: 18,top: 15),
                      child: Row(
                        children: [
                          Container(                               
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(width: 2,
                                color: rememberme == true ? AppColors.EMERALD_GREEN: AppColors.LIGHT_GREY,
                              ),
                            ),
                            width: 21,
                            height: 21,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                checkColor: AppColors.EMERALD_GREEN,
                                activeColor: Colors.transparent,
                                value: rememberme,
                                tristate: false,
                                onChanged: (value) {
                                  setState(() => rememberme = value!);
                                },
                              ),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text('Remember me',style: AppCss.grey12medium),
                        )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 205),
                      child: buttion(
                          btnwidth = 295,
                          btnheight = 44,
                          btntext = 'LOG IN',
                          _isSubmitButtonEnabled
                              ? AppCss.blue14bold
                              : AppCss.white14bold,
                          _isSubmitButtonEnabled
                              ? AppColors.LIGHT_ORANGE
                              : AppColors.LIGHT_GREY,
                          btntypesubmit = true,
                          _isSubmitButtonEnabled
                              ? () {
                                  _submitLogin();
                                }
                              : null,
                          12,
                          12,
                          30,
                          29,
                          context)
                      ),
                      Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 34),
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Forgot your password? ',
                                    style: AppCss.grey12regular),
                                TextSpan(
                                    text: 'Reset it.',
                                    style: AppCss.green12regular,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed( context,"/forgot-password"); 
                                      }),
                              ],
                            )),
                      ),
                    ),
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
