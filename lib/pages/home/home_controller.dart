import 'dart:convert';

import 'package:flutter_getx_template/proto/helloworld.pbgrpc.dart';
import 'package:flutter_getx_template/utils/request.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  String userName = 'burnish';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void increment() => count.value++;

  void changeUserName() {
    userName = 'juefei';
    update();
    getHelloReply();
  }

  void getHelloReply() {
    GrpcRequest().getHelloRequest(name:"dart").then((value) {
      userName = value.message;
      var data3 = value.toProto3Json();
      print(data3);
      HelloReply ii = HelloReply.create()..mergeFromProto3Json(data3);
      print(ii.message);
      update();
    });
  }
}
