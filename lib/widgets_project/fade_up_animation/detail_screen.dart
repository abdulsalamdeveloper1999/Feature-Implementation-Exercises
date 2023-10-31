import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String tag;

  const DetailScreen({
    Key? key,
    required this.tag,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 200),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    animationController.forward();
  }

  backPress() {
    final context = this.context;

    animationController.reverse().then((value) {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              backPress();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.tag,
              child: Image.asset(widget.data['image']),
            ),
            Expanded(
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1.0),
                  end: const Offset(0, 0),
                ).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Curves.fastEaseInToSlowEaseOut,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.data['price'],
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.data['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
