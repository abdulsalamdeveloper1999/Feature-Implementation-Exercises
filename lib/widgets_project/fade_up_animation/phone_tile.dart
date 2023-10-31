import 'package:flutter/material.dart';
import 'package:tutorials_project/widgets_project/fade_up_animation/slide_trasnition_widget.dart';

import 'detail_screen.dart';

class PhoneTile extends StatefulWidget {
  const PhoneTile({
    super.key,
    required this.tag,
    required this.context,
    required this.duration,
    required this.data,
  });
  final Map<String, dynamic> data;

  final String tag;
  final BuildContext context;
  final Duration duration;

  @override
  State<PhoneTile> createState() => _PhoneTileState();
}

class _PhoneTileState extends State<PhoneTile> with TickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    animation = Tween(begin: -2.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag,
      transitionOnUserGestures: true,
      child: Material(
        color: Colors.transparent, // <-- Add this, if needed
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 1000),
                pageBuilder: (_, animation, secondryAnimation) {
                  final curvedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: const Interval(
                      0,
                      0.5,
                    ),
                  );
                  return FadeTransition(
                    opacity: curvedAnimation,
                    child: DetailScreen(
                      tag: widget.tag,
                      data: widget.data,
                    ),
                  );
                },
              ),
            );
          },
          child: Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TransitionWidget(
                      animationController: animationController,
                      child: Text(
                        widget.data['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    TransitionWidget(
                      animationController: animationController,
                      child: Text(
                        widget.data['price'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      widget.data['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Text(tag),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
