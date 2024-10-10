// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_question_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myQuestionDetailHash() => r'94b02d12c69277e35e3de53d16c8e44dc9903517';

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

/// See also [myQuestionDetail].
@ProviderFor(myQuestionDetail)
const myQuestionDetailProvider = MyQuestionDetailFamily();

/// See also [myQuestionDetail].
class MyQuestionDetailFamily extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [myQuestionDetail].
  const MyQuestionDetailFamily();

  /// See also [myQuestionDetail].
  MyQuestionDetailProvider call(
    String questionID,
  ) {
    return MyQuestionDetailProvider(
      questionID,
    );
  }

  @override
  MyQuestionDetailProvider getProviderOverride(
    covariant MyQuestionDetailProvider provider,
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
  String? get name => r'myQuestionDetailProvider';
}

/// See also [myQuestionDetail].
class MyQuestionDetailProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [myQuestionDetail].
  MyQuestionDetailProvider(
    String questionID,
  ) : this._internal(
          (ref) => myQuestionDetail(
            ref as MyQuestionDetailRef,
            questionID,
          ),
          from: myQuestionDetailProvider,
          name: r'myQuestionDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myQuestionDetailHash,
          dependencies: MyQuestionDetailFamily._dependencies,
          allTransitiveDependencies:
              MyQuestionDetailFamily._allTransitiveDependencies,
          questionID: questionID,
        );

  MyQuestionDetailProvider._internal(
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
    FutureOr<Map<String, dynamic>?> Function(MyQuestionDetailRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyQuestionDetailProvider._internal(
        (ref) => create(ref as MyQuestionDetailRef),
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
    return _MyQuestionDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyQuestionDetailProvider && other.questionID == questionID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, questionID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MyQuestionDetailRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `questionID` of this provider.
  String get questionID;
}

class _MyQuestionDetailProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with MyQuestionDetailRef {
  _MyQuestionDetailProviderElement(super.provider);

  @override
  String get questionID => (origin as MyQuestionDetailProvider).questionID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
