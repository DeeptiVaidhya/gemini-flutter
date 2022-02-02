import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/more/public-profile.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';

class BuddiesTab extends StatefulWidget {
  @override
  _BuddiesTabState createState() => _BuddiesTabState();
}

class _BuddiesTabState extends State<BuddiesTab> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var buddiesList = [];
  var profilePicture;
  var fullUsername;
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    allBuddies();
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
          Navigator.pushNamed(context, '/');
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
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
        return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 375,
              ),
              child: Column(
                children: [            
                  Container(
                  padding: const EdgeInsets.only(top:32,left:20,bottom: 40,right: 20),
                  child: buddiesList.isEmpty ? 
                    Container(
                      margin: const EdgeInsets.only(top:150,bottom: 150,left: 40,right: 40),
                      child: Text("You do not have any buddies at this time.",style: AppCss.grey12medium,textAlign: TextAlign.center,),
                    ) 
                    : 
                    GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: buddiesList.length,  
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                    crossAxisCount: 3,  
                    crossAxisSpacing: 8.0,  
                    mainAxisSpacing: constraints.maxWidth < 500 ? 3 : 8,
                    childAspectRatio: constraints.maxWidth < 500 ? height/800.0 : height /500,  
                    ),
                    itemBuilder: (BuildContext context, int index) {   
                    profilePicture = (buddiesList[index]['fullname'] !=null) & (buddiesList[index]['profile_picture'].isNotEmpty);
                    fullUsername = (buddiesList[index]['fullname'] !=null) & (buddiesList[index]['fullname'].isNotEmpty) ? buddiesList[index]['fullname'] : false;
                    return SingleChildScrollView(
                      child: GestureDetector(
                      onTap: () {  
                        var buddyId =  buddiesList[index]['buddy_user_id'];       
                        var url="/public-profile/$buddyId";                              
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute( 
                          settings: RouteSettings(name:url),
                          builder: (context) => new PublicProfile(buddyUserId:buddyId,type: "", postId: "")
                        )
                      );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          profilePicture !=false ? 
                          Center(
                            child: ClipRRect(                                
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              child: Image.network(buddiesList[index]['profile_picture'],fit: BoxFit.cover,width: 70.0,height: 70.0,
                              ),
                            ),
                          ) : ClipRRect(                                
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Image.asset("assets/images/profile/Ellipse-17.png",fit: BoxFit.cover,width: 70.0,height: 70.0,
                          ),
                            ),
                          fullUsername != false ? 
                          Padding(
                            padding: const EdgeInsets.only(left:20.0,top:9.0,right: 20.0),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child:Text(buddiesList[index]['fullname'],textAlign: TextAlign.center,
                                  style: AppCss.green10semibold),
                            ),
                          ) :Container(),
                        ],
                      ),
                      )
                    );
                    }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        );
        }
        )
      );
  }
}
