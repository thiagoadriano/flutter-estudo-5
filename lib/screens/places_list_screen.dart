import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/routes.dart';
import 'package:great_places/widgets/great_tile.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.FORM_PLACE);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(child: Text('Nao foi encontrado registros')),
                    builder: (ctx, greatPlace, ch) => greatPlace.count == 0
                        ? ch
                        : ListView.builder(
                            itemCount: greatPlace.count,
                            itemBuilder: (ctx, i) =>
                                GreatTile(greatPlace.findByIndex(i)),
                          ),
                  ),
      ),
    );
  }
}
