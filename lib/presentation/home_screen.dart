import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../utils/clipper.dart';
// List for Slider
List<String> imageList=["assets/veg.png","assets/paneer.png","assets/fish.png","assets/avacado.webp"];
// List for OrderSection
List<String> orderList=["assets/veg.png","assets/paneer.png","assets/fish.png",];
// List for Names
List<String> saladNames=["Pure Veg Salad","Paneer Salad","Fish Salad","Avocado Salad"];
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with TickerProviderStateMixin {
  // Controller to Handle the CarouselSlider
  late CarouselController buttonCarouselController;
  // animation controller to  controller flip  the animation of Text
  late final AnimationController textController=AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
//Carousel index
  int _index=0;
  // To Hide/Show the cart
  bool _showCart=false;

  @override
  // dispose every controller to prevent memory leak
  void dispose() {
    textController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    // initialization of CarouselController
    buttonCarouselController = CarouselController();
    // added Listener to reset animation after its completion
    textController.addListener(() {
      //Checking Weather the animation is completed or not
  if(textController.isCompleted){
    // Reseting the controller for forwarding the animation
    textController.reset();
  }

    });
  }

  @override
  Widget build(BuildContext context) {
    // Using Stack to Handel Cart Section
    return Stack(
      children: [
        // Entire Screen
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(onPressed: (){},icon: const Icon(Icons.menu,color: Colors.brown),),
            actions: [
              IconButton(onPressed: (){
                // Setting the _showCart to display the cart section
                setState(() {
                  _showCart=true;
                });
              },icon: const Badge(
                label: Text("3"),
                  child:  Icon(Icons.shopping_cart_outlined,color: Colors.brown)),)
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  //Used ClipPath for Curve
                  ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4-60,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15, top: 80),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle Carousel on Tap
                                  buttonCarouselController.previousPage();
                                  // Starting the Animation for salad Title
                                  textController.forward();
                                },
                                child:  CircleAvatar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  child: const Icon(Icons.arrow_back_ios, size: 15,color: Colors.brown
                                    ,),
                                ),
                              ),
                               Expanded(
                                child: Center(
                                  child: AnimatedBuilder(
                                      animation: textController,
                                      builder: (BuildContext context, Widget? child) {
                                        return Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.identity()..setEntry(3,2, 0.001)..rotateY((textController.value<0.5)?pi*textController.value:(pi*(1+textController.value))),
                                          child: Text( saladNames[_index],style:const  TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)
                                        );}
                                  ),

                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Carousel on Tap
                                  buttonCarouselController.nextPage();
                                  // Starting the Animation for salad Title
                                  textController.forward();
                                },
                                child:  CircleAvatar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  child:const  Icon(Icons.arrow_forward_ios, size: 15,color: Colors.brown,),
                                ),
                              ),
                            ],
                          ),
                        const   SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              for(int i=0;i<5;i++)...[const Icon(Icons.star,color: Colors.yellow,)]
                            ],
                          ),
                          const   SizedBox(
                            height: 20,
                          ),
                         const  Text("Salad -  A salad is a dish consisting of mixed ingredients, frequently vegetables. They are typically served chilled or at room temperature, though some can be served warm."),
                          const   SizedBox(
                            height: 20,
                          ),
                         /////// ////// Add to Cart Button Section/////////////
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                alignment: Alignment.center,
                                child: const  Text(
                                  "Add to cart",
                                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ),
                              /////// ////// Increment/Decrement Button /////////////
                              Container(
                                height: 50,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(onPressed: (){}, icon:const  Icon(Icons.remove,color: Colors.white,)),
                                  const   Text(
                                      "1",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(onPressed: (){}, icon:const  Icon(Icons.add,color: Colors.white,)),
                                  ],
                                )
                              )

                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              /////////////  CarouselSlider Section  /////////////
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25-80,
                  ),
                  CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      onPageChanged: (val, CarouselPageChangedReason){
                        // Starting the Animation for salad Title
                        textController.forward();
                       setState(() {
                         _index=val;
                       });
                      },
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      initialPage: 0,
                      height: 180.0,
                    ),
                    items: imageList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: 180,
                            margin: const EdgeInsets.symmetric(horizontal: 55.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              image: DecorationImage(
                                image: AssetImage(i),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )
                ],
              )
            ],
          ),
        ),
        /////////////  My Cart  Section  /////////////
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
         curve: Curves.linear,
         right:_showCart? 0:-100,
            child: Container(
              width: 100,
          height:MediaQuery.sizeOf(context).height,
          color: Theme.of(context).primaryColorDark,
              child: SafeArea(
                child: Column(
                  children: [
                   const  SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _showCart=false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26,
                            offset: Offset(5,8),
                            blurRadius: 10)
                          ]
                        ),
                        child:const  Icon(Icons.close,color: Colors.white,),
                      ),
                    ),
                    const  SizedBox(height: 20,),

                    Expanded(child: Material(
                      color: Theme.of(context).primaryColorDark,
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const  Text(
                              "Your Order",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                           const  SizedBox(height: 20,),
                            Expanded(child: ListView.builder(
                              itemCount: orderList.length,
                                shrinkWrap: true,
                                itemBuilder: (context,index){
                                return Container(
                                width: 70,
                                height: 70,
                                margin:const  EdgeInsets.only(bottom: 20,),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(orderList[index]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );

                            })),
                            const  Text(
                              "Total",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 18,),
                            ),
                          
                            const  Text(
                              "\$ 42.30",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                           const  SizedBox(height: 20,),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.check,color: Theme.of(context).primaryColorDark,size: 30,),
                            )
                          ],
                        ),
                      ),
                    )),
                    const  SizedBox(height: 50,),
                  ],
                ),
              ),
        ))
      ],
    );
  }
}
