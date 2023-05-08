import 'package:flutter/material.dart';
import 'package:musicplayer/drawert.dart';

import 'package:provider/provider.dart';
import 'main.dart';

final List<String> categories = ['New', 'Pop', 'Rock', 'Melodies'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = categories[0];

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      drawerEdgeDragWidth: 80,
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: const Drawert(),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
          child: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: Container(
                  height: 65,
                  width: 65,
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                SearchField(musicProvider: musicProvider),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            child: Text(
              'Trending Right Now',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          HListTrending(musicProvider: musicProvider),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 7,),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: isSelected ? Colors.white54 : Colors.white10,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
              child: VListCategory(musicProvider: musicProvider, selectedCategory: selectedCategory),
            ),
        ],
      ),


    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.musicProvider,
  });

  final MusicProvider musicProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onTap: () {
          Navigator.pushNamed(context, '/search');
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
        onSubmitted: (value) {
          musicProvider.setCurrentSong(value);
          Navigator.pushNamed(context, '/search');
        },
      ),
    );
  }
}

class HListTrending extends StatelessWidget {
  const HListTrending({
    super.key,
    required this.musicProvider,
  });

  final MusicProvider musicProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: musicProvider.trendingSongs.length,
        itemBuilder: (context, index) {
          final song = musicProvider.trendingSongs[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 190,
                      height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(song.albumImageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              song.title,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.play_arrow),
                              color: Colors.white,
                              onPressed: () {
                                musicProvider.setCurrentSong(song.title);
                                musicProvider.playCurrentSong();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VListCategory extends StatelessWidget {
  const VListCategory({
    Key? key,
    required this.musicProvider,
    required this.selectedCategory,
  }) : super(key: key);

  final MusicProvider musicProvider;
  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: musicProvider.getSongsByCategory(selectedCategory).length,
      itemBuilder: (context, index) {
        final song = musicProvider.getSongsByCategory(selectedCategory)[index];

        return ListTile(
          title: GestureDetector(
            onTap: () {
              musicProvider.setCurrentSong(song.title);
              musicProvider.playCurrentSong();
            },
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(song.albumImageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  song.title,
                  style:  TextStyle(color: Colors.white,fontSize: 25),

                ),
              ],
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.favorite_border_outlined, color: Colors.white,size: 40,),
            onPressed: () {
              final song = musicProvider.trendingSongs[index];
              musicProvider.addToFavorites(song.albumImageUrl, song.title);
            },
          ),
        );
      },
    );
  }
}
