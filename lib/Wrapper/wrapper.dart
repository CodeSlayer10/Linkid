import 'package:linkid/LoSi/choose.dart';
import 'package:linkid/LoSi/SignUp.dart';
import 'package:linkid/Screens/InterestPage.dart';
import 'package:linkid/Screens/Interest_List.dart';
import 'package:linkid/Screens/pagez.dart';
import 'package:linkid/Services/auth.dart';
import 'package:linkid/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(Wrapper());

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user1 = Provider.of<User>(context);
    // final user = Provider.of<User>(context);
    // if (user1 == null) {
    //   return  Choose();
    // } else {
    //   return InterestList();
    // }
    return StreamBuilder<User>(
        stream: AuthService().user,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Pagez();
          else
            return Choose();
        });
  }
}




