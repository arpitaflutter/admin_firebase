import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var args;

  @override
  void initState() {
    super.initState();

    args = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 397,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                  Text(
                    "${args.product}",
                    style: TextStyle(color: Color(0xff2C3856), fontSize: 25),
                  ),
                  Center(child: Image.network("${args.imgurl}",height: 300,width: 300)),
                  // SizedBox(height: 15,),
                ],
              ),
            ),
            Container(
              height: 355,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xffDDF1FA),
                borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Color(0xff3A435E),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${args.desc}",
                    style: TextStyle(color: Colors.grey.shade700,fontSize: 18),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.arrow_forward_ios_outlined,color: Color(0xff71BCB7),size: 17,),
                      SizedBox(width: 10,),
                      Text(
                        "Price :",
                        style: TextStyle(
                            color: Color(0xff3A435E),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 20,),
                      Text("\$",style: TextStyle(color: Color(0xff67D2D8),fontSize: 20),),
                      SizedBox(width: 7,),
                      Text("${args.price}",style: TextStyle(color: Color(0xff4A5163),fontSize: 18),)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.arrow_forward_ios_outlined,color: Color(0xff71BCB7),size: 17,),
                      SizedBox(width: 10,),
                      Text(
                        "Discount :",
                        style: TextStyle(
                            color: Color(0xff3A435E),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 20,),
                      Text("${args.discount}",style: TextStyle(color: Color(0xff4A5163),fontSize: 20),),
                      SizedBox(width: 7,),
                      Text("%",style: TextStyle(color: Color(0xff4A5163),fontSize: 18),)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
