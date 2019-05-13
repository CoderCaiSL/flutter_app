import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nima/nima_actor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AminTest extends StatelessWidget {

  var showAnim = new SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 32.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*new NimaActor("assets/robot.nima",
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
          ),*/
            SpinKitRotatingCircle(color: Colors.blue),
            SpinKitRotatingPlain(color: Colors.cyan),
            SpinKitChasingDots(color: Colors.cyan),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitPumpingHeart(color: Colors.cyan),
            SpinKitPulse(color: Colors.cyan),
            SpinKitDoubleBounce(color: Colors.cyan),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitWave(color: Colors.cyan, type: SpinKitWaveType.start),
            SpinKitWave(color: Colors.cyan, type: SpinKitWaveType.center),
            SpinKitWave(color: Colors.cyan, type: SpinKitWaveType.end),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitThreeBounce(color: Colors.cyan),
            SpinKitWanderingCubes(color: Colors.cyan),
            SpinKitWanderingCubes(
                color: Colors.cyan, shape: BoxShape.circle),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitCircle(color: Colors.cyan),
            SpinKitFadingFour(color: Colors.cyan),
            SpinKitFadingFour(
                color: Colors.cyan, shape: BoxShape.rectangle),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitFadingCube(color: Colors.cyan),
            SpinKitCubeGrid(size: 51.0, color: Colors.cyan),
            SpinKitFoldingCube(color: Colors.cyan),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitRing(color: Colors.cyan),
            SpinKitDualRing(color: Colors.cyan),
            SpinKitRipple(color: Colors.cyan),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitFadingGrid(color: Colors.cyan),
            SpinKitFadingGrid(
                color: Colors.cyan, shape: BoxShape.rectangle),
            SpinKitHourGlass(color: Colors.cyan),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitSpinningCircle(color: Colors.cyan),
            SpinKitSpinningCircle(
                color: Colors.cyan, shape: BoxShape.rectangle),
            SpinKitFadingCircle(color: Colors.cyan),
          ],
        ),
        const SizedBox(height: 48.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitPouringHourglass(color: Colors.cyan),
          ],
        ),
        const SizedBox(height: 64.0),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: Text("SpinKit和动画效果", style: TextStyle(fontSize: 24.0)),
      ),
      /*body: new Image.asset("assets/robot.png"),*/
      body: Center(
        child: Column(
          children: <Widget>[
            showAnim,
            /*new NimaActor("assets/robot.nima",
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
          ),*/
          ],
        ),
      ),
    );
  }
}