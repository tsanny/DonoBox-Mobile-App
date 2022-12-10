import 'package:flutter/material.dart';

import '../drawer/sidebar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F4E4F),
      ),
      drawer: const drawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color(0xFF3F4E4F),
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50))),
                  child: Column(
                    children: [
                      Expanded(child: Image.asset("assets/logo.png", width: 300,))
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: Color(0xFF3F4E4F),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: const [
                          SizedBox(height: 30),
                          Text(
                            textAlign: TextAlign.center,
                            "Tempat terbaik untuk menggalang\n dana dan berdonasi",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            textAlign: TextAlign.center,
                            "DonoBox adalah sebuah wadah untuk \nmenggalang dana dan berdonasi secara online \ndan transparan. Donobox menyediakan wadah \nbagi individu maupun organisasi yang ingin\nmenggalang dana untuk tujuan sosial, personal, \ndan lainnya serta berdonasi dengan mudah \nsecara online melalui Donobox.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),

                          //repleace sizebox with spacer
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}