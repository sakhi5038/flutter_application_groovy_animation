import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(SplashScreen());

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimatedSplash();
}

class AnimatedSplash extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  late double _scale;
  late double _rotate;
  late AnimationController _controller;
  FlutterLogoStyle _logoStyle = FlutterLogoStyle.horizontal;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  AnimatedSplash() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _logoStyle = FlutterLogoStyle.stacked;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Groovy Splash by ',
              style: TextStyle(color: Colors.black, fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                  text: 'SAKHAWAT HUSSAIN ',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              ],
            ),
          ),
          flexibleSpace: Container(
            alignment: Alignment.bottomCenter,
            // height: 40,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.lightGreen, Colors.blue])),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: new EdgeInsets.only(bottom: 15.0),
                child: AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    child: Stack(
                      children: [
                        FlutterLogo(
                          style: _logoStyle,
                          curve: Curves.decelerate,
                          size: 300.0,
                          textColor: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        margin: new EdgeInsets.only(top: 55.0),
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          // color: Colors.lightGreen,
          gradient: const LinearGradient(
              colors: <Color>[Colors.lightGreen, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: const [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 30.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Hide/Show',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    setState(() {
      _visible = !_visible;
    });
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}











//child property of container 
//  new FlutterLogo(
//                       curve: Curves.decelerate,
//                       size: 300.0,
//                       style: _logoStyle,
//                     ),