import 'package:flutter/material.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';

class Buddies extends StatefulWidget {
  final String userId;
  const Buddies({Key? key,required this.userId}) : super(key: key);
  @override
  _BuddiesState createState() => _BuddiesState();
}

class _BuddiesState extends State<Buddies> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var buddiesList = [];
  var  profilePicture;
  
  void initState() {    
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    allBuddies();
    super.initState();
  }

  Future<void> allBuddies() async {
    try {
      final data = await getBuddies(<String, dynamic>{});
      if (data['status'] == "success") {       
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          buddiesList = data['data'];
                 
        });
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
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }	
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: buddiesList.isEmpty ? Container() : ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>	
        Padding(padding: EdgeInsets.only(right: 15)),
        shrinkWrap: true,        
        scrollDirection: Axis.horizontal,
        itemCount: buddiesList.length,
        itemBuilder: (context, index) {
        profilePicture = (buddiesList[index]['profile_picture'].isNotEmpty);
        return Column(
        children: <Widget>[
          profilePicture ?
          Stack(
            children: <Widget>[
              ClipRRect(
              borderRadius: BorderRadius.circular(100.0),                                
              child: Image.network(isImageCheck(buddiesList[index]['profile_picture']),
              width: 60,height: 60,
              ),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 4.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ) : 
          Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage('assets/images/profile/Ellipse-17.png'),
              ),
              Positioned(
                right: 1.0,
                bottom: 1.0,
                child: CircleAvatar(
                  radius: 4.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ]
        );
        }
      ),
    );
  }
}