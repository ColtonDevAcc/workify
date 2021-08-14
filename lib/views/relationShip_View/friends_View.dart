import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workify/providers/userProvider.dart';
import 'package:workify/views/relationShip_View/_widgets/friendsTab_Widget.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Column(
      children: [
        Flexible(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('UserInfo')
                .where('friends', arrayContains: user.email)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Scrollbar(
                    child: new ListView(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                        return FriendsTab_Widget(name: data['email'], tags: data['tags']);
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}