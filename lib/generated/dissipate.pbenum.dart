///
//  Generated code. Do not modify.
//  source: dissipate.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class AccountStatus extends $pb.ProtobufEnum {
  static const AccountStatus Active = AccountStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Active');
  static const AccountStatus Disabled = AccountStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Disabled');
  static const AccountStatus Deleted = AccountStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Deleted');

  static const $core.List<AccountStatus> values = <AccountStatus> [
    Active,
    Disabled,
    Deleted,
  ];

  static final $core.Map<$core.int, AccountStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AccountStatus? valueOf($core.int value) => _byValue[value];

  const AccountStatus._($core.int v, $core.String n) : super(v, n);
}

