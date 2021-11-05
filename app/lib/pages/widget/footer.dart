import 'package:flutter/material.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';

bool ishomepageactive = false;
bool isclassespageactive = false;
bool islibyrarypageactive = false;
bool ismorepageactive = false;
bool checkin = false;
footer(ishomepageactive, isclassespageactive, islibyrarypageactive,
    ismorepageactive, context) {
  return SafeArea(
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.PRIMARY_COLOR,
        boxShadow: [
          BoxShadow(
            color: AppColors.SHADOWCOLOR,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 4),
          )
        ],
      ),
      height: 75,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.zero,
            decoration: ishomepageactive
                ? BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 4, color: AppColors.DEEP_BLUE)))
                : null,
            child: Column(children: [
              IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pushNamed("/home");
                },
                icon: ishomepageactive
                    ? Icon(GeminiIcon.mood_active,
                        size: 24, color: AppColors.DEEP_BLUE)
                    : Icon(GeminiIcon.mood_inactive,
                        size: 24, color: AppColors.MEDIUM_GREY2),
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text('HOME',
                        style: ishomepageactive
                            ? AppCss.blue10bold
                            : AppCss.mediumgrey10bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/home");
                  })
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: isclassespageactive
                ? BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 4, color: AppColors.DEEP_BLUE)))
                : null,
            child: Column(children: [
              IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pushNamed("/classes");
                },
                icon: isclassespageactive
                    ? Icon(GeminiIcon.course_active,
                        size: 24, color: AppColors.DEEP_BLUE)
                    : Icon(GeminiIcon.course_inactive,
                        size: 24, color: AppColors.MEDIUM_GREY2),
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text('CLASSES',
                        style: isclassespageactive
                            ? AppCss.blue10bold
                            : AppCss.mediumgrey10bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/classes");
                  })
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: checkin
                ? BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 4, color: AppColors.DEEP_BLUE)))
                : null,
            child: Column(children: [
              IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pushNamed("/check-in");
                },
                icon: Icon(GeminiIcon.checkin,size: 24, color: AppColors.PRIMARY_COLOR)
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text('CHECK-IN',style: AppCss.mediumgrey10bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/check-in");
                  })
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            decoration: islibyrarypageactive
                ? BoxDecoration(
                    border: Border(
                        bottom:BorderSide(width: 4, color: AppColors.DEEP_BLUE)))
                : null,
            child: Column(children: [
              IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pushNamed("/library");
                },
                icon: islibyrarypageactive
                    ? Icon(GeminiIcon.library_active,
                        size: 24, color: AppColors.DEEP_BLUE)
                    : Icon(GeminiIcon.library_inactive,
                        size: 24, color: AppColors.MEDIUM_GREY2),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text('LIBRARY',style: islibyrarypageactive ? AppCss.blue10bold
                  : AppCss.mediumgrey10bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/library");
                })
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            decoration: ismorepageactive ? BoxDecoration(border: Border(bottom:BorderSide(width: 4, color: AppColors.DEEP_BLUE)))
            : null,
            child: Column(children: [
              IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pushNamed("/more");
                },
                icon: ismorepageactive
                ? Container(width: 30,height: 7.5,child: Icon(GeminiIcon.dot_active,size: 7, color: AppColors.DEEP_BLUE)
                ): Container(width: 30,height: 7.5,child: Icon(GeminiIcon.dot_inactive,size: 7, color: AppColors.MEDIUM_GREY2)),
              ),
              InkWell(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text('MORE',style: ismorepageactive ? AppCss.blue10bold : AppCss.mediumgrey10bold),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/more");
              })
            ]),
          ),
        ],
      ),
    ),
  );
}

floatingactionbuttion(context) {
  return Container(
    margin: EdgeInsets.only(top: 22),
    child: FloatingActionButton(
      // backgroundColor: AppColors.PRIMARY_COLOR,
      // foregroundColor: AppColors.TRANSPARENT,
      // clipBehavior: Clip.none,
      // elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      autofocus: false,
      elevation: 0,
      splashColor: Colors.transparent,
      hoverElevation: 0,
      onPressed: () {
        Navigator.of(context).pushNamed("/check-in");
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 6),
          shape: BoxShape.circle,
        ),
        child: Icon(GeminiIcon.checkin, size: 40, color: AppColors.DEEP_BLUE),
      ),
    ),
  );
}
