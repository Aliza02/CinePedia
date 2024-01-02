import 'package:cinepedia/model/addToFav.dart';

abstract class FavoriteState {}

class FavoritesLoading extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final List<addToFav> favoriteItems;

  FavoritesLoaded(this.favoriteItems);
}

class FavoritesError extends FavoriteState {
  final String error;

  FavoritesError(this.error);
}
