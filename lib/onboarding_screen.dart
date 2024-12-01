import 'package:consumernetworks/openwebview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List onBoardingList = [
    {
      'image': 'assets/logo/onboarding1.png',
      'title': 'GANAS\nPOR\nCOMPRAR',
    },
    {
      'image': 'assets/logo/onboarding2.png',
      'title': 'GANAS\nPOR\nVENDER',
    },
    {
      'image': 'assets/logo/onboarding3.png',
      'title': 'CREA\nTIENDAS\nGRATIS',
    }
  ];

  int selectedIndex = 0;

  changeSelectIndex(int index) {
    selectedIndex = index;
    setState(() {});
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            itemCount: onBoardingList.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              changeSelectIndex(index);
            },
            itemBuilder: (context, index) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    onBoardingList[index]['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: selectedIndex == 0 || selectedIndex == 1
                        ? 0 + 130
                        : MediaQuery.of(context).size.height * .8,
                    right: selectedIndex == 0
                        ? 0 + 40
                        : selectedIndex == 1
                            ? 0 + 80
                            : 0 + 40,
                    child: Text(
                      onBoardingList[index]['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 40,
                          height: 0.90,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0790FF)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 35),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: const LinearGradient(colors: [
                            Color(0xff1b7fed),
                            Color(0xff1b7fed),
                            Color(0xff1b7fed),
                          ])),
                      child: TextButton(
                        onPressed: () async {
                          if (selectedIndex == onBoardingList.length - 1) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('isIntro', true);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const OpenWebView()));
                          } else {
                            _pageController.animateToPage(selectedIndex + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                              selectedIndex == onBoardingList.length - 1
                                  ? 'Get started'
                                  : 'Next',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
