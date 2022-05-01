import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/utility/base_view_model.dart';

import '../../model/home_model.dart';
import '../../view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _searchview = new TextEditingController();

  @override
  void initState(){
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false)
        .getFutureList();


  }


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(model.homeModel?.title?? ""),
          automaticallyImplyLeading: false,
        ),
        body: model.state == ViewState.busy? Center(
          child: CircularProgressIndicator(),
        ):model.homeModel==null?Center(
          child: Text(
            'No Data found',
            style: Get.theme.textTheme.bodyText1!.copyWith(
                color: Colors.black,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ): Column(
          children: [
            _createSearchView(model),
            Expanded(child:
            ListView.builder(
                itemCount: model.rowsData!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  return RowItems(rows: model.rowsData![index],);
                }))
          ],
        ),
      );
    });
  }

  Widget _createSearchView(HomeViewModel? model) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: TextField(
        controller: _searchview,
        onChanged: (value) => model?.viewModelSearch(value),
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

}
class RowItems extends StatefulWidget {
  Rows? rows;
   RowItems({Key? key,this.rows}) : super(key: key);

  @override
  State<RowItems> createState() => _RowItemsState();
}

class _RowItemsState extends State<RowItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: widget.rows?.imageHref??"",
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          Container(
             // constraints: BoxConstraints.expand(), // ← this guy
              child: Text(widget.rows?.title??"")
          ),
          Container(
              //constraints: BoxConstraints.expand(), // ← this guy
              child: Text(widget.rows?.description??"")
          )
        ],
      ),
    );
  }
}


