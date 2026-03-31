import 'package:bookia_app/core/styles/colors.dart';
import 'package:bookia_app/features/home/data/model/best_seller_model/products.dart';
import 'package:bookia_app/features/home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Product> _filteredBooks = [];
  bool _hasSearched = false; 

  // Static books data
  final List<Product> _allBooks = [
    Product(
      id: 1,
      name: 'The Republic',
      image: 'https://images-na.ssl-images-amazon.com/images/I/71N5zYcNcaL.jpg',
      price: '285',
      priceAfterDiscount: 285,
    ),
    Product(
      id: 2,
      name: 'The Republicldldld dfge',
      image: 'https://images-na.ssl-images-amazon.com/images/I/71N5zYcNcaL.jpg',
      price: '285',
      priceAfterDiscount: 285,
    ),
    Product(
      id: 3,
      name: 'Pride and Prejudice',
      image: 'https://images-na.ssl-images-amazon.com/images/I/71Q1tPupKjL.jpg',
      price: '250',
      priceAfterDiscount: 250,
    ),
    Product(
      id: 4,
      name: 'To Kill a Mockingbird',
      image: 'https://images-na.ssl-images-amazon.com/images/I/71FxgtFKcQL.jpg',
      price: '300',
      priceAfterDiscount: 300,
    ),
    Product(
      id: 5,
      name: '1984',
      image: 'https://images-na.ssl-images-amazon.com/images/I/71kxa1-0mfL.jpg',
      price: '275',
      priceAfterDiscount: 275,
    ),
    Product(
      id: 6,
      name: 'The Great Gatsby',
      image: 'https://images-na.ssl-images-amazon.com/images/I/71FTb9X6wsL.jpg',
      price: '260',
      priceAfterDiscount: 260,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBooks(String query) {
    setState(() {
      _hasSearched = query.isNotEmpty; // User started searching
      
      if (query.isEmpty) {
        _filteredBooks = [];
      } else {
        _filteredBooks = _allBooks
            .where((book) =>
                book.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterBooks,
                decoration: InputDecoration(
                  hintText: 'Search Store',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: _hasSearched
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _filterBooks('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),

          // Results Area
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // Case 1: User hasn't searched yet
    if (!_hasSearched) {
      return _buildInitialState();
    }

    // Case 2: User searched but no results
    if (_filteredBooks.isEmpty) {
      return _buildEmptyResults();
    }

    // Case 3: Show search results
    return _buildBookGrid();
  }

  // Initial State: Before any search
  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.grey[300],
          ),
          const Gap(16),
          Text(
            'No Search',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const Gap(8),
          Text(
            'Start typing to search for books',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  // Empty Results: User searched but nothing found
  Widget _buildEmptyResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[300],
          ),
          const Gap(16),
          Text(
            'No books found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const Gap(8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  // Book Grid: Search results
  Widget _buildBookGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: _filteredBooks.length,
      itemBuilder: (context, index) {
        return BookCard(product: _filteredBooks[index]);
      },
    );
  }
}