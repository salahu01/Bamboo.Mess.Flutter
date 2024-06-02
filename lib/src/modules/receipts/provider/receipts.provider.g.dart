// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipts.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchRecieptsHash() => r'5921b13f05121b7b57d280a6a69135134dbe9c99';

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

/// See also [fetchReciepts].
@ProviderFor(fetchReciepts)
const fetchRecieptsProvider = FetchRecieptsFamily();

/// See also [fetchReciepts].
class FetchRecieptsFamily extends Family<AsyncValue<List<List<RecieptModel>>>> {
  /// See also [fetchReciepts].
  const FetchRecieptsFamily();

  /// See also [fetchReciepts].
  FetchRecieptsProvider call({
    required int page,
    String? sortType,
    int limit = 10,
  }) {
    return FetchRecieptsProvider(
      page: page,
      sortType: sortType,
      limit: limit,
    );
  }

  @override
  FetchRecieptsProvider getProviderOverride(
    covariant FetchRecieptsProvider provider,
  ) {
    return call(
      page: provider.page,
      sortType: provider.sortType,
      limit: provider.limit,
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
  String? get name => r'fetchRecieptsProvider';
}

/// See also [fetchReciepts].
class FetchRecieptsProvider
    extends AutoDisposeFutureProvider<List<List<RecieptModel>>> {
  /// See also [fetchReciepts].
  FetchRecieptsProvider({
    required int page,
    String? sortType,
    int limit = 10,
  }) : this._internal(
          (ref) => fetchReciepts(
            ref as FetchRecieptsRef,
            page: page,
            sortType: sortType,
            limit: limit,
          ),
          from: fetchRecieptsProvider,
          name: r'fetchRecieptsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchRecieptsHash,
          dependencies: FetchRecieptsFamily._dependencies,
          allTransitiveDependencies:
              FetchRecieptsFamily._allTransitiveDependencies,
          page: page,
          sortType: sortType,
          limit: limit,
        );

  FetchRecieptsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.sortType,
    required this.limit,
  }) : super.internal();

  final int page;
  final String? sortType;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<List<RecieptModel>>> Function(FetchRecieptsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchRecieptsProvider._internal(
        (ref) => create(ref as FetchRecieptsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        sortType: sortType,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<List<RecieptModel>>> createElement() {
    return _FetchRecieptsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchRecieptsProvider &&
        other.page == page &&
        other.sortType == sortType &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, sortType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchRecieptsRef
    on AutoDisposeFutureProviderRef<List<List<RecieptModel>>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `sortType` of this provider.
  String? get sortType;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _FetchRecieptsProviderElement
    extends AutoDisposeFutureProviderElement<List<List<RecieptModel>>>
    with FetchRecieptsRef {
  _FetchRecieptsProviderElement(super.provider);

  @override
  int get page => (origin as FetchRecieptsProvider).page;
  @override
  String? get sortType => (origin as FetchRecieptsProvider).sortType;
  @override
  int get limit => (origin as FetchRecieptsProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
