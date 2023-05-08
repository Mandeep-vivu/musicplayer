  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  import 'main.dart';


  class SearchScreen extends StatelessWidget {
    const SearchScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      final musicProvider = Provider.of<MusicProvider>(context);
      final searchQuery = musicProvider.currentSong;

      // Filter the songs based on the search query
      final searchResults = musicProvider.trendingSongs
          .where((song) =>
          song.title.toLowerCase().contains(searchQuery?.toLowerCase() ?? ''))
          .toList();

      if (searchQuery?.isNotEmpty == true) {
        // Show the search results when there is a search query
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
              child: AppBar(
                backgroundColor: Colors.grey[900],
                title: TextField(
                  onChanged: (value) {
                    print(value);
                    musicProvider.setCurrentSong(value); // Update search query
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final song = searchResults[index];
                return GestureDetector(
                  onTap: () {
                    musicProvider.setCurrentSong(song.title); // Set the current song
                    musicProvider.playCurrentSong(); // Play the selected song
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    horizontalTitleGap: 50,
                    title: Text(song.title),
                    subtitle: Text(song.category),
                    leading: Image.network(
                      song.albumImageUrl,
                      scale: 1,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        // Show a grid view of favorite items when there is no search query
        return Center(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[900],
              title: TextField(
                onChanged: (value) {
                  print(value);
                  musicProvider.setCurrentSong(value); // Update search query
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: Column(
              children: [

                Text("favorite Songs",style: TextStyle(fontSize: 30,color: Colors.white),),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: musicProvider.favoriteItems.length,
                    itemBuilder: (context, index) {
                      final item = musicProvider.favoriteItems[index];
                      final song = musicProvider.trendingSongs[index];

                      return GestureDetector(
                        onTap: () {
                          musicProvider.setCurrentSong(song.title);
                          musicProvider.playCurrentSong();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: NetworkImage(item.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

