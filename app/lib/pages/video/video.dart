import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:gemini/services/class.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:gemini/pages/video/OverlayWidget.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/services.dart' show SystemChrome;
class Video extends StatefulWidget {
  final String practiceResourceId;
  final String url;
  final String resourceId;
  Video({Key? key, required this.practiceResourceId,  this.url="",required this.resourceId}) : super(key: key);
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
late VideoPlayerController _controller;
var videoList = [];	
late Orientation target;
var pos;
 var timer;
var currentTime;
var totalTime;

@override
void initState() {
  initcontroller();      
}

initcontroller() {
  _controller  = VideoPlayerController.network(widget.url)
  ..addListener(() => setState((){}))..setLooping(false)..initialize().then((value) => _controller.pause());
  //if (widget.videoPlaytype == "practice") {  
  timer = Timer.periodic(Duration(seconds: 15), (Timer t) => fileTrackingWeekly());  
  //}
  super.initState();
}  

// @override
// didUpdateWidget(){
//   return;

// }

// getPosition(){
//   pos = _controller.value.position.inSeconds;
//   print(pos);
//   if (pos%10==0) {
//     fileTracking();
//   }
//   return true;
// }

// Future<void> fileTracking() async {
//   try { 
//   currentTime = _controller.value.position.inSeconds.toString();
//   totalTime = _controller.value.duration.inSeconds.toString(); 

//   final data = await updatePracticeContent(<String, dynamic>{
//     "practice_resource_id":widget.practiceResourceId,
//     "progress_time":currentTime,
//     "total_time":totalTime,
//   });	
//   if (data['status'] == "success") {	
//   } else {	      
//       if (data['is_valid']) {	
//       setState(() {	
//         Navigator.of(context, rootNavigator: true).pop();	
//       });	
//       toast(data['msg']);	
//     } else {	
//       Navigator.of(context, rootNavigator: true).pop();		
//       errortoast(data['msg']);	
//     }		
//   }	
//   } catch (err) {
//     Navigator.of(context, rootNavigator: true).pop();	
//     print('Caught error: $err');
//   }
// }
Future<void> fileTrackingWeekly() async {  
    try { 
    currentTime = _controller.value.position.inSeconds.toString();
    totalTime = _controller.value.duration.inSeconds.toString(); 

    final data = await updatePracticeWeek(<String, dynamic>{
      "class_practice_id":widget.practiceResourceId,
      "left_player_time":currentTime,
      "total_player_time":totalTime,
      "resource_id" : widget.resourceId
    });	
    if (data['status'] == "success") {	
  } else {	      
      if (data['is_valid']) {	
      setState(() {	
        Navigator.of(context, rootNavigator: true).pop();	
      });	
      toast(data['msg']);	
    } else {	
      Navigator.of(context, rootNavigator: true).pop();		
      errortoast(data['msg']);	
    }		
  }		
   } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }

  Widget build(BuildContext context) {
  return _controller.value.isInitialized
  ?  Container(
    alignment: Alignment.topCenter, 
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: buildVideo(),
    ),     
  )
  : Center(child: CircularProgressIndicator());
  }


  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          setOrientation(isPortrait);
          return Stack(
            fit: isPortrait ? StackFit.loose : StackFit.expand,
            children: <Widget>[
              buildVideoPlayer(),
              Positioned.fill(
                child: BasicOverlayWidget(
                  controller: _controller,
                  practiceResourceId : widget.practiceResourceId,
                  url: widget.url,
                  onClickedFullScreen: () {
                    target = isPortrait
                        ? Orientation.landscape
                        : Orientation.portrait;
                    if (isPortrait) {
                      AutoOrientation.landscapeRightMode();
                    } else {
                      AutoOrientation.portraitUpMode();
                    }
                  }, key: null,
                ),
              ),
            ],
          );
        },
      );

  
  // @override
  // Widget build(BuildContext context) {    
  //   return Column(
  //     children: [
  //      ClipRRect(
  //       borderRadius: BorderRadius.circular(8),
  //       child: VideoPlayerWidget(controller: _controller)),
  //     ],
  //   );
  // }

  Widget buildVideoPlayer() => buildFullScreen(
  child: AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
    child: VideoPlayer(_controller),
  ),
);

Widget buildFullScreen({
    required Widget child,
  }) {
    final size = _controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }

}

