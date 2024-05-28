import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: const Color(0xff1b7fed),
      //   centerTitle: true,
      //   title: const Text(
      //     'Dashboard',
      //     style: TextStyle(color: Colors.white, fontSize: 18),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 120),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/splashlogo.png',
            ),
            const SizedBox(
              height: 50,
            ),
            customBtn('assets/logo/shopping-cart.gif', 'Purchase', () {}),
            const SizedBox(
              height: 20,
            ),
            customBtn(
                'assets/logo/real-estate-agent.gif', 'Become a seller', () {}),
            const SizedBox(
              height: 20,
            ),
            customBtn('assets/logo/society.gif', 'Become a member', () {}),
          ],
        ),
      ),
    );
  }

  showPopUp() {
    showDialog(
        context: context,
        builder: (context) {
          return Theme(
            data:
                Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              // backgroundColor: Colors.white,
              content: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    customBtn(
                        'assets/logo/shopping-cart.gif', 'Purchase', () {}),
                    const SizedBox(
                      height: 15,
                    ),
                    customBtn('assets/logo/real-estate-agent.gif',
                        'Become a seller', () {}),
                    const SizedBox(
                      height: 15,
                    ),
                    customBtn(
                        'assets/logo/society.gif', 'Become a member', () {}),
                  ],
                ),
              ),
            ),
          );
        });
  }

  customBtn(String img, String title, Function() onTap) {
    return GestureDetector(
      onTap: () {
        showPopUp();
      },
      child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff1b7fed),
              ),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.only(left: 20, right: 20),
          // padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
          child: Row(
            children: [
              Container(
                child: Image.asset(
                  img,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(color: Color(0xff1b7fed), fontSize: 16),
              ),
            ],
          )),
    );
  }
}
