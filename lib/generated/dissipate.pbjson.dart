//
//  Generated code. Do not modify.
//  source: dissipate.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use accountStatusDescriptor instead')
const AccountStatus$json = {
  '1': 'AccountStatus',
  '2': [
    {'1': 'Active', '2': 0},
    {'1': 'Disabled', '2': 1},
    {'1': 'Suspended', '2': 2},
    {'1': 'Banned', '2': 3},
  ],
};

/// Descriptor for `AccountStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List accountStatusDescriptor = $convert.base64Decode(
    'Cg1BY2NvdW50U3RhdHVzEgoKBkFjdGl2ZRAAEgwKCERpc2FibGVkEAESDQoJU3VzcGVuZGVkEA'
    'ISCgoGQmFubmVkEAM=');

@$core.Deprecated('Use registerResponseResultDescriptor instead')
const RegisterResponseResult$json = {
  '1': 'RegisterResponseResult',
  '2': [
    {'1': 'Error', '2': 0},
    {'1': 'EmailSent', '2': 1},
    {'1': 'PhoneSent', '2': 2},
  ],
};

/// Descriptor for `RegisterResponseResult`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List registerResponseResultDescriptor = $convert.base64Decode(
    'ChZSZWdpc3RlclJlc3BvbnNlUmVzdWx0EgkKBUVycm9yEAASDQoJRW1haWxTZW50EAESDQoJUG'
    'hvbmVTZW50EAI=');

@$core.Deprecated('Use createHandleRequestDescriptor instead')
const CreateHandleRequest$json = {
  '1': 'CreateHandleRequest',
  '2': [
    {'1': 'handle', '3': 1, '4': 1, '5': 9, '10': 'handle'},
  ],
};

/// Descriptor for `CreateHandleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createHandleRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVIYW5kbGVSZXF1ZXN0EhYKBmhhbmRsZRgBIAEoCVIGaGFuZGxl');

@$core.Deprecated('Use createHandleResponseDescriptor instead')
const CreateHandleResponse$json = {
  '1': 'CreateHandleResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'handle', '3': 2, '4': 1, '5': 9, '10': 'handle'},
    {'1': 'created', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created'},
    {'1': 'last_seen', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSeen'},
  ],
};

/// Descriptor for `CreateHandleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createHandleResponseDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVIYW5kbGVSZXNwb25zZRIOCgJpZBgBIAEoCVICaWQSFgoGaGFuZGxlGAIgASgJUg'
    'ZoYW5kbGUSNAoHY3JlYXRlZBgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2Ny'
    'ZWF0ZWQSNwoJbGFzdF9zZWVuGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIbG'
    'FzdFNlZW4=');

@$core.Deprecated('Use registerRequestDescriptor instead')
const RegisterRequest$json = {
  '1': 'RegisterRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'email', '17': true},
    {'1': 'phone_number', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'phoneNumber', '17': true},
  ],
  '8': [
    {'1': '_email'},
    {'1': '_phone_number'},
  ],
};

/// Descriptor for `RegisterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerRequestDescriptor = $convert.base64Decode(
    'Cg9SZWdpc3RlclJlcXVlc3QSGQoFZW1haWwYASABKAlIAFIFZW1haWyIAQESJgoMcGhvbmVfbn'
    'VtYmVyGAIgASgJSAFSC3Bob25lTnVtYmVyiAEBQggKBl9lbWFpbEIPCg1fcGhvbmVfbnVtYmVy');

@$core.Deprecated('Use registerResponseDescriptor instead')
const RegisterResponse$json = {
  '1': 'RegisterResponse',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 14, '6': '.RegisterResponseResult', '10': 'result'},
    {'1': 'error_message', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'errorMessage', '17': true},
  ],
  '8': [
    {'1': '_error_message'},
  ],
};

/// Descriptor for `RegisterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerResponseDescriptor = $convert.base64Decode(
    'ChBSZWdpc3RlclJlc3BvbnNlEi8KBnJlc3VsdBgBIAEoDjIXLlJlZ2lzdGVyUmVzcG9uc2VSZX'
    'N1bHRSBnJlc3VsdBIoCg1lcnJvcl9tZXNzYWdlGAIgASgJSABSDGVycm9yTWVzc2FnZYgBAUIQ'
    'Cg5fZXJyb3JfbWVzc2FnZQ==');

