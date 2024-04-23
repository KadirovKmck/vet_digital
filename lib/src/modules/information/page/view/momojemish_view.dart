import 'package:flutter/material.dart';
import 'package:vet_digital/src/app/theme/colors/app_colors.dart';
import 'package:vet_digital/src/modules/information/page/view/sub%20fruits/fuits_view.dart';

class MomojemishView extends StatelessWidget {
  const MomojemishView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetsName = <String>[
      'assets/images/apple.png',
      'assets/images/bananas.png',
      'assets/images/cherries.png',
      'assets/images/grapes.png',
      'assets/images/lemon.png',
      'assets/images/orange.png',
    ];
    final fruitName = <String>[
      'apple',
      'bananas',
      'cherries',
      'grapes',
      'lemon',
      'orange',
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: assetsName.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FruitsView(),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                color: AppColors.mainColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      assetsName[index],
                      height: 100,
                    ),
                    Text(
                      fruitName[index],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
