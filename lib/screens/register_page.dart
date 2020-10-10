import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learnwithseries/_constants/app_contstants.dart';
import 'package:learnwithseries/services/auth_service.dart';

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
              alignment: Alignment.center,
              children: [
                ...getListOfStripes(
                    numberOfStripes: 10,
                    color1: Colors.orange,
                    color2: Colors.amber),
                Column(
                  children: [
                    Text(
                      "Dizilerle İngilizce öğren",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: registerForm(context),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getListOfStripes(
      {int numberOfStripes, Color color1, Color color2}) {
    List<Widget> stripes = [];
    for (var i = 0; i < numberOfStripes; i++) {
      stripes.add(
        ClipPath(
          child: Container(
            color: (i % 2 == 0) ? color1 : color2,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          clipper: RegisterClipper(extent: i * 100.0),
        ),
      );
    }
    return stripes;
  }

  Widget registerForm(BuildContext context) {
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
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            color: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            onPressed: () async {
              try {
                var jwt = await json.decode(await this
                    .widget
                    .authService
                    .login(this.identifier, this.password));
                this.widget.authService.setToken(jwt["jwt"]);
                Navigator.pushNamed(context, RoutePaths.Home);
              } catch (e) {
                print(e);
              }
            },
            child: Text(
              'Giriş',
              style: TextStyle(color: Colors.orange),
            ),
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
  final double extent;

  RegisterClipper({this.extent});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, extent);
    path.lineTo(extent, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
