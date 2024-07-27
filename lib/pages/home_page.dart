import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../services/data_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // create a variable to track the mile type

  String _mealTypeFilter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        centerTitle: true,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          _recipeTypesButtons(),
          _recipesList(),
        ],
      ),
    );
  }

  Widget _recipeTypesButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "Snack";
                });
              },
              child: const Text("🍉 Snack"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "Breakfast";
                });
              },
              child: const Text("🍽️ Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "Lunch";
                });
              },
              child: const Text("🥣Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "Dinner";
                });
              },
              child: const Text("'🍝 Dinner"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipesList() {
    return Expanded(
        child: FutureBuilder(
            future: DataService().getRecipes(_mealTypeFilter),
            builder: (context, snaphot) {
              if (snaphot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snaphot.hasError) {
                return const Center(
                  child: Text("Unable to fetch data at this time"),
                );
              }
              return ListView.builder(
                  itemCount: snaphot.data!.length,
                  itemBuilder: (context, index) {
                    // create a variable of type Recipe
                    Recipes recipe = snaphot.data![index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailPage(recipes: recipe);
                        }));
                      },
                      contentPadding: const EdgeInsets.only(top: 17.0),
                      isThreeLine: true,
                      title: Text(recipe.name),
                      subtitle: Text(
                          "${recipe.cuisine} \nDifficulty: ${recipe.difficulty}"),
                      leading: Image.network(recipe.image),
                      trailing: Text(
                        "${recipe.rating.toString()} ⭐",
                        style: const TextStyle(fontSize: 15.0),
                      ),
                    );
                  });
            }));
  }
}
