import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
 
class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List users;
  Map datas;
  Future setUser() async{
    String url = "https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=yellow+flowers&image_type=photo&pretty=true";
    http.Response response = await http.get(url);
    datas = json.decode(response.body);
   setState(() {
      users = datas['hits'];
   });
  }
  @override
  void initState(){
    setState(() {
      super.initState();
      setUser();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text("API"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users == null ? 0 : users.length,
        itemBuilder: (BuildContext context, int i){
          return Card(
               child: Column(
                 children: <Widget>[
                     Container(
                       child: Row(
                         children: <Widget>[
                           CircleAvatar(
                          backgroundImage: NetworkImage(users[i]["userImageURL"]),
                          ),
                            SizedBox(width: 10.0),
                            Text("${users[i]["user"]}"),
                         ],
                       ),
                     ),
                     Container(
                       child: Column(
                         children: <Widget>[
                            Image.network("${users[i]["largeImageURL"]}"),
                         ],
                       ),
                     ),
                 ],
               ),
          );
        }
      ),
    );
  }
}