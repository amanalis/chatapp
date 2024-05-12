import 'package:chatapp/Pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/notification/notification_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.isTokenRefresh();
    notificationServices.requestNotificationPermission();

    notificationServices.getDeviceToken().then((value){
      print('device token:');
      print(value);
    });
  }

  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Sign user out
  void signOut() {
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:
        Text("HomePage", style: TextStyle(color: Colors.lightBlue.shade50)),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(
              Icons.logout,
              color: Colors.lightBlue.shade50,
            ),
          ),
        ],
      ),
      body: _buildUserList(),
      backgroundColor: Colors.lightBlue.shade900,
    );
  }

  // build a list of user except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  // build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        leading: Icon(
          Icons.account_circle_outlined,
          color: Colors.lightBlue.shade50,
        ),
        title: Text(data['email'],
            style: TextStyle(color: Colors.lightBlue.shade50)),
        onTap: () {
          // pass the clicked user's UID to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                recieveruserEmail: data['email'],
                recieverUserId: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      //return empty container
      return Container();
    }
  }
}
