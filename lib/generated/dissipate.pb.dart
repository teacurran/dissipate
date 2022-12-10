///
//  Generated code. Do not modify.
//  source: dissipate.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'dissipate.pbenum.dart';

export 'dissipate.pbenum.dart';

class CreateHandleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateHandleRequest', createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'handle')
    ..hasRequiredFields = false
  ;

  CreateHandleRequest._() : super();
  factory CreateHandleRequest({
    $core.String? handle,
  }) {
    final _result = create();
    if (handle != null) {
      _result.handle = handle;
    }
    return _result;
  }
  factory CreateHandleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateHandleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateHandleRequest clone() => CreateHandleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateHandleRequest copyWith(void Function(CreateHandleRequest) updates) => super.copyWith((message) => updates(message as CreateHandleRequest)) as CreateHandleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateHandleRequest create() => CreateHandleRequest._();
  CreateHandleRequest createEmptyInstance() => create();
  static $pb.PbList<CreateHandleRequest> createRepeated() => $pb.PbList<CreateHandleRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateHandleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateHandleRequest>(create);
  static CreateHandleRequest? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get handle => $_getSZ(0);
  @$pb.TagNumber(2)
  set handle($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasHandle() => $_has(0);
  @$pb.TagNumber(2)
  void clearHandle() => clearField(2);
}

class CreateHandleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateHandleResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'handle')
    ..aOM<$1.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastSeen', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CreateHandleResponse._() : super();
  factory CreateHandleResponse({
    $core.String? id,
    $core.String? handle,
    $1.Timestamp? created,
    $1.Timestamp? lastSeen,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (handle != null) {
      _result.handle = handle;
    }
    if (created != null) {
      _result.created = created;
    }
    if (lastSeen != null) {
      _result.lastSeen = lastSeen;
    }
    return _result;
  }
  factory CreateHandleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateHandleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateHandleResponse clone() => CreateHandleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateHandleResponse copyWith(void Function(CreateHandleResponse) updates) => super.copyWith((message) => updates(message as CreateHandleResponse)) as CreateHandleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateHandleResponse create() => CreateHandleResponse._();
  CreateHandleResponse createEmptyInstance() => create();
  static $pb.PbList<CreateHandleResponse> createRepeated() => $pb.PbList<CreateHandleResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateHandleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateHandleResponse>(create);
  static CreateHandleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get handle => $_getSZ(1);
  @$pb.TagNumber(2)
  set handle($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHandle() => $_has(1);
  @$pb.TagNumber(2)
  void clearHandle() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get created => $_getN(2);
  @$pb.TagNumber(3)
  set created($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreated() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreated() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureCreated() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get lastSeen => $_getN(3);
  @$pb.TagNumber(4)
  set lastSeen($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastSeen() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastSeen() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureLastSeen() => $_ensure(3);
}

class RegisterRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  RegisterRequest._() : super();
  factory RegisterRequest() => create();
  factory RegisterRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterRequest clone() => RegisterRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterRequest copyWith(void Function(RegisterRequest) updates) => super.copyWith((message) => updates(message as RegisterRequest)) as RegisterRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterRequest create() => RegisterRequest._();
  RegisterRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterRequest> createRepeated() => $pb.PbList<RegisterRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterRequest>(create);
  static RegisterRequest? _defaultInstance;
}

class RegisterResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$1.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastLogin', subBuilder: $1.Timestamp.create)
    ..e<AccountStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: AccountStatus.Active, valueOf: AccountStatus.valueOf, enumValues: AccountStatus.values)
    ..hasRequiredFields = false
  ;

  RegisterResponse._() : super();
  factory RegisterResponse({
    $core.String? id,
    $1.Timestamp? created,
    $1.Timestamp? lastLogin,
    AccountStatus? status,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (created != null) {
      _result.created = created;
    }
    if (lastLogin != null) {
      _result.lastLogin = lastLogin;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory RegisterResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterResponse clone() => RegisterResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterResponse copyWith(void Function(RegisterResponse) updates) => super.copyWith((message) => updates(message as RegisterResponse)) as RegisterResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterResponse create() => RegisterResponse._();
  RegisterResponse createEmptyInstance() => create();
  static $pb.PbList<RegisterResponse> createRepeated() => $pb.PbList<RegisterResponse>();
  @$core.pragma('dart2js:noInline')
  static RegisterResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterResponse>(create);
  static RegisterResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get created => $_getN(1);
  @$pb.TagNumber(2)
  set created($1.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreated() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreated() => clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureCreated() => $_ensure(1);

  @$pb.TagNumber(3)
  $1.Timestamp get lastLogin => $_getN(2);
  @$pb.TagNumber(3)
  set lastLogin($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastLogin() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastLogin() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureLastLogin() => $_ensure(2);

  @$pb.TagNumber(4)
  AccountStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(AccountStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

