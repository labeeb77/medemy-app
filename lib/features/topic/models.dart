import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

enum ContentMode {
  learn('learn', 'Learn'),
  revise('revise', 'Revise'),
  highYield('exam_high_yield', 'Exam High-Yield');

  const ContentMode(this.apiValue, this.label);
  final String apiValue;
  final String label;

  static ContentMode fromPath(String? value) => ContentMode.values.firstWhere((mode) => mode.name == value, orElse: () => ContentMode.learn);
}

@freezed
abstract class BlockAsset with _$BlockAsset {
  const factory BlockAsset({required String id, required String url, String? altText, String? mimeType}) = _BlockAsset;
  factory BlockAsset.fromJson(Map<String, dynamic> json) => _$BlockAssetFromJson(json);
}

@freezed
abstract class Citation with _$Citation {
  const factory Citation({required String resourceTitle, int? resourceVersion, int? pageFrom, int? pageTo, String? section}) = _Citation;
  factory Citation.fromJson(Map<String, dynamic> json) => _$CitationFromJson(json);
}

@freezed
abstract class ContentBlock with _$ContentBlock {
  const factory ContentBlock({required String id, required String mode, required String type, required String rendererKey,
    @Default(1) int schemaVersion, String? title, @Default(<String, dynamic>{}) Map<String, dynamic> payload,
    @Default(<BlockAsset>[]) List<BlockAsset> assets, @Default(<Citation>[]) List<Citation> citations}) = _ContentBlock;
  factory ContentBlock.fromJson(Map<String, dynamic> json) => _$ContentBlockFromJson(json);
}

@freezed
abstract class TopicContent with _$TopicContent {
  const factory TopicContent({required String contentVersionId, required String topicPlacementId, required String title,
    @Default(1) int versionNumber, String? mode, @Default(<ContentBlock>[]) List<ContentBlock> blocks}) = _TopicContent;
  factory TopicContent.fromJson(Map<String, dynamic> json) => _$TopicContentFromJson(json);
}
