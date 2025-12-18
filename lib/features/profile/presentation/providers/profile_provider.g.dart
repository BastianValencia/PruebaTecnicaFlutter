// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileLocalDatasource)
const profileLocalDatasourceProvider = ProfileLocalDatasourceProvider._();

final class ProfileLocalDatasourceProvider
    extends
        $FunctionalProvider<
          ProfileLocalDatasource,
          ProfileLocalDatasource,
          ProfileLocalDatasource
        >
    with $Provider<ProfileLocalDatasource> {
  const ProfileLocalDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileLocalDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileLocalDatasourceHash();

  @$internal
  @override
  $ProviderElement<ProfileLocalDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileLocalDatasource create(Ref ref) {
    return profileLocalDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileLocalDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileLocalDatasource>(value),
    );
  }
}

String _$profileLocalDatasourceHash() =>
    r'afa12934590c7f6f70c0ff3b24aa7c34ea7d68b8';

@ProviderFor(profileRepository)
const profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  const ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'8793023ff6a77c56daeea0bbac41581b6ebab5a6';

@ProviderFor(ProfileNotifier)
const profileProvider = ProfileNotifierProvider._();

final class ProfileNotifierProvider
    extends $AsyncNotifierProvider<ProfileNotifier, ProfileEditState> {
  const ProfileNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileNotifierHash();

  @$internal
  @override
  ProfileNotifier create() => ProfileNotifier();
}

String _$profileNotifierHash() => r'b764955c4b938b93208528f9aad6ce37359bb4ec';

abstract class _$ProfileNotifier extends $AsyncNotifier<ProfileEditState> {
  FutureOr<ProfileEditState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<ProfileEditState>, ProfileEditState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileEditState>, ProfileEditState>,
              AsyncValue<ProfileEditState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
