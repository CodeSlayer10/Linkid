import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/LoSi/Info.dart';
import 'package:linkid/Services/auth.dart';
import 'package:linkid/items/UnderLine.dart';

class Login extends StatefulWidget {
  Function toggle;
  Login(this.toggle);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pass = '';
  String error = '';
  // String error1 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12, left: MediaQuery.of(context).size.width / 13),
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 5,
                      child: SvgPicture.asset("assets/icon.svg")),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 12, left: MediaQuery.of(context).size.width / 30),
                    child: AutoSizeText("Linkid", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 45, minFontSize: 42,),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.7, left: MediaQuery.of(context).size.width / 8),
                child: AutoSizeText("Welcome Back. \nyou've been missed!", style: TextStyle(color: Colors.white), maxLines: 2, maxFontSize: 32, minFontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.2, left: MediaQuery.of(context).size.width / 7),
                child: textFormField("Email", 1, false),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.75, left: MediaQuery.of(context).size.width / 7),
                child: textFormField("Password", 0, true),
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.Signin(email, pass);
                    if (result == null) {
                      setState(() {
                        error = 'incorrect credentials';
                      });
                    }
                    // dynamic result = await _auth.Register(username, password);
                    // if (result ==  null) {
                  }

                },
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.45, left: MediaQuery.of(context).size.width / 7.1),
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 200, left: MediaQuery.of(context).size.width / 30),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 16,
                  decoration: BoxDecoration(
                    color: Color(0xffc4c4c4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: AutoSizeText("Login", style: TextStyle(color: Colors.white), maxLines: 1, maxFontSize: 36, minFontSize: 34,),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.2, left: MediaQuery.of(context).size.width / 7),
                child: UnderLine(
                  text: "don't have an account?",
                  text1: "SignUp",
                  onTap: (){widget.toggle(1);},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget textFormField(String text, int iz, bool one){
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 80, left: MediaQuery.of(context).size.width / 50),
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 17,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffc4c4c4).withOpacity(0.4), width: 5),
      ),
      child: TextFormField(
        keyboardType: iz == 1 ? TextInputType.emailAddress : null,
        obscureText: one,
        validator: iz == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
        style: TextStyle(color: Colors.white),
        // validator: one1 == 1 ? (val) => val.isEmpty ? 'Enter Email' : null : (val) => val.isEmpty ? 'Enter Password' : null,
        decoration: InputDecoration(
          // labelText: one1 == 1 ? error1.isEmpty ? "Email" : error1 : error1.isEmpty ? "Password" : error1,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: text,
        ),
        onChanged: (val){
          if(iz == 1) {
            email = val;
          } else {
            pass = val;
          }
        },
      ),
    );
  }
}



