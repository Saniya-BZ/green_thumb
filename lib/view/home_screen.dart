import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:green_thumb/view/recipeDetails.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../model/recipeResponse.dart';
import 'diet_preference_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchEditingController = TextEditingController();
  String searchText = '';
  late Future<RecipeResponse> _recipeFuture;

  @override
  void initState() {
    super.initState();
    _recipeFuture = fetchData();
    searchEditingController.addListener(() {
      if (searchEditingController.text.isEmpty) {
        _refreshData();
      }
    });
  }

  Future<RecipeResponse> fetchData() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    String dietList = sharedPreferences.getString("Diet")!;
    String intoleranceList = sharedPreferences.getString("Intolerance")!;

    final Uri uri = Uri.parse('https://api.spoonacular.com/recipes/complexSearch');
    final Map<String, String> params = {
      'apiKey': 'e15e793e5316448a895329e55f9ee2f5',
      'diet': dietList,
      'intolerances': intoleranceList,
      'number': '20',
      'query': searchText,
    };

    // Add query parameters to the URI
    final Uri uriWithQuery = uri.replace(queryParameters: params);

    final response = await http.get(uriWithQuery);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return RecipeResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      searchText = searchEditingController.text;
      _recipeFuture = fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(0),
          elevation: 4,
          child: Container(
            height: 90,
            decoration: const BoxDecoration(
              color: ColorConstants.primaryColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    controller: searchEditingController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _refreshData();
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Search',
                      hintText: 'Enter Recipe Name',
                      hoverColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DietPreferenceScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.filter_alt_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: FutureBuilder<RecipeResponse>(
              future: _recipeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Display the data from the API
                  final recipeResponse = snapshot.data!;
                  if (recipeResponse.totalResults == 0) {
                    return const Text("No Result Found!");
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: recipeResponse.results.length,
                    itemBuilder: (context, index) {
                      final recipe = recipeResponse.results[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetails(index: index, recipe: recipe),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                              title: Text(recipe.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              leading: Hero(
                                tag: "image$index",
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      recipe.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(height: 2, color: ColorConstants.primaryColor),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
