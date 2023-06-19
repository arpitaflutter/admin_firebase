import 'package:admin_firebase/screens/home/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/firebase_helper.dart';
import '../model/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    FirebaseHelper.firehelper.checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffDDF1FA),
        body: StreamBuilder(
          stream: FirebaseHelper.firehelper.readData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              List<TaskModel> taskList = [];
              QuerySnapshot? snapData = snapshot.data;
              for (var x in snapData!.docs) {
                Map? data = x.data() as Map;
                print(data);
                String? product = data['product'];
                String? discount = data['discount'];
                String? rate = data['rate'];
                String? desc = data['desc'];
                String? price = data['price'];
                String? imgurl = data['imgurl'];

                TaskModel t1 = TaskModel(
                    price: price,
                    imgurl: imgurl,
                    discount: discount,
                    key: x.id,
                    desc: desc,
                    product: product,
                    rate: rate);

                taskList.add(t1);

                print("$price $product $discount $rate $desc $imgurl");
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                                color: Color(0xff333B59), fontSize: 25),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "🎉",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: Colors.black),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: IconButton(
                                  onPressed: () {
                                    Get.toNamed('/profile');
                                  },
                                  icon: Icon(Icons.person,
                                      color: Colors.blue.shade900),
                                ),
                              ),
                              PopupMenuItem(
                                child: IconButton(
                                  onPressed: () {
                                    Get.toNamed('/order');
                                  },
                                  icon: Icon(Icons.shopping_cart_checkout_rounded,color: Colors.blue.shade900),
                                ),
                              ),
                              //     PopupMenuItem(
                              //       child: IconButton(
                              //         onPressed: () {
                              //           NotificationService.notificationService
                              //               .scheduleNotification();
                              //         },
                              //         icon: Icon(
                              //           Icons.timer,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //     PopupMenuItem(
                              //       child: IconButton(
                              //         onPressed: () {
                              //           NotificationService.notificationService
                              //               .soundNotification();
                              //         },
                              //         icon: Icon(
                              //           Icons.music_note,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //     PopupMenuItem(
                              //       child: IconButton(
                              //         onPressed: () {
                              //           NotificationService.notificationService
                              //               .showNotification();
                              //         },
                              //         icon: Icon(
                              //           Icons.notifications,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              PopupMenuItem(
                                child: IconButton(
                                  onPressed: () {
                                    FirebaseHelper.firehelper.logOut();

                                    Get.offAndToNamed('/google');
                                  },
                                  icon: Icon(
                                    Icons.logout_rounded,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                              //     PopupMenuItem(
                              //       child: IconButton(
                              //         onPressed: () {
                              //           NotificationService.notificationService
                              //               .showBigPictureNotification();
                              //         },
                              //         icon: Icon(Icons.image, color: Colors.black),
                              //       ),
                              //     ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade50,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${taskList[index].product}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$ ${taskList[index].price}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20),
                                InkWell(
                                  onTap: () {
                                    TaskModel t1 = TaskModel(
                                      price: taskList[index].price,
                                      product: taskList[index].product,
                                      imgurl: taskList[index].imgurl,
                                      desc: taskList[index].desc,
                                      discount: taskList[index].discount,
                                      rate: taskList[index].rate,
                                    );
                                    Get.toNamed('/details', arguments: t1);
                                  },
                                  child: Container(
                                    height: 90,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          fit: BoxFit.fill,
                                          "${taskList[index].imgurl}"),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    var userData = taskList[index];
                                    FirebaseHelper.firehelper
                                        .updateTask(taskList[index]);
                                    Get.toNamed('/add', arguments: {
                                      'status': 1,
                                      'data': userData
                                    });
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print("${taskList[index].key}");
                                    FirebaseHelper.firehelper
                                        .deleteData(taskList[index].key!);

                                    Get.snackbar(
                                        "Delete data successfully", "");
                                  },
                                  icon: Icon(Icons.delete,
                                      color: Colors.red.shade400),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: taskList.length,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add', arguments: {'status': 0});
          },
          child: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
