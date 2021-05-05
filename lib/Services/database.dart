import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkid/models/Text.dart';

import 'package:linkid/models/user.dart';
Future<bool> updo(String name) async {
  bool aldo = true;
  final CollectionReference collection = Firestore.instance.collection("Names");
  var cold = await collection.getDocuments();
  cold.documents.forEach((element) {
    if (element.data["name"] == name) {
      aldo = !aldo;
    }
  });
  return aldo;
}
Future<String> updoz(String uid) async {
  String name = "";
  final CollectionReference collection = Firestore.instance.collection("Names");
  var cold = await collection.getDocuments();
  cold.documents.forEach((element) {
    if (element.documentID == uid) {
     name = element.data["senderID"];
    }
  });
  return name;
}
class DataBaseService {
  final String uid;


  DataBaseService({ this.uid });
    Future Add(String name, String genre, int index, List<String> interests, List<bool> selectedZ) async {
    Firestore.instance.collection("Names").document(uid).setData({
      "senderID": name,
      "name": name,
      "genre": genre,
      "index": index,
      "interests": interests,
      "indexZ": selectedZ,
    });
  }
  Future updateUser(String name) async {
    final CollectionReference collection = Firestore.instance.collection("Names");
    var cold = await collection.getDocuments();
    cold.documents.forEach((element) {

    });
    return await collection.document(uid).updateData({
      'name': name,
    });
  }

  // Future createGroup(String userName, String groupName) async {
  //   DocumentReference groupDocRef = await groupCollection.add({
  //     'groupName': groupName,
  //     // 'groupIcon': '',
  //     'admin': userName,
  //     // 'members': [],
  //     //'messages': ,
  //     'groupId': '',
  //     'recentMessage': '',
  //     'recentMessageSender': ''
  //   });
  // }
  Future createGroup(String groupName, var docID, String creator) async {
    final CollectionReference groupCollection = Firestore.instance.collection("Interests").document(docID).collection("Groups");
    DocumentReference groupDocRef = await groupCollection.add({
      'Group': groupName,
      'creator': creator

      // 'groupIcon': '',
      // 'admin': userName,
      // 'members': [],
      //'messages': ,
      // 'groupId': '',
      // 'recentMessage': '',
      // 'recentMessageSender': ''
    });

    await groupCollection.document(groupDocRef.documentID).collection("Messages").add({
      "sender": "CodeSlayer67",
      "message": "Hello Users.",
      "time": DateTime.now().millisecondsSinceEpoch,
    });

  }
  Future addI(List interests) async {
    Firestore.instance.collection("Names").document(uid).updateData({
      "interests": interests,
    });

  }

  getChats(String interestId, String groupId) {
    final CollectionReference groupCollection = Firestore.instance.collection("Interests").document(interestId).collection("Groups");
    return groupCollection.document(groupId).collection('Messages').orderBy('time').snapshots();
  }


  sendMessage(String interestId, String groupId, chatMessageData) {
    final CollectionReference groupCollection = Firestore.instance.collection("Interests").document(interestId).collection("Groups");
    groupCollection.document(groupId).collection('Messages').add(chatMessageData);
    groupCollection.document(groupId).updateData({
      'sender': chatMessageData['sender'],
      'message': chatMessageData['message'],
      'time': chatMessageData['time'].toString(),
    });
  }

    List<Text1> _TextListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Text1(
        text: doc.data['text'],
      );
    }).toList();
  }
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        senderID: snapshot.data['senderID'],
        name: snapshot.data['name'],
        genre: snapshot.data["genre"],
        index: snapshot.data["index"],
        interests: snapshot.data["interests"],
        indexZ: snapshot.data["indexZ"],



    );
  }


  // get data doc stream

  Stream<List<Text1>> get text {
    final CollectionReference collection = Firestore.instance.collection(uid);
    return collection.snapshots()
        .map(_TextListFromSnapshot);
  }


  // get user doc stream
  Stream<UserData> get userData  {
     DocumentReference collection =  Firestore.instance.collection("Names").document(uid);

    return collection.snapshots().map(_userDataFromSnapshot);
  }






}

