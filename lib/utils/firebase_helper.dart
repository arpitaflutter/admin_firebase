import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/home/model/task_model.dart';



class FirebaseHelper
{
  static FirebaseHelper firehelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> signIN({required email, required password}) async {
    String? msg;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");

    return msg;
  }

  Future<String> signUP({required email, required password}) async {
    String msg = "";
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");

    return msg;
  }

  Future<String> sighInWithGoogle() async {
    String msg = "";
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication auth = await googleSignInAccount!.authentication;

    AuthCredential crd = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);

    return await firebaseAuth
        .signInWithCredential(crd)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");
  }

  void updateTask(TaskModel task) {

    print("=============================${task.key}");
    firestore.collection("product").doc(task.key).set({
      "product": task.product,
      "price": task.price,
      "desc": task.desc,
      "imgurl": task.imgurl,
      "discount": task.discount,
      "rate": task.rate
    });
  }

  String getUid() {
    User? user = firebaseAuth.currentUser;

    String? uid = user!.uid;
    return uid;
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();

    GoogleSignIn().signOut();
  }

  void addTask({product, price, desc, discount, rate, imgurl}) {

    firestore.collection("product").add({
      "product": product,
      "price": price,
      "discount": discount,
      "rate": rate,
      "imgurl": imgurl,
      "desc": desc
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readData() {
    // User? user = firebaseAuth.currentUser;
    //
    // String uid = user!.uid;
    return firestore.collection("product").snapshots();
  }

  Future<void> deleteData(String key)
  async {
    await firestore.collection("product").doc(key).delete();
  }

  Map<String, String?> userDetails() {
    User? user = firebaseAuth.currentUser;

    String? email = user!.email;
    String? phoneNumber = user.phoneNumber;
    String? img = user.photoURL;
    String? name = user.displayName;

    return {"email": email, "img": img, "name": name,"phoneNumber":phoneNumber};
  }

  bool checkUser() {
    User? user;
    return user != null;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readbuy()
  {
    return firestore.collection('buy').snapshots();
  }

}