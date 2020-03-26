import 'package:blacktom/models/casino_slide.dart';
import 'package:blacktom/models/user.dart';
import 'package:blacktom/services/auth.dart';
import 'package:blacktom/services/database.dart';
import 'package:blacktom/shared/drawer.dart';
import 'package:blacktom/shared/palettes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = new AuthService();

  List<Map<String, dynamic>> casinos = [
    {
      'location': 'Gotham City PD',
      'locationImage': 'assets/casino_slides/gcpd.png',
      'dealerImage': 'assets/dealers/commissioner_gordon.jpg',
      'dealer': 'Commissioner Gordon',
      'villainColor': Colors.blue[900],
      'tableMin': 10
    },
    {
      'location': 'Arkham Asylum',
      'locationImage': 'assets/casino_slides/arkham_asylum.jpg',
      'dealerImage': 'assets/dealers/scarecrow.jpg',
      'dealer': 'Scarecrow',
      'villainColor': Colors.brown[300],
      'tableMin': 15
    },
    {
      'location': 'The Batcave',
      'locationImage': 'assets/casino_slides/batcave.png',
      'dealer': 'Bane',
      'dealerImage': 'assets/dealers/bane.jpg',
      'villainColor': Colors.brown[700],
      'tableMin': 25,
    },
    {
      'location': 'Iceberg Lounge',
      'locationImage': 'assets/casino_slides/iceberg_lounge.jpg',
      'dealerImage': 'assets/dealers/penguin.png',
      'dealer': 'Penguin',
      'villainColor': Colors.lightBlue[200],
      'tableMin': 50,
    },
    {
      'location': 'Ace Chemicals',
      'locationImage': 'assets/casino_slides/ace_chemicals.jpg',
      'dealer': 'Joker',
      'dealerImage': 'assets/dealers/joker.jpg',
      'villainColor': BatmanColors.jokerGreen,
      'tableMin': 100,
    }
  ];

  List<Widget> _allCasinos() {
    List<CasinoSlide> allCasinos = [];
    for (var i = 0; i < casinos.length; i++) {
      allCasinos.add(CasinoSlide(
        location: casinos[i]['location'],
        locationImage: casinos[i]['locationImage'],
        dealer: casinos[i]['dealer'],
        dealerImage: casinos[i]['dealerImage'],
        villainColor: casinos[i]['villainColor'],
        tableMin: casinos[i]['tableMin'],
      ));
    }
    return allCasinos;
  }

  @override
  Widget build(BuildContext context) {
    num batLogoWidth = MediaQuery.of(context).size.width / 2;
    num batLogoHeight = batLogoWidth * 0.6;
    final user = Provider.of<User>(context);
    return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().gamblers,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: BatmanColors.blueGrey,
            title: Text('Batjack'),
            elevation: 0.8,
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  'sign out',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/wallpapers/home.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 20),
                      child: Image.asset(
                        'assets/batman_logos/white.png',
                        width: batLogoWidth / 1.7,
                        height: batLogoHeight / 1.7,
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text('Choose a casino', style: GoogleFonts.oxanium(color: Colors.white, fontSize: 20))),
                  Container(height: 225, child: ListView(scrollDirection: Axis.horizontal, children: _allCasinos())),
                ],
              ))),
          drawer: MainDrawer(),
        ));
  }
}
