import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/more/edit-photo.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/profile.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _editFormKey = new GlobalKey<FormState>();
  final LocalStorage storageCreateAccount = new LocalStorage('gemini-create-account');
  final GlobalKey<FormFieldState> _fNameFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lNameFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailAddFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _currentPwdFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _newPwdFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _confirmPwdFormKey =
      GlobalKey<FormFieldState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final GlobalKey<State> _keyLoading = new GlobalKey<State>();

  var fname, lname, email, currentPassword, newPassword, confirmPassword;
  bool _isSubmitButtonEnabled = false;
  bool _isFnameDoneIconEnabled = false;
  bool _isLnameDoneIconEnabled = false;
  bool _isPasswordDoneIconEnabled = false;
  bool _isConfirmPasswordDoneIconEnabled = false;
  bool _isNewPasswordDoneIconEnabled = false;
  bool _isEmailDoneIconEnabled = false;
  bool _isLabelFirstName = false;
  bool _isLabelLastName = false;
  bool _isLabelEmail = false;
  bool _isLabelPassword = false;
  bool _isLabelConfirmPassword = false;
  bool _isLabelNewPassword = false;  
  bool _securePasswordText = true;
  bool _secureConfirmPasswordText = true;
  bool _secureNewPasswordText = true;
  bool isPwdChar = false;
  bool isPwdSpace = false;
  bool isPwdUppercase = false;
  bool isPwdLowercase = false;
  bool isPwdNumber = false;
  bool isPwdSpecialSymbol = false;
  var fileBytes;
  var fileName;
  var firstName;
  var lastName;
  var emailAdd;
  var profilePicture;
  var imgPath;
  bool imageUpload = false;

  @override
  void initState() {
    super.initState();
    checkLoginToken(context);
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoading));
    Future.delayed(Duration.zero, () {
      getUserDetails();
    });
  }

  bool _isFormFieldValid() {
    if (_currentPwdFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  passwordShowHide() {
    setState(() {
      _securePasswordText = !_securePasswordText;
    });
  }

  confirmPasswordShowHide() {
    setState(() {
      _secureConfirmPasswordText = !_secureConfirmPasswordText;
    });
  }

  newPasswordShowHide() {
    setState(() {
      _secureNewPasswordText = !_secureNewPasswordText;
    });
  }

  bool _isFnameFormFieldValid() {
    return ((_fNameFormKey.currentState!.isValid));
  }

  bool _isLnameFormFieldValid() {
    return ((_lNameFormKey.currentState!.isValid));
  }

  bool _isPasswordFormFieldValid() {
    return ((_currentPwdFormKey.currentState!.isValid));
  }

  bool _isNewPasswordFormFieldValid() {
    return ((_newPwdFormKey.currentState!.isValid));
  }

  bool _isConfirmPasswordFormFieldValid() {
    return ((_confirmPwdFormKey.currentState!.isValid));
  }

  bool _isPasswordEightCharacterValid() {
    if (_currentPwdFormKey.currentState!.value.length > 7) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPasswordSpaceValid() {
    if (_currentPwdFormKey.currentState!.value.length > 0) {
      if (_currentPwdFormKey.currentState!.value.indexOf(' ') >= 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool _isPasswordUppercaseValid() {
    if (_currentPwdFormKey.currentState!.value.length > 0) {
      return _currentPwdFormKey.currentState!.value.contains(RegExp(r'[A-Z]'));
    } else {
      return false;
    }
  }

  bool _isPasswordLowercaseValid() {
    if (_currentPwdFormKey.currentState!.value.length > 0) {
      return _currentPwdFormKey.currentState!.value.contains(RegExp(r'[a-z]'));
    } else {
      return false;
    }
  }

  bool _isPasswordNumberValid() {
    if (_currentPwdFormKey.currentState!.value.length > 0) {
      return _currentPwdFormKey.currentState!.value.contains(RegExp(r'[0-9]'));
    } else {
      return false;
    }
  }

  bool _isPasswordSpecialSymbolValid() {
    if (_currentPwdFormKey.currentState!.value.length > 0) {
      return _currentPwdFormKey.currentState!.value
          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    } else {
      return false;
    }
  }

  bool _isLabelPasswordValid() {
    if (_currentPwdFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelNewPasswordValid() {
    if (_newPwdFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelConfirmPasswordValid() {
    if (_confirmPwdFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isEmailFormFieldValid() {
    return ((_emailAddFormKey.currentState!.isValid));
  }

  bool _isLabelFirstNameValid() {
    if (_fNameFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelLastNameValid() {
    if (_lNameFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelEmailValid() {
    if (_emailAddFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getUserDetails() async {
    try {
      final data = await getUserProfile(<String, dynamic>{});
      if (data['status'] == "success") {
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          firstName = data['data']['first_name'];
          lastName = data['data']['last_name'];
          emailAdd = data['data']['email'];
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

  chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        imageUpload = true;
        fileBytes = file.bytes;
        fileName = file.name;
        Navigator.push(
          context,PageTransition(type: PageTransitionType.fade,
          child: EditPhoto(fileName: fileBytes)
          ),
        );
      });
    }
  }

  Future<void> submitProfile() async {
    try {
      final data = await editUserProfile(<String, dynamic>{
        "username": "",
        "email": _emailAddFormKey.currentState!.value,
        "current_password": _currentPwdFormKey.currentState!.value,
        "password": _newPwdFormKey.currentState!.value,
        "confirm_password": _confirmPwdFormKey.currentState!.value,
        "first_name": _fNameFormKey.currentState!.value,
        "last_name": _lNameFormKey.currentState!.value,
        "zip_code": "47001",
        "phone_number": "7894561230",
        "timezone": "",
        "current_image_name": fileName,
        "profile_picture": {
          "filename": fileName,
          "filetype": "image/jpeg",
          "value": fileName != null ? base64Encode(fileBytes) : "",
        }
      });
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();          
        });
        Navigator.pushNamed(context, '/edit-profile');
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
          Navigator.pushNamed(context, '/edit-profile');
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (isVarEmpty(firstName) == '') {
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
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: header(
                logedin = false,
                back = true,
                logo = false,
                skip = false,
                backlink = true,
                '/more',
                skiplink = false,
                '',
                headingtext = 'Edit my info',
                isMsgActive =false,        
                isNotificationActive=false,
                context),
            body: SingleChildScrollView(
                child: Center(
                child: Column(
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 23.0),
                  child: Stack(
                    children: [
                      imageUpload ?
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.memory(fileBytes,
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                          ),
                        ),
                        ) : (
                        (profilePicture!=null) ? 
                         ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: (profilePicture!="") ? Container( height: 100.0,
                          width: 100.0,child: Image.network(profilePicture.toString(),height: 100.0,width: 100.0,fit: BoxFit.cover)) : Container(height: 100.0,width: 100.0,
                          decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.TRANSPARENT),
                          child: Icon(GeminiIcon.profile,size: 60, color: AppColors.PRIMARY_COLOR)),
                        ) 
                        : 
                         Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.TRANSPARENT),
                          child: Container(
                          alignment: Alignment.center,
                          child: new Icon(GeminiIcon.profile,size: 60, color: AppColors.PRIMARY_COLOR)),
                        )
                        ) 
                        ,
                      Positioned(
                        bottom: 2.0,
                        right: 5.0,
                        child: InkWell(
                          onTap: () {
                            chooseImage();
                          },
                        child: Container(
                          width: 28,height: 28,
                          decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.LIGHT_ORANGE,
                          border:Border.all(color: Colors.white, width: 2)),     
                          child : new Container(
                            alignment: Alignment.center,
                            child: Icon(GeminiIcon.icon_edit_white,size: 10, color: AppColors.PRIMARY_COLOR)),
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _editFormKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 375,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 18, bottom: 5, right: 18),
                            child: Text(_isLabelFirstName ? 'First Name' : '',
                                style: AppCss.grey10light,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 375,
                        padding: EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]"))
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _fNameFormKey,
                          initialValue: firstName ?? '',
                          cursorColor: AppColors.MEDIUM_GREY2,
                          validator: MultiValidator([
                            RequiredValidator(errorText: ''),
                          ]),
                          onChanged: (value) {
                            setState(() {
                              _fNameFormKey.currentState!.validate();
                              _isFnameDoneIconEnabled =
                                  _isFnameFormFieldValid();
                              _isLabelFirstName = _isLabelFirstNameValid();
                              _isSubmitButtonEnabled = _isFormFieldValid();
                            });
                          },
                          onSaved: (e) => fname = e!,
                          style: AppCss.grey12regular,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            errorStyle: AppCss.red10regular,
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
                          width: 375,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: 18, bottom: 5, right: 18),
                            child: Text(_isLabelLastName ? 'Last Name' : '',
                                style: AppCss.grey10light,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 375,
                        padding: EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          key: _lNameFormKey,
                          initialValue: lastName ?? '',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]"))
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: AppColors.MEDIUM_GREY2,
                          autocorrect: true,
                          validator: MultiValidator([
                            RequiredValidator(errorText: ''),
                          ]),
                          onChanged: (value) {
                            setState(() {
                              _lNameFormKey.currentState!.validate();
                              _isLnameDoneIconEnabled =
                                  _isLnameFormFieldValid();
                              _isLabelLastName = _isLabelLastNameValid();
                              //_isSubmitButtonEnabled = _isFormFieldValid();
                            });
                          },
                          onSaved: (e) => lname = e!,
                          style: AppCss.grey12regular,
                          keyboardType: TextInputType.text,
                          //textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            errorStyle: AppCss.red10regular,
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
                          width: 375,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: 18, bottom: 5, right: 18),
                            child: Text(_isLabelEmail ? 'Email address' : '',
                                style: AppCss.grey10light,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 375,
                        padding: EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          initialValue:emailAdd,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _emailAddFormKey,
                          cursorColor: AppColors.MEDIUM_GREY2,
                          validator: MultiValidator([
                            RequiredValidator(errorText: ''),
                            //EmailValidator(errorText: '')
                          ]),
                          onChanged: (value) {
                            setState(() {
                              _emailAddFormKey.currentState!.validate();
                              _isEmailDoneIconEnabled =
                                  _isEmailFormFieldValid();
                              _isLabelEmail = _isLabelEmailValid();
                              //_isSubmitButtonEnabled = _isFormFieldValid();
                            });
                          },
                          onSaved: (e) => email = e!,
                          style: AppCss.grey12regular,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorStyle: AppCss.red10regular,
                            filled: true,
                            fillColor: AppColors.PRIMARY_COLOR,
                            hintText: "Email address",
                            hintStyle: AppCss.mediumgrey12regular,
                            suffixIcon: _isEmailDoneIconEnabled
                                ? Icon(Icons.done,
                                    color: AppColors.EMERALD_GREEN)
                                : null,
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
                          width: 375,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: 18, bottom: 5, right: 18),
                            child: Text(
                                _isLabelPassword ? 'Current Password *' : '',
                                style: AppCss.grey10light,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 375,
                        padding: const EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _currentPwdFormKey,
                          validator: MultiValidator([
                            RequiredValidator(errorText: ""),
                            MinLengthValidator(8, errorText: ""),
                            PatternValidator(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                errorText: "")
                          ]),
                          onChanged: (value) {
                            setState(() {
                              _currentPwdFormKey.currentState!.validate();
                              _isPasswordDoneIconEnabled = _isPasswordFormFieldValid();
                              isPwdChar = _isPasswordEightCharacterValid();
                              isPwdSpace = _isPasswordSpaceValid();
                              isPwdUppercase = _isPasswordUppercaseValid();
                              _isLabelPassword = _isLabelPasswordValid();
                              isPwdLowercase = _isPasswordLowercaseValid();
                              isPwdNumber = _isPasswordNumberValid();
                              isPwdSpecialSymbol =
                                  _isPasswordSpecialSymbolValid();
                              _isSubmitButtonEnabled = _isFormFieldValid();
                            });
                          },
                          obscureText: _securePasswordText,
                          onSaved: (e) => currentPassword = e!,
                          style:AppCss.grey12regular,
                          decoration: InputDecoration(
                            errorStyle: AppCss.red10regular,
                            filled: true,
                            fillColor: AppColors.PRIMARY_COLOR,
                            hintText: "Current Password *",
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // added line
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
                          ),
                        ),
                      ),
                      Container(
                          width: 375,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: 18, bottom: 5, right: 18),
                            child: Text(
                                _isLabelNewPassword
                                    ? 'New Password (8+ characters)'
                                    : '',
                                style: AppCss.grey10light,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 375,
                        padding: const EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _newPwdFormKey,
                          validator: MultiValidator([
                            RequiredValidator(errorText: ""),
                            MinLengthValidator(8, errorText: ""),
                            PatternValidator(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                errorText: "")
                          ]),
                          onChanged: (value) {
                            setState(() {
                              _newPwdFormKey.currentState!.validate();
                              _isNewPasswordDoneIconEnabled =
                                  _isNewPasswordFormFieldValid();
                              _isLabelNewPassword = _isLabelNewPasswordValid();
                              //_isSubmitButtonEnabled = _isFormFieldValid();
                            });
                          },
                          obscureText: _secureNewPasswordText,
                          onSaved: (e) => newPassword = e!,
                          style: AppCss.grey12regular,
                          decoration: InputDecoration(
                            errorStyle: AppCss.red10regular,
                            filled: true,
                            fillColor: AppColors.PRIMARY_COLOR,
                            hintText: "New Password (8+ characters)",
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // added line
                              mainAxisSize: MainAxisSize.min, // added line
                              children: <Widget>[
                                Icon(
                                    _isNewPasswordDoneIconEnabled
                                        ? Icons.done
                                        : null,
                                    color: AppColors.EMERALD_GREEN),
                                IconButton(
                                  onPressed: newPasswordShowHide,
                                  color: Color.fromRGBO(38, 62, 114, 1),
                                   icon: _secureNewPasswordText ? Icon(GeminiIcon.invisible_password,size: 17, color: AppColors.DEEP_BLUE) : Icon(GeminiIcon.visible_password,size: 13, color: AppColors.DEEP_BLUE),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: 375,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 0, left: 18, bottom: 5, right: 18),
                            child: Text(
                                _isLabelConfirmPassword
                                    ? 'Confirm Password'
                                    : '',
                                style: AppCss.grey10light,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 375,
                        padding: const EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _confirmPwdFormKey,
                          validator: MultiValidator([
                            RequiredValidator(errorText: ""),
                            MinLengthValidator(8, errorText: ""),
                            PatternValidator(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                errorText: "")
                          ]),
                          onChanged: (value) {
                            setState(() {
                              _confirmPwdFormKey.currentState!.validate();
                              _isConfirmPasswordDoneIconEnabled =
                                  _isConfirmPasswordFormFieldValid();
                              _isLabelConfirmPassword =
                                  _isLabelConfirmPasswordValid();
                              //_isSubmitButtonEnabled = _isFormFieldValid();
                            });
                          },
                          obscureText: _secureConfirmPasswordText,
                          onSaved: (e) => confirmPassword = e!,
                          style: AppCss.grey12regular,
                          decoration: InputDecoration(
                            errorStyle: AppCss.red10regular,
                            filled: true,
                            fillColor: AppColors.PRIMARY_COLOR,
                            hintText: "Confirm Password",
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // added line
                              mainAxisSize: MainAxisSize.min, // added line
                              children: <Widget>[
                                Icon(
                                    _isConfirmPasswordDoneIconEnabled
                                        ? Icons.done
                                        : null,
                                    color: AppColors.EMERALD_GREEN),
                                IconButton(
                                  onPressed: confirmPasswordShowHide,
                                  color: Color.fromRGBO(38, 62, 114, 1),
                                  icon: _secureConfirmPasswordText ? Icon(GeminiIcon.invisible_password,size: 17, color: AppColors.DEEP_BLUE) : Icon(GeminiIcon.visible_password,size: 13, color: AppColors.DEEP_BLUE),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 25.0,
                            bottom: 40,
                          ),
                          child: buttion(
                              btnwidth = 295,
                              btnheight = 44,
                              btntext = 'save'.toUpperCase(),
                              _isSubmitButtonEnabled
                                  ? AppCss.blue14bold
                                  : AppCss.white14bold,
                              _isSubmitButtonEnabled
                                  ? AppColors.LIGHT_ORANGE
                                  : AppColors.LIGHT_GREY,
                              btntypesubmit = true,
                              _isSubmitButtonEnabled
                              ? () {
                                  submitProfile();
                                }
                              : null,
                              12,
                              12,
                              72,
                              72,
                              context)),
                    ],
                  ),
                ),
              ]),
            ))),
      ],
    );
  }
}

