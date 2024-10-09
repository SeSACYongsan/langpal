// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_answer_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myAnswerDetailHash() => r'24e1d83a15e90ac17c1e1ae784137fec6d3557e8';

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

/// See also [myAnswerDetail].
@ProviderFor(myAnswerDetail)
const myAnswerDetailProvider = MyAnswerDetailFamily();

/// See also [myAnswerDetail].
class MyAnswerDetailFamily extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [myAnswerDetail].
  const MyAnswerDetailFamily();

  /// See also [myAnswerDetail].
  MyAnswerDetailProvider call(
    String answerID,
  ) {
    return MyAnswerDetailProvider(
      answerID,
    );
  }

  @override
  MyAnswerDetailProvider getProviderOverride(
    covariant MyAnswerDetailProvider provider,
  ) {
    return call(
      provider.answerID,
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
  String? get name => r'myAnswerDetailProvider';
}

/// See also [myAnswerDetail].
class MyAnswerDetailProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>?> {
  /// See also [myAnswerDetail].
  MyAnswerDetailProvider(
    String answerID,
  ) : this._internal(
          (ref) => myAnswerDetail(
            ref as MyAnswerDetailRef,
            answerID,
          ),
          from: myAnswerDetailProvider,
          name: r'myAnswerDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myAnswerDetailHash,
          dependencies: MyAnswerDetailFamily._dependencies,
          allTransitiveDependencies:
              MyAnswerDetailFamily._allTransitiveDependencies,
          answerID: answerID,
        );

  MyAnswerDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.answerID,
  }) : super.internal();

  final String answerID;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>?> Function(MyAnswerDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyAnswerDetailProvider._internal(
        (ref) => create(ref as MyAnswerDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        answerID: answerID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>?> createElement() {
    return _MyAnswerDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyAnswerDetailProvider && other.answerID == answerID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, answerID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MyAnswerDetailRef on AutoDisposeFutureProviderRef<Map<String, dynamic>?> {
  /// The parameter `answerID` of this provider.
  String get answerID;
}

class _MyAnswerDetailProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>?>
    with MyAnswerDetailRef {
  _MyAnswerDetailProviderElement(super.provider);

  @override
  String get answerID => (origin as MyAnswerDetailProvider).answerID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
