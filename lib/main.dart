import 'dart:async';
import 'dart:math';
import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/theme/clay_text_theme.dart';
import 'package:clay_containers/theme/clay_theme.dart';
import 'package:clay_containers/theme/clay_theme_data.dart';
import 'package:clay_containers/widgets/clay_animated_container.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Happy New Year From Akilan',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MyHomePage(),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConfettiController _topLeftController;
  late ConfettiController _topRightController;
  late ConfettiController _bottomLeftController;
  late ConfettiController _bottomRightController;
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();

    // Initialize confetti controllers
    _topLeftController = ConfettiController(duration: const Duration(seconds: 2));
    _topRightController = ConfettiController(duration: const Duration(seconds: 2));
    _bottomLeftController = ConfettiController(duration: const Duration(seconds: 2));
    _bottomRightController = ConfettiController(duration: const Duration(seconds: 2));
    _centerController = ConfettiController(duration: const Duration(seconds: 2));

    // Start auto-play timer
    _startAutoPlay();
  }

  @override
  void dispose() {
    _topLeftController.dispose();
    _topRightController.dispose();
    _bottomLeftController.dispose();
    _bottomRightController.dispose();
    _centerController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    // Initial play
    _playAllConfetti();

    // Auto-play every 30 seconds
    Timer.periodic(const Duration(seconds: 10), (_) {
      _playAllConfetti();
    });
  }

  void _playAllConfetti() {
    _topLeftController.play();
    _topRightController.play();
    _bottomLeftController.play();
    _bottomRightController.play();
    _centerController.play();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(color: Colors.purple.shade100,
          ),

          // Top-left corner
          _cornerWidget(size, Alignment.topLeft, _topLeftController),

          // Top-right corner
          _cornerWidget(size, Alignment.topRight, _topRightController),

          // Bottom-left corner
          _cornerWidget(size, Alignment.bottomLeft, _bottomLeftController),

          // Bottom-right corner
          _cornerWidget(size, Alignment.bottomRight, _bottomRightController),
          Container(
            height: size.height,
            width: size.width,
            child:
            Center(
              child: ClayTheme(
                themeData: const ClayThemeData(
                  height: 10,
                  width: 20,
                  borderRadius: 360,
                  textTheme: ClayTextTheme(style: TextStyle(color:Colors.purple)),
                  depth: 12,
                ),
                child: ClayAnimatedContainer(
                  height: size.width/2,
                  width: size.width/1.2,
                  child: ClayContainer(
                    borderRadius: 75,
                    curveType: CurveType.concave,
                    color: Colors.purple.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClayContainer(
                        borderRadius: 75,
                        curveType: CurveType.convex,
                        color: Colors.purple.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClayContainer(
                            borderRadius: 75,
                            curveType: CurveType.concave,
                            color: Colors.purple.shade100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClayContainer(
                                borderRadius: 75,
                                curveType: CurveType.convex,
                                color: Colors.purple.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClayContainer(
                                    borderRadius: 75,
                                    curveType: CurveType.concave,
                                    color: Colors.purple.shade100,
                                    child: FittedBox(child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: size.height/10),
                                      child: const Column(
                                        children: [
                                          ClayText("Happy New Year!",style: TextStyle(color: Colors.purple,fontSize: 100,fontWeight: FontWeight.w900),textColor: Colors.purple,),
                                          ClayText("May 2025 bring joy,",style: TextStyle(color: Colors.purple,fontSize: 100),textColor: Colors.purple,),
                                          ClayText("success, and endless",style: TextStyle(color: Colors.purple,fontSize: 100),textColor: Colors.purple,),
                                          ClayText("smiles to your life.",style: TextStyle(color: Colors.purple,fontSize: 100),textColor: Colors.purple,),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            ,
          ),

          // Center confetti
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _centerController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.3,
              numberOfParticles: 50,
              gravity: 0.5,
              colors: const [Colors.green, Colors.blue, Colors.red, Colors.yellow],
              createParticlePath: (size) => _drawStar(size),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cornerWidget(
      Size size, Alignment alignment, ConfettiController controller) {
    return Stack(
      alignment: alignment,
      children: [
        _cornerClayContainer(size, alignment),
        ConfettiWidget(
          confettiController: controller,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.3,
          numberOfParticles: 30,
          gravity: 0.5,
          colors: const [Colors.green, Colors.blue, Colors.red, Colors.yellow],
          createParticlePath: (size) => _drawStar(size),
        ),
      ],
    );
  }

  Widget _cornerClayContainer(Size size, Alignment alignment) {
    BorderRadius customBorderRadius;

    if (alignment == Alignment.topLeft) {
      customBorderRadius = const BorderRadius.only(
        bottomRight: Radius.elliptical(150, 150),
        topLeft: Radius.circular(0),
      );
    } else if (alignment == Alignment.topRight) {
      customBorderRadius = const BorderRadius.only(
        bottomLeft: Radius.elliptical(150, 150),
        topRight: Radius.circular(0),
      );
    } else if (alignment == Alignment.bottomLeft) {
      customBorderRadius = const BorderRadius.only(
        topRight: Radius.elliptical(150, 150),
        bottomLeft: Radius.circular(0),
      );
    } else {
      customBorderRadius = const BorderRadius.only(
        topLeft: Radius.elliptical(150, 150),
        bottomRight: Radius.circular(0),
      );
    }

    return Align(
      alignment: alignment,
      child: ClayContainer(
        color: Colors.purple.shade100,
        height: size.width / 4,
        width: size.width / 4,
        customBorderRadius: customBorderRadius,
      ),
    );
  }

  Path _drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }
}
