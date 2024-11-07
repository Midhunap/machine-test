import 'package:flutter/material.dart';
import 'package:machine_test_01/view/home_page.dart';
import 'package:get/get.dart';
import '../controller/navigation_con.dart';



class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var bottomNavController = Get.put(BottomNavController());


  onStart()async{
  }

  final List<Widget> _pages = [
    const HomePage(),
    const Center(
      child: Text('Brand'),
    ),
    const Center(
      child: Text('Best Items'),
    ),
    const Center(
      child: Text('Categories'),
    ),
    const Center(
      child: Text('Accounts',style: TextStyle(color: Colors.black54),),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return  PopScope(
      onPopInvoked: (value){
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
          child: Obx((){
            return BottomNavigationBar(
              elevation: 10,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomNavController.selectedIndex.value,
              onTap: (index){
                bottomNavController.updateSelectedIndex(index);
              },
              items: [
                selectTile('swan.png','Swan'),
                selectTile('brand.png','Brands'),
                selectTile('item.png','Best items'),
                selectTile('category.png','Categories'),
                selectTile('account.png','Accounts'),
              ],
            );
          }),
        ),
        body: Obx(() => _pages[bottomNavController.selectedIndex.value]),
      ),
    );
  }

  selectTile(String icon,String label)=>BottomNavigationBarItem(
    icon: SizedBox(
      // width: ,
      height: 45,
      child: Image.asset(
        'assets/dash_icon/$icon',
      ),
    ),
    label: label,
  );

}


