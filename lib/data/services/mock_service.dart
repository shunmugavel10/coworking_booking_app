import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/branch.dart';

class MockService {
  Future<List<Branch>> fetchBranches() async {
    final raw = await rootBundle.loadString('assets/data/branches.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['branches'] as List).map((e) => Branch.fromJson(e)).toList();
    await Future.delayed(const Duration(milliseconds: 400)); // simulate latency
    return list;
  }
}
