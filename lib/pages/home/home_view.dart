import 'package:flutter/material.dart';
import 'package:flutter_getx_template/components/components.dart';
import 'package:flutter_getx_template/components/custom_scaffold.dart';
import 'package:flutter_getx_template/pages/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [EmptyPage(), SamplePage(), EmptyPage()];
    final List<BottomNavigationBarItem> _list = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
          size: 25,
        ),

        activeIcon: Icon(
          Icons.map,
          size: 25,
          color: Colors.black38,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.update,
            size: 25,
          ),

          activeIcon: Icon(
            Icons.info,
            size: 25,
            color: Colors.black38,
          ),
          label: "Tab"
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.margin,
            size: 25,
          ),

          activeIcon: Icon(
            Icons.create,
            size: 25,
            color: Colors.black38,
          ),
          label: "Me"
      ),
    ];

    return Scaffold(bottomNavigationBar: GetBuilder<HomeController>(
      builder: (controller) {
        return BottomNavigationBar(
          // 底部导航
          enableFeedback: false,
          unselectedItemColor: Colors.grey,
          fixedColor: Colors.grey,
          items: _list,
          currentIndex: controller.index.value,
          selectedLabelStyle: TextStyle(fontSize: 9),
          unselectedLabelStyle: TextStyle(fontSize: 9),
          onTap: (index) {
            controller.changePage(index);
          },
        );
      },
    ), body: GetBuilder<HomeController>(
      builder: (controller) {
        return _children[controller.index.value];
      },
    )
      // body: _children[controller.index.value],
    );
  }
}

class SamplePage extends GetView<HomeController> {
  const SamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Center(child: Text(controller.count.toString()))),
          TextButton(onPressed: () => controller.increment(), child: Text('count++')),
          GetBuilder<HomeController>(builder: (_) {
            return Text(controller.userName);
          }),
          TextButton(onPressed: () => controller.changeUserName(), child: Text('changeName')),
        ],
      ),
    );
  }
}


class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
