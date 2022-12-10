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
    const {'1': 'Suspended', '2': 2},
    const {'1': 'Banned', '2': 3},
  ],
};

/// Descriptor for `AccountStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List accountStatusDescriptor = $convert.base64Decode('Cg1BY2NvdW50U3RhdHVzEgoKBkFjdGl2ZRAAEgwKCERpc2FibGVkEAESDQoJU3VzcGVuZGVkEAISCgoGQmFubmVkEAM=');
@$core.Deprecated('Use createHandleRequestDescriptor instead')
const CreateHandleRequest$json = const {
  '1': 'CreateHandleRequest',
  '2': const [
    const {'1': 'handle', '3': 2, '4': 1, '5': 9, '10': 'handle'},
  ],
};

/// Descriptor for `CreateHandleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createHandleRequestDescriptor = $convert.base64Decode('ChNDcmVhdGVIYW5kbGVSZXF1ZXN0EhYKBmhhbmRsZRgCIAEoCVIGaGFuZGxl');
@$core.Deprecated('Use createHandleResponseDescriptor instead')
const CreateHandleResponse$json = const {
  '1': 'CreateHandleResponse',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'handle', '3': 2, '4': 1, '5': 9, '10': 'handle'},
    const {'1': 'created', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created'},
    const {'1': 'last_seen', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSeen'},
  ],
};

/// Descriptor for `CreateHandleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createHandleResponseDescriptor = $convert.base64Decode('ChRDcmVhdGVIYW5kbGVSZXNwb25zZRIOCgJpZBgBIAEoCVICaWQSFgoGaGFuZGxlGAIgASgJUgZoYW5kbGUSNAoHY3JlYXRlZBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2NyZWF0ZWQSNwoJbGFzdF9zZWVuGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIbGFzdFNlZW4=');
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
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'created', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created'},
    const {'1': 'last_login', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastLogin'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.AccountStatus', '10': 'status'},
  ],
};

/// Descriptor for `RegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerResponseDescriptor = $convert.base64Decode('ChBSZWdpc3RlclJlc3BvbnNlEg4KAmlkGAEgASgJUgJpZBI0CgdjcmVhdGVkGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHY3JlYXRlZBI5CgpsYXN0X2xvZ2luGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJbGFzdExvZ2luEiYKBnN0YXR1cxgEIAEoDjIOLkFjY291bnRTdGF0dXNSBnN0YXR1cw==');
