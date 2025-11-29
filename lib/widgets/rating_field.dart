import 'package:flutter/material.dart';

class RatingField extends StatefulWidget {
  final ValueChanged<int> onRatingSelected;

  const RatingField({super.key, required this.onRatingSelected});

  @override
  State<RatingField> createState() => _RatingFieldState();
}

class _RatingFieldState extends State<RatingField> {
  int? _selectedRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rating:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            final rating = index + 1;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRating = rating;
                });
                widget.onRatingSelected(rating);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedRating == rating
                      ? Colors.blue
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$rating',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedRating == rating
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
        if (_selectedRating == null)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Select a rating please',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}