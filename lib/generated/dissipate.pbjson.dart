///
//  Generated code. Do not modify.
//  source: dissipate.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use accountStatusDescriptor instead')
const AccountStatus$json = const {
  '1': 'AccountStatus',
  '2': const [
    const {'1': 'Active', '2': 0},
    const {'1': 'Disabled', '2': 1},
    const {'1': 'Deleted', '2': 2},
  ],
};

/// Descriptor for `AccountStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List accountStatusDescriptor = $convert.base64Decode('Cg1BY2NvdW50U3RhdHVzEgoKBkFjdGl2ZRAAEgwKCERpc2FibGVkEAESCwoHRGVsZXRlZBAC');
@$core.Deprecated('Use accountDescriptor instead')
const Account$json = const {
  '1': 'Account',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'created', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created'},
    const {'1': 'last_login', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogin'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.AccountStatus', '10': 'status'},
  ],
};

/// Descriptor for `Account`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountDescriptor = $convert.base64Decode('CgdBY2NvdW50Eg4KAmlkGAEgASgJUgJpZBI0CgdjcmVhdGVkGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHY3JlYXRlZBI5CgpsYXN0X2xvZ2luGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJbGFzdExvZ2luEiYKBnN0YXR1cxgEIAEoDjIOLkFjY291bnRTdGF0dXNSBnN0YXR1cw==');
@$core.Deprecated('Use handleDescriptor instead')
const Handle$json = const {
  '1': 'Handle',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'handle', '3': 2, '4': 1, '5': 9, '10': 'handle'},
    const {'1': 'created', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created'},
    const {'1': 'last_seen', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSeen'},
  ],
};

/// Descriptor for `Handle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List handleDescriptor = $convert.base64Decode('CgZIYW5kbGUSDgoCaWQYASABKAlSAmlkEhYKBmhhbmRsZRgCIAEoCVIGaGFuZGxlEjQKB2NyZWF0ZWQYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdjcmVhdGVkEjcKCWxhc3Rfc2VlbhgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGxhc3RTZWVu');
@$core.Deprecated('Use createHandleRequestDescriptor instead')
const CreateHandleRequest$json = const {
  '1': 'CreateHandleRequest',
  '2': const [
    const {'1': 'handle', '3': 2, '4': 1, '5': 9, '10': 'handle'},
  ],
};

/// Descriptor for `CreateHandleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createHandleRequestDescriptor = $convert.base64Decode('ChNDcmVhdGVIYW5kbGVSZXF1ZXN0EhYKBmhhbmRsZRgCIAEoCVIGaGFuZGxl');
@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = const {
  '1': 'RegisterRequest',
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode('Cg9SZWdpc3RlclJlcXVlc3Q=');
@$core.Deprecated('Use registerResponseDescriptor instead')
const RegisterResponse$json = const {
  '1': 'RegisterResponse',
  '2': const [
    const {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.Account', '10': 'account'},
    const {'1': 'handles', '3': 2, '4': 3, '5': 11, '6': '.Handle', '10': 'handles'},
  ],
};

/// Descriptor for `RegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerResponseDescriptor = $convert.base64Decode('ChBSZWdpc3RlclJlc3BvbnNlEiIKB2FjY291bnQYASABKAsyCC5BY2NvdW50UgdhY2NvdW50EiEKB2hhbmRsZXMYAiADKAsyBy5IYW5kbGVSB2hhbmRsZXM=');