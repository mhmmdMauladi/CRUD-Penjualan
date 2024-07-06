import 'package:flutter/material.dart';
import 'package:penjualan/colors.dart';
import 'package:penjualan/screen/home_page.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColors,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              "asset/fourth.png",
              height: 320,
              width: 320,
            ),
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                textAlign: TextAlign.center,
                "Fast delievery at \n your doorstep",
                style: TextStyle(
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(1),
              child: Text(
                textAlign: TextAlign.center,
                "Home delivery and online reservation \nsystem for restaurants & cafe",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              width: double.infinity,
              height: 55,
              margin: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: const Text(
                    "Let's Explore",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: primaryColors,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
