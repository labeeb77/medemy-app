import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_client.dart';
import '../../core/auth/session.dart';
import 'models.dart';

class TopicRepository {
  TopicRepository(this._api);
  final ApiClient _api;

  Future<TopicContent> content(String topicPlacementId, {ContentMode? mode}) async => TopicContent.fromJson(
      await _api.get('/topic-placements/$topicPlacementId/content', query: {'mode': ?mode?.apiValue}) as Map<String, dynamic>);
}

final topicRepositoryProvider = Provider<TopicRepository>((ref) => TopicRepository(ref.watch(apiClientProvider)));

typedef ContentRequest = ({String topicPlacementId, ContentMode? mode});

/// Not kept between visits: block images use signed URLs that expire, so content is fetched fresh each time.
final topicContentProvider = FutureProvider.autoDispose.family<TopicContent, ContentRequest>(
    (ref, request) => ref.watch(topicRepositoryProvider).content(request.topicPlacementId, mode: request.mode));
