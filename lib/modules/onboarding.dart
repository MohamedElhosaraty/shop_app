import 'package:flutter/material.dart';
import 'package:shop_app/model.dart';
import 'package:shop_app/modules/login.dart';
import 'package:shop_app/shared/components/navigatorto.dart';
import 'package:shop_app/shared/components/textbest.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding.jpg',
      title: "Title One ",
      body: "Body One",
    ),
    BoardingModel(
      image: 'assets/images/onboarding.jpg',
      title: "Title Two ",
      body: "Body Two",
    ),
    BoardingModel(
      image: 'assets/images/onboarding.jpg',
      title: "Title Three ",
      body: "Body Three",
    ),
  ];

  final pageController = PageController();
  bool isLast = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            navigateAndFinish(context, const LoginScreen());
          }, child: TextBest(text: 'SKIP',color: Colors.orange,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  onPageChanged: (index){
                    if(index == boarding.length -1){
                      setState(() {
                        isLast = true ;
                      });
                    }else{
                      setState(() {
                        isLast = false ;
                      });
                    }
                  },
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => BuildBoardItem(
                model: boarding[index],
              ),
              itemCount: boarding.length,
            )),
            SmoothPageIndicator(
                controller: pageController,
                count: boarding.length,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: Colors.orange,
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 4,
              ),
            ),
            Row(
              children: [
                TextBest(
                  text: "Indicator",
                  fontSize: 25,
                  fontFamily: 'font',
                ),
                const Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast == false) {
                    pageController.nextPage(duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn
                    );
                  }else{
                    navigateAndFinish(context, const LoginScreen());
                  }

                },
                  backgroundColor: Colors.orange,
                  child: const Icon(Icons.arrow_forward_ios_outlined),)
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class BuildBoardItem extends StatelessWidget {
   BuildBoardItem({super.key, required this.model});

  BoardingModel? model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage(model!.image),
        )),
        TextBest(
          text: model!.title,
          fontSize: 40,
          fontFamily: 'font',
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 18,
        ),
        TextBest(
          text: model!.body,
          fontSize: 40,
          fontFamily: 'font',
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 18,
        ),
      ],
    );
  }
}
