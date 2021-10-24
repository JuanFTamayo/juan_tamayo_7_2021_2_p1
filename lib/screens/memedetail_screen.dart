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
          ]
        ),
    );
  }

 

  void _getMemeDetail() async {
    var url = Uri.parse(Constans.apiUrl + '/' + widget.meme.submissionTitle);
    var response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    
  }
}