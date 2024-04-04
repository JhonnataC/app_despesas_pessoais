import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/screens/introduction_pages/introduction_page_1.dart';
import 'package:projeto_despesas_pessoais/screens/introduction_pages/introduction_page_2.dart';
import 'package:projeto_despesas_pessoais/screens/introduction_pages/introduction_page_3.dart';
import 'package:projeto_despesas_pessoais/utils/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController();
  bool onFirstPage = true;
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onFirstPage = (value == 0);
                onLastPage = (value == 2);
              });
            },
            children: const [
              IntroductionPage1(),
              IntroductionPage2(),
              IntroductionPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: onFirstPage
                      ? null
                      : () {
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                  child: Text(
                    'voltar',
                    style: TextStyle(
                      color: onFirstPage ? Colors.transparent : Colors.white,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: SwapEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.grey.withOpacity(0.5),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onLastPage
                        ? Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.HOME_SCREEN)
                        : _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                  },
                  child: onLastPage
                      ? const Text(
                          'pronto',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'próximo',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
