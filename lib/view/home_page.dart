import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:machine_test_01/controller/api/api.dart';
import 'package:machine_test_01/utils/color.dart';

import '../global.dart';
import '../utils/utils.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var cont = Get.put(ApiProviders());
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      cont.onPageStart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // logo
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                    ),
                    Row(
                      children: [
                        iconButtons('search.png',(){}),
                        iconButtons('heart.png',(){}),
                        cart(),

                      ],
                    )

                  ],
                ),
              ),
              //banner
              Stack(
                children: [
                  Obx(() =>cont.banner1.value.isEmpty?
                      loader():
                  CarouselSlider.builder(
                    itemCount: cont.banner1.length,
                    itemBuilder: (context, index, realIndex) {
                      String image = cont.banner1.value[index]['image'];
                      return Image.network(
                        '$serurl/images/banner/$image',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                      },
                    ),
                  )),
                  shopNow(),
                ],
              ),
              // our brands
              const SizedBox(height: 10,),
              titleText('Our Brands'),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 150,
                  child:Obx(
                      ()=>
                      cont.ourProducts.value.isEmpty?
                      const Center(
                            child:  CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          ):
                          ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(),
                          itemCount: cont.ourProducts.length,
                          itemBuilder: (context,index){
                            var item = cont.ourProducts.value[index];
                            return Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.network(
                                          '$serurl/images/product/${item['image']}',
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 70,
                                            child: Image.asset(
                                              'assets/icon/banner_title.png',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10,)
                              ],
                            );
                          })
                  ),),
              ),
              //Suggested for you
              const SizedBox(height: 10,),
              titleText('Suggested For You'),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 350,
                  child:Obx(()=>
                  cont.suggested.value.isEmpty?
                      loader():
                      ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      itemCount: cont.suggested.length,
                      itemBuilder: (context,index){
                        var item = cont.suggested.value[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height:250,
                                  width: 160,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      '$serurl/images/product/${item['image']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,)
                              ],
                            ),
                            const SizedBox(height: 2,),
                            SizedBox(
                              width: 100,
                              child: Text('${item['name']}',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),),
                            ),
                            const SizedBox(height: 2,),
                            Text('₹ ${item['price']}',style:const  TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),),
                          ],
                        );
                      })),),
              ),
              const SizedBox(height: 10,),
              Image.network('$serurl/images/banner/1690184122_1_Mm05vGbG777SMCXlD1n0itrvW1PheeEtLyEVWfUi.webp'),
              const SizedBox(height: 10,),
              titleText('Best seller'),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(height: 400,
                  child:Obx(()=>
                  cont.best_seller.value.isEmpty?
                  loader():
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      itemCount: cont.best_seller.length,
                      itemBuilder: (context,index){
                        var item = cont.best_seller.value[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height:250,
                                  width: 160,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      '$serurl/images/product/${item['image']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,)
                              ],
                            ),
                            const SizedBox(height: 2,),
                            SizedBox(
                              width: 100,
                              child: Text('${item['name']}',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),),
                            ),
                            const SizedBox(height: 2,),
                            Text('₹ ${item['price']}',style:const  TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),),
                          ],
                        );
                      })),),
              ),
              titleText('Trending Categories'),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Obx(()=>
                  cont.categories.value.isEmpty?
                  loader():
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemCount: cont.categories.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = cont.categories.value[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 140,
                            width: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                '$serurl/images/category/${item['category']['image']}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2,),
                          SizedBox(
                            width: 100,
                            child: Text('${item['category']['name']}',style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ],
                      );
                    },
                  )
                  ),
                ),
              ),
              titleText('Shop Exclusive Deals'),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.network('$serurl/images/banner/1690193506_1_i9jhinKdMadeoJILsKLJUG6tUlDYT1mvcI5AMhAo.webp'),
              )

            ],
          ),
        ),
      ),
    );
  }


  iconButtons(String icon,void Function()? onTap)=>InkWell(
    onTap: onTap,
    child: SizedBox(
      height: 40,
      child: Image.asset(
        'assets/icon/$icon',
      ),
    ),
  );

  cart()=>Stack(
    children: [
      SizedBox(
        height: 40,
        child: Image.asset(
          'assets/icon/cart.png',
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
          ),
          child: Obx(()=>Center(
              child: Text(cont.cartCount.value.toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10),))),
        ),
      ),
    ],
  );

  shopNow()=>Positioned(
      bottom: 0,
      right: 0,
      child:Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1,color: Colors.white)
        ),
        child: const Text('Shop now',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
      ) );

}
