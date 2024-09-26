import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, String>> recipes = [
    {
      'Name': 'Breakfast Burrito',
      'Ingredients': 'Eggs, Tortilla, Cheese, Salsa',
      'Steps': '1. Scramble eggs.\n2. Heat tortilla.\n3. Add eggs, cheese, and salsa.',
    },
    {
      'Name': 'Scrambled Eggs',
      'Ingredients': 'Eggs, Butter, Salt',
      'Steps': '1. Crack eggs.\n2. Heat butter in a pan.\n3. Add eggs and scramble.',
    },
    {
      'Name': 'French Toast',
      'Ingredients': 'Bread, Eggs, Milk, Cinnamon',
      'Steps': '1. Mix eggs and milk.\n2. Dip bread in mixture.\n3. Cook on pan.',
    },
  ];

  Map<String, String>? detailInfo;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateDetailInfo(int recipeIndex) {
    setState(() {
      detailInfo = recipes[recipeIndex];
    });
    _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Recipe App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {updateDetailInfo(0);},
                  child: const Text("Breakfast Burrito"),
                ),
                ElevatedButton(
                  onPressed: () {updateDetailInfo(1);},
                  child: const Text("Scrambled Eggs"),
                ),
                ElevatedButton(
                  onPressed: () {updateDetailInfo(2);},
                  child: const Text("French Toast"),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (detailInfo != null) ...[
                  Text('Name: ${detailInfo!['Name']}', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  Text('Ingredients: ${detailInfo!['Ingredients']}', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text('Steps:\n ${detailInfo!['Steps']}', style: const TextStyle(fontSize: 18)),
                ] else
                  const Text('Select a recipe to view details', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
