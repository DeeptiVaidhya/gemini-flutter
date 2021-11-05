import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/library/fliters.dart';
import 'package:gemini/pages/library/library-details.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/library.dart';

class AllLibrary extends StatefulWidget {
  final String type;
  const AllLibrary({Key? key, required this.type}) : super(key: key);
  @override
  _AllLibraryState createState() => _AllLibraryState();
}

class _AllLibraryState extends State<AllLibrary> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var currentSelectedValue;
  var libraryList = [];
  var sortByList = [];
  var listActivity = {};
  var libraryID;
  var type;
  var filterValue = "";
  var sortValue;
  dynamic idIndex;

  @override
  void initState() {
    type = widget.type;
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    allLibraryList();
    super.initState();
  }

  Future<void> allLibraryList([popRoute=true]) async {
    try {
      final data = await getLibraryList(<String, dynamic>{
        "sort_by": sortValue,
        // "menu": (type == "my") ? "-2" : "",
        "menu": type,
        "filter": filterValue
      });
      if (data['status'] == "success") {
        setState(() {
          if(popRoute){
            Navigator.of(context, rootNavigator: true).pop();
          }          
          libraryList = data['data']['list'];
          libraryList.forEach((list) {
            idIndex = list['id'];
            listActivity[idIndex] = {'is_favorite': list['is_favorite']};
          });
        });
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

  favUnfavorite(idlibraryID) async {
    final data = await favUnfavoritePost(<String, dynamic>{"resource_id": idlibraryID});
    if (data['status'] == "success") {
      if (listActivity.containsKey(idlibraryID)) {
        listActivity[idlibraryID]['is_favorite'] = !listActivity[idlibraryID]['is_favorite'];
        setState(() {
          listActivity;
        });
      }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Container(
                    child: Row(
                      children: filters(
                        context,
                        type,
                        (filter) => {filterValue = filter, allLibraryList()}),
                    ),
                  ), 
                 trailing: Container(
                   margin: EdgeInsets.only(right: 19),
                   child: SortBy(
                    sortByValue: sortValue,
                    onSortVal: (sortVal) => {
                      sortValue = sortVal,
                      allLibraryList(false)
                    }),
                 ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40, left: 20.0, right: 20.0),
                  child: libraryList.isEmpty
                 ? Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40, left: 40, right: 40),
                    child: Text( "No library list yet.", style: AppCss.grey12medium,textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                    Container(margin: EdgeInsets.only(bottom: 16)),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: libraryList.length,
                    itemBuilder: (context, index) {
                      libraryID = libraryList[index]['id'];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.PRIMARY_COLOR,
                          borderRadius: new BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.SHADOWCOLOR,
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset: Offset(0, 3))
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(left: BorderSide(width: 6.0,color: AppColors.DEEP_BLUE)),
                            ),
                            child: ListTile(
                              minLeadingWidth: 0,
                              horizontalTitleGap: 0.0,
                              isThreeLine: true,
                              dense: true,
                              title: Container(
                                margin: const EdgeInsets.only(top: 10, left: 5.0, right: 105.0),
                                child: (libraryList[index]['created_at'] !=null)
                                ? Text(dateTimeFormate(libraryList[index]['created_at']),
                                style: AppCss.mediumgrey10bold,textAlign: TextAlign.left)
                                : Container(),
                              ),
                              subtitle: Container(
                                margin: const EdgeInsets.only(top: 1,left: 5.0,right: 35.0,bottom: 21),
                                child: Text(isVarEmpty(libraryList[index]['title']).toString(),
                                style: AppCss.blue16semibold,textAlign: TextAlign.left),
                              ),
                              trailing: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    child: InkWell(
                                      onTap: (() {
                                        favUnfavorite(libraryList[index]['id']);
                                      }),
                                      child: listActivity[libraryList[index]['id']]['is_favorite']
                                      ? Image.asset('assets/images/icons/fav-like/fav-like.png',width: 20.0,
                                          height: 17.79)
                                      : Image.asset(
                                          'assets/images/icons/fav-unlike/fav-unlike.png',
                                          width: 20.0,
                                          height: 17.79)
                                  ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.21, 20, 10, 10),
                                    child: Image.asset("assets/images/icons/chevron-thin/chevron-thin.png",
                                    width: 9.0,height: 15.32),
                                  ),
                              ]),
                              onTap: () {
                                var topicId = isVarEmpty(libraryList[index]['id']);
                                var url = "/library-details/$topicId";
                                Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                settings:RouteSettings(name: url),
                                builder: (context) =>
                                LibraryDetails(topicId: topicId!,title: libraryList[index]
                                ['title'])));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
