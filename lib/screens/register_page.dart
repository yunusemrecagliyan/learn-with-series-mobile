import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lernwithseries/_constants/app_contstants.dart';
import 'package:lernwithseries/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
  final authService = AuthService();
}

class _RegisterPageState extends State<RegisterPage> {
  String identifier = "";
  String password = "";
  String username = "";
  String name = "";
  String lastname = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: FlatButton.icon(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          label: Text("Geri"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipPath(
                  clipper: RegisterClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.orange,
                    child: Text("data"),
                  ),
                ),
                Text(
                  "Dizilerle İngilizce öğren",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: loginForm(context),
            )
          ],
        ),
      ),
    );
  }

  Widget loginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: "Adı"),
          validator: (val) =>
              val != "" ? "Lütfen kullanıcı adını giriniz." : val,
          onChanged: (value) {
            setState(() {
              this.name = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Soyadı"),
          validator: (val) =>
              val != "" ? "Lütfen kullanıcı adını giriniz." : val,
          onChanged: (value) {
            setState(() {
              this.lastname = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Kullanıcı Adı"),
          validator: (val) =>
              val != "" ? "Lütfen kullanıcı adını giriniz." : val,
          onChanged: (value) {
            setState(() {
              this.username = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Email"),
          validator: validateEmail,
          onChanged: (value) {
            setState(() {
              this.identifier = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Şifre"),
          obscureText: true,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              this.password = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () async {
              try {
                var jwt = await json.decode(await this
                    .widget
                    .authService
                    .register(
                        name: name,
                        email: identifier,
                        lastname: lastname,
                        password: password,
                        username: username));
                this.widget.authService.setToken(jwt["jwt"]);
                Navigator.pushNamed(context, RoutePaths.Home);
              } catch (e) {
                print(e);
              }
            },
            child: Text('Giriş'),
          ),
        ),
      ],
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Lütfen geçerli bir email adresi girin.';
    else
      return null;
  }
}

class RegisterClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(170, 0);
    path.quadraticBezierTo(124, 50, (2 * size.width) / 5, size.height / 5 + 60);
    path.quadraticBezierTo(
        200, 160, (8 * size.width) / 12, (7 * size.height) / 12);

    path.quadraticBezierTo(
        size.width - 40, 175, size.width - 20, size.height - 30);
    path.quadraticBezierTo(
        size.width + 20, size.height + 20, size.width, size.height);
    // path.quadraticBezierTo(350, 175, size.width, size.height);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(RegisterClipper oldClipper) => true;
}