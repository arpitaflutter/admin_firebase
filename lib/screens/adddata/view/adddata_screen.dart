import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/firebase_helper.dart';
import '../../home/controller/home_controller.dart';
import '../../home/model/task_model.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {

  TextEditingController txtProduct = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtDiscount = TextEditingController();
  TextEditingController txtRate = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txtimgurl = TextEditingController();

  var args;

  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    args = Get.arguments;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (args['status'] == 1) {
      txtProduct = TextEditingController(text: args['data'].product);
      txtPrice = TextEditingController(text: args['data'].price);
      txtdesc = TextEditingController(text: args['data'].desc);
      txtDiscount = TextEditingController(text: args['data'].discount);
      txtRate = TextEditingController(text: args['data'].rate);
      txtimgurl = TextEditingController(text: args['data'].imgurl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffDDF1FA),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Product Details",
                  style: TextStyle(
                      color: Color(0xff363F60),
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: txtProduct,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Product"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtPrice,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Price"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtDiscount,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Discount"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtRate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Rate"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtdesc,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Description"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLines: 3,
                  controller: txtimgurl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("ImgUrl"),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (args['status'] == 1) {
                      TaskModel t1 = TaskModel(
                          key: args['data'].key,
                          imgurl: txtimgurl.text,
                          discount: txtDiscount.text,
                          product: txtProduct.text,
                          desc: txtdesc.text,
                          price: txtPrice.text,
                          rate: txtRate.text);
                      FirebaseHelper.firehelper.updateTask(t1);
                      Get.toNamed('/home');
                    } else {
                      FirebaseHelper.firehelper.addTask(
                        price: txtPrice.text,
                        imgurl: txtimgurl.text,
                        discount: txtDiscount.text,
                        rate: txtRate.text,
                        product: txtProduct.text,
                        desc: txtdesc.text,
                      );
                      Get.toNamed('/home');
                    }
                  },
                  child: Text(args['status'] == 1 ? "Update Task" : "Add data"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(135, 50),
                    textStyle: TextStyle(fontSize: 18),
                    backgroundColor: Color(0xff363F60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
