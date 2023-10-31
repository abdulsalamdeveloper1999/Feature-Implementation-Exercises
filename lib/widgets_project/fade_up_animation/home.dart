import 'package:flutter/material.dart';

import 'phone_tile.dart';

class FadeUpExample extends StatefulWidget {
  const FadeUpExample({Key? key}) : super(key: key);

  @override
  State<FadeUpExample> createState() => _FadeUpExampleState();
}

class _FadeUpExampleState extends State<FadeUpExample>
    with TickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> data = [
    {
      'image': 'assets/fadeup/11 pro max.jpg',
      'name': 'Iphone 11 pro max',
      'price': '\$699',
      'description':
          'The iPhone 11 Pro Max features a powerful A13 Bionic chip, a stunning Super Retina XDR display, and a triple-camera system, making it an ideal choice for users who demand high performance and exceptional photography capabilities.'
    },
    {
      'image': 'assets/fadeup/12 pro max.jpg',
      'name': 'Iphone 12 pro max',
      'price': '\$799',
      'description':
          'The iPhone 12 Pro Max boasts the A14 Bionic chip, 5G capabilities, and a Ceramic Shield front cover for increased durability. With its Pro camera system, it\'s perfect for photography enthusiasts.'
    },
    {
      'image': 'assets/fadeup/13 pro max.jpg',
      'name': 'Iphone 13 pro max',
      'price': '\$899',
      'description':
          'The iPhone 13 Pro Max offers a faster A15 Bionic chip, ProRAW photography, and improved battery life. It\'s an excellent choice for users seeking the latest in Apple technology.'
    },
    {
      'image': 'assets/fadeup/14 pro max.jpg',
      'name': 'Iphone 14 pro max',
      'price': '\$999',
      'description':
          'The iPhone 14 Pro Max comes with advanced features like the A16 chip, enhanced MagSafe capabilities, and a ProMotion display for smoother visuals.'
    },
    {
      'image': 'assets/fadeup/15 pro max.jpg',
      'name': 'Iphone 15 pro max',
      'price': '\$1299',
      'description':
          'The iPhone 15 Pro Max sets a new standard with an A17 chip, an improved camera system, and additional AI-powered features, making it an excellent choice for power users.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: null,
          title: const Text(
            "Apple",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < data.length; i++)
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1.0), // Start from the bottom
                      end: const Offset(0, 0), // End at the top
                    ).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: Interval(0.1 * i, 1.0, curve: Curves.easeOut),
                      ),
                    ),
                    child: FadeTransition(
                      opacity: animationController.drive(
                        CurveTween(curve: Curves.easeOut),
                      ),
                      child: PhoneTile(
                        tag: 'tag_$i',
                        data: data[i],
                        context: context,
                        duration: const Duration(milliseconds: 1500),
                        // names: data[i]['name'],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
