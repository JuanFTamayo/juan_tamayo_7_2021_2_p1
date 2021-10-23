import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcialjuantamayo/helpers/constans.dart';
import 'package:http/http.dart' as http;
import 'package:parcialjuantamayo/models/Meme.dart';

class MemeScreen extends StatefulWidget {
  const MemeScreen({ Key? key }) : super(key: key);

  @override
  _MemeScreenState createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  List<Meme> list =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getmeme();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _author()
    );
  }

  Widget _logo() {
    return Image(
      image: AssetImage('assets/dogo.png'));
      
  }

  void _getmeme() async {
    
    var url = Uri.parse(Constans.apiUrl);
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    var body = response.body;
    var decodedJson = jsonDecode(body);
    var total = decodedJson['total'];
    var count = decodedJson['count'];
    if (decodedJson!= null) {
      for (var item in decodedJson['data']) {
        list.add(Meme.fromJson(item));
      }
    }
    print(total);
    print(count);
    print(list);

  }

  

    Widget _author() {
      
    return ListView(
      children: list.map((e) {
        return Card(
          child: InkWell(
            onTap: () {
             
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      e.submissionUrl,
                      width: 50,
                    ),
                  ),
                  Text(
                    e.submissionTitle,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  
}
}