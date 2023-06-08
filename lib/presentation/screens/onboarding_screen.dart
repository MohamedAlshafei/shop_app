import 'package:flutter/material.dart';
import 'package:shop_app/business_logic/shared_pref/cache_helper.dart';
import 'package:shop_app/presentation/screens/shop_login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding=[
    BoardingModel(
      image: 'assets/images/onboard1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  var boardController= PageController();

  bool isLast=false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>  ShopLoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: const Text('SKIP')
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index){
                  if(index==boarding.length - 1){
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                itemBuilder: (context,index){
                  return buildBoardingItem(boarding[index]);
                },
                itemCount: boarding.length,
                ),
            ),
            const SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(  
                  controller: boardController,  
                  count:  boarding.length,  
                  //  axisDirection: Axis.vertical,  
                  effect:  const SlideEffect(  
                    spacing:  8.0,  
                    radius:  4.0,  
                    dotWidth:  24.0,  
                    dotHeight:  12.0,  
                    paintStyle:  PaintingStyle.stroke,  
                    strokeWidth:  1.5,  
                    dotColor:  Colors.grey,  
                    activeDotColor:  Colors.indigo  
                  ),  
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                    boardController.nextPage(duration:const Duration(milliseconds: 700), curve: Curves.easeInOutCubicEmphasized);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image)
            ),
        ),
        
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,

          ),
        ),
        const SizedBox(height: 15.0,),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500
          ),
        ),
        const SizedBox(height: 30.0,)
      ],
    );
  }
}