//
//  Generated code. Do not modify.
//  source: dissipate.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class AccountStatus extends $pb.ProtobufEnum {
  static const AccountStatus Active = AccountStatus._(0, _omitEnumNames ? '' : 'Active');
  static const AccountStatus Disabled = AccountStatus._(1, _omitEnumNames ? '' : 'Disabled');
  static const AccountStatus Suspended = AccountStatus._(2, _omitEnumNames ? '' : 'Suspended');
  static const AccountStatus Banned = AccountStatus._(3, _omitEnumNames ? '' : 'Banned');

  static const $core.List<AccountStatus> values = <AccountStatus> [
    Active,
    Disabled,
    Suspended,
    Banned,
  ];

  static final $core.Map<$core.int, AccountStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AccountStatus? valueOf($core.int value) => _byValue[value];

  const AccountStatus._($core.int v, $core.String n) : super(v, n);
}

class RegisterResponseResult extends $pb.ProtobufEnum {
  static const RegisterResponseResult Error = RegisterResponseResult._(0, _omitEnumNames ? '' : 'Error');
  static const RegisterResponseResult EmailSent = RegisterResponseResult._(1, _omitEnumNames ? '' : 'EmailSent');
  static const RegisterResponseResult PhoneSent = RegisterResponseResult._(2, _omitEnumNames ? '' : 'PhoneSent');

  static const $core.List<RegisterResponseResult> values = <RegisterResponseResult> [
    Error,
    EmailSent,
    PhoneSent,
  ];

  static final $core.Map<$core.int, RegisterResponseResult> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RegisterResponseResult? valueOf($core.int value) => _byValue[value];

  const RegisterResponseResult._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
