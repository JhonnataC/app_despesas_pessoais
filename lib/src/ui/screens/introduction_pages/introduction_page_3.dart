import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroductionPage3 extends StatelessWidget {
  const IntroductionPage3({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/intro3.png',
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Visualize o ritmo dos \nseus gastos por meio \nde gráficos gerados \nautomaticamente',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Image.asset('assets/images/icone_chart.png')
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: width * 0.05),
                Image.asset('assets/images/cc.png'),
                const SizedBox(width: 22),
                const Text(
                  'Com o tempo, seus \ngastos mensais serão \nregistrados no histórico',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
