import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcialjuantamayo/helpers/constans.dart';
import 'package:parcialjuantamayo/models/meme.dart';

class DetailMeme extends StatefulWidget {
  final Meme meme;

  DetailMeme({required this.meme});

  @override
  _DetailMemeState createState() => _DetailMemeState();
}

class _DetailMemeState extends State<DetailMeme> {
  bool loader=false;
  @override
  void initState() {
    _getMemeDetail();
    
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('${widget.meme.submissionTitle}'),
          backgroundColor: Color(0xFF12B0E8),
        ),
        body: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.meme.submissionUrl,
                        width: 250,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            memeList()
          ],
        ),
    );
  }

  Widget memeList(){
    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          
          Card(
          child: Flexible(
          child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          color: Color(0xFF12B0E8),
          child: Column(
            children: <Widget>[
              Text('Nombre:',
               style: const TextStyle(
               color: Color(0xFF000000),
               fontSize: 20,
               fontWeight: FontWeight.bold
               )
               ),
              SizedBox(height: 18,),
              Text('${widget.meme.submissionTitle}',
               style: const TextStyle(color: Color(0xFF000000),
                fontSize: 18,)),
                SizedBox(height: 5,),
                Text('Autor:',
               style: const TextStyle(
               color: Color(0xFF000000),
               fontSize: 20,
               fontWeight: FontWeight.bold
               )
               ),
              SizedBox(height: 18,),
              Text('${widget.meme.author}',
               style: const TextStyle(color: Color(0xFF000000),
                fontSize: 18,)),
                 SizedBox(height: 5,),
                Text('Fecha de creacion:',
               style: const TextStyle(
               color: Color(0xFF000000),
               fontSize: 20,
               fontWeight: FontWeight.bold
               )
               ),
              SizedBox(height: 18,),
              Text('${widget.meme.created}',
               style: const TextStyle(color: Color(0xFF000000),
                fontSize: 18,)),
                SizedBox(height: 5,),
                Text('tiempo:',
               style: const TextStyle(
               color: Color(0xFF000000),
               fontSize: 20,
               fontWeight: FontWeight.bold
               )
               ),
              SizedBox(height: 18,),
              Text('${widget.meme.timestamp}',
               style: const TextStyle(color: Color(0xFF000000),
                fontSize: 18,)),
            ],
            
          ),
         ),

         ),
        ),
      
          
        
        ]
      ),
    );
    
  }

  void _getMemeDetail() async {
    setState(() {
        loader = true;
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
    var url = Uri.parse(Constans.apiUrl + '/' + widget.meme.submissionTitle);
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    setState(() {
        loader = false;
      });
  }
}