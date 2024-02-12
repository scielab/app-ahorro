import 'package:flutter/material.dart';

class Category {
  final String id;
  final int category;
  final String name;
  final IconData icon; 
  final Color color;
  Category({
    required this.id,
    required this.category,
    required this.name,
    required this.icon,
    required this.color,
  });
}