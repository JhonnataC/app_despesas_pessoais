import 'package:flutter/material.dart';

class IntroductionPage2 extends StatelessWidget {
  const IntroductionPage2({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print(height);
    // print(width);
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/intro5.png',
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.35),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: width * 0.05),
                const Text(
                  'Adicione gastos em',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                const ButtonDraw(),                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: width * 0.05),
                const Text(
                  'E deslize para o lado esquerdo para \nexcluir',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: width * 0.05),
                const SlideDraw(),
              ],
            ),
            Image.asset('assets/images/icone_mao.png', height: 80, width: 80)
          ],
        ),
      ],
    );
  }
}

class ButtonDraw extends StatelessWidget {
  const ButtonDraw({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 3)),
      child: const Center(
        child: Text(
          '+',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}

class SlideDraw extends StatelessWidget {
  const SlideDraw({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          height: 60,
          width: width * 0.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 3)),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 2,
                    width: 60,
                    color: Colors.white,
                  ),
                  Container(
                    height: 2,
                    width: 44,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 1)
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1.5,
              width: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const SizedBox(width: 5),
                Container(
                  height: 1.5,
                  width: 55,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 22),
            Container(
              height: 1.5,
              width: 40,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
