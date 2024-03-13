import 'package:flutter/material.dart';
import 'package:kamus_trpl3b/model/model_kamus.dart';

class PageDetailKamus extends StatelessWidget {
  final Datum? data;
  const PageDetailKamus(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          data!.kosakata
        ),
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          ListTile(
            title: Text(data?.deskripsi ?? "", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),), 
            trailing:  Icon(Icons.star, color: Colors.lightBlue,),
          ), 
          Container(
            margin: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
            child: Text(
              data?.deskripsi ?? "",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              // textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}