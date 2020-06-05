import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:the_high_space/searchpage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


    var apidata;

    getAPIdata()async{
     Response response = await get("https://extendsclass.com/api/json-storage/bin/deddffc");
       var data =  jsonDecode(response.body);
       return data;
    }
    @override
  void initState() {
    // TODO: implement initState
    getAPIdata().then((data){
      setState(() {
        apidata  = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return apidata == null?
    Scaffold(
      backgroundColor: Colors.pink,
      body: Center(child: Text("The High Space",style: TextStyle(color:Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),),
    ):
     Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 50,
          padding: EdgeInsets.all(0),
          child: TextField(
            showCursor: true,
            readOnly: true,
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchPage(apidata)));
            },
            decoration: InputDecoration(
              hintText: "Try restaurants,coffee",
              hintStyle: TextStyle(fontSize: 20),
              prefixIcon: Icon(Icons.menu,color: Colors.black,),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 10,style: BorderStyle.solid))
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 0,left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Explore Events Now",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,),),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: apidata["Explore Events Now"].length,
                      itemBuilder: (context,i){
                        return Stack(
                          children: <Widget>[
                            Container(
                            margin: EdgeInsets.all(5),
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: NetworkImage(apidata["Explore Events Now"][i]["iconURL"].toString()),fit: BoxFit.cover),
                            ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 10,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 130
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(apidata["Explore Events Now"][i]["name"].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20))
                              ),
                            )

                          ],
                        );
                      }),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Ongoing Events",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,),),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 230,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: apidata["Ongoing Events"].length,
                      itemBuilder: (context,i){
                        return Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5),
                              height: 230,
                              width: MediaQuery.of(context).size.width -30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: NetworkImage(apidata["Ongoing Events"][i]["iconURL"].toString()),fit: BoxFit.cover),
                              ),
                            ),
                            
                            Positioned(
                              bottom: 20,
                              left: 10,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width -45
                                ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(apidata["Ongoing Events"][i]["name"].toString(),softWrap: true,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
                                      Text("${apidata["Ongoing Events"][i]["type"]}.${apidata["Ongoing Events"][i]["location"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)
                                    ],
                                  )
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Container(
                                padding:EdgeInsets.all(10),
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                                ),
                                child: Center(
                                  child: Text(apidata["Ongoing Events"][i]["dateTime"].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
    Container(
    padding: EdgeInsets.all(10),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text("Upcoming Events",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,),),
    ),
    SizedBox(height: 10,),
    Container(
    height: 200,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: apidata["Upcoming Events"].length,
    itemBuilder: (context,i){
    return Stack(
    children: <Widget>[
    Container(
    margin: EdgeInsets.all(5),
    height: 200,
    width: 200,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    image: DecorationImage(image: NetworkImage(apidata["Upcoming Events"][i]["iconURL"].toString()),fit: BoxFit.cover),
    ),
    ),
    Positioned(
    bottom: 10,
    left: 10,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: 180
      ),
    padding: EdgeInsets.all(10),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text(apidata["Upcoming Events"][i]["name"].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
    Text("${apidata["Upcoming Events"][i]["type"]}.${apidata["Upcoming Events"][i]["location"]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)
    ],
    )
    ),
    ),
    Positioned(
    top: 20,
    left: 20,
    child: Container(
    padding:EdgeInsets.all(10),
    decoration:BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white
    ),
    child: Center(
    child: Text(apidata["Upcoming Events"][i]["dateTime"].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
    ),
    ),
    )
    ],
    );
    }),
    )
              ],
            ),
          )
        ],
      ),
    )]));
  }
}
