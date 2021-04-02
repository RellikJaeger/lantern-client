///
//  Generated code. Do not modify.
//  source: protos_flutteronly/messaging.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MessageDirection extends $pb.ProtobufEnum {
  static const MessageDirection OUT = MessageDirection._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OUT');
  static const MessageDirection IN = MessageDirection._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IN');

  static const $core.List<MessageDirection> values = <MessageDirection> [
    OUT,
    IN,
  ];

  static final $core.Map<$core.int, MessageDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MessageDirection? valueOf($core.int value) => _byValue[value];

  const MessageDirection._($core.int v, $core.String n) : super(v, n);
}

class Contact_Type extends $pb.ProtobufEnum {
  static const Contact_Type DIRECT = Contact_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DIRECT');
  static const Contact_Type GROUP = Contact_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GROUP');

  static const $core.List<Contact_Type> values = <Contact_Type> [
    DIRECT,
    GROUP,
  ];

  static final $core.Map<$core.int, Contact_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Contact_Type? valueOf($core.int value) => _byValue[value];

  const Contact_Type._($core.int v, $core.String n) : super(v, n);
}

class StoredAttachment_Status extends $pb.ProtobufEnum {
  static const StoredAttachment_Status PENDING = StoredAttachment_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PENDING');
  static const StoredAttachment_Status DONE = StoredAttachment_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DONE');
  static const StoredAttachment_Status FAILED = StoredAttachment_Status._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILED');

  static const $core.List<StoredAttachment_Status> values = <StoredAttachment_Status> [
    PENDING,
    DONE,
    FAILED,
  ];

  static final $core.Map<$core.int, StoredAttachment_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StoredAttachment_Status? valueOf($core.int value) => _byValue[value];

  const StoredAttachment_Status._($core.int v, $core.String n) : super(v, n);
}

class StoredMessage_DeliveryStatus extends $pb.ProtobufEnum {
  static const StoredMessage_DeliveryStatus SENDING = StoredMessage_DeliveryStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENDING');
  static const StoredMessage_DeliveryStatus PARTIALLY_SENT = StoredMessage_DeliveryStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PARTIALLY_SENT');
  static const StoredMessage_DeliveryStatus COMPLETELY_SENT = StoredMessage_DeliveryStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMPLETELY_SENT');
  static const StoredMessage_DeliveryStatus PARTIALLY_FAILED = StoredMessage_DeliveryStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PARTIALLY_FAILED');
  static const StoredMessage_DeliveryStatus COMPLETELY_FAILED = StoredMessage_DeliveryStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMPLETELY_FAILED');

  static const $core.List<StoredMessage_DeliveryStatus> values = <StoredMessage_DeliveryStatus> [
    SENDING,
    PARTIALLY_SENT,
    COMPLETELY_SENT,
    PARTIALLY_FAILED,
    COMPLETELY_FAILED,
  ];

  static final $core.Map<$core.int, StoredMessage_DeliveryStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static StoredMessage_DeliveryStatus? valueOf($core.int value) => _byValue[value];

  const StoredMessage_DeliveryStatus._($core.int v, $core.String n) : super(v, n);
}

class OutboundMessage_SubDeliveryStatus extends $pb.ProtobufEnum {
  static const OutboundMessage_SubDeliveryStatus SENDING = OutboundMessage_SubDeliveryStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENDING');
  static const OutboundMessage_SubDeliveryStatus SENT = OutboundMessage_SubDeliveryStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENT');

  static const $core.List<OutboundMessage_SubDeliveryStatus> values = <OutboundMessage_SubDeliveryStatus> [
    SENDING,
    SENT,
  ];

  static final $core.Map<$core.int, OutboundMessage_SubDeliveryStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OutboundMessage_SubDeliveryStatus? valueOf($core.int value) => _byValue[value];

  const OutboundMessage_SubDeliveryStatus._($core.int v, $core.String n) : super(v, n);
}

