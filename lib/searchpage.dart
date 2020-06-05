import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{

  final apidata;
  SearchPage(this.apidata);

  @override
  SearchPageState createState() {
    // TODO: implement createState
    return SearchPageState();
  }


}
class SearchPageState extends State<SearchPage>{

  List searchlist = [];
  List resultlist = [];

  search(String value){

    if(value.length == 0){
      setState(() {
        searchlist = [];
        resultlist = [];
      });
    }
    else{
      value = value.substring(0,1).toUpperCase() + value.substring(1);
      resultlist = [];
      widget.apidata["Explore Events Now"].forEach((element){
        if (value == element["name"].toString().substring(0,value.length)){
          searchlist.add(element);
        }
      });
      setState(() {
        resultlist.addAll(searchlist);
      });
      searchlist.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Container(
          height: 50,
          child: TextField(
            decoration: InputDecoration(

                hintText: "Try restaurants,coffee",
                hintStyle: TextStyle(fontSize: 20),
                prefixIcon: Icon(Icons.menu, color: Colors.black,),
                border: OutlineInputBorder(

                    borderSide: BorderSide(
                    color: Colors.black, width: 2, style: BorderStyle.solid))
            ),
            onChanged: (value) {
              search(value);
            },
          ),
        ),
      ),
      body: resultlist.length == 0 ?
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search,size: 50,),
                  Text("Search restaurants from your Explore Events Now",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              )
            ),
          ):
      ListView(
        children: BuildSearchList(),
      )

    );
  }
    List<Widget> BuildSearchList(){
      List<Widget> wlist = [];
      resultlist.forEach((element){
        wlist.add(Container(
          padding: EdgeInsets.all(20),
          child: Text(element["name"],style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
        ));
      });
      return wlist;
    }


}