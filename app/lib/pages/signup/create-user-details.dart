import 'package:flutter/material.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';

class CreateUserDetails extends StatefulWidget {
  final String fname;
  final String lname;
  final String email;
  final String accessCode;
  final String timeZone;
  final String phoneNumber;

  CreateUserDetails(
      {Key? key,
      required this.fname,
      required this.lname,
      required this.email,
      required this.accessCode,
      required this.phoneNumber,
      required this.timeZone})
      : super(key: key);
  @override
  _CreateUserDetailsState createState() => _CreateUserDetailsState();
}

class _CreateUserDetailsState extends State<CreateUserDetails> {
  // final LocalStorage storage = new LocalStorage('gemini');
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _key = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _usernameFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _confirmPasswordFormKey =
      GlobalKey<FormFieldState>();
  var username, password, conformpassword;
  bool _securePasswordText = true;
  bool _secureConformPasswordText = true;
  bool _isSubmitButtonEnabled = false;

  bool _isUsernameDoneIconEnabled = false;
  bool _isPasswordDoneIconEnabled = false;
  bool _isConformPasswordDoneIconEnabled = false;

  bool _isPasswordEightCharacter = false;
  bool _isPasswordSpace = false;
  bool _isPasswordUppercase = false;
  bool _isPasswordLowercase = false;
  bool _isPasswordNumber = false;
  bool _isPasswordSpecialsymbol = false;
  bool _isLabelUserName = false;
  bool _isLabelPassword = false;
  bool _isLabelConformPassword = false;
  late FocusNode focusNode;
  bool _isFormFieldValid() {
    return ((_usernameFormKey.currentState!.isValid &&
        _passwordFormKey.currentState!.isValid &&
        _confirmPasswordFormKey.currentState!.isValid));
  }

  bool _isUsernameFormFieldValid() {
    return ((_usernameFormKey.currentState!.isValid));
  }

  bool _isPasswordFormFieldValid() {
    return ((_passwordFormKey.currentState!.isValid));
  }

  bool _isConformPasswordFormFieldValid() {
    return ((_confirmPasswordFormKey.currentState!.isValid));
  }

  bool _isPasswordEightCharacterValid() {
    if (_passwordFormKey.currentState!.value.length > 7) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPasswordSpaceValid() {
    if (_passwordFormKey.currentState!.value.length > 0) {
      if (_passwordFormKey.currentState!.value.indexOf(' ') >= 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool _isPasswordUppercaseValid() {
    if (_passwordFormKey.currentState!.value.length > 0) {
      return _passwordFormKey.currentState!.value.contains(RegExp(r'[A-Z]'));
    } else {
      return false;
    }
  }

  bool _isPasswordLowercaseValid() {
    if (_passwordFormKey.currentState!.value.length > 0) {
      return _passwordFormKey.currentState!.value.contains(RegExp(r'[a-z]'));
    } else {
      return false;
    }
  }

  bool _isPasswordNumberValid() {
    if (_passwordFormKey.currentState!.value.length > 0) {
      return _passwordFormKey.currentState!.value.contains(RegExp(r'[0-9]'));
    } else {
      return false;
    }
  }

  bool _isPasswordSpecialsymbolValid() {
    if (_passwordFormKey.currentState!.value.length > 0) {
      return _passwordFormKey.currentState!.value
          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    } else {
      return false;
    }
  }

  bool _isLabelUserNameValid() {
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

  bool _isLabelConformPasswordValid() {
    if (_confirmPasswordFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();
    // listen to focus changes
    focusNode.addListener(() => {
          if (!focusNode.hasFocus && _usernameFormKey.currentState!.isValid)
            {_checkUsernameFields()}
        });
  }

  _checkUsernameFields() async {
    final data = await checkEntryExistence(<String, dynamic>{
      "key": "username",
      "value": _usernameFormKey.currentState!.value,
      "check_overall": "1",
    });
    if (data['status'] == "error") {
      errortoast(data['msg']);
      setState(() {
        _isLabelUserName = false;
        _isUsernameDoneIconEnabled = false;
        _usernameFormKey.currentState?.reset();
      });
    }
  }

  passwordShowHide() {
    setState(() {
      _securePasswordText = !_securePasswordText;
    });
  }

  conformPasswordShowHide() {
    setState(() {
      _secureConformPasswordText = !_secureConformPasswordText;
    });
  }

  _submit() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      signupdata();
    }
  }

  signupdata() async {
    loader(context, _keyLoader); //invoking login
    final data = await signUp(<String, dynamic>{
      "first_name": widget.fname,
      "last_name": widget.lname,
      "email": widget.email,
      "username": username,
      "password": password,
      "confirm_password": conformpassword,
      "zip_code": widget.accessCode,
      "phone_number": widget.phoneNumber,
      "time_zone": widget.timeZone,
      "access_code" : widget.accessCode
    });
    if (data['status'] == "success") {
      toast(data['msg']);
      setState(() {
        // storage.setItem('userdata', jsonEncode(data));
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, '/signin');
      });
    } else {
      setState(() {
        //_key.currentState?.reset();
        //_isSubmitButtonEnabled = false;
        Navigator.of(context, rootNavigator: true).pop();
      });
      if (data['msg_format'] == "array") {
        data['msg'].forEach((key, value) => errortoast(value));
      } else {
        errortoast(data['msg']);
      }
    }
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
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
              '/signup',
              skiplink = false,
              '',
              headingtext = '', isMsgActive =false,         isNotificationActive=false,
              context),
          body: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                  Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 24, bottom: 16, left: 20, right: 20),
                          child: Text(
                            "Create user details",
                            style: AppCss.blue26semibold,
                          ),
                        ),
                        //card for Email TextFormField
                        Container(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 18, bottom: 5, right: 18),
                              child: Text(_isLabelUserName ? 'Username' : '',
                                  style: AppCss.grey10light,
                                  textAlign: TextAlign.left),
                            )),
                        Container(
                          width: 500,
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 13, left: 18, right: 18),
                          child: TextFormField(
                            focusNode: focusNode,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _usernameFormKey,
                            validator: MultiValidator(
                                [RequiredValidator(errorText: '')]),
                            onChanged: (value) {
                              setState(() {
                                _usernameFormKey.currentState!.validate();
                                _isUsernameDoneIconEnabled =
                                    _isUsernameFormFieldValid();
                                _isLabelUserName = _isLabelUserNameValid();
                                _isSubmitButtonEnabled = _isFormFieldValid();
                              });
                            },
                            onSaved: (e) => username = e!,
                           style: AppCss.grey12regular,
                            decoration: InputDecoration(
                              errorStyle:AppCss.red10regular,
                              filled: true,
                              fillColor: AppColors.PRIMARY_COLOR,
                              hintText: "Create a username",
                               hintStyle: AppCss.mediumgrey12regular,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff666666), width: 0.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff666666), width: 0.0),
                              ),
                              suffixIcon: _isUsernameDoneIconEnabled
                                  ? Icon(Icons.done,
                                      color: AppColors.EMERALD_GREEN)
                                  : null,
                            ),
                          ),
                        ),
                        // Card for password TextFormField
                        Container(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 18, bottom: 5, right: 18),
                              child: Text(
                                  _isLabelPassword
                                      ? 'Password (8+ characters)'
                                      : '',
                                  style: AppCss.grey10light,
                                  textAlign: TextAlign.left),
                            )),
                        Container(
                          width: 500,
                          padding: const EdgeInsets.only(
                              top: 0, left: 18, bottom: 13, right: 18),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _passwordFormKey,
                            validator: MultiValidator([
                              RequiredValidator(errorText: ""),
                              MinLengthValidator(8, errorText: ""),
                              PatternValidator(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                  errorText: "")
                            ]),
                            onChanged: (value) {
                              setState(() {
                                _passwordFormKey.currentState!.validate();
                                _isPasswordDoneIconEnabled =
                                    _isPasswordFormFieldValid();
                                _isPasswordEightCharacter =
                                    _isPasswordEightCharacterValid();
                                _isPasswordSpace = _isPasswordSpaceValid();
                                _isPasswordUppercase =
                                    _isPasswordUppercaseValid();
                                _isLabelPassword = _isLabelPasswordValid();
                                _isPasswordLowercase =
                                    _isPasswordLowercaseValid();
                                _isPasswordNumber = _isPasswordNumberValid();
                                _isPasswordSpecialsymbol =
                                    _isPasswordSpecialsymbolValid();
                                _isSubmitButtonEnabled = _isFormFieldValid();
                              });
                            },
                            obscureText: _securePasswordText,
                            onSaved: (e) => password = e!,
                            style: _securePasswordText ? TextStyle(fontSize: 20,color: AppColors.DEEP_GREY,height:1.0) :AppCss.grey12regular,
                            decoration: InputDecoration(
                              errorStyle:AppCss.red10regular,
                              filled: true,
                              fillColor: AppColors.PRIMARY_COLOR,
                              hintText: "Create a password",
                               hintStyle: AppCss.mediumgrey12regular,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff666666), width: 0.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff666666), width: 0.0),
                              ),
                              suffixIcon: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // added line
                                mainAxisSize: MainAxisSize.min, // added line
                                children: <Widget>[
                                  Icon(
                                      _isPasswordDoneIconEnabled
                                          ? Icons.done
                                          : null,
                                      color: AppColors.EMERALD_GREEN),
                                  IconButton(
                                    onPressed: passwordShowHide,
                                    color: Color.fromRGBO(38, 62, 114, 1),
                                    icon: _securePasswordText ? Icon(GeminiIcon.invisible_password,size: 17, color: AppColors.DEEP_BLUE) : Icon(GeminiIcon.visible_password,size: 13, color: AppColors.DEEP_BLUE),
                                  )
                                ],
                              ),

                              ///contentPadding: EdgeInsets.all(18),
                            ),
                          ),
                        ),
                        Container(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 18, bottom: 5, right: 18),
                              child: Text(
                                  _isLabelConformPassword
                                      ? 'Confirm Password'
                                      : '',
                                  style: AppCss.grey10light,
                                  textAlign: TextAlign.left),
                            )),
                        Container(
                          width: 500,
                          padding: const EdgeInsets.only(
                              top: 0, left: 18, bottom: 13, right: 18),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            key: _confirmPasswordFormKey,
                            validator: MultiValidator([
                              RequiredValidator(errorText: ""),
                              MinLengthValidator(8, errorText: ""),
                              PatternValidator(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                  errorText: "")
                            ]),
                            onChanged: (value) {
                              setState(() {
                                _confirmPasswordFormKey.currentState!.validate();
                                _isConformPasswordDoneIconEnabled =
                                    _isConformPasswordFormFieldValid();
                                _isLabelConformPassword =
                                    _isLabelConformPasswordValid();
                                _isSubmitButtonEnabled = _isFormFieldValid();
                              });
                            },
                            obscureText: _secureConformPasswordText,
                            onSaved: (e) => conformpassword = e!,
                            style: _secureConformPasswordText ? TextStyle(fontSize: 20,color: AppColors.DEEP_GREY,height:1.0) :AppCss.grey12regular,
                            decoration: InputDecoration(
                              errorStyle:AppCss.red10regular,
                              filled: true,
                              fillColor: AppColors.PRIMARY_COLOR,
                              hintText: "Enter password again",
                               hintStyle: AppCss.mediumgrey12regular,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff666666), width: 0.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff666666), width: 0.0),
                              ),
                              suffixIcon: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // added line
                                mainAxisSize: MainAxisSize.min, // added line
                                children: <Widget>[
                                  Icon(
                                      _isConformPasswordDoneIconEnabled
                                          ? Icons.done
                                          : null,
                                      color: AppColors.EMERALD_GREEN),
                                  IconButton(
                                    onPressed: conformPasswordShowHide,
                                    color: Color.fromRGBO(38, 62, 114, 1),
                                     icon: _secureConformPasswordText ? Icon(GeminiIcon.invisible_password,size: 17, color: AppColors.DEEP_BLUE) : Icon(GeminiIcon.visible_password,size: 13, color: AppColors.DEEP_BLUE),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            width: 500,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Text('Your password should be',
                                        textAlign: TextAlign.start,
                                        style: AppCss.grey10light),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordEightCharacter
                                            ? Icon(Icons.done,
                                                size: 10,
                                                color: AppColors.EMERALD_GREEN)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('8 characters or more',
                                          style: AppCss.grey10light),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordSpace
                                            ? Icon(Icons.done,
                                                size: 10,
                                                color: AppColors.EMERALD_GREEN)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('No spaces',
                                          style: AppCss.grey10light),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordUppercase
                                            ? Icon(Icons.done,
                                                size: 10,
                                                color: AppColors.EMERALD_GREEN)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('1 uppercase letter',
                                          style: AppCss.grey10light),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordLowercase
                                            ? Icon(Icons.done,
                                                size: 10,
                                                color: AppColors.EMERALD_GREEN)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('1 lowercase letter',
                                          style: AppCss.grey10light),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordSpecialsymbol
                                            ? Icon(Icons.done,
                                                size: 10,
                                                color: AppColors.EMERALD_GREEN)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('1 symbol (!@£%^&*)',
                                          style: AppCss.grey10light),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 38),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordNumber
                                            ? Icon(Icons.done,
                                                size: 10,
                                                color: AppColors.EMERALD_GREEN)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('1 number',
                                          style: AppCss.grey10light),
                                    ]),
                                  )
                                ]),
                          ),
                        ),
                        buttion(
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
                                            .pushNamed("/login");
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
          )),
    ]);
  }
}
