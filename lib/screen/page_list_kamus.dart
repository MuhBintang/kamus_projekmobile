import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kamus_trpl3b/model/model_kamus.dart';
import 'package:kamus_trpl3b/screen/login_screen.dart';
import 'package:kamus_trpl3b/screen/page_detail_kamus.dart';
import 'package:kamus_trpl3b/utils/cek_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageListKamus extends StatefulWidget {
  const PageListKamus({Key? key}) : super(key: key);

  @override
  State<PageListKamus> createState() => _PageListKamusState();
}

class _PageListKamusState extends State<PageListKamus> {
  String? id, username;
  List<Datum>? _kamusList;
  List<Datum>? _searchResult;

  @override
  void initState() {
    super.initState();
    getKamus();
    getSession();
  }

  Future<void> getKamus() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.100.8/kamusDb/getKamus.php'));
      if (response.statusCode == 200) {
        setState(() {
          _kamusList = modelBeritaFromJson(response.body).data;
        });
      } else {
        throw Exception('Failed to load kamus');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      username = pref.getString("username");
    });
  }

  void _searchKamus(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResult = null;
      });
      return;
    }

    setState(() {
      _searchResult = _kamusList?.where((kamus) => kamus.kosakata.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Kamus Inggris'),
        backgroundColor: Colors.lightBlue,
        actions: [
          Row(
            children: [
              Text("Hi... $username"),
              IconButton(
                onPressed: () {
                  setState(() {
                    session.clearSession();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  });
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _searchKamus,
                decoration: InputDecoration(
                  labelText: 'Search Keyword',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResult?.length ?? _kamusList?.length ?? 0,
                itemBuilder: (context, index) {
                  Datum? data = _searchResult?[index] ?? _kamusList?[index];
                  return Padding(
                    padding: EdgeInsets.all(0.2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageDetailKamus(data)),
                        );
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                "${data?.kosakata}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
