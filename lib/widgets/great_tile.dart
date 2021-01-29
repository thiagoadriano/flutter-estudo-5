import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatTile extends StatelessWidget {
  final Place _place;

  GreatTile(this._place);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_place.title),
      leading: CircleAvatar(
        backgroundImage: FileImage(_place.image),
      ),
      onTap: () {},
    );
  }
}
