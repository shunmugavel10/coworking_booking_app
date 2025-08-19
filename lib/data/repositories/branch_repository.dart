import '../models/branch.dart';
import '../services/mock_service.dart';

class BranchRepository {
  final MockService _service;
  BranchRepository(this._service);

  Future<List<Branch>> getBranches() => _service.fetchBranches();
}
