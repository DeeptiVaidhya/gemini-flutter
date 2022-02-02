import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:just_audio/just_audio.dart';
import 'package:gemini/services/class.dart';
import 'package:gemini/pages/widget/helper.dart';

class AudioPlay extends StatefulWidget {
  final String practiceResourceId;
  final audioStop;
  final audioCallback;
  final String url;
  final String title;
  final String resourceId;
  const AudioPlay({Key? key, required this.audioStop, this.audioCallback, required this.practiceResourceId, this.url ="",  this.title="",required this.resourceId}) : super(key: key);

  @override
  _AudioPlayState createState() => _AudioPlayState();
}

typedef OnError = void Function(Exception exception);

//const url = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';

class _AudioPlayState extends State<AudioPlay> {

  final AudioPlayer player = AudioPlayer();  
  dynamic duration = const Duration(seconds: 0);
  dynamic position= const Duration(seconds: 0);
  dynamic timer;
  var audioState;
  bool isPlay =false;
  var isMuted =1;
  var audioList = [];	
  var fileUrl;
  var totalTime;
  var currentTime;
  var posSec;
  var durSec;
  int timerCounter = 0;
  var practiceResourceId;
  var type;

  @override
  void initState() {
    initAudio();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    // stopAudio();
    // pauseAudio();
    // player.pause();
    // setState((){audioState='stopped';});
    // timer?.cancel();
    // player.dispose();
    super.dispose();
    //player.pause();
    //player.dispose();

  }

   
  playAudio(audioUrl) async{  
    var playSeconds=position.inSeconds.remainder(60).toString().padLeft(2, '0');
    if(playSeconds!='00'){
        setPosistion(position);
    }else{      
      var d = await player.setUrl(audioUrl);
        setState(() { 
          duration = d;     
        });
      await player.play();
    }    
  }

  setPosistion(Duration p) async{
    await player.play();
    await player.seek(p);
  }

  pauseAudio() async{
    await player.pause();
  } 

  stopAudio() async{
    await player.stop();
  }

  getPosition() {
    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (mounted) {
        if (widget.audioStop == true) {
          stopAudio();
          timer.cancel();
          player.dispose();
          return;
        }
        var p = player.position;        
        if (audioState == 'played') {
          timerCounter+=1;
          if((timerCounter)%10==0){             
            fileTrackingWeekly();
            //fileTracking();
          }
          setState(() {
            position = p;
          });
        } else {
          timer.cancel();
        }
      }
    });
  }

  getPositionNew() {
    timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (mounted) {
        if (widget.audioStop == true) {
          stopAudio();
          timer.cancel();
          player.dispose();
          return;
        }
        var p = player.position;        
        if (audioState == 'played') {
          timerCounter+=1;
          if((timerCounter)%10==0){
          }
          setState(() {
            position = p;
          });
        } else {
          timer.cancel();
        }
      }
    });
  }

  initAudio() {
    player.playerStateStream.listen((state) {
      if (mounted) {
        if (widget.audioStop == true) {
          stopAudio();
          timer.cancel();
          player.dispose();
          return;
        }

        if (state.playing && audioState!="played") {
          getPosition();
          // if (widget.audioPlaytype == "practice") {
          //   getPosition();
          // }else{
          //   getPositionNew();
          // }
          setState(() {
            audioState = 'played';
          });
        } else {
          setState(() {
            audioState = 'stopped';
          });
          timer?.cancel();
        }
      }
    });
  }

  reStart() async {
    await player.seek(Duration.zero);
    await player.play();
  }

  mute1() async {
    await player.setVolume(0);
  }  

  setAudio(v) async {
    (v==0) ? 1 : 0;
    await player.setVolume(v);
  }

  void didPushNext() {
    player.play();
    dispose();
  }

  void didPop() {
    player.pause();
    dispose();
  }

  mute() async {
    var v = player.volume;
    v=v>0?0:1;
    await player.setVolume(v);
  }

  // Future<void> fileTracking() async {
  //   try { 
  //   currentTime = position.inSeconds.toString();
  //   totalTime = duration.inSeconds.toString(); 

  //   final data = await updatePracticeContent(<String, dynamic>{
  //     "practice_resource_id":widget.practiceResourceId,
  //     "progress_time":currentTime,
  //     "total_time":totalTime,
  //   });	
  //   if (data['status'] == "success") {	
  //     widget.audioCallback({"totalTime" : totalTime,"currentTime":currentTime});
  //   } else {	      
  //     if (data['is_valid'] == false) {	
  //       setState(() {	
  //         Navigator.of(context, rootNavigator: true).pop();	
  //       });
  //       Navigator.pushNamed(context, '/signin');
  //     } else {	
  //       setState(() {	
  //         Navigator.of(context, rootNavigator: true).pop();	
  //       });
  //       errortoast(data['msg']);	
  //     }		
  //   }	
  //  } catch (err) {
  //     Navigator.of(context, rootNavigator: true).pop();	
  //     print('Caught error: $err');
  //   }
  // }

   Future<void> fileTrackingWeekly() async {
    try { 
    currentTime = position.inSeconds.toString();
    totalTime = duration.inSeconds.toString(); 

    final data = await updatePracticeWeek(<String, dynamic>{
      "class_practice_id":widget.practiceResourceId,
      "left_player_time":currentTime,
      "total_player_time":totalTime,
      "resource_id" : widget.resourceId
    });	
    if (data['status'] == "success") {	
      widget.audioCallback({"totalTime" : totalTime,"currentTime":currentTime});
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
    var possec = position.inSeconds- position.inMinutes*60;
    var dursec = duration.inSeconds- duration.inMinutes*60;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.PRIMARY_COLOR,
        borderRadius: new BorderRadius.circular(10.0),                            
        boxShadow: [
          BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
        ],
      ),
      child : ListTile(     
            contentPadding: EdgeInsets.only(left: 20,right: 20,top: 5.0, bottom: 5),               
            leading: InkWell(
              child: isPlay ?  
              InkWell(child: Icon(GeminiIcon.pause,size: 34, color: AppColors.LIGHT_ORANGE),
              onTap: () => {
                pauseAudio(),
                setState(() {
                  isPlay = !isPlay;
                }),
              },  
              ) :
              InkWell(child: Icon(GeminiIcon.play,size: 34, color: AppColors.LIGHT_ORANGE),
              onTap: () => {
                playAudio(widget.url),
                setState(() {
                  isPlay = !isPlay;
                }),
              },  
            ),
            onTap: () => {
              setState(() {
                isPlay = !isPlay;
              }),
            },
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: new Text(widget.title.toString(), style: AppCss.blue14semibold,overflow: TextOverflow.ellipsis),
            ),
            trailing: Wrap(
              children: [
                new Text(position.inMinutes.toString()+"."+possec.toString(), style: AppCss.boldgrey12bold),
                new Text('/'+duration.inMinutes.toString()+"."+dursec.toString(), style: AppCss.boldgrey12regular),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: InkWell(child: Icon(GeminiIcon.volume_up,size: 19, color: AppColors.DEEP_BLUE),
                  onTap: () async { 
                    await mute(); 
                  },  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.8),
                  child: InkWell(child:  Icon(GeminiIcon.replay,size: 19, color: AppColors.DEEP_BLUE),
                  onTap: () async {
                    await player.seek(Duration.zero);
                    setState( () {
                      player.play();
                    } );
                  },
                  ),
                ),
            ],),
          ),
      );
  }
}
