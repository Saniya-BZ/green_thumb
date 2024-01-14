
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import 'intolerances_screen.dart';

class DietPreferenceScreen extends StatefulWidget {
  const DietPreferenceScreen({super.key});

  @override
  State<DietPreferenceScreen> createState() => _DietPreferenceScreenState();
}

class _DietPreferenceScreenState extends State<DietPreferenceScreen> {
  List<String> dietTypes = [
    'Gluten-Free',
    'Ketogenic',
    'Vegetarian',
    'Vegan',
    'Primal',
    'Low FODMAP',
    'Whole30',
  ];

  String selectedDiets = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              const Text(
                "Diet Preference",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              const SizedBox(
                height: 40,
              ),
              Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: dietTypes.length,
                  itemBuilder: (context, index) {
                    final dietType = dietTypes[index];
                    return CheckboxListTile(
                      title: Text(dietType),
                      value: selectedDiets.contains(dietType),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            // Add cuisine to the selectedCuisines string
                            selectedDiets +=
                                (selectedDiets.isEmpty ? '' : ', ') + dietType;
                          } else {
                            // Remove cuisine from the selectedCuisines string
                            selectedDiets = selectedDiets
                                .replaceAll(', $dietType', '')
                                .replaceAll('$dietType, ', '');
                            selectedDiets =
                                selectedDiets.replaceAll(dietType, '');
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              Center(
                child: SizedBox(
                  width: 240,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorConstants.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (selectedDiets.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Select any diet preference to continue"),
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                      final sharedPref =  await SharedPreferences.getInstance();
                      sharedPref.setString("Diet", selectedDiets);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IntolerancesPreferenceScreen()),
                        );
                      }
                    },
                    child: const Text(
                      'Proceed',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
