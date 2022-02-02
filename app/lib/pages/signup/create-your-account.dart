import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/auth.dart';
import 'package:page_transition/page_transition.dart';
import 'create-user-details.dart';
import 'package:localstorage/localstorage.dart';

class CreateYourAccount extends StatefulWidget {
  final String accessCode;
  CreateYourAccount({Key? key, required this.accessCode}) : super(key: key);
  @override
  _CreateYourAccountState createState() => _CreateYourAccountState();
}

class _CreateYourAccountState extends State<CreateYourAccount> {
  final _key = new GlobalKey<FormState>();
  final LocalStorage storageCreateAccount = new LocalStorage('gemini-create-account');
  final GlobalKey<FormFieldState> _fnameFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lnameFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _timeZoneFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneNumberFormKey = GlobalKey<FormFieldState>();

  bool _isNextButtonEnabled = false;
  bool _isFnameDoneIconEnabled = false;
  bool _isLnameDoneIconEnabled = false;
  bool _isPhoneNumberDoneIconEnabled = false;
  bool _isEmailDoneIconEnabled = false;
  bool _isTimeZoneDoneIconEnabled = false;
  bool _isLabelFirstName = false;
  bool _isLabelLastName = false;
  bool _isLabelPhoneNumber = false;
  bool _isLabelEmail = false;
  bool _isLabelTimeZone = false;
  var timeZoneList = [];
  var currentSelectedValue;
  late FocusNode focusNode;
  var fname, lname, email, accessCode, phoneNumber;


  bool _isFormFieldValid() {
    // print(_fnameFormKey.currentState!.isValid);
    // print(_lnameFormKey.currentState!.isValid);    
    // print(_emailFormKey.currentState!.isValid);    
    //print(_timeZoneFormKey.currentState);    

    return (
      (
      _fnameFormKey.currentState!.isValid 
      && _lnameFormKey.currentState!.isValid 
      && _emailFormKey.currentState!.isValid 
      && _timeZoneFormKey.currentState!.isValid)
      );
  }

  bool _isFnameFormFieldValid() {
    return ((_fnameFormKey.currentState!.isValid));
  }

  bool _isLnameFormFieldValid() {
    return ((_lnameFormKey.currentState!.isValid));
  }

  bool _isPhoneNumberFormFieldValid() {
    return ((_phoneNumberFormKey.currentState!.isValid));
  }

  bool _isEmailFormFieldValid() {
    return ((_emailFormKey.currentState!.isValid));
  }

  bool _isTimeZoneFormFieldValid() {
    return ((_timeZoneFormKey.currentState!.isValid));
  }

  bool _isLabelFirstNameValid() {
    if (_fnameFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelLastNameValid() {
    if (_lnameFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelEmailValid() {
    if (_emailFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelPhoneNumberValid() {
    if (_phoneNumberFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelTimeZoneValid() {
    if (_timeZoneFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }


  @override
  void initState() {
    if (storageCreateAccount.getItem('fname') != null && storageCreateAccount.getItem('lname') != null && storageCreateAccount.getItem('email') != null && storageCreateAccount.getItem('phoneNumber') != null ) {
      _isNextButtonEnabled = true;
    }
    super.initState();
    focusNode = new FocusNode();
    // listen to focus changes
    focusNode.addListener(() => {
    if (!focusNode.hasFocus && _emailFormKey.currentState!.isValid)
      {
        _checkEmailFields()
      }
    });
    _timeZoneData();
  }

  _checkEmailFields() async {
    final data = await checkEntryExistence(<String, dynamic>{
      "key": "email",
      "value": isVarEmpty(_emailFormKey.currentState!.value),
      "check_overall": "1",
    });
    if (data['status'] == "success") {
      setState(() {     
      _isEmailDoneIconEnabled =true;
      });      
    }else{
      setState(() { 
        _isLabelEmail = false;
        _isEmailDoneIconEnabled = false;
        _emailFormKey.currentState?.reset();
      });
      errortoast(data['msg']);

    }
  }

  _timeZoneData() async {
    final data = await getTimeZone(<String, dynamic>{});
    if (data['status'] == "success") {
      setState(() {
        timeZoneList = data['data']['zones'];
      });
    }
  }

  _next() {
    storageCreateAccount.setItem('fname', _fnameFormKey.currentState!.value);	
    storageCreateAccount.setItem('lname', _lnameFormKey.currentState!.value);	
    storageCreateAccount.setItem('email', _emailFormKey.currentState!.value);
    storageCreateAccount.setItem('phoneNumber', _phoneNumberFormKey.currentState!.value);	

    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: CreateUserDetails(
            fname: isVarEmpty(fname),
            lname: isVarEmpty(lname),
            email: isVarEmpty(email),
            accessCode: isVarEmpty(widget.accessCode),
            phoneNumber: isVarEmpty(phoneNumber),
            timeZone: isVarEmpty(currentSelectedValue)
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (isVarEmpty(_emailFormKey.currentState) == null) {
      return Container();
    }

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
                '/create-access-code',
                skiplink = false,
                '',
                headingtext = '', isMsgActive =false,         isNotificationActive=false,
                context),
            body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                  Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24.32, 20, 0),
                          child: Text("Create your account",style: AppCss.blue26semibold,textAlign: TextAlign.center),
                        ),
                        Container(
                          width: 500,
                          child: Padding(padding: EdgeInsets.only(
                                top: 10, left: 18, bottom: 5, right: 18),
                            child: Text(_isLabelFirstName ? 'First Name' : '',style: AppCss.grey10light,textAlign: TextAlign.left),
                        )),
                        Container(
                          width: 500,
                          padding: EdgeInsets.only(
                              top: 0, left: 18, bottom: 13, right: 18),
                          child: TextFormField(
                            initialValue:(storageCreateAccount.getItem('fname') != null)	
                                ? storageCreateAccount.getItem('fname'): null,
                            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _fnameFormKey,
                            cursorColor: AppColors.MEDIUM_GREY2,
                            validator: MultiValidator([
                              RequiredValidator(errorText: ''),
                            ]),
                            onChanged: (value) {
                              setState(() {
                                _fnameFormKey.currentState!.validate();
                                _isFnameDoneIconEnabled =
                                    _isFnameFormFieldValid();
                                _isLabelFirstName = _isLabelFirstNameValid();
                                _isNextButtonEnabled = _isFormFieldValid();
                              });
                            },
                            onSaved: (e) => fname = e!,
                            style: AppCss.grey12regular,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorStyle:AppCss.red10regular,
                              filled: true,
                              fillColor: AppColors.PRIMARY_COLOR,
                              hintText: "First Name",
                              suffixIcon: _isFnameDoneIconEnabled
                                  ? Icon(Icons.done,
                                      color: AppColors.EMERALD_GREEN)
                                  : null,
                              hintStyle: AppCss.mediumgrey12regular,
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
                        Container(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 18, bottom: 5, right: 18),
                              child: Text(_isLabelLastName ? 'Last Name' : '',
                                  style: AppCss.grey10light,
                                  textAlign: TextAlign.left),
                            )),
                        Container(
                          width: 500,
                          padding: EdgeInsets.only(
                              top: 0, left: 18, bottom: 13, right: 18),
                          child: TextFormField(
                            initialValue:(storageCreateAccount.getItem('lname') != null)	
                                ? storageCreateAccount.getItem('lname'): null,
                            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                            autovalidateMode:AutovalidateMode.onUserInteraction,
                            key: _lnameFormKey,
                            cursorColor: AppColors.MEDIUM_GREY2,
                            autocorrect: true,
                            validator: MultiValidator([
                              RequiredValidator(errorText: ''),
                            ]),
                            onChanged: (value) {
                              setState(() {
                                _lnameFormKey.currentState!.validate();
                                _isLnameDoneIconEnabled =
                                    _isLnameFormFieldValid();
                                _isLabelLastName = _isLabelLastNameValid();
                                _isNextButtonEnabled = _isFormFieldValid();
                              });
                            },
                            onSaved: (e) => lname = e!,
                            style: AppCss.grey12regular,
                            keyboardType: TextInputType.text,
                            //textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              errorStyle:AppCss.red10regular,
                              filled: true,
                              fillColor: AppColors.PRIMARY_COLOR,
                              suffixIcon: _isLnameDoneIconEnabled
                                  ? Icon(Icons.done,
                                      color: AppColors.EMERALD_GREEN)
                                  : null,
                              hintText: "Last Name",
                              hintStyle: AppCss.mediumgrey12regular,
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
                        Container(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 18, bottom: 5, right: 18),
                              child: Text(
                                  _isLabelEmail ? 'Email address' : '',
                                  style: AppCss.grey10light,
                                  textAlign: TextAlign.left),
                            )),
                        Container(
                          width: 500,
                          padding: EdgeInsets.only(
                              top: 0, left: 18, bottom: 13, right: 18),
                          child: TextFormField(
                            initialValue:(storageCreateAccount.getItem('email') != null)	
                                ? storageCreateAccount.getItem('email'): null,
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
                                _isEmailDoneIconEnabled =_isEmailFormFieldValid();
                                _isLabelEmail = _isLabelEmailValid();
                                _isNextButtonEnabled = _isFormFieldValid();
                              });
                            },
                            onSaved: (e) => email = e!,
                            style: AppCss.grey12regular,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorStyle:AppCss.red10regular,
                              filled: true,
                              fillColor: AppColors.PRIMARY_COLOR,
                              hintText: "Email address",
                              hintStyle: AppCss.mediumgrey12regular,
                              suffixIcon: _isEmailDoneIconEnabled
                              ? Icon(Icons.done,color: AppColors.EMERALD_GREEN): Icon(Icons.done,color: AppColors.LIGHT_ORANGE),
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
                        Container(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 18, bottom: 5, right: 18),
                              child: Text(
                                  _isLabelPhoneNumber ? 'Phone Number' : '',
                                  style: AppCss.grey10light,
                                  textAlign: TextAlign.left),
                            )),
                        Container(
                          width: 500,
                          padding: EdgeInsets.only(
                              top: 0, left: 18, bottom: 13, right: 18),
                          child: TextFormField(
                            initialValue:(storageCreateAccount.getItem('phoneNumber') != null)	
                            ? storageCreateAccount.getItem('phoneNumber'): null,
                            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                            autovalidateMode:AutovalidateMode.onUserInteraction,
                            key: _phoneNumberFormKey,
                            cursorColor: AppColors.MEDIUM_GREY2,
                            autocorrect: true,
                            validator: MultiValidator([
                              MinLengthValidator(10, errorText: ''),
                              PatternValidator(
                                  r'^(?:[+0][1-9])?[0-9]{10,12}$',
                                  errorText: '')
                            ]),
                            onChanged: (value) {
                              setState(() {
                                _phoneNumberFormKey.currentState!.validate();
                                _isPhoneNumberDoneIconEnabled =
                                    _isPhoneNumberFormFieldValid();
                                _isLabelPhoneNumber =
                                    _isLabelPhoneNumberValid();
                                _isNextButtonEnabled = _isFormFieldValid();
                              });
                            },
                            onSaved: (e) => phoneNumber = e!,
                            style: AppCss.grey12regular,
                            keyboardType: TextInputType.text,
                            //textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              errorStyle:AppCss.red10regular,
                              filled: true,
                              fillColor: AppColors.PRIMARY_COLOR,
                              suffixIcon: _isPhoneNumberDoneIconEnabled
                                  ? Icon(Icons.done,
                                      color: AppColors.EMERALD_GREEN)
                                  : Icon(Icons.done,
                                      color: AppColors.PRIMARY_COLOR),
                              hintText: "Phone Number",
                              hintStyle: AppCss.mediumgrey12regular,
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
                        Container(
                            width: 500,
                            child: Padding(
                              padding: EdgeInsets.only(top: 0, left: 18, bottom: 5, right: 18),
                              child: Text(_isLabelTimeZone ? 'Time zone' : '',
                                  style: AppCss.grey10light,
                                  textAlign: TextAlign.left),
                            )),
                        Container(
                          width: 500,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 18, right: 18),
                            child: DropdownButtonFormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _timeZoneFormKey,
                              validator: MultiValidator([
                                RequiredValidator(errorText: ''),
                              ]),
                              decoration: InputDecoration(
                                  errorStyle:AppCss.red10regular,
                                  filled: true,
                                  fillColor: AppColors.PRIMARY_COLOR,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1,
                                        width: 0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1,
                                        width: 0.0),
                                  )),
                              icon: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // added line
                                  mainAxisSize:
                                      MainAxisSize.min, // added line
                                  children: <Widget>[
                                    Icon(
                                        _isTimeZoneDoneIconEnabled ? Icons.done: null,
                                        color: AppColors.EMERALD_GREEN),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.DEEP_BLUE,
                                      size: 30.0,
                                    )
                                  ]),
                              hint: Text("Time zone (Select one)",
                                  style: AppCss.mediumgrey12light),
                              value: currentSelectedValue,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  currentSelectedValue = newValue!;
                                  _timeZoneFormKey.currentState!.validate();
                                  _isTimeZoneDoneIconEnabled =
                                      _isTimeZoneFormFieldValid();
                                  _isLabelTimeZone = _isLabelTimeZoneValid();
                                  _isNextButtonEnabled = _isFormFieldValid();
                                });
                              },
                              items: timeZoneList.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child:
                                      Text(item, style: AppCss.grey12regular),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 49),
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
                                      _next();
                                    }
                                  : null,                                    
                              13,
                              13,
                              73,
                              72,
                              context)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 34,left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Already have an account?',style: AppCss.grey12regular),
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
                        )
                      ],
                    ),
                  ),
                ]))),
      ],
    );
  }
}

