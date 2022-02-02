import 'package:flutter/material.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/library.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

List<Widget> filters(context, type, onFilter) {
  return <Widget>[
    InkWell(
      child: Row(children: <Widget>[
        Text("Filter", style: AppCss.blue12semibold),
        SizedBox(
          width: 5,
          height: 5,
        ),
        Icon(GeminiIcon.filter, size: 18, color: AppColors.DEEP_BLUE)
      ]),
      onTap: () {
        modalPopup(
            context,
            AppColors.DEEP_BLUE,
            Filtercontent(onFilter: onFilter),
            335,
            652,
            1,
            "library", onFilter);
      },
    ),
  ];
}



class Filtercontent extends StatefulWidget {
  final onFilter;
  const Filtercontent({Key? key, required this.onFilter}) : super(key: key);
  @override
  _FiltercontentState createState() => _FiltercontentState();
}

class _FiltercontentState extends State<Filtercontent> {
  var filterList = [];
  late String local;
  dynamic onFilter;
  bool isselected =false;
  var selectedId = '';
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    onFilter = widget.onFilter;
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loader(context, _keyLoader));
    getLibraryFilter();
  }

  Future<void> getLibraryFilter() async {
    try {
      final data = await getLibraryFilterMenu(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          filterList = data['data']['filter'];
        });
        onSelect(-1);
      } else {
        if (data['is_valid']) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          toast(data['msg']);
        } else {
          Navigator.pushNamed(context, '/library');
          Navigator.of(context, rootNavigator: true).pop();
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  onSelect(sIndex, [isSelect = false]) {
    var dFilter = [];
    filterList.asMap().forEach((index, fltr) {
      fltr['isChecked'] = sIndex == index ? isSelect : false;
      dFilter.add(fltr);
    });
    setState(() {
      filterList:dFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Container(margin: EdgeInsets.only(bottom: 5)),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppColors.TRANSPARENT, width: 0.5)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4, bottom: 4),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4, left: 20, right: 20),
                              child: Container(
                                width: 251,
                                child: (filterList[index]['week_number'] !=null) ? Text("Class "+filterList[index]['week_number']+" - " +filterList[index]['title'],style: AppCss.grey14regular) :Text(filterList[index]['title'],style: AppCss.grey14regular)
                              ),
                            ),
                            Container(
                              width: 21,
                              height: 21,
                              child: RoundCheckBox(
                                onTap: (selected) {
                                  onSelect(index, selected);
                                  selectedId = filterList[index]['id'];
                                  isselected = true;
                                },
                                //border: isselected ? Border.all(color: AppColors.LIGHT_GREY,width: 1.5) : null,
                                checkedWidget: Icon(Icons.done,size: 13, color: AppColors.PRIMARY_COLOR), 
                                uncheckedColor: AppColors.PRIMARY_COLOR,
                                checkedColor: AppColors.DEEP_BLUE,
                                isChecked: filterList[index]['isChecked'],                                
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: buttion(
                  btnwidth = 275,
                  btnheight = 36,
                  btntext = 'APPLY',
                  AppCss.blue13bold,
                  AppColors.PALE_BLUE,
                  btntypesubmit = true, () {
                onFilter(selectedId);
              }, 9, 9, 106, 106, context),
            ),
          ],
        ),
      ),
    );
  }
}

class SortBy extends StatefulWidget {
  final onSortVal;
  final sortByValue;
  const SortBy({Key? key, required this.onSortVal, required this.sortByValue})
      : super(key: key);
  @override
  _SortByState createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  //final GlobalKey<State> _key = new GlobalKey<State>();
  var sortByList = [];
  var _chosenValue;
  dynamic onSortVal;

  @override
  void initState() {
    onSortVal = widget.onSortVal;
    _chosenValue = widget.sortByValue;
    getSortByFilter();
    super.initState();
  }

  Future<void> getSortByFilter() async {
    try {
      final data = await getLibraryFilterMenu(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          sortByList = data['data']['sort_by'];

        });
      } else {
        if (data['is_valid']) {
          toast(data['msg']);
        } else {
          Navigator.pushNamed(context, '/');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      print('Caught error: $err');
    }
  }

  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text("Sort by", style: AppCss.blue12semibold),
      value: _chosenValue,
      underline: Container(),
      icon: Icon(Icons.keyboard_arrow_down, color: AppColors.DEEP_BLUE),
      iconSize: 22.0,
      iconEnabledColor: AppColors.DEEP_BLUE,
      items: sortByList.map((item) {
        return DropdownMenuItem<String>(
          value: item['id'].toString(),
          child: Text(item['title'].toString(), style: AppCss.blue12semibold));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _chosenValue = (value != '') ? value : null;
        });
        onSortVal(value);
      },
    );



    //  return Container(
    //   child: Padding(
    //     padding:EdgeInsets.only(right:20),
    //     child : PopupMenuButton(
    //       shape: RoundedRectangleBorder(
    //         side: BorderSide(color: Colors.white),
    //         borderRadius: BorderRadius.circular(10)
    //       ),
    //       enabled: true,
    //       onSelected: (value) {
    //         setState(() {
    //             _chosenValue = value;
    //         });
    //         onSortVal(value);
    //       },
    //       itemBuilder:(context) {
    //         return sortByList.map((item) {
    //           return PopupMenuItem(
    //             value: item['id'],
    //             child: Text(item['title'], style: AppCss.blue12semibold)
    //           );
    //         }).toList();
    //       },
    //     ),

    //   ),
    // );
  }
}

class Item {
}
