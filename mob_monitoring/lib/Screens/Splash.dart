import 'package:flutter/material.dart';
import 'package:mob_monitoring/Screens/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
      ),
      //  themeMode: ThemeMode
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            CurvedShape(),
            Positioned(
              top: 100,
              left: 60,
              child: Image.asset(
                'assets/images/splash.png', // Replace 'assets/image.png' with your image path
                height: 200,
                width: 200,
              ),
            ),
            Positioned(
              top: 300,
              left: 36,
              child: Text(
                '         MOB \n MONITORING',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 640,
              left: 200,
              child: InkWell(
                child: Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 48, 126, 227)),
                    child: Center(
                        child: Text("Get Start",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500)))),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
              ),
            ),
            // Positioned(
            //   child: GestureDetector(
            //       child: Icon(
            //         Icons.arrow_back,
            //         color: Colors.white,
            //       ),
            //       onTap: () => Navigator.of(context)
            //               .push(MaterialPageRoute(builder: (context) {
            //             return HomeScreen();
            //           }))),
            //   top: 20,
            //   left: 20,
            // ),
          ],
        ),
      ),
    );
  }
}

class CurvedShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 800,
      child: CustomPaint(
        painter: CurvePainter(),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 34, 35, 35)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height + 150)
      ..quadraticBezierTo(size.width + 300, 0, 0, 0)
      ..lineTo(0, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
