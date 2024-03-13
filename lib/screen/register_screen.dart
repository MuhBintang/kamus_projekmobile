import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kamus_trpl3b/screen/login_screen.dart';

import 'package:kamus_trpl3b/model/model_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

    GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;
  Future<ResRegister?> registerAccount() async{
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(Uri.parse("http://192.168.100.8/kamusDb/register.php"), body: {
        "fullname": fullname.text,
        "username": username.text,
        "password": password.text,
        "email": email.text,
      });
      ResRegister data = resRegisterFromJson(res.body);

      if (data.value == 1) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data.message}")));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
        });
      } else if (data.value == 2){
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data.message}")));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data.message}")));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Page Register'),
      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Form(key: keyForm, child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
            controller: fullname,
            validator: (val) {
              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
            },
            decoration: InputDecoration(
              hintText: "FULLNAME",
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(6), 
                borderSide: BorderSide.none),
                filled: true, 
                fillColor: Colors.grey.withOpacity(0.2)
            ), 
          ), SizedBox(height: 8,),
          TextFormField(
            controller: username,
            validator: (val) {
              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
            },
            decoration: InputDecoration(
              hintText: "USERNAME",
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(6), 
                borderSide: BorderSide.none),
                filled: true, 
                fillColor: Colors.grey.withOpacity(0.2)
            ), 
          ), SizedBox(height: 8,),
          TextFormField(
            controller: email,
            validator: (val) {
              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
            },
            decoration: InputDecoration(
              hintText: "EMAIL",
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(6), 
                borderSide: BorderSide.none),
                filled: true, 
                fillColor: Colors.grey.withOpacity(0.2)
            ), 
          ), SizedBox(height: 8,),
          TextFormField(
            controller: password,
            validator: (val) {
              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
            },
            decoration: InputDecoration(
              hintText: "PASSWORD",
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(6), 
                borderSide: BorderSide.none),
                filled: true, 
                fillColor: Colors.grey.withOpacity(0.2)
            ), obscureText: true
          ), SizedBox(height: 25,),
          Center(child: isLoading ? Center(child: CircularProgressIndicator(),) 
          : MaterialButton(minWidth: 150, height: 45, color: Colors.lightBlue,
          onPressed: () {
            if (keyForm.currentState?.validate() == true){
              registerAccount();
            }
          },
          child: Text("REGISTER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
          ),),
        ),
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.all(16.0),
        child: MaterialButton(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), 
          side: BorderSide(width: 1, color: Colors.white)
        ), 
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
          },
          child: Text("Anda Sudah Punya Akun? Silahkan Login"),
        ),
      ),
    );
  }
}