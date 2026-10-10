import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/auth/session.dart';
import 'models.dart';

class AcademicRepository {
  AcademicRepository(this._api);
  final ApiClient _api;

  List<T> _list<T>(dynamic data, T Function(Map<String, dynamic>) parse) => (data as List).map((item) => parse(item as Map<String, dynamic>)).toList();

  Future<List<Semester>> semesters() async => _list(await _api.get('/semesters'), Semester.fromJson);
  Future<List<CurriculumNode>> subjects(String semesterId) async => _list(await _api.get('/semesters/$semesterId/subjects'), CurriculumNode.fromJson);
  Future<List<CurriculumNode>> units(String subjectId) async => _list(await _api.get('/subjects/$subjectId/units'), CurriculumNode.fromJson);
  Future<List<TopicNode>> topics(String unitId) async => _list(await _api.get('/units/$unitId/topic-placements'), TopicNode.fromJson);
}

final academicRepositoryProvider = Provider<AcademicRepository>((ref) => AcademicRepository(ref.watch(apiClientProvider)));

final semestersProvider = FutureProvider.autoDispose<List<Semester>>((ref) => ref.watch(academicRepositoryProvider).semesters());

/// Subjects of the student's current semester. Empty until a semester is chosen.
final currentSubjectsProvider = FutureProvider.autoDispose<List<CurriculumNode>>((ref) async {
  final semesterId = ref.watch(studentProvider)?.profile?.currentSemesterId;
  return semesterId == null ? const [] : ref.watch(academicRepositoryProvider).subjects(semesterId);
});

final unitsProvider = FutureProvider.autoDispose.family<List<CurriculumNode>, String>((ref, subjectId) => ref.watch(academicRepositoryProvider).units(subjectId));
final topicsProvider = FutureProvider.autoDispose.family<List<TopicNode>, String>((ref, unitId) => ref.watch(academicRepositoryProvider).topics(unitId));
