import 'package:blacktom/models/user.dart';
import 'package:blacktom/screens/home/leaderboard.dart';
import 'package:blacktom/services/auth.dart';
import 'package:blacktom/services/database.dart';
import 'package:blacktom/shared/palettes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'loading.dart';

class MainDrawer extends StatelessWidget {
  AuthService _auth = new AuthService();

  List<String> _batvatars = [
    'assets/batmen/adam_west.png',
    'assets/batmen/michael_keaton.jpg',
    'assets/batmen/val_kilmer.png',
    'assets/batmen/george_clooney.png',
    'assets/batmen/christian_bale.png',
    'assets/batmen/ben_affleck.png',
    'assets/batmen/arkham_knight.png',
    'assets/batmen/lego.png'
  ];

  List<String> _actors = ['West', 'Keaton', 'Kilmer', 'Clooney', 'Bale', 'Affleck', 'Xbox', 'Lego'];

  // return new List<Hand>.generate(_player.length, (int index) => Hand(cards: _player[index]['cards']));

  Widget _batvatarSelection() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
        child: Container(
            child: ListView(
          scrollDirection: Axis.horizontal,
          children: List<Widget>.generate(
              _batvatars.length,
              (int index) => Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                      GestureDetector(
                        onTap: () {/* Update Firebase batvatar w/ this image */},
                        child: Container(
                          height: 73,
                          width: 73,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Center(
                              child: CircleAvatar(
                            radius: 35,
                            backgroundColor: BatmanColors.lightGrey,
                            backgroundImage: AssetImage(_batvatars[index]),
                          )),
                        ),
                      ),
                      Container(child: Text('${_actors[index]}', style: GoogleFonts.oxanium(color: Colors.white, fontSize: 14)))
                    ]),
                  )),
        )));
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).gamblerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Drawer(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(8, statusBar, 4, 4),
                    color: BatmanColors.blueGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 16, bottom: 4),
                            child: Text(userData.username, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Avenir', color: Colors.white))),
                        Container(
                            padding: EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.white,
                                ),
                                Text(' Chips: ${userData.chips}  |   Level: ${userData.level}', style: TextStyle(fontSize: 14, fontFamily: 'Avenir', color: Colors.white)),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(
                                padding: EdgeInsets.fromLTRB(4, 4, 0, 0), child: Text('Choose your Batvatar', style: GoogleFonts.oxanium(fontSize: 16, color: Colors.white)))),
                        Container(height: 115, child: _batvatarSelection()),
                      ],
                    )),
                GestureDetector(
                  child: ListTile(title: Text('Leaderboard'), leading: Icon(Icons.casino)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Leaderboard()));
                  },
                ),
                GestureDetector(
                  child: ListTile(title: Text('Sign Out'), leading: Icon(Icons.flight_takeoff)),
                  onTap: () => _auth.signOut(),
                ),
              ],
            ));
          } else {
            return Loading(
              bgColor: BatmanColors.black,
              dotColor: BatmanColors.blueGrey,
            );
          }
        });
  }
}
