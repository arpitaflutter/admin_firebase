import 'package:admin_firebase/screens/home/model/task_model.dart';
import 'package:admin_firebase/utils/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseHelper.firehelper.readbuy(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              QuerySnapshot? data = snapshot.data;
              List<TaskModel> OrderList = [];

              for (var x in data!.docs) {
                TaskModel t1 = TaskModel(
                    imgurl: x['imgurl'],
                    key: x.id,
                    discount: x['discount'],
                    desc: x['desc'],
                    rate: x['rate'],
                    price: x['price'],
                    product: x['product']);
                OrderList.add(t1);
              }

              return Padding(
                padding: const EdgeInsets.only(top: 9, left: 4, right: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        Text(
                          "Orders",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Icon(Icons.shopping_cart)
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: double.infinity,
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color(0xff9DD7ED),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 80,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        "${OrderList[index].imgurl}"),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${OrderList[index].product}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "\$ ${OrderList[index].price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Order Placed",
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/images/img.png",
                                  height: 30,
                                  width: 30,
                                  color: Colors.indigo,
                                ),
                                SizedBox(width: 10,)
                              ],
                            ),
                          );
                        },
                        itemCount: OrderList.length,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
