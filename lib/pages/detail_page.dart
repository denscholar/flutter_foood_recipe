import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/models/recipe.dart';

class DetailPage extends StatelessWidget {
  final Recipes recipes;
  const DetailPage({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Recipe Details"),
        backgroundColor: Colors.white,
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _reccipeDetails(context),
          _recipeIgredients(context),
          _recipeInstructions(context),
        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(recipes.image),
        ),
      ),
    );
  }

  Widget _reccipeDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "${recipes.cuisine}, ${recipes.difficulty}",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              recipes.name,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Prep Time: ${recipes.prepTimeMinutes} Minute | cook Time ${recipes.cookTimeMinutes}",
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "Rating: ${recipes.rating.toString()} | ${recipes.reviewCount} reviews",
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recipeIgredients(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      child: Column(
        children: recipes.ingredients.map((i) {
          return Row(
            children: [
              const Icon(Icons.check_box),
              Text(" $i"),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _recipeInstructions(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: recipes.instructions.map((i) {
          return Text(
            "${recipes.instructions.indexOf(i)} $i\n",
            maxLines: 3,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 15.0),
          );
        }).toList()));
  }
}
