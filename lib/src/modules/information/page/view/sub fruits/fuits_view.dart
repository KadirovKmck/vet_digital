import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FruitsView extends StatefulWidget {
  const FruitsView({Key? key}) : super(key: key);

  @override
  State<FruitsView> createState() => _FruitsViewState();
}

class _FruitsViewState extends State<FruitsView> {
  final controller = TextEditingController();
  late List<String> addToDo = [];
  late final Future<SharedPreferences> _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    initPrefs();
  }

  Future<void> initPrefs() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      addToDo = prefs.getStringList('addToDO') ?? [];
    });
  }

  void addToDoList() async {
    if (controller.text.isNotEmpty) {
      final text = controller.text;
      addToDo.add(text);
      controller.clear();
      final SharedPreferences prefs = await _prefs;
      await prefs.setStringList('addToDO', addToDo);
    } else {
      return null;
    }
    log(addToDo.toString());
    setState(() {});
  }

  void deleteItem(int index) async {
    final SharedPreferences prefs = await _prefs;
    addToDo.removeAt(index);
    await prefs.setStringList('addToDO', addToDo);
    setState(() {});
  }

  void toggleCompletion(int index) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      addToDo[index] = addToDo[index].startsWith('Completed:')
          ? addToDo[index].substring(10)
          : 'Completed: ${addToDo[index]}';
    });
    await prefs.setStringList('addToDO', addToDo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Apple',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Here is a step-by-step guide on how to plant apple trees:\n\n'
                '1. Choosing the right location:\n'
                'Apple trees thrive in sunny spots with good air circulation. Choose a location where the tree will receive plenty of sunlight and won\'t be shaded by other plants or structures.\n\n'
                '2. Soil preparation:\n'
                'Prepare the soil well in advance. Dig a hole about one and a half times the size of the tree\'s root system. This will allow the roots to spread easily in the soil.\n\n'
                '3. Selecting the sapling:\n'
                'Purchase healthy apple saplings from reputable nurseries or gardening centers. Check the health of the root system and look for any visible damage on the trunk and branches.\n\n'
                '4. Planting the sapling:\n'
                'Before planting, soak the sapling\'s roots in water for a few hours to hydrate them. Then, place the sapling in the prepared hole, spreading out the roots evenly, and cover them with soil. Make sure the root collar (the junction of roots and trunk) is at soil level.\n\n'
                '5. Fertilizing and watering:\n'
                'After planting, water the soil around the sapling thoroughly and fertilize it with a fertilizer containing nitrogen, phosphorus, and potassium. Then, set up a support or stake to provide additional support to the plant. Water the sapling regularly during its first year after planting, especially in dry periods.\n\n'
                '6. Mulching:\n'
                'Apply a layer of mulch around the base of the sapling to retain moisture, suppress weed growth, and protect the roots from overheating or chilling.\n\n'
                '7. Care and pruning:\n'
                'After planting, regularly inspect the tree for diseases, pests, or damaged branches. Prune to shape the canopy and remove diseased or damaged parts of the plant.\n\n'
                '8. Pest and disease control:\n'
                'Apply necessary pest and disease control measures according to the recommendations of gardeners or specialists.\n\n'
                'By following these steps, you can successfully plant apple trees and enjoy their fruits for many years.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const Text(
              'Add To-Do',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a To-Do',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      addToDoList();
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: addToDo.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: CheckboxListTile(
                      value: addToDo[index].startsWith('Completed'),
                      onChanged: (value) {
                        toggleCompletion(index);
                      },
                      title: Text(
                        addToDo[index].replaceAll('Completed: ', ''),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      secondary: IconButton(
                        onPressed: () {
                          deleteItem(index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
