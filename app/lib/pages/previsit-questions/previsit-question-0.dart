import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PrevisitQuestion1 extends StatefulWidget {
  final String qid;
  const PrevisitQuestion1({Key? key, required this.qid}) : super(key: key);

  @override
  _PrevisitQuestion1State createState() => _PrevisitQuestion1State();
}

class _PrevisitQuestion1State extends State<PrevisitQuestion1> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool _isSubmitButtonEnabled = false;
  bool _isSubmitButtonEnabledForTextBox = false;
  bool _isLabelSystolic = false;
  bool _isLabelDiastolic = false;
  String checkboxdata = '';
  String radiobuttonData = '';
  bool dd = false;
  final da = ['1', '2', '3'];
  int count = 0;
  int c = 0;

  List<Map<String, dynamic>> _value = [];
  final GlobalKey<FormFieldState> _postTextFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _postTextBox = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _systolicFormKey = GlobalKey<FormFieldState>();
  final TextEditingController _textAreaController = new TextEditingController();

  bool _isFormFieldValid() {
    return ((_postTextFormKey.currentState!.isValid));
  }

  bool _isTextBoxValid() {
    return ((_postTextBox.currentState!.isValid));
  }

  double _sleekSliderValue = 0;

  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loader(context, _keyLoader));
    getWeekly();
    super.initState();
  }

  var checkinList = [];
  var optionsList = [];
  var questionSequence = [];
  var text;
  var questionIndex = 0;
  var previsitQuestionNo;
  var jumpOption = {};

  Future<void> getWeekly() async {
    try {
      final data = await getWeeklyCheckin(
          <String, dynamic>{"question_id": "", "only_sequence": true});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          questionSequence = data['data']['question_sequence'];
        });
        getWeeklyQuestion();
      } else {
        if (data['is_valid'] == false) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, 'signin');
          errortoast(data['msg']);
        } else {
          Navigator.pushNamed(context, 'home');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  backButton() {
   // print('back back');
    // questionIndex = questionIndex - 1;
    // getWeeklyQuestion();
  }

  Future<void> getWeeklyQuestion() async {
    var questioId = questionSequence[questionIndex];
    try {
      final data =
          await getWeeklyCheckin(<String, dynamic>{"question_id": questioId});
      if (data['status'] == "success") {
        setState(() {
          checkinList = data['data']['checkin'];
        });
      } else {
        if (data['is_valid'] == false) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, 'signin');
          errortoast(data['msg']);
        } else {
          Navigator.pushNamed(context, 'home');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  submitWeeklyCheckin(id, answer) async {
    loader(context, _keyLoader); //invoking login
    final data = await weeklyCheckin(<String, dynamic>{
      "question_id": questionSequence[questionIndex],
      "user_answer": [
        {"id": id, "answer": answer}
      ]
    });
    if (data['status'] == "success") {
      setState(() {
        questionIndex += 1;
        Navigator.of(context, rootNavigator: true).pop();
      });
      getWeeklyQuestion();
      //toast(data['msg']);
    } else {
      if (data['is_valid'] == false) {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
      } else {
        Navigator.pushNamed(context, '/home');
        errortoast(data['msg']);
      }
    }
  }

  _onUpdate(String value) {
    Map<String, dynamic> json = {'id': 1, 'answer': value};
    _value.add(json);
  }

  int _n = 0;
  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  Widget mutipleTextField(option, {oIndex = 0, length = 1}) {
    var lastIndex = length - 1;
    //print("$oIndex >>>> $length");
    return option.isEmpty
        ? Container()
        : SizedBox(
            width: (MediaQuery.of(context).size.width / length) -
                (oIndex < lastIndex ? 16 : 0),
            child: Row(
              children: [
              Flexible(
                child: Column(
                children: [
                  Container(
                      width: 100,
                      margin: EdgeInsets.only(left: 0, right: 0),
                      child: Text(_isLabelSystolic ? 'Systolic #' : '',
                          style: AppCss.grey10light,
                          textAlign: TextAlign.left)),
                  Container(
                    width: 140,
                    child: new TextFormField(
                        cursorColor: AppColors.MEDIUM_GREY2,
                        style: AppCss.grey12light,
                        // key: _systolicFormKey,
                        // onSaved: (e) => text = e!,
                        onChanged: (value) {
                          setState(() {
                            _onUpdate(value);
                            // _isSubmitButtonEnabled = _isFormFieldValid();
                            // print(_systolicFormKey.currentState!.value
                            //     .toString());
                          });
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(new RegExp(r"\s")),
                          FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                        ],
                        decoration: InputDecoration(
                          hintText: option['placeholder_text'] ?? '',
                          hintStyle: AppCss.mediumgrey12light,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.MEDIUM_GREY1, width: 0.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.MEDIUM_GREY1),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.MEDIUM_GREY1),
                          ),
                        )),
                  ),
                ],
              )),
              // oIndex < lastIndex
              //     ? Flexible(
              //         child: Container(
              //           width: 16,
              //           height: 36,
              //           margin: const EdgeInsets.only(left: 0, right: 0),
              //           child: Text("/", style: AppCss.blue26semibold),
              //         ),
              //       )
              //     : SizedBox(width: 0),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    previsitQuestionNo = (previsitQuestionNo != null) ? previsitQuestionNo : 1;
    return (checkinList.isEmpty)
        ? Container()
        : Stack(children: <Widget>[
            Image.asset(
              "assets/images/bg.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      StepProgressIndicator(
                        totalSteps: 3,
                        currentStep: 1,
                        size: 4,
                        padding: 0,
                        selectedColor: AppColors.DEEP_GREEN,
                        unselectedColor: AppColors.PALE_GREEN,
                        roundedEdges: Radius.circular(10),
                      ),
                      header(
                          logedin = false,
                          back = true,
                          logo = false,
                          skip = false,
                          backlink = true,
                          // backButton(),
                          '/start-previsit',
                          skiplink = false,
                          '',
                          headingtext = 'Question $previsitQuestionNo of 20',
                          isMsgActive = false,
                          isNotificationActive = false,
                          context),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 40, left: 20.0, right: 20.0),
                        child: checkinList.isEmpty
                            ? Container(
                                margin: const EdgeInsets.only(
                                    top: 40, bottom: 40, left: 40, right: 40),
                                child: Text(
                                  "No questions yet.",
                                  style: AppCss.grey12medium,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container(
                                constraints: BoxConstraints(maxWidth: 375),
                                child: ListView.separated(
                                  separatorBuilder: (BuildContext context,
                                          int index) =>
                                      Container(
                                          margin: EdgeInsets.only(bottom: 16)),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: checkinList.length,
                                  itemBuilder: (context, qindex) {
                                    optionsList =
                                        checkinList[qindex]['options'];
                                    jumpOption[checkinList[qindex]['id']] = 0;
                                    //print(">> $jumpOption");
                                    previsitQuestionNo =
                                        checkinList[qindex]['id'];
                                    return Column(
                                      children: [
                                        Container(
                                          width: 500,
                                          padding: const EdgeInsets.only(
                                              top: 55,
                                              bottom: 13,
                                              left: 20,
                                              right: 20),
                                          child: (checkinList[qindex]
                                                      ['question'] !=
                                                  null)
                                              ? Text(
                                                  checkinList[qindex]
                                                      ['question'],
                                                  textAlign: TextAlign.center,
                                                  style: AppCss.blue26semibold)
                                              : Container(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 31, left: 34, right: 34),
                                          child: Center(
                                            child: (checkinList[qindex]
                                                        ['intro_text'] !=
                                                    null)
                                                ? Text(
                                                    checkinList[qindex]
                                                        ['intro_text'],
                                                    textAlign: TextAlign.center,
                                                    style: AppCss.grey10light)
                                                : Container(),
                                          ),
                                        ),
                                        optionsList.isEmpty
                                            ? new Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 102,
                                                    bottom: 78,
                                                    left: 50,
                                                    right: 30),
                                                child: buttion(
                                                    btnwidth = 290,
                                                    btnheight = 44,
                                                    btntext = 'NEXT',
                                                    AppCss.blue14bold,
                                                    AppColors.LIGHT_ORANGE,
                                                    btntypesubmit = true, () {
                                                  submitWeeklyCheckin(
                                                      null, null);
                                                }, 13, 13, 73, 72, context),
                                              )
                                            : ListView.separated(
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 0)),
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: optionsList.length,
                                                itemBuilder: (context, index) {
                                                  return Column(children: [
                                                    (optionsList[index]
                                                                ['type'] ==
                                                            "radio")
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 9.0,
                                                                    left: 20,
                                                                    right: 20),
                                                            child: (radiobuttonData !=
                                                                    optionsList[
                                                                            index]
                                                                        [
                                                                        'label'])
                                                                ? buttion(
                                                                    btnwidth =
                                                                        420,
                                                                    btnheight =
                                                                        60,
                                                                    btntext =
                                                                        optionsList[index]['label']
                                                                            .toString(),
                                                                    AppCss
                                                                        .blue16semibold,
                                                                    AppColors
                                                                        .PRIMARY_COLOR,
                                                                    btntypesubmit =
                                                                        false,
                                                                    () => {
                                                                          setState(
                                                                              () {
                                                                            radiobuttonData =
                                                                                optionsList[index]['label'];
                                                                          })
                                                                        },
                                                                    19,
                                                                    20,
                                                                    20,
                                                                    20,
                                                                    context)
                                                                : buttion(
                                                                    btnwidth =
                                                                        335,
                                                                    btnheight =
                                                                        60,
                                                                    btntext = optionsList[index]
                                                                            [
                                                                            'label']
                                                                        .toString(),
                                                                    AppCss
                                                                        .white16semibold,
                                                                    AppColors
                                                                        .DEEP_BLUE,
                                                                    btntypesubmit =
                                                                        false,
                                                                    () {
                                                                    submitWeeklyCheckin(
                                                                        optionsList[index]
                                                                            [
                                                                            'id'],
                                                                        optionsList[index]
                                                                            [
                                                                            'label']);
                                                                    radiobuttonData =
                                                                        '';
                                                                  },
                                                                    18,
                                                                    18,
                                                                    18,
                                                                    220,
                                                                    context),
                                                          )
                                                        : Container(),
                                                    (optionsList[index]
                                                                ['type'] ==
                                                            "checkbox")
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 9.0,
                                                                    left: 20,
                                                                    right: 20),
                                                            child: (da[0] !=
                                                                    optionsList[
                                                                            index]
                                                                        [
                                                                        'label'])
                                                                ? buttion(
                                                                    btnwidth =
                                                                        420,
                                                                    btnheight =
                                                                        60,
                                                                    btntext =
                                                                        optionsList[index]['label']
                                                                            .toString(),
                                                                    AppCss
                                                                        .blue16semibold,
                                                                    AppColors
                                                                        .PRIMARY_COLOR,
                                                                    btntypesubmit =
                                                                        false,
                                                                    () => {
                                                                          setState(
                                                                              () {
                                                                            checkboxdata =
                                                                                optionsList[index]['label'];

                                                                            if (count <=
                                                                                2) {
                                                                              da[count] = optionsList[index]['label'];
                                                                              count++;
                                                                            } else {
                                                                              da[count - 1] = optionsList[index]['label'];
                                                                            }
                                                                          })
                                                                        },
                                                                    19,
                                                                    18,
                                                                    20,
                                                                    20,
                                                                    context)
                                                                : buttion(
                                                                    btnwidth =
                                                                        335,
                                                                    btnheight =
                                                                        60,
                                                                    btntext = optionsList[index]
                                                                            [
                                                                            'label']
                                                                        .toString(),
                                                                    AppCss
                                                                        .white16semibold,
                                                                    AppColors
                                                                        .DEEP_BLUE,
                                                                    btntypesubmit =
                                                                        false,
                                                                    () {
                                                                    submitWeeklyCheckin(
                                                                        optionsList[index]
                                                                            [
                                                                            'id'],
                                                                        optionsList[index]
                                                                            [
                                                                            'label']);
                                                                  },
                                                                    18,
                                                                    18,
                                                                    18,
                                                                    80,
                                                                    context),
                                                          )
                                                        : Container(),
                                                    (optionsList[index]
                                                                ['type'] ==
                                                            "textarea")
                                                        ? Column(
                                                            children: [
                                                              Scrollbar(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  child:
                                                                      Container(
                                                                    width: 500,
                                                                    padding: EdgeInsets.only(
                                                                        top: 10,
                                                                        left:
                                                                            18,
                                                                        right:
                                                                            18),
                                                                    child:
                                                                        TextFormField(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .multiline,
                                                                      minLines:
                                                                          10,
                                                                      maxLines:
                                                                          null,
                                                                      cursorColor:
                                                                          AppColors
                                                                              .MEDIUM_GREY2,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                              errorText: 'field is required')
                                                                        ],
                                                                      ),
                                                                      key:
                                                                          _postTextFormKey,

                                                                      controller:
                                                                          _textAreaController,
                                                                      // controller:
                                                                      //     _textareaField,
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          _postTextFormKey
                                                                              .currentState!
                                                                              .validate();
                                                                          _isSubmitButtonEnabled =
                                                                              _isFormFieldValid();
                                                                        });
                                                                      },
                                                                      onSaved: (e) =>
                                                                          text =
                                                                              e!,
                                                                      style: AppCss
                                                                          .grey12regular,

                                                                      decoration:
                                                                          InputDecoration(
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            AppColors.PRIMARY_COLOR,
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: AppColors.MEDIUM_GREY1,
                                                                              width: 0.0),
                                                                        ),
                                                                        contentPadding: EdgeInsets.only(
                                                                            top:
                                                                                12.0,
                                                                            left:
                                                                                8.0,
                                                                            right:
                                                                                8.0,
                                                                            bottom:
                                                                                12),
                                                                        hintText: (optionsList[index]['placeholder_text'] !=
                                                                                null)
                                                                            ? optionsList[index]['placeholder_text'].toString()
                                                                            : "",
                                                                        hintStyle:
                                                                            AppCss.mediumgrey12light,
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: AppColors.MEDIUM_GREY1,
                                                                              width: 0.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            128,
                                                                        left:
                                                                            15,
                                                                        bottom:
                                                                            20,
                                                                        right:
                                                                            15),
                                                                child:
                                                                    Container(
                                                                  width: 275,
                                                                  height: 44,
                                                                  child: _isSubmitButtonEnabled
                                                                      ? Material(
                                                                          shape: RoundedRectangleBorder(
                                                                              side: BorderSide(color: AppColors.LIGHT_ORANGE, width: 1, style: BorderStyle.solid),
                                                                              borderRadius: BorderRadius.circular(50)),
                                                                          color:
                                                                              AppColors.LIGHT_ORANGE,
                                                                          child:
                                                                              MaterialButton(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                1,
                                                                                5,
                                                                                1,
                                                                                4),
                                                                            onPressed:
                                                                                () {
                                                                              submitWeeklyCheckin(optionsList[index]['id'], _textAreaController.text);
                                                                              _textAreaController.clear();
                                                                              _isSubmitButtonEnabled = false;
                                                                            },
                                                                            textColor:
                                                                                AppColors.DEEP_BLUE,
                                                                            child:
                                                                                Text("NEXT".toUpperCase(), style: AppCss.blue13bold),
                                                                          ),
                                                                        )
                                                                      : Material(
                                                                          shape: RoundedRectangleBorder(
                                                                              side: BorderSide(color: AppColors.LIGHT_GREY, width: 1, style: BorderStyle.solid),
                                                                              borderRadius: BorderRadius.circular(50)),
                                                                          color:
                                                                              AppColors.LIGHT_GREY,
                                                                          child:
                                                                              MaterialButton(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                1,
                                                                                5,
                                                                                1,
                                                                                4),
                                                                            onPressed:
                                                                                () {},
                                                                            textColor:
                                                                                AppColors.DEEP_BLUE,
                                                                            child:
                                                                                Text("NEXT".toUpperCase(), style: AppCss.white13bold),
                                                                          ),
                                                                        ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        : Container(),
                                                    (optionsList[index]
                                                                ['type'] ==
                                                            "textbox")
                                                        ? Column(
                                                            children: [
                                                              (optionsList.length >
                                                                      1)
                                                                  ? (jumpOption[checkinList[qindex]
                                                                              [
                                                                              'id']] <=
                                                                          0
                                                                      ? Container(
                                                                          constraints:
                                                                              BoxConstraints(maxWidth: 375),
                                                                          margin:
                                                                              const EdgeInsets.only(top: 100.0),
                                                                          child:
                                                                              Form(
                                                                            //key: _bpKey,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: optionsList.map((item) {
                                                                                jumpOption[checkinList[qindex]['id']] = 1;
                                                                                return this.mutipleTextField(item, oIndex: optionsList.indexOf(item), length: optionsList.length);
                                                                              }).toList(),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container())
                                                                  : Container(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              10,
                                                                          left:
                                                                              18,
                                                                          bottom:
                                                                              10,
                                                                          right:
                                                                              18),
                                                                      child:
                                                                          TextFormField(
                                                                        maxLength:
                                                                            85,
                                                                        cursorColor:
                                                                            AppColors.MEDIUM_GREY2,
                                                                        key:
                                                                            _postTextBox,
                                                                        controller:
                                                                            _textAreaController,
                                                                        validator:
                                                                            MultiValidator([
                                                                          RequiredValidator(
                                                                              errorText: 'this field is require')
                                                                        ]),
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            _isSubmitButtonEnabledForTextBox =
                                                                                _isTextBoxValid();
                                                                          });
                                                                        },
                                                                        onSaved:
                                                                            (e) =>
                                                                                text = e!,
                                                                        style: AppCss
                                                                            .grey12regular,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          counterText:
                                                                              "",
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              AppColors.PRIMARY_COLOR,
                                                                          enabledBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: AppColors.MEDIUM_GREY1, width: 0.0),
                                                                          ),
                                                                          contentPadding:
                                                                              EdgeInsets.all(8),
                                                                          hintText: (optionsList[index]['placeholder_text'] != null)
                                                                              ? optionsList[index]['placeholder_text'].toString()
                                                                              : "",
                                                                          hintStyle:
                                                                              AppCss.mediumgrey12light,
                                                                          focusedBorder:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: AppColors.MEDIUM_GREY1, width: 0.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                              index < 1
                                                                  ? Container(
                                                                      margin: EdgeInsets.only(
                                                                          top:
                                                                              271,
                                                                          left:
                                                                              15,
                                                                          bottom:
                                                                              20,
                                                                          right:
                                                                              15),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            275,
                                                                        height:
                                                                            44,
                                                                        child: _isSubmitButtonEnabledForTextBox
                                                                            ? Material(
                                                                                shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.LIGHT_ORANGE, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(50)),
                                                                                color: AppColors.LIGHT_ORANGE,
                                                                                child: MaterialButton(
                                                                                  padding: const EdgeInsets.fromLTRB(1, 5, 1, 4),
                                                                                  onPressed: () {
                                                                                    submitWeeklyCheckin(optionsList[index]['id'], _textAreaController.text);
                                                                                    _textAreaController.clear();
                                                                                    _isSubmitButtonEnabledForTextBox = false;
                                                                                  },
                                                                                  textColor: AppColors.DEEP_BLUE,
                                                                                  child: Text("NEXT".toUpperCase(), style: AppCss.blue13bold),
                                                                                ),
                                                                              )
                                                                            : Material(
                                                                                shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.LIGHT_GREY, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(50)),
                                                                                color: AppColors.LIGHT_GREY,
                                                                                child: MaterialButton(
                                                                                  padding: const EdgeInsets.fromLTRB(1, 5, 1, 4),
                                                                                  onPressed: () {
                                                                                    submitWeeklyCheckin(optionsList[index]['id'], _textAreaController.text);
                                                                                    _textAreaController.clear();
                                                                                    _isSubmitButtonEnabledForTextBox = false;
                                                                                  },
                                                                                  textColor: AppColors.DEEP_BLUE,
                                                                                  child: Text("NEXT".toUpperCase(), style: AppCss.white13bold),
                                                                                ),
                                                                              ),
                                                                      ),
                                                                    )
                                                                  : Container()
                                                            ],
                                                          )
                                                        : Container(),
                                                    (optionsList[index]
                                                                ['type'] ==
                                                            "range")
                                                        ? Column(children: [
                                                            SleekCircularSlider(
                                                              appearance:
                                                                  CircularSliderAppearance(
                                                                spinnerMode:
                                                                    false,
                                                                size: 220,
                                                                startAngle: 270,
                                                                angleRange: 360,
                                                                customColors: CustomSliderColors(
                                                                    trackColor:
                                                                        AppColors
                                                                            .ffff,
                                                                    dotColor:
                                                                        AppColors
                                                                            .EMERALD_GREEN,
                                                                    progressBarColor:
                                                                        AppColors
                                                                            .DEEP_GREEN,
                                                                    shadowColor:
                                                                        AppColors
                                                                            .ffff),
                                                                customWidths: CustomSliderWidths(
                                                                    trackWidth:
                                                                        12,
                                                                    progressBarWidth:
                                                                        12,
                                                                    shadowWidth:
                                                                        0,
                                                                    handlerSize:
                                                                        10),
                                                                infoProperties:
                                                                    InfoProperties(),
                                                              ),
                                                              innerWidget:
                                                                  (percentage) {
                                                                // value = percentage;
                                                                return Center(
                                                                  child: Text(
                                                                    'No Pain Imaginable',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: AppCss
                                                                        .blue12bold,
                                                                  ),
                                                                );
                                                              },
                                                              min: 0,
                                                              max: 100,
                                                              initialValue: 0,
                                                              onChange: (double
                                                                  value) {
                                                                setState(() {
                                                                  _sleekSliderValue =
                                                                      value;
                                                                });
                                                              },
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 36,
                                                                      left: 15,
                                                                      bottom:
                                                                          20,
                                                                      right:
                                                                          15),
                                                              child: Container(
                                                                width: 295,
                                                                height: 44,
                                                                child: _sleekSliderValue !=
                                                                        0
                                                                    ? Material(
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                color: AppColors.LIGHT_ORANGE,
                                                                                width: 1,
                                                                                style: BorderStyle.solid),
                                                                            borderRadius: BorderRadius.circular(50)),
                                                                        color: AppColors
                                                                            .LIGHT_ORANGE,
                                                                        child:
                                                                            MaterialButton(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              1,
                                                                              5,
                                                                              1,
                                                                              4),
                                                                          onPressed:
                                                                              () {
                                                                            submitWeeklyCheckin(optionsList[index]['id'],
                                                                                _sleekSliderValue);
                                                                            _sleekSliderValue =
                                                                                0;
                                                                          },
                                                                          textColor:
                                                                              AppColors.DEEP_BLUE,
                                                                          child: Text(
                                                                              "NEXT".toUpperCase(),
                                                                              style: AppCss.blue13bold),
                                                                        ),
                                                                      )
                                                                    : Material(
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                color: AppColors.LIGHT_GREY,
                                                                                width: 1,
                                                                                style: BorderStyle.solid),
                                                                            borderRadius: BorderRadius.circular(50)),
                                                                        color: AppColors
                                                                            .LIGHT_GREY,
                                                                        child:
                                                                            MaterialButton(
                                                                          padding: const EdgeInsets.fromLTRB(
                                                                              1,
                                                                              5,
                                                                              1,
                                                                              4),
                                                                          onPressed:
                                                                              () {},
                                                                          textColor:
                                                                              AppColors.DEEP_BLUE,
                                                                          child: Text(
                                                                              "NEXT".toUpperCase(),
                                                                              style: AppCss.white13bold),
                                                                        ),
                                                                      ),
                                                              ),
                                                            )
                                                          ])
                                                        : Container(),
                                                    (optionsList[index]
                                                                ['type'] ==
                                                            "incremental")
                                                        ? Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 108),
                                                            child: Column(
                                                              children: [
                                                                new Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              30.0),
                                                                      child:
                                                                          new FloatingActionButton(
                                                                        mini:
                                                                            true,
                                                                        onPressed:
                                                                            minus,
                                                                        child: new Icon(
                                                                            Icons
                                                                                .remove,
                                                                            color:
                                                                                Colors.black),
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                    new Text(
                                                                        '$_n',
                                                                        style: AppCss
                                                                            .grey78bold),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              30.0),
                                                                      child:
                                                                          new FloatingActionButton(
                                                                        mini:
                                                                            true,
                                                                        onPressed:
                                                                            add,
                                                                        child:
                                                                            new Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        backgroundColor:
                                                                            AppColors.LIGHT_ORANGE,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                new Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 102,
                                                                      bottom:
                                                                          78,
                                                                      left: 50,
                                                                      right:
                                                                          30),
                                                                  child: _n != 0
                                                                      ? buttion(
                                                                          btnwidth =
                                                                              295,
                                                                          btnheight =
                                                                              44,
                                                                          btntext =
                                                                              'NEXT',
                                                                          AppCss
                                                                              .blue14bold,
                                                                          AppColors
                                                                              .LIGHT_ORANGE,
                                                                          btntypesubmit = true,
                                                                          () {
                                                                          submitWeeklyCheckin(
                                                                              optionsList[index]['id'],
                                                                              _n);
                                                                        },
                                                                          13,
                                                                          13,
                                                                          73,
                                                                          72,
                                                                          context)
                                                                      : buttion(
                                                                          btnwidth =
                                                                              295,
                                                                          btnheight =
                                                                              44,
                                                                          btntext =
                                                                              'NEXT',
                                                                          AppCss
                                                                              .white14bold,
                                                                          AppColors
                                                                              .LIGHT_GREY,
                                                                          btntypesubmit =
                                                                              true,
                                                                          () {},
                                                                          13,
                                                                          13,
                                                                          73,
                                                                          72,
                                                                          context),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                  ]);
                                                }),
                                      ],
                                    );
                                  },
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]);
  }
}
//  for(var i = 0; i < optionsList.length; i++){
//                                                                               return Container();
//                                                                             },
//                                                                             Flexible(
//                                                                                 child: Column(
//                                                                               children: [
//                                                                                 Container(width: 100, margin: EdgeInsets.only(left: 10, right: 10), child: Text(_isLabelSystolic ? 'Systolic #' : '', style: AppCss.grey10light, textAlign: TextAlign.left)),
//                                                                                 Container(
//                                                                                   child: new TextFormField(
//                                                                                       cursorColor: AppColors.MEDIUM_GREY2,
//                                                                                       style: AppCss.grey12light,
//                                                                                       //key: _systolicFormKey,
//                                                                                       onSaved: (e) => text = e!,
//                                                                                       onChanged: (value) {
//                                                                                         setState(() {
//                                                                                           _isSubmitButtonEnabled = _isFormFieldValid();
//                                                                                         });
//                                                                                       },
//                                                                                       //keyboardType: TextInputType.number,
//                                                                                       inputFormatters: [
//                                                                                         FilteringTextInputFormatter.deny(new RegExp(r"\s")),
//                                                                                         FilteringTextInputFormatter.allow(RegExp("[0-9]"))
//                                                                                       ],
//                                                                                       decoration: InputDecoration(
//                                                                                         hintText: "Enter systolic #",
//                                                                                         hintStyle: AppCss.mediumgrey12light,
//                                                                                         enabledBorder: UnderlineInputBorder(
//                                                                                           borderSide: BorderSide(color: AppColors.MEDIUM_GREY1, width: 0.0),
//                                                                                         ),
//                                                                                         focusedBorder: UnderlineInputBorder(
//                                                                                           borderSide: BorderSide(color: AppColors.MEDIUM_GREY1),
//                                                                                         ),
//                                                                                         border: UnderlineInputBorder(
//                                                                                           borderSide: BorderSide(color: AppColors.MEDIUM_GREY1),
//                                                                                         ),
//                                                                                       )),
//                                                                                 ),
//                                                                               ],
//                                                                             )),
//                                                                             Flexible(
//                                                                               child: Column(children: [
//                                                                                 Container(
//                                                                                   width: 16,
//                                                                                   height: 36,
//                                                                                   margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0),
//                                                                                   child: Text("/", style: AppCss.blue26semibold),
//                                                                                 )
//                                                                               ]),
//                                                                             ),
//                                                                             Flexible(
//                                                                                 child: Column(
//                                                                               children: [
//                                                                                 Container(width: 100, child: Text(_isLabelDiastolic ? 'Diastolic #' : '', style: AppCss.grey10light, textAlign: TextAlign.left)),
//                                                                                 Container(
//                                                                                   child: new TextFormField(
//                                                                                       cursorColor: AppColors.MEDIUM_GREY2,
//                                                                                       style: AppCss.grey12light,
//                                                                                       // key: _diastolicFormKey,
//                                                                                       onSaved: (e) => text = e!,
//                                                                                       onChanged: (value) {
//                                                                                         setState(() {});
//                                                                                       },
//                                                                                       //keyboardType: TextInputType.number,
//                                                                                       // inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s")),
//                                                                                       // FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
//                                                                                       autocorrect: true,
//                                                                                       decoration: InputDecoration(
//                                                                                         hintText: "Enter diastolic #",
//                                                                                         hintStyle: AppCss.mediumgrey12light,
//                                                                                         enabledBorder: UnderlineInputBorder(
//                                                                                           borderSide: BorderSide(color: AppColors.MEDIUM_GREY1, width: 0.0),
//                                                                                         ),
//                                                                                         focusedBorder: UnderlineInputBorder(
//                                                                                           borderSide: BorderSide(color: AppColors.MEDIUM_GREY1),
//                                                                                         ),
//                                                                                         border: UnderlineInputBorder(
//                                                                                           borderSide: BorderSide(color: AppColors.MEDIUM_GREY1),
//                                                                                         ),
//                                                                                       )),
//                                                                                 ),
//                                                                               ],
//                                                                             )),
