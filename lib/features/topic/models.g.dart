// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BlockAsset _$BlockAssetFromJson(Map<String, dynamic> json) => _BlockAsset(
  id: json['id'] as String,
  url: json['url'] as String,
  altText: json['altText'] as String?,
  mimeType: json['mimeType'] as String?,
);

Map<String, dynamic> _$BlockAssetToJson(_BlockAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'altText': instance.altText,
      'mimeType': instance.mimeType,
    };

_Citation _$CitationFromJson(Map<String, dynamic> json) => _Citation(
  resourceTitle: json['resourceTitle'] as String,
  resourceVersion: (json['resourceVersion'] as num?)?.toInt(),
  pageFrom: (json['pageFrom'] as num?)?.toInt(),
  pageTo: (json['pageTo'] as num?)?.toInt(),
  section: json['section'] as String?,
);

Map<String, dynamic> _$CitationToJson(_Citation instance) => <String, dynamic>{
  'resourceTitle': instance.resourceTitle,
  'resourceVersion': instance.resourceVersion,
  'pageFrom': instance.pageFrom,
  'pageTo': instance.pageTo,
  'section': instance.section,
};

_ContentBlock _$ContentBlockFromJson(Map<String, dynamic> json) =>
    _ContentBlock(
      id: json['id'] as String,
      mode: json['mode'] as String,
      type: json['type'] as String,
      rendererKey: json['rendererKey'] as String,
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
      title: json['title'] as String?,
      payload:
          json['payload'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      assets:
          (json['assets'] as List<dynamic>?)
              ?.map((e) => BlockAsset.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BlockAsset>[],
      citations:
          (json['citations'] as List<dynamic>?)
              ?.map((e) => Citation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Citation>[],
    );

Map<String, dynamic> _$ContentBlockToJson(_ContentBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mode': instance.mode,
      'type': instance.type,
      'rendererKey': instance.rendererKey,
      'schemaVersion': instance.schemaVersion,
      'title': instance.title,
      'payload': instance.payload,
      'assets': instance.assets,
      'citations': instance.citations,
    };

_TopicContent _$TopicContentFromJson(Map<String, dynamic> json) =>
    _TopicContent(
      contentVersionId: json['contentVersionId'] as String,
      topicPlacementId: json['topicPlacementId'] as String,
      title: json['title'] as String,
      versionNumber: (json['versionNumber'] as num?)?.toInt() ?? 1,
      mode: json['mode'] as String?,
      blocks:
          (json['blocks'] as List<dynamic>?)
              ?.map((e) => ContentBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ContentBlock>[],
    );

Map<String, dynamic> _$TopicContentToJson(_TopicContent instance) =>
    <String, dynamic>{
      'contentVersionId': instance.contentVersionId,
      'topicPlacementId': instance.topicPlacementId,
      'title': instance.title,
      'versionNumber': instance.versionNumber,
      'mode': instance.mode,
      'blocks': instance.blocks,
    };
