import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'models.dart';

/// What each known renderer supports. A block with an unknown key or a newer schema gets the fallback card,
/// so new content types published from the admin never break an older app.
const supportedSchemaVersions = <String, int>{
  'quick_concept_card': 1, 'definition_card': 1, 'visual_concept_card': 1, 'pathophysiology_card': 1, 'manifestations_card': 1,
  'diagnostics_card': 1, 'pharmacology_card': 1, 'nursing_priority_card': 1, 'comparison_card': 1, 'exam_focus_card': 1,
};

bool canRender(ContentBlock block) => (supportedSchemaVersions[block.rendererKey] ?? 0) >= block.schemaVersion;

List<String> _strings(dynamic value) => value is List ? value.map((item) => '$item').where((text) => text.trim().isNotEmpty).toList() : const [];
String _text(dynamic value) => value is String ? value : '';
List<Map<String, dynamic>> _maps(dynamic value) => value is List ? value.whereType<Map<String, dynamic>>().toList() : const [];

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(top: Space.md, bottom: Space.xs),
      child: Text(text, style: context.text.labelMedium?.copyWith(fontWeight: FontWeight.w700)));
}

class _Para extends StatelessWidget {
  const _Para(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => text.isEmpty ? const SizedBox.shrink() : Text(text, style: context.text.bodyLarge);
}

class _Bullets extends StatelessWidget {
  const _Bullets(this.items, {this.numbered = false, this.icon});
  final List<String> items;
  final bool numbered;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final (index, item) in items.indexed)
        Padding(padding: const EdgeInsets.only(bottom: Space.xs), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 26, child: icon != null
              ? Padding(padding: const EdgeInsets.only(top: 3), child: Icon(icon, size: 16, color: context.colors.secondaryText))
              : Text(numbered ? '${index + 1}.' : '•', style: context.text.bodyLarge)),
          Expanded(child: Text(item, style: context.text.bodyLarge)),
        ])),
    ]);
  }
}

/// A labelled list that disappears entirely when the payload has nothing for it.
List<Widget> _section(String label, dynamic value, {bool numbered = false, IconData? icon}) {
  final items = _strings(value);
  return items.isEmpty ? const [] : [_Label(label), _Bullets(items, numbered: numbered, icon: icon)];
}

List<Widget> _field(String label, dynamic value) => _text(value).isEmpty ? const [] : [_Label(label), _Para(_text(value))];

/// The body of a block, chosen by its renderer key. Presentation lives here; the payload carries none.
List<Widget> renderBlockBody(BuildContext context, ContentBlock block) {
  final p = block.payload;
  switch (block.rendererKey) {
    case 'quick_concept_card':
      return [_Para(_text(p['summary'])), ..._section('Key points', p['keyPoints'])];
    case 'definition_card':
      return [Text(_text(p['term']), style: context.text.titleMedium), const SizedBox(height: Space.xs), _Para(_text(p['definition'])),
        ..._field('Clinical context', p['clinicalContext'])];
    case 'visual_concept_card':
      return [_Para(_text(p['title'])), ..._field('Diagram type', p['diagramType']), ..._section('Elements', p['elements']), ..._field('Caption', p['caption'])];
    case 'pathophysiology_card':
      return [..._field('Cause', p['etiology']), ..._section('How it progresses', p['progressionSteps'], numbered: true),
        ..._section('Compensatory mechanisms', p['compensatoryMechanisms']), ..._section('Clinical consequences', p['clinicalConsequences'])];
    case 'manifestations_card':
      final stages = p['earlyVsLate'] is Map ? p['earlyVsLate'] as Map : const {};
      return [..._section('Signs', p['signs']), ..._section('Symptoms', p['symptoms']), ..._section('Early', stages['early']),
        ..._section('Late', stages['late']), ..._section('Red flags', p['redFlags'], icon: Icons.warning_amber_rounded)];
    case 'diagnostics_card':
      return [for (final test in _maps(p['investigations'])) ...[_Label(_text(test['testName'])), _Para(_text(test['findings'])),
        ..._field('Normal value', test['normalValue']), ..._field('Nursing implications', test['nursingImplications'])]];
    case 'pharmacology_card':
      return [for (final drug in _maps(p['drugClasses'])) ...[Padding(padding: const EdgeInsets.only(top: Space.md), child: Text(_text(drug['className']), style: context.text.titleMedium)),
        _Para(_text(drug['mechanism'])), ..._section('Common drugs', drug['commonDrugs']), ..._section('Adverse effects', drug['adverseEffects']),
        ..._section('Nursing alerts', drug['nursingAlerts'], icon: Icons.priority_high_rounded)]];
    case 'nursing_priority_card':
      return [..._section('Immediate priorities', p['immediatePriorities'], numbered: true), ..._section('Nursing diagnoses', p['nursingDiagnoses']),
        ..._section('Monitor', p['monitoringParameters']), ..._section('Patient education', p['patientEducation'])];
    case 'comparison_card':
      return [_Para(_text(p['title'])), const SizedBox(height: Space.sm), _ComparisonTable(columns: _strings(p['columns']), rows: _maps(p['rows']))];
    case 'exam_focus_card':
      return [..._section('High-yield pearls', p['highYieldPearls'], icon: Icons.star_outline_rounded),
        ..._section('Common pitfalls', p['commonPitfalls'], icon: Icons.warning_amber_rounded), ..._section('Mnemonics', p['examMnemonics'])];
  }
  return const [];
}

/// Each feature becomes a small card with one labelled value per column, which stays readable on a narrow phone
/// and at large text sizes where a real table would not.
class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({required this.columns, required this.rows});
  final List<String> columns;
  final List<Map<String, dynamic>> rows;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      for (final row in rows)
        Container(
          margin: const EdgeInsets.only(bottom: Space.sm), padding: const EdgeInsets.all(Space.md),
          decoration: BoxDecoration(border: Border.all(color: context.colors.border), borderRadius: BorderRadius.circular(Radii.control)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(_text(row['feature']), style: context.text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            for (final (index, value) in _strings(row['values']).indexed)
              Padding(padding: const EdgeInsets.only(top: Space.xs), child: Text.rich(TextSpan(children: [
                if (index < columns.length) TextSpan(text: '${columns[index]}: ', style: context.text.labelMedium),
                TextSpan(text: value, style: context.text.bodyLarge),
              ]))),
          ]),
        ),
    ]);
  }
}
