import 'package:cinepedia/model/addToFav.dart';

abstract class FavoriteEvent {}

class AddToFavorites extends FavoriteEvent {
  final addToFav item;

  AddToFavorites(this.item);
}

class RemoveFromFavorites extends FavoriteEvent {
  final int itemIndex;

  RemoveFromFavorites(this.itemIndex);
}