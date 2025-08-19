import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/branch_repository.dart';
import '../../data/services/mock_service.dart';
import '../../data/models/branch.dart';

final mockServiceProvider = Provider((_) => MockService());
final branchRepositoryProvider = Provider((ref) => BranchRepository(ref.read(mockServiceProvider)));

class BranchFilter {
  final String query;
  final String? city;
  final int? maxPrice;
  const BranchFilter({this.query = '', this.city, this.maxPrice});

  BranchFilter copyWith({String? query, String? city, int? maxPrice}) =>
      BranchFilter(query: query ?? this.query, city: city ?? this.city, maxPrice: maxPrice ?? this.maxPrice);
}

final branchFilterProvider = StateProvider<BranchFilter>((_) => const BranchFilter());

final branchesProvider = FutureProvider<List<Branch>>((ref) async {
  final repo = ref.read(branchRepositoryProvider);
  final filter = ref.watch(branchFilterProvider);
  final data = await repo.getBranches();
  return data.where((b) {
    final q = filter.query.toLowerCase();
    final matchesQuery = q.isEmpty || b.name.toLowerCase().contains(q) || b.city.toLowerCase().contains(q) || b.branch.toLowerCase().contains(q);
    final matchesCity = filter.city == null || b.city == filter.city;
    final matchesPrice = filter.maxPrice == null || b.pricePerHour <= filter.maxPrice!;
    return matchesQuery && matchesCity && matchesPrice;
  }).toList();
});
