import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../data/attractions_data.dart';
import '../models/attraction.dart';
import '../services/location_service.dart';
import '../services/pexels_service.dart';
import '../widgets/attraction_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  Position? _currentPosition;
  final List<Attraction> _attractions = List.from(sampleAttractions);
  bool _isLoadingImages = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    //Fetch location first
    final pos = await LocationService.getCurrentPosition();
    if (mounted) {
      setState(() => _currentPosition = pos);
    }

    // Fetch all images concurrently in the background instead of one-by-one
    try {
      final futures = _attractions.map((attraction) async {
        final updatedUrl = await PexelsService.fetchImage(
          attraction.name,
          attraction.imageUrl,
        );
        return Attraction(
          id: attraction.id,
          name: attraction.name,
          category: attraction.category,
          description: attraction.description,
          imageUrl: updatedUrl,
          latitude: attraction.latitude,
          longitude: attraction.longitude,
          address: attraction.address,
        );
      }).toList();

      final updatedAttractions = await Future.wait(futures);

      if (mounted) {
        setState(() {
          _attractions.clear();
          _attractions.addAll(updatedAttractions);
          _isLoadingImages = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingImages = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Hotels', 'Nature', 'Historical'];
    final filtered = _selectedCategory == 'All'
        ? _attractions
        : _attractions.where((a) => a.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ceylon Guide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: categories.map((cat) {
                final isSel = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSel,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Attractions Grid Display
          Expanded(
            child: _isLoadingImages && filtered.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final attraction = filtered[index];
                      double? dist;
                      if (_currentPosition != null) {
                        dist = LocationService.calculateDistanceInKm(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                          attraction.latitude,
                          attraction.longitude,
                        );
                      }
                      return AttractionCard(attraction: attraction, distance: dist);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}