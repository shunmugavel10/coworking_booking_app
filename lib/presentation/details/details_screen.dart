import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/branch_providers.dart';

class DetailsScreen extends ConsumerWidget {
  final String id;
  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(branchesProvider);
    return async.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text(e.toString()))),
      data: (list) {
        final branch = list.firstWhere((b) => b.id == id);
        return Scaffold(
          appBar: AppBar(title: Text(branch.name)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SizedBox(
                height: 220,
                child: PageView(
                  children: branch.images.map((url) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(url, fit: BoxFit.cover),
                  )).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Text('${branch.branch}, ${branch.city}', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              Text(branch.description),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: branch.amenities.map((a) => Chip(label: Text(a.replaceAll('_', ' ').toLowerCase()))).toList(),
              ),
              const SizedBox(height: 12),
              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hours: ${branch.hours}'),
                const SizedBox(height: 25),
                Center(child: FilledButton(onPressed: () => context.go('/home/booking?id=${branch.id}'), child: const Text('Book Now'))),
              ])
            ],
          ),
        );
      },
    );
  }
}
