import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_scaffold.dart';
import '../providers/branch_providers.dart';
import '../../core/widgets/app_loading.dart';
import '../../core/widgets/app_error.dart';
import '../../data/models/branch.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(branchesProvider);

    return AppScaffold(
      title: 'Discover Spaces',
      currentIndex: 0,
      actions: [
        IconButton(
          onPressed: () => context.go('/map'),
          icon: const Icon(Icons.map),
        ),
      ],
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SearchAndFilters(),
            SizedBox(height: 12.h),
            Expanded(
              child: async.when(
                loading: () => const AppLoading(message: 'Loading branches...'),
                error: (e, st) => AppError(
                  message: e.toString(),
                  onRetry: () => ref.refresh(branchesProvider),
                ),
                data: (data) => _ResponsiveBranchGrid(branches: data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchAndFilters extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(branchFilterProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search by name, city, branch',
            border: OutlineInputBorder(),
          ),
          onChanged: (v) => ref.read(branchFilterProvider.notifier).state =
              filter.copyWith(query: v),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String?>(
                value: filter.city,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: null, child: Text('All Cities')),
                  DropdownMenuItem(value: 'Bengaluru', child: Text('Bengaluru')),
                  DropdownMenuItem(value: 'Hyderabad', child: Text('Hyderabad')),
                  DropdownMenuItem(value: 'Chennai', child: Text('Chennai')),
                  DropdownMenuItem(value: 'Kerala', child: Text('Kerala')),
                ],
                onChanged: (v) => ref.read(branchFilterProvider.notifier).state =
                    filter.copyWith(city: v),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: DropdownButtonFormField<int?>(
                value: filter.maxPrice,
                decoration: const InputDecoration(
                  labelText: "Max ₹/hr",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: null, child: Text('Any')),
                  DropdownMenuItem(value: 100, child: Text('₹100')),
                  DropdownMenuItem(value: 120, child: Text('₹120')),
                  DropdownMenuItem(value: 150, child: Text('₹150')),
                ],
                onChanged: (v) => ref.read(branchFilterProvider.notifier).state =
                    filter.copyWith(maxPrice: v),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _ResponsiveBranchGrid extends StatelessWidget {
  final List<Branch> branches;
  const _ResponsiveBranchGrid({required this.branches});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final width = c.maxWidth;
      final crossAxisCount =
          width >= 1000 ? 4 : width >= 700 ? 3 : width >= 500 ? 2 : 1;

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 3.3,
        ),
        itemCount: branches.length,
        itemBuilder: (_, i) => _BranchCard(branch: branches[i]),
      );
    });
  }
}

class _BranchCard extends StatelessWidget {
  final Branch branch;
  const _BranchCard({required this.branch});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/details?id=${branch.id}'),
      child: Card(
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  branch.images.first,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      branch.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${branch.branch}, ${branch.city}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹${branch.pricePerHour}/hr',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          FilledButton.icon(
                            onPressed: () =>
                                context.go('/booking?id=${branch.id}'),
                            icon: const Icon(Icons.event),
                            label: const Text(
                              'Book',
                              style: TextStyle(fontSize: 12),
                            ),
                            style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 6.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
