import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    final userInput = ref.watch(searchBarProvider);

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.all(10.0),
            child: TextField(
                decoration: InputDecoration(
                  labelText: 'Input Restaurant Name',
                ),
                onChanged: (userInput) {
                  ref.read(searchBarProvider.notifier).state = userInput;
                }),
          ),
          Expanded(
            child: data.when(
              data: (restaurantList) {
                final restaurantList1 = restaurantList.where((restaurant) {
                  return restaurant.name
                      .toLowerCase()
                      .contains(userInput.toLowerCase());
                }).toList();

                return ListView.separated(
                  itemCount: restaurantList1.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final restaurant = restaurantList1[index];

                    return ListTile(
                      title: Text('${restaurant.id}. ${restaurant.name}'),
                      subtitle: Text(restaurant.cuisine),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    ));
  }
}
