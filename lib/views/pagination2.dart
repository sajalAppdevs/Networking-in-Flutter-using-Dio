import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/grid_photo_provider.dart';


class PaginationViewWidget extends StatefulWidget {
  const PaginationViewWidget({Key? key}) : super(key: key);

  @override
  PaginationViewWidgetState createState() => PaginationViewWidgetState();
}

class PaginationViewWidgetState extends State<PaginationViewWidget> {
  late PhotoProvider _photoProvider;
  bool _isLoadingMore = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initialize the PhotoProvider
    _photoProvider = Provider.of<PhotoProvider>(context, listen: false);
    _loadMoreData();

    // Listen to the scroll position and check when the user reaches the bottom of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreData() async {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });

      // Call the API to load more data
      await _photoProvider.callPhotoApi();

      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('Building...');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My ListView'),
      ),
      body:
      Stack(
        children: [

          Consumer<PhotoProvider>( // Consumer widget to listen for changes in UserViewModel
            builder: (BuildContext context, PhotoProvider photoProvider, _) {
              return

                ListView.builder(
                controller: _scrollController,
                itemCount: photoProvider.photos.length + 1,
                itemBuilder: (context, index) {

                  if (index == photoProvider.photos.length) {
                    if (kDebugMode) {
                      print('Loading more...');
                    }
                    return photoProvider.isLoading
                        ?  const Center(
                      child: CircularProgressIndicator(),
                    )
                        : Container(); // Return an empty container to hide the "Load More" button when all data is loaded
                  }
                  else {
                    final photo = photoProvider.photos[index];
                    return
                      Card(
                        margin: const EdgeInsets.all(15), // Set your desired margin value
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        shadowColor: Colors.yellow, // Set your desired shadow color here
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Image.network(
                              photo.webformatURL.toString(),
                              height: 340,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Matrimony ID: ABC123",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "John Doe",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Age: 30 • Height: 5'9'' • City: New York • Job: Engineer",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () {
                                    // Handle button press
                                  },
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );




                  }
                },
              );

            },
          ),

         /* if (_isLoadingMore)
            Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
*/
        ],
      )
    );
  }

}