import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';

class Routes {
  static const HOME = '/';
  static const FORM_PLACE = '/form-place';

  static get mapRoutes {
    return {
      HOME: (_) => PlacesListScreen(),
      FORM_PLACE: (_) => PlaceFormScreen()
    };
  }
  
}