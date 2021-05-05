import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkid/LoSi/Info.dart';
import 'package:linkid/LoSi/Login.dart';
import 'package:linkid/LoSi/SignUp.dart';
import 'package:linkid/LoSi/choose.dart';
import 'package:linkid/Screens/InterestPage.dart';
import 'package:linkid/Screens/Interest_List.dart';
import 'package:linkid/Screens/MessagePage.dart';
import 'package:linkid/Screens/pagez.dart';
import 'package:linkid/Wrapper/wrapper.dart';
import 'package:linkid/Services/auth.dart';
import 'package:linkid/models/common.dart';
import 'package:linkid/models/user.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "DoppioOne",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Wrapper(),
    ),
    );
  }
}
