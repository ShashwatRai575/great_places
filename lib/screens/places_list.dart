import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: Center(
            child: const Text('Got no places yet, start adding some!'),
          ),
          builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
              ? ch!
              : ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        greatPlaces.items[i].image,
                      ),
                    ),
                    title: Text(greatPlaces.items[i].title),
                    onTap: () {
                      // Go to detail page ...
                    },
                  ),
                ),
        ));
  }
}
