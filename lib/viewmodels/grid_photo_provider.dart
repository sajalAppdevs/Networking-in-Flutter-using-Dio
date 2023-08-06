import 'package:flutter/material.dart';
import '../data/models/pixelpay_photo.dart';
import '../data/repositories/pagination_repository.dart';


class PhotoProvider extends ChangeNotifier {
  final PaginationRepository userRepository;
  PhotoProvider({required this.userRepository});

  int _page = 1;
  String _search = 'nature';
  List<Hits> _photos = <Hits>[];
  bool _isLoading = false; // declare _isLoading as a private boolean variable

  String get search => _search;
  bool get isLoading => _isLoading;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<Hits> get photos => _photos;

  set photos(List<Hits> value) {
    _photos = value;
    notifyListeners();
  }

  Future<void> callPhotoApi() async {
    if (_isLoading) {
      return; // return if a fetch request is already in progress
    }
    _isLoading = true; // set _isLoading to true before making the API call
    userRepository.getPhotos(_search,_page).then((response) {
      _page = _page + 1;
      addPhotosToList(PixelPay.fromJson(response).hits!);
    });
  }

  void addPhotosToList(List<Hits> photoData) {
    /*_photos.addAll(photoData);
    _isLoading = false; // set _isLoading to false after the data has been fetched
    notifyListeners();*/

    Future.delayed(const Duration(seconds: 3), () {
      _photos.addAll(photoData);
      _isLoading = false;
      notifyListeners();
    });

  }
}
