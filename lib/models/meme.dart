import 'package:parcialjuantamayo/models/data.dart';

class meme {
  int total=0;
  int count=0;
  List<Data> data=[];

  meme({
    required this.total,
    required this.count,
    required this.data
  });

  meme.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    
    return data;
  }
}