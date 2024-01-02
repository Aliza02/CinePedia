import 'package:cinepedia/bloc/addToFavouriteEvent.dart';
import 'package:cinepedia/bloc/addToFavouritesState.dart';
import 'package:cinepedia/model/addToFav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<addToFav> _favoriteItems = [];

  FavoriteBloc() : super(FavoritesLoading()) {
    on<FavoriteEvent>((event, emit) {
      if (event is AddToFavorites) {
        _favoriteItems.add(event.item);
        emit(FavoritesLoaded(List.from(_favoriteItems)));
      } else if (event is RemoveFromFavorites) {
        _favoriteItems.removeAt(event.itemIndex);
        emit(FavoritesLoaded(List.from(_favoriteItems)));
      }
    });
  }
}
