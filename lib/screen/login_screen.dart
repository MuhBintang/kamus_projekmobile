import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kamus_trpl3b/screen/page_list_kamus.dart';
import 'package:kamus_trpl3b/screen/register_screen.dart';

import 'package:kamus_trpl3b/model/model_login.dart';
import 'package:kamus_trpl3b/utils/cek_session.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<RegisterScreen?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(
        Uri.parse("http://192.168.100.8/kamusDb/login.php"),
        body: {
          "username": username.text,
          "password": password.text,
        },
      );
      ModelLogin data = modelLoginFromJson(res.body);
      if (data.value == 1) {
        setState(() {
          session.saveSession(data.value ?? 0, data.id ?? "", data.username ?? "");

          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data.message}")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PageListKamus()),
            (route) => false,
          );
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data.message}")),
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Page Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: username,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    hintText: "USERNAME",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    hintText: "PASSWORD",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : MaterialButton(
                          minWidth: 150,
                          height: 45,
                          color: Colors.lightBlue,
                          onPressed: () {
                            if (keyForm.currentState?.validate() == true) {
                              loginAccount();
                            }
                          },
                          child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(width: 1, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
              (route) => false,
            );
          },
          child: const Text("Anda belum punya akun ? silahkan daftar"),
        ),
      ),
    );
  }
}