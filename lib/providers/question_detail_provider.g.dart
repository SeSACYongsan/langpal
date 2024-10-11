// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$questionDetailHash() => r'114f8dc739009d2b4e40c9fc99a27a35051ccf11';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [questionDetail].
@ProviderFor(questionDetail)
const questionDetailProvider = QuestionDetailFamily();

/// See also [questionDetail].
class QuestionDetailFamily extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [questionDetail].
  const QuestionDetailFamily();

  /// See also [questionDetail].
  QuestionDetailProvider call(
    String questionID,
  ) {
    return QuestionDetailProvider(
      questionID,
    );
  }

  @override
  QuestionDetailProvider getProviderOverride(
    covariant QuestionDetailProvider provider,
  ) {
    return call(
      provider.questionID,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'questionDetailProvider';
}

/// See also [questionDetail].
class QuestionDetailProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [questionDetail].
  QuestionDetailProvider(
    String questionID,
  ) : this._internal(
          (ref) => questionDetail(
            ref as QuestionDetailRef,
            questionID,
          ),
          from: questionDetailProvider,
          name: r'questionDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$questionDetailHash,
          dependencies: QuestionDetailFamily._dependencies,
          allTransitiveDependencies:
              QuestionDetailFamily._allTransitiveDependencies,
          questionID: questionID,
        );

  QuestionDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.questionID,
  }) : super.internal();

  final String questionID;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(QuestionDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuestionDetailProvider._internal(
        (ref) => create(ref as QuestionDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        questionID: questionID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _QuestionDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionDetailProvider && other.questionID == questionID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, questionID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin QuestionDetailRef on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `questionID` of this provider.
  String get questionID;
}

class _QuestionDetailProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with QuestionDetailRef {
  _QuestionDetailProviderElement(super.provider);

  @override
  String get questionID => (origin as QuestionDetailProvider).questionID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
