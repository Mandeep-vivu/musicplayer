import 'package:flutter/material.dart';
import 'package:musicplayer/home.dart';
import 'package:musicplayer/music.dart';
import 'package:musicplayer/person.dart';
import 'package:musicplayer/search.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(const MyApp());

class MusicProvider extends ChangeNotifier {
  int currentSongIndex = -1;
  String? currentSong;

  AudioPlayer player = AudioPlayer();
  void setCurrentSong(String song) {
    currentSong = song;
    currentSongIndex = trendingSongs.indexWhere((song) => song.title == currentSong);
    notifyListeners();
  }

  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  void setIsPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  void playCurrentSong() {
    if (currentSong != null) {
      player.play();
      setIsPlaying(true);
    }
  }
  void disposePlayer() {
    player.dispose();
  }
  List<Song> getSongsByCategory(String category) {
    return trendingSongs.where((song) => song.category == category).toList();
  }

  Song? get getSongDetails {
    if (currentSongIndex == -1) {
      return null;
    }
    return trendingSongs[currentSongIndex];
  }
  List<FavoriteItem> _favoriteItems = [];

  List<FavoriteItem> get favoriteItems => _favoriteItems;

  void addToFavorites(String imageUrl, String title) {
    // Check if the item already exists in the favoriteItems list
    bool isDuplicate = _favoriteItems.any((item) =>
    item.imageUrl == imageUrl && item.title == title);

    if (!isDuplicate) {
      final item = FavoriteItem(imageUrl: imageUrl, title: title);
      _favoriteItems.add(item);
      notifyListeners();
    }
  }

  void removeFromFavorites(FavoriteItem item) {
    _favoriteItems.remove(item);
    notifyListeners();
  }

  List<Song> trendingSongs = [
    Song(
      title: 'Tere Hawalle',
      category: 'New',
      albumImageUrl: 'https://img.freepik.com/free-vector/realistic-music-record-label-disk-mockup_1017-33906.jpg',
      sourceLinkIndex: 4, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Mastiyaan1',
      category: 'Pop',
      albumImageUrl: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg?ts=1561488440',
      sourceLinkIndex: 5, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Kahaani Suno1',
      category: 'New',
      albumImageUrl: 'https://img.freepik.com/free-vector/electro-music-album_53876-67221.jpg',
      sourceLinkIndex: 3,
    ),
    Song(
      title: 'Tere Hawalle1',
      category: 'New',
      albumImageUrl: 'https://img.freepik.com/free-vector/realistic-music-record-label-disk-mockup_1017-33906.jpg',
      sourceLinkIndex: 4, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Mastiyaan2',
      category: 'Pop',
      albumImageUrl: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg?ts=1561488440',
      sourceLinkIndex: 5, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Song 1',
      category: 'New',
      albumImageUrl: 'https://img.freepik.com/free-vector/electro-music-album_53876-67221.jpg',
      sourceLinkIndex: 0,
    ),
    Song(
      title: 'Song 2',
      category: 'Pop',
      albumImageUrl: 'https://img.freepik.com/free-vector/realistic-music-record-label-disk-mockup_1017-33906.jpg',
      sourceLinkIndex: 1, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Song 3',
      category: 'New',
      albumImageUrl: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg?ts=1561488440',
      sourceLinkIndex: 2, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Kahaani Suno4',
      category: 'New',
      albumImageUrl: 'https://img.freepik.com/free-vector/electro-music-album_53876-67221.jpg',
      sourceLinkIndex: 3,
    ),
    Song(
      title: 'Tere Hawalle4',
      category: 'New',
      albumImageUrl: 'https://img.freepik.com/free-vector/realistic-music-record-label-disk-mockup_1017-33906.jpg',
      sourceLinkIndex: 4, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Mastiyaan7',
      category: 'Pop',
      albumImageUrl: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg?ts=1561488440',
      sourceLinkIndex: 5, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Kahaani Suno9',
      category: 'New',
      albumImageUrl: 'https://img.freepik.com/free-vector/electro-music-album_53876-67221.jpg',
      sourceLinkIndex: 3,
    ),
    Song(
      title: 'Tere Hawalle6',
      category: 'New',
      albumImageUrl: 'https://img.freepik.com/free-vector/realistic-music-record-label-disk-mockup_1017-33906.jpg',
      sourceLinkIndex: 4, // Index of the source link in the sourceLinks list
    ),
    Song(
      title: 'Mastiyaan4',
      category: 'Pop',
      albumImageUrl: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg?ts=1561488440',
      sourceLinkIndex: 5, // Index of the source link in the sourceLinks list
    ),


  ];

  List<String> sourceLinks = [
    'https://www.pagalworld.com.se/files/download/id/65497', // Source link for Song 1
    'https://www.pagalworld.com.se/files/download/id/65756', // Source link for Song 2
    'https://www.pagalworld.com.se/files/download/id/6793', // Source link for Song 3
    'https://www.pagalworld.com.se/files/download/id/65497', // Source link for
    'https://www.pagalworld.com.se/files/download/id/65756', // Source link for
    'https://www.pagalworld.com.se/files/download/id/6793', // Source link for
  ];


}
class FavoriteItem {
  final String imageUrl;
  final String title;

  FavoriteItem({required this.imageUrl, required this.title});
}

class Song {
  final String title;
  final String category;
  final String albumImageUrl;
  final int sourceLinkIndex; // Index of the source link in the sourceLinks list

  Song({
    required this.title,
    required this.category,
    required this.albumImageUrl,
    required this.sourceLinkIndex,
  });

  String get sourceLink => MusicProvider().sourceLinks[sourceLinkIndex];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MusicProvider(),
      child: MaterialApp(
        title: 'Music Player',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[900], // Darker shade of black
        ),
        initialRoute: '/', // Set the initial route
        routes: {
          '/': (context) => const MyHomePage(), // Define the home route
          '/search': (context) => SearchScreen(), // Define the search route
        },
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    MusicScreen(),
    ProfileScreen(),
  ];
  void _onSearchSubmitted(String searchQuery) {
    final musicProvider = Provider.of<MusicProvider>(context);
    musicProvider.setCurrentSong(searchQuery);

    setState(() {
      _selectedIndex = 1;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850], // Lesser shade of black
      body: Stack(
        children: [
          _screens[_selectedIndex],
     Positioned(
       bottom: 20,
       left: 15,
       right: 15,
       child: Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 5), // Adjust the horizontal padding
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.grey.withOpacity(0.5), // Grey color with transparency
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(20),
                left: Radius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(20),
                    left: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust the spacing
                  children: <Widget>[
                    _CustomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: 40,
                        color: _selectedIndex == 0 ? Colors.white : Colors.grey[400],
                      ),
                      label: 'Home',
                      isSelected: _selectedIndex == 0,
                      onPressed: () => _onItemTapped(0),
                    ),
                    _CustomNavigationBarItem(
                      icon: Icon(
                        Icons.search_rounded,
                        size: 40,
                        color: _selectedIndex == 1 ? Colors.white : Colors.grey[400],
                      ),
                      label: 'Search',
                      isSelected: _selectedIndex == 1,
                      onPressed: () => _onItemTapped(1),
                    ),
                    _CustomNavigationBarItem(
                      icon: Icon(
                        Icons.music_note_outlined,
                        size: 40,
                        color: _selectedIndex == 2 ? Colors.white : Colors.grey[400],
                      ),
                      label: 'Music',
                      isSelected: _selectedIndex == 2,
                      onPressed: () => _onItemTapped(2),
                    ),
                    _CustomNavigationBarItem(
                      icon: Icon(
                        Icons.person_outline_rounded,
                        size: 40,
                        color: _selectedIndex == 3 ? Colors.white : Colors.grey[400],
                      ),
                      label: 'Profile',
                      isSelected: _selectedIndex == 3,
                      onPressed: () => _onItemTapped(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
     ),
        ],
      ),
    );
  }
}

class _CustomNavigationBarItem extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final String label;
  final bool isSelected;

  const _CustomNavigationBarItem({
    required this.icon,
    required this.onPressed,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8), // Adjust the vertical spacing
        child: icon,
      ),
    );
  }
}

