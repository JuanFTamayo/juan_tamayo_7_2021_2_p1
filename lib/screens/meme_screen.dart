import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:parcialjuantamayo/components/loader.dart';
import 'package:parcialjuantamayo/helpers/constans.dart';
import 'package:http/http.dart' as http;
import 'package:parcialjuantamayo/models/meme.dart';
import 'package:parcialjuantamayo/screens/memedetail_screen.dart';

class MemeScreen extends StatefulWidget {
  const MemeScreen({ Key? key }) : super(key: key);

  @override
  _MemeScreenState createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  List<Meme> list= [];
  List<Meme> filter= [];
  bool searched= false;
  bool loader = false;
  @override
  void initState() {
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: loader? LoaderComponent(text: 'cargando...',): _author(),
    );
  }

  

  Widget _author() {
    return ListView(
      children: list.map((e) {
        return Card(
          child: Flexible(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailMeme(
                            meme: e,
                          )));
            },
            
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                    e.submissionTitle,
                      
                    style: const TextStyle(fontSize: 15),
                  ),),
                  /*ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      e.submissionUrl,
                      width: 50,
                    ),
                  ),*/
                  
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          ),
          
        );
      }).toList(),
    );
  }

  void getdata() async {
    setState(() {
      loader= true;
    });
    var connecResult = await Connectivity().checkConnectivity();
    if (connecResult == ConnectivityResult.none) {
      setState(() {
        loader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'ERROR!',
          message: 'Verifica tu conexion a internet!',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar')
          ]);
      return;
    }
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
    if (decodedJson != null) {
      for (var item in decodedJson['data']) {
        list.add(Meme.fromJson(item));
      }
    }
    setState(() {
      loader = false;
    });
  }
}