import 'package:flutter/material.dart';
import 'package:vet_digital/src/modules/information/page/view/jerjemish_view.dart';
import 'package:vet_digital/src/modules/information/page/view/momojemish_view.dart';

import '../../../../app/theme/theme.dart';
import '../../information.dart';

class MenuList extends StatelessWidget {
  const MenuList(this.items, {super.key});

  final List<InfoMenu> items;
  // final List<InfoSubMenu> infoSubItems;
  @override
  Widget build(BuildContext context) {
    final List<String> momojemish = [
      'Momojemish',
      'Jerjemish',
    ];
    final List<String> listAssetsName = [
      'assets/images/fruits.png',
      'assets/images/vegetable.png',
    ];
    final List<Widget> momo = [
      const MomojemishView(),
      const JerjemishView(),
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
      ),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => momo[index])));
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
                  listAssetsName[index],
                  height: 160,
                ),
                const SizedBox(height: 13),
                Text(
                  momojemish[index],
                  style: AppTextStyles.robotoWhite16w400,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
