///
//  Generated code. Do not modify.
//  source: protos_flutteronly/messaging.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'messaging.pbenum.dart';

export 'messaging.pbenum.dart';

class ContactId extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ContactId', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..e<ContactType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ContactType.DIRECT, valueOf: ContactType.valueOf, enumValues: ContactType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  ContactId._() : super();
  factory ContactId({
    ContactType? type,
    $core.String? id,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory ContactId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContactId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContactId clone() => ContactId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContactId copyWith(void Function(ContactId) updates) => super.copyWith((message) => updates(message as ContactId)) as ContactId; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ContactId create() => ContactId._();
  ContactId createEmptyInstance() => create();
  static $pb.PbList<ContactId> createRepeated() => $pb.PbList<ContactId>();
  @$core.pragma('dart2js:noInline')
  static ContactId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContactId>(create);
  static ContactId? _defaultInstance;

  @$pb.TagNumber(1)
  ContactType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(ContactType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);
}

class Contact extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Contact', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..aOM<ContactId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contactId', protoName: 'contactId', subBuilder: ContactId.create)
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'memberIds', protoName: 'memberIds')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName', protoName: 'displayName')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdTs', protoName: 'createdTs')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mostRecentMessageTs', protoName: 'mostRecentMessageTs')
    ..e<MessageDirection>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mostRecentMessageDirection', $pb.PbFieldType.OE, protoName: 'mostRecentMessageDirection', defaultOrMaker: MessageDirection.OUT, valueOf: MessageDirection.valueOf, enumValues: MessageDirection.values)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mostRecentMessageText', protoName: 'mostRecentMessageText')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mostRecentAttachmentMimeType', protoName: 'mostRecentAttachmentMimeType')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messagesDisappearAfterSeconds', $pb.PbFieldType.O3, protoName: 'messagesDisappearAfterSeconds')
    ..hasRequiredFields = false
  ;

  Contact._() : super();
  factory Contact({
    ContactId? contactId,
    $core.Iterable<$core.String>? memberIds,
    $core.String? displayName,
    $fixnum.Int64? createdTs,
    $fixnum.Int64? mostRecentMessageTs,
    MessageDirection? mostRecentMessageDirection,
    $core.String? mostRecentMessageText,
    $core.String? mostRecentAttachmentMimeType,
    $core.int? messagesDisappearAfterSeconds,
  }) {
    final _result = create();
    if (contactId != null) {
      _result.contactId = contactId;
    }
    if (memberIds != null) {
      _result.memberIds.addAll(memberIds);
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (createdTs != null) {
      _result.createdTs = createdTs;
    }
    if (mostRecentMessageTs != null) {
      _result.mostRecentMessageTs = mostRecentMessageTs;
    }
    if (mostRecentMessageDirection != null) {
      _result.mostRecentMessageDirection = mostRecentMessageDirection;
    }
    if (mostRecentMessageText != null) {
      _result.mostRecentMessageText = mostRecentMessageText;
    }
    if (mostRecentAttachmentMimeType != null) {
      _result.mostRecentAttachmentMimeType = mostRecentAttachmentMimeType;
    }
    if (messagesDisappearAfterSeconds != null) {
      _result.messagesDisappearAfterSeconds = messagesDisappearAfterSeconds;
    }
    return _result;
  }
  factory Contact.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Contact.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Contact clone() => Contact()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Contact copyWith(void Function(Contact) updates) => super.copyWith((message) => updates(message as Contact)) as Contact; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Contact create() => Contact._();
  Contact createEmptyInstance() => create();
  static $pb.PbList<Contact> createRepeated() => $pb.PbList<Contact>();
  @$core.pragma('dart2js:noInline')
  static Contact getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Contact>(create);
  static Contact? _defaultInstance;

  @$pb.TagNumber(1)
  ContactId get contactId => $_getN(0);
  @$pb.TagNumber(1)
  set contactId(ContactId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasContactId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContactId() => clearField(1);
  @$pb.TagNumber(1)
  ContactId ensureContactId() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get memberIds => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get createdTs => $_getI64(3);
  @$pb.TagNumber(4)
  set createdTs($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatedTs() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedTs() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get mostRecentMessageTs => $_getI64(4);
  @$pb.TagNumber(5)
  set mostRecentMessageTs($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMostRecentMessageTs() => $_has(4);
  @$pb.TagNumber(5)
  void clearMostRecentMessageTs() => clearField(5);

  @$pb.TagNumber(6)
  MessageDirection get mostRecentMessageDirection => $_getN(5);
  @$pb.TagNumber(6)
  set mostRecentMessageDirection(MessageDirection v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasMostRecentMessageDirection() => $_has(5);
  @$pb.TagNumber(6)
  void clearMostRecentMessageDirection() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get mostRecentMessageText => $_getSZ(6);
  @$pb.TagNumber(7)
  set mostRecentMessageText($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMostRecentMessageText() => $_has(6);
  @$pb.TagNumber(7)
  void clearMostRecentMessageText() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get mostRecentAttachmentMimeType => $_getSZ(7);
  @$pb.TagNumber(8)
  set mostRecentAttachmentMimeType($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMostRecentAttachmentMimeType() => $_has(7);
  @$pb.TagNumber(8)
  void clearMostRecentAttachmentMimeType() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get messagesDisappearAfterSeconds => $_getIZ(8);
  @$pb.TagNumber(9)
  set messagesDisappearAfterSeconds($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMessagesDisappearAfterSeconds() => $_has(8);
  @$pb.TagNumber(9)
  void clearMessagesDisappearAfterSeconds() => clearField(9);
}

class Attachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Attachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mimeType', protoName: 'mimeType')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'keyMaterial', $pb.PbFieldType.OY, protoName: 'keyMaterial')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'digest', $pb.PbFieldType.OY)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'plaintextLength', protoName: 'plaintextLength')
    ..m<$core.String, $core.String>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'Attachment.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('model'))
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'downloadUrl', protoName: 'downloadUrl')
    ..hasRequiredFields = false
  ;

  Attachment._() : super();
  factory Attachment({
    $core.String? mimeType,
    $core.List<$core.int>? keyMaterial,
    $core.List<$core.int>? digest,
    $fixnum.Int64? plaintextLength,
    $core.Map<$core.String, $core.String>? metadata,
    $core.String? downloadUrl,
  }) {
    final _result = create();
    if (mimeType != null) {
      _result.mimeType = mimeType;
    }
    if (keyMaterial != null) {
      _result.keyMaterial = keyMaterial;
    }
    if (digest != null) {
      _result.digest = digest;
    }
    if (plaintextLength != null) {
      _result.plaintextLength = plaintextLength;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (downloadUrl != null) {
      _result.downloadUrl = downloadUrl;
    }
    return _result;
  }
  factory Attachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Attachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Attachment clone() => Attachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Attachment copyWith(void Function(Attachment) updates) => super.copyWith((message) => updates(message as Attachment)) as Attachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Attachment create() => Attachment._();
  Attachment createEmptyInstance() => create();
  static $pb.PbList<Attachment> createRepeated() => $pb.PbList<Attachment>();
  @$core.pragma('dart2js:noInline')
  static Attachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Attachment>(create);
  static Attachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mimeType => $_getSZ(0);
  @$pb.TagNumber(1)
  set mimeType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMimeType() => $_has(0);
  @$pb.TagNumber(1)
  void clearMimeType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get keyMaterial => $_getN(1);
  @$pb.TagNumber(2)
  set keyMaterial($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKeyMaterial() => $_has(1);
  @$pb.TagNumber(2)
  void clearKeyMaterial() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get digest => $_getN(2);
  @$pb.TagNumber(3)
  set digest($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDigest() => $_has(2);
  @$pb.TagNumber(3)
  void clearDigest() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get plaintextLength => $_getI64(3);
  @$pb.TagNumber(4)
  set plaintextLength($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPlaintextLength() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlaintextLength() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(4);

  @$pb.TagNumber(6)
  $core.String get downloadUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set downloadUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDownloadUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearDownloadUrl() => clearField(6);
}

class StoredAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StoredAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'guid')
    ..aOM<Attachment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachment', subBuilder: Attachment.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'encryptedFilePath', protoName: 'encryptedFilePath')
    ..e<StoredAttachment_Status>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: StoredAttachment_Status.PENDING, valueOf: StoredAttachment_Status.valueOf, enumValues: StoredAttachment_Status.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'plainTextFilePath', protoName: 'plainTextFilePath')
    ..aOM<StoredAttachment>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'thumbnail', subBuilder: StoredAttachment.create)
    ..hasRequiredFields = false
  ;

  StoredAttachment._() : super();
  factory StoredAttachment({
    $core.String? guid,
    Attachment? attachment,
    $core.String? encryptedFilePath,
    StoredAttachment_Status? status,
    $core.String? plainTextFilePath,
    StoredAttachment? thumbnail,
  }) {
    final _result = create();
    if (guid != null) {
      _result.guid = guid;
    }
    if (attachment != null) {
      _result.attachment = attachment;
    }
    if (encryptedFilePath != null) {
      _result.encryptedFilePath = encryptedFilePath;
    }
    if (status != null) {
      _result.status = status;
    }
    if (plainTextFilePath != null) {
      _result.plainTextFilePath = plainTextFilePath;
    }
    if (thumbnail != null) {
      _result.thumbnail = thumbnail;
    }
    return _result;
  }
  factory StoredAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StoredAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StoredAttachment clone() => StoredAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StoredAttachment copyWith(void Function(StoredAttachment) updates) => super.copyWith((message) => updates(message as StoredAttachment)) as StoredAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StoredAttachment create() => StoredAttachment._();
  StoredAttachment createEmptyInstance() => create();
  static $pb.PbList<StoredAttachment> createRepeated() => $pb.PbList<StoredAttachment>();
  @$core.pragma('dart2js:noInline')
  static StoredAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StoredAttachment>(create);
  static StoredAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get guid => $_getSZ(0);
  @$pb.TagNumber(1)
  set guid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearGuid() => clearField(1);

  @$pb.TagNumber(2)
  Attachment get attachment => $_getN(1);
  @$pb.TagNumber(2)
  set attachment(Attachment v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAttachment() => $_has(1);
  @$pb.TagNumber(2)
  void clearAttachment() => clearField(2);
  @$pb.TagNumber(2)
  Attachment ensureAttachment() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get encryptedFilePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set encryptedFilePath($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEncryptedFilePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearEncryptedFilePath() => clearField(3);

  @$pb.TagNumber(4)
  StoredAttachment_Status get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(StoredAttachment_Status v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get plainTextFilePath => $_getSZ(4);
  @$pb.TagNumber(5)
  set plainTextFilePath($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPlainTextFilePath() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlainTextFilePath() => clearField(5);

  @$pb.TagNumber(6)
  StoredAttachment get thumbnail => $_getN(5);
  @$pb.TagNumber(6)
  set thumbnail(StoredAttachment v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasThumbnail() => $_has(5);
  @$pb.TagNumber(6)
  void clearThumbnail() => clearField(6);
  @$pb.TagNumber(6)
  StoredAttachment ensureThumbnail() => $_ensure(5);
}

class AttachmentWithThumbnail extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AttachmentWithThumbnail', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..aOM<Attachment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachment', subBuilder: Attachment.create)
    ..aOM<Attachment>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'thumbnail', subBuilder: Attachment.create)
    ..hasRequiredFields = false
  ;

  AttachmentWithThumbnail._() : super();
  factory AttachmentWithThumbnail({
    Attachment? attachment,
    Attachment? thumbnail,
  }) {
    final _result = create();
    if (attachment != null) {
      _result.attachment = attachment;
    }
    if (thumbnail != null) {
      _result.thumbnail = thumbnail;
    }
    return _result;
  }
  factory AttachmentWithThumbnail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AttachmentWithThumbnail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AttachmentWithThumbnail clone() => AttachmentWithThumbnail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AttachmentWithThumbnail copyWith(void Function(AttachmentWithThumbnail) updates) => super.copyWith((message) => updates(message as AttachmentWithThumbnail)) as AttachmentWithThumbnail; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AttachmentWithThumbnail create() => AttachmentWithThumbnail._();
  AttachmentWithThumbnail createEmptyInstance() => create();
  static $pb.PbList<AttachmentWithThumbnail> createRepeated() => $pb.PbList<AttachmentWithThumbnail>();
  @$core.pragma('dart2js:noInline')
  static AttachmentWithThumbnail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AttachmentWithThumbnail>(create);
  static AttachmentWithThumbnail? _defaultInstance;

  @$pb.TagNumber(1)
  Attachment get attachment => $_getN(0);
  @$pb.TagNumber(1)
  set attachment(Attachment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAttachment() => $_has(0);
  @$pb.TagNumber(1)
  void clearAttachment() => clearField(1);
  @$pb.TagNumber(1)
  Attachment ensureAttachment() => $_ensure(0);

  @$pb.TagNumber(2)
  Attachment get thumbnail => $_getN(1);
  @$pb.TagNumber(2)
  set thumbnail(Attachment v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasThumbnail() => $_has(1);
  @$pb.TagNumber(2)
  void clearThumbnail() => clearField(2);
  @$pb.TagNumber(2)
  Attachment ensureThumbnail() => $_ensure(1);
}

class Message extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'replyToSenderId', $pb.PbFieldType.OY, protoName: 'replyToSenderId')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'replyToId', $pb.PbFieldType.OY, protoName: 'replyToId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..m<$core.int, AttachmentWithThumbnail>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachments', entryClassName: 'Message.AttachmentsEntry', keyFieldType: $pb.PbFieldType.O3, valueFieldType: $pb.PbFieldType.OM, valueCreator: AttachmentWithThumbnail.create, packageName: const $pb.PackageName('model'))
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disappearAfterSeconds', $pb.PbFieldType.O3, protoName: 'disappearAfterSeconds')
    ..hasRequiredFields = false
  ;

  Message._() : super();
  factory Message({
    $core.List<$core.int>? id,
    $core.List<$core.int>? replyToSenderId,
    $core.List<$core.int>? replyToId,
    $core.String? text,
    $core.Map<$core.int, AttachmentWithThumbnail>? attachments,
    $core.int? disappearAfterSeconds,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (replyToSenderId != null) {
      _result.replyToSenderId = replyToSenderId;
    }
    if (replyToId != null) {
      _result.replyToId = replyToId;
    }
    if (text != null) {
      _result.text = text;
    }
    if (attachments != null) {
      _result.attachments.addAll(attachments);
    }
    if (disappearAfterSeconds != null) {
      _result.disappearAfterSeconds = disappearAfterSeconds;
    }
    return _result;
  }
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get replyToSenderId => $_getN(1);
  @$pb.TagNumber(2)
  set replyToSenderId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReplyToSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReplyToSenderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get replyToId => $_getN(2);
  @$pb.TagNumber(3)
  set replyToId($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReplyToId() => $_has(2);
  @$pb.TagNumber(3)
  void clearReplyToId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get text => $_getSZ(3);
  @$pb.TagNumber(4)
  set text($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasText() => $_has(3);
  @$pb.TagNumber(4)
  void clearText() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.int, AttachmentWithThumbnail> get attachments => $_getMap(4);

  @$pb.TagNumber(6)
  $core.int get disappearAfterSeconds => $_getIZ(5);
  @$pb.TagNumber(6)
  set disappearAfterSeconds($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDisappearAfterSeconds() => $_has(5);
  @$pb.TagNumber(6)
  void clearDisappearAfterSeconds() => clearField(6);
}

class StoredMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StoredMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..aOM<ContactId>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contactId', protoName: 'contactId', subBuilder: ContactId.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId', protoName: 'senderId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ts')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'replyToSenderId', protoName: 'replyToSenderId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'replyToId', protoName: 'replyToId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disappearAfterSeconds', $pb.PbFieldType.O3, protoName: 'disappearAfterSeconds')
    ..m<$core.int, StoredAttachment>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachments', entryClassName: 'StoredMessage.AttachmentsEntry', keyFieldType: $pb.PbFieldType.O3, valueFieldType: $pb.PbFieldType.OM, valueCreator: StoredAttachment.create, packageName: const $pb.PackageName('model'))
    ..e<MessageDirection>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: MessageDirection.OUT, valueOf: MessageDirection.valueOf, enumValues: MessageDirection.values)
    ..m<$core.String, Reaction>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reactions', entryClassName: 'StoredMessage.ReactionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: Reaction.create, packageName: const $pb.PackageName('model'))
    ..e<StoredMessage_DeliveryStatus>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: StoredMessage_DeliveryStatus.SENDING, valueOf: StoredMessage_DeliveryStatus.valueOf, enumValues: StoredMessage_DeliveryStatus.values)
    ..aInt64(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstViewedAt', protoName: 'firstViewedAt')
    ..aInt64(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disappearAt', protoName: 'disappearAt')
    ..m<$core.int, $core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'thumbnails', entryClassName: 'StoredMessage.ThumbnailsEntry', keyFieldType: $pb.PbFieldType.O3, valueFieldType: $pb.PbFieldType.O3, packageName: const $pb.PackageName('model'))
    ..aInt64(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remotelyDeletedAt', protoName: 'remotelyDeletedAt')
    ..aOM<ContactId>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remotelyDeletedBy', protoName: 'remotelyDeletedBy', subBuilder: ContactId.create)
    ..hasRequiredFields = false
  ;

  StoredMessage._() : super();
  factory StoredMessage({
    ContactId? contactId,
    $core.String? senderId,
    $core.String? id,
    $fixnum.Int64? ts,
    $core.String? replyToSenderId,
    $core.String? replyToId,
    $core.String? text,
    $core.int? disappearAfterSeconds,
    $core.Map<$core.int, StoredAttachment>? attachments,
    MessageDirection? direction,
    $core.Map<$core.String, Reaction>? reactions,
    StoredMessage_DeliveryStatus? status,
    $fixnum.Int64? firstViewedAt,
    $fixnum.Int64? disappearAt,
    $core.Map<$core.int, $core.int>? thumbnails,
    $fixnum.Int64? remotelyDeletedAt,
    ContactId? remotelyDeletedBy,
  }) {
    final _result = create();
    if (contactId != null) {
      _result.contactId = contactId;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (id != null) {
      _result.id = id;
    }
    if (ts != null) {
      _result.ts = ts;
    }
    if (replyToSenderId != null) {
      _result.replyToSenderId = replyToSenderId;
    }
    if (replyToId != null) {
      _result.replyToId = replyToId;
    }
    if (text != null) {
      _result.text = text;
    }
    if (disappearAfterSeconds != null) {
      _result.disappearAfterSeconds = disappearAfterSeconds;
    }
    if (attachments != null) {
      _result.attachments.addAll(attachments);
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (reactions != null) {
      _result.reactions.addAll(reactions);
    }
    if (status != null) {
      _result.status = status;
    }
    if (firstViewedAt != null) {
      _result.firstViewedAt = firstViewedAt;
    }
    if (disappearAt != null) {
      _result.disappearAt = disappearAt;
    }
    if (thumbnails != null) {
      _result.thumbnails.addAll(thumbnails);
    }
    if (remotelyDeletedAt != null) {
      _result.remotelyDeletedAt = remotelyDeletedAt;
    }
    if (remotelyDeletedBy != null) {
      _result.remotelyDeletedBy = remotelyDeletedBy;
    }
    return _result;
  }
  factory StoredMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StoredMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StoredMessage clone() => StoredMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StoredMessage copyWith(void Function(StoredMessage) updates) => super.copyWith((message) => updates(message as StoredMessage)) as StoredMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StoredMessage create() => StoredMessage._();
  StoredMessage createEmptyInstance() => create();
  static $pb.PbList<StoredMessage> createRepeated() => $pb.PbList<StoredMessage>();
  @$core.pragma('dart2js:noInline')
  static StoredMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StoredMessage>(create);
  static StoredMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ContactId get contactId => $_getN(0);
  @$pb.TagNumber(1)
  set contactId(ContactId v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasContactId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContactId() => clearField(1);
  @$pb.TagNumber(1)
  ContactId ensureContactId() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get id => $_getSZ(2);
  @$pb.TagNumber(3)
  set id($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get ts => $_getI64(3);
  @$pb.TagNumber(4)
  set ts($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTs() => $_has(3);
  @$pb.TagNumber(4)
  void clearTs() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get replyToSenderId => $_getSZ(4);
  @$pb.TagNumber(5)
  set replyToSenderId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReplyToSenderId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReplyToSenderId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get replyToId => $_getSZ(5);
  @$pb.TagNumber(6)
  set replyToId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReplyToId() => $_has(5);
  @$pb.TagNumber(6)
  void clearReplyToId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get text => $_getSZ(6);
  @$pb.TagNumber(7)
  set text($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasText() => $_has(6);
  @$pb.TagNumber(7)
  void clearText() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get disappearAfterSeconds => $_getIZ(7);
  @$pb.TagNumber(8)
  set disappearAfterSeconds($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDisappearAfterSeconds() => $_has(7);
  @$pb.TagNumber(8)
  void clearDisappearAfterSeconds() => clearField(8);

  @$pb.TagNumber(9)
  $core.Map<$core.int, StoredAttachment> get attachments => $_getMap(8);

  @$pb.TagNumber(10)
  MessageDirection get direction => $_getN(9);
  @$pb.TagNumber(10)
  set direction(MessageDirection v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasDirection() => $_has(9);
  @$pb.TagNumber(10)
  void clearDirection() => clearField(10);

  @$pb.TagNumber(11)
  $core.Map<$core.String, Reaction> get reactions => $_getMap(10);

  @$pb.TagNumber(12)
  StoredMessage_DeliveryStatus get status => $_getN(11);
  @$pb.TagNumber(12)
  set status(StoredMessage_DeliveryStatus v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get firstViewedAt => $_getI64(12);
  @$pb.TagNumber(13)
  set firstViewedAt($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFirstViewedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearFirstViewedAt() => clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get disappearAt => $_getI64(13);
  @$pb.TagNumber(14)
  set disappearAt($fixnum.Int64 v) { $_setInt64(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDisappearAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearDisappearAt() => clearField(14);

  @$pb.TagNumber(15)
  $core.Map<$core.int, $core.int> get thumbnails => $_getMap(14);

  @$pb.TagNumber(16)
  $fixnum.Int64 get remotelyDeletedAt => $_getI64(15);
  @$pb.TagNumber(16)
  set remotelyDeletedAt($fixnum.Int64 v) { $_setInt64(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRemotelyDeletedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearRemotelyDeletedAt() => clearField(16);

  @$pb.TagNumber(17)
  ContactId get remotelyDeletedBy => $_getN(16);
  @$pb.TagNumber(17)
  set remotelyDeletedBy(ContactId v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasRemotelyDeletedBy() => $_has(16);
  @$pb.TagNumber(17)
  void clearRemotelyDeletedBy() => clearField(17);
  @$pb.TagNumber(17)
  ContactId ensureRemotelyDeletedBy() => $_ensure(16);
}

class Reaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Reaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reactingToSenderId', $pb.PbFieldType.OY, protoName: 'reactingToSenderId')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reactingToMessageId', $pb.PbFieldType.OY, protoName: 'reactingToMessageId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emoticon')
    ..hasRequiredFields = false
  ;

  Reaction._() : super();
  factory Reaction({
    $core.List<$core.int>? reactingToSenderId,
    $core.List<$core.int>? reactingToMessageId,
    $core.String? emoticon,
  }) {
    final _result = create();
    if (reactingToSenderId != null) {
      _result.reactingToSenderId = reactingToSenderId;
    }
    if (reactingToMessageId != null) {
      _result.reactingToMessageId = reactingToMessageId;
    }
    if (emoticon != null) {
      _result.emoticon = emoticon;
    }
    return _result;
  }
  factory Reaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Reaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Reaction clone() => Reaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Reaction copyWith(void Function(Reaction) updates) => super.copyWith((message) => updates(message as Reaction)) as Reaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Reaction create() => Reaction._();
  Reaction createEmptyInstance() => create();
  static $pb.PbList<Reaction> createRepeated() => $pb.PbList<Reaction>();
  @$core.pragma('dart2js:noInline')
  static Reaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Reaction>(create);
  static Reaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get reactingToSenderId => $_getN(0);
  @$pb.TagNumber(1)
  set reactingToSenderId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReactingToSenderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReactingToSenderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get reactingToMessageId => $_getN(1);
  @$pb.TagNumber(2)
  set reactingToMessageId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReactingToMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReactingToMessageId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get emoticon => $_getSZ(2);
  @$pb.TagNumber(3)
  set emoticon($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmoticon() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmoticon() => clearField(3);
}

class DisappearSettings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisappearSettings', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messagesDisappearAfterSeconds', $pb.PbFieldType.O3, protoName: 'messagesDisappearAfterSeconds')
    ..hasRequiredFields = false
  ;

  DisappearSettings._() : super();
  factory DisappearSettings({
    $core.int? messagesDisappearAfterSeconds,
  }) {
    final _result = create();
    if (messagesDisappearAfterSeconds != null) {
      _result.messagesDisappearAfterSeconds = messagesDisappearAfterSeconds;
    }
    return _result;
  }
  factory DisappearSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisappearSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisappearSettings clone() => DisappearSettings()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisappearSettings copyWith(void Function(DisappearSettings) updates) => super.copyWith((message) => updates(message as DisappearSettings)) as DisappearSettings; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DisappearSettings create() => DisappearSettings._();
  DisappearSettings createEmptyInstance() => create();
  static $pb.PbList<DisappearSettings> createRepeated() => $pb.PbList<DisappearSettings>();
  @$core.pragma('dart2js:noInline')
  static DisappearSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisappearSettings>(create);
  static DisappearSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get messagesDisappearAfterSeconds => $_getIZ(0);
  @$pb.TagNumber(1)
  set messagesDisappearAfterSeconds($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessagesDisappearAfterSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessagesDisappearAfterSeconds() => clearField(1);
}

enum TransferMessage_Content {
  message, 
  reaction, 
  deleteMessageId, 
  disappearSettings, 
  notSet
}

class TransferMessage extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, TransferMessage_Content> _TransferMessage_ContentByTag = {
    1 : TransferMessage_Content.message,
    2 : TransferMessage_Content.reaction,
    3 : TransferMessage_Content.deleteMessageId,
    4 : TransferMessage_Content.disappearSettings,
    0 : TransferMessage_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reaction', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deleteMessageId', $pb.PbFieldType.OY, protoName: 'deleteMessageId')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disappearSettings', $pb.PbFieldType.OY, protoName: 'disappearSettings')
    ..hasRequiredFields = false
  ;

  TransferMessage._() : super();
  factory TransferMessage({
    $core.List<$core.int>? message,
    $core.List<$core.int>? reaction,
    $core.List<$core.int>? deleteMessageId,
    $core.List<$core.int>? disappearSettings,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (reaction != null) {
      _result.reaction = reaction;
    }
    if (deleteMessageId != null) {
      _result.deleteMessageId = deleteMessageId;
    }
    if (disappearSettings != null) {
      _result.disappearSettings = disappearSettings;
    }
    return _result;
  }
  factory TransferMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferMessage clone() => TransferMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferMessage copyWith(void Function(TransferMessage) updates) => super.copyWith((message) => updates(message as TransferMessage)) as TransferMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransferMessage create() => TransferMessage._();
  TransferMessage createEmptyInstance() => create();
  static $pb.PbList<TransferMessage> createRepeated() => $pb.PbList<TransferMessage>();
  @$core.pragma('dart2js:noInline')
  static TransferMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferMessage>(create);
  static TransferMessage? _defaultInstance;

  TransferMessage_Content whichContent() => _TransferMessage_ContentByTag[$_whichOneof(0)]!;
  void clearContent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.List<$core.int> get message => $_getN(0);
  @$pb.TagNumber(1)
  set message($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get reaction => $_getN(1);
  @$pb.TagNumber(2)
  set reaction($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearReaction() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get deleteMessageId => $_getN(2);
  @$pb.TagNumber(3)
  set deleteMessageId($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeleteMessageId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeleteMessageId() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get disappearSettings => $_getN(3);
  @$pb.TagNumber(4)
  set disappearSettings($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDisappearSettings() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisappearSettings() => clearField(4);
}

enum OutboundMessage_Content {
  messageId, 
  reaction, 
  deleteMessageId, 
  disappearSettings, 
  notSet
}

class OutboundMessage extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, OutboundMessage_Content> _OutboundMessage_ContentByTag = {
    31 : OutboundMessage_Content.messageId,
    32 : OutboundMessage_Content.reaction,
    33 : OutboundMessage_Content.deleteMessageId,
    34 : OutboundMessage_Content.disappearSettings,
    0 : OutboundMessage_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OutboundMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..oo(0, [31, 32, 33, 34])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId', protoName: 'senderId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientId', protoName: 'recipientId')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sent')
    ..m<$core.String, OutboundMessage_SubDeliveryStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subDeliveryStatuses', protoName: 'subDeliveryStatuses', entryClassName: 'OutboundMessage.SubDeliveryStatusesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OE, valueOf: OutboundMessage_SubDeliveryStatus.valueOf, enumValues: OutboundMessage_SubDeliveryStatus.values, packageName: const $pb.PackageName('model'))
    ..aOS(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageId', protoName: 'messageId')
    ..a<$core.List<$core.int>>(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reaction', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(33, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deleteMessageId', $pb.PbFieldType.OY, protoName: 'deleteMessageId')
    ..a<$core.List<$core.int>>(34, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disappearSettings', $pb.PbFieldType.OY, protoName: 'disappearSettings')
    ..hasRequiredFields = false
  ;

  OutboundMessage._() : super();
  factory OutboundMessage({
    $core.String? id,
    $core.String? senderId,
    $core.String? recipientId,
    $fixnum.Int64? sent,
    $core.Map<$core.String, OutboundMessage_SubDeliveryStatus>? subDeliveryStatuses,
    $core.String? messageId,
    $core.List<$core.int>? reaction,
    $core.List<$core.int>? deleteMessageId,
    $core.List<$core.int>? disappearSettings,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (recipientId != null) {
      _result.recipientId = recipientId;
    }
    if (sent != null) {
      _result.sent = sent;
    }
    if (subDeliveryStatuses != null) {
      _result.subDeliveryStatuses.addAll(subDeliveryStatuses);
    }
    if (messageId != null) {
      _result.messageId = messageId;
    }
    if (reaction != null) {
      _result.reaction = reaction;
    }
    if (deleteMessageId != null) {
      _result.deleteMessageId = deleteMessageId;
    }
    if (disappearSettings != null) {
      _result.disappearSettings = disappearSettings;
    }
    return _result;
  }
  factory OutboundMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OutboundMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OutboundMessage clone() => OutboundMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OutboundMessage copyWith(void Function(OutboundMessage) updates) => super.copyWith((message) => updates(message as OutboundMessage)) as OutboundMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OutboundMessage create() => OutboundMessage._();
  OutboundMessage createEmptyInstance() => create();
  static $pb.PbList<OutboundMessage> createRepeated() => $pb.PbList<OutboundMessage>();
  @$core.pragma('dart2js:noInline')
  static OutboundMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OutboundMessage>(create);
  static OutboundMessage? _defaultInstance;

  OutboundMessage_Content whichContent() => _OutboundMessage_ContentByTag[$_whichOneof(0)]!;
  void clearContent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientId => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipientId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get sent => $_getI64(3);
  @$pb.TagNumber(4)
  set sent($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSent() => $_has(3);
  @$pb.TagNumber(4)
  void clearSent() => clearField(4);

  @$pb.TagNumber(5)
  $core.Map<$core.String, OutboundMessage_SubDeliveryStatus> get subDeliveryStatuses => $_getMap(4);

  @$pb.TagNumber(31)
  $core.String get messageId => $_getSZ(5);
  @$pb.TagNumber(31)
  set messageId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(31)
  $core.bool hasMessageId() => $_has(5);
  @$pb.TagNumber(31)
  void clearMessageId() => clearField(31);

  @$pb.TagNumber(32)
  $core.List<$core.int> get reaction => $_getN(6);
  @$pb.TagNumber(32)
  set reaction($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(32)
  $core.bool hasReaction() => $_has(6);
  @$pb.TagNumber(32)
  void clearReaction() => clearField(32);

  @$pb.TagNumber(33)
  $core.List<$core.int> get deleteMessageId => $_getN(7);
  @$pb.TagNumber(33)
  set deleteMessageId($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(33)
  $core.bool hasDeleteMessageId() => $_has(7);
  @$pb.TagNumber(33)
  void clearDeleteMessageId() => clearField(33);

  @$pb.TagNumber(34)
  $core.List<$core.int> get disappearSettings => $_getN(8);
  @$pb.TagNumber(34)
  set disappearSettings($core.List<$core.int> v) { $_setBytes(8, v); }
  @$pb.TagNumber(34)
  $core.bool hasDisappearSettings() => $_has(8);
  @$pb.TagNumber(34)
  void clearDisappearSettings() => clearField(34);
}

class InboundAttachment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InboundAttachment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'model'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId', protoName: 'senderId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'messageId', protoName: 'messageId')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ts')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachmentId', $pb.PbFieldType.O3, protoName: 'attachmentId')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isThumbnail', protoName: 'isThumbnail')
    ..hasRequiredFields = false
  ;

  InboundAttachment._() : super();
  factory InboundAttachment({
    $core.String? senderId,
    $core.String? messageId,
    $fixnum.Int64? ts,
    $core.int? attachmentId,
    $core.bool? isThumbnail,
  }) {
    final _result = create();
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (messageId != null) {
      _result.messageId = messageId;
    }
    if (ts != null) {
      _result.ts = ts;
    }
    if (attachmentId != null) {
      _result.attachmentId = attachmentId;
    }
    if (isThumbnail != null) {
      _result.isThumbnail = isThumbnail;
    }
    return _result;
  }
  factory InboundAttachment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InboundAttachment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InboundAttachment clone() => InboundAttachment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InboundAttachment copyWith(void Function(InboundAttachment) updates) => super.copyWith((message) => updates(message as InboundAttachment)) as InboundAttachment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InboundAttachment create() => InboundAttachment._();
  InboundAttachment createEmptyInstance() => create();
  static $pb.PbList<InboundAttachment> createRepeated() => $pb.PbList<InboundAttachment>();
  @$core.pragma('dart2js:noInline')
  static InboundAttachment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InboundAttachment>(create);
  static InboundAttachment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get ts => $_getI64(2);
  @$pb.TagNumber(3)
  set ts($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTs() => $_has(2);
  @$pb.TagNumber(3)
  void clearTs() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get attachmentId => $_getIZ(3);
  @$pb.TagNumber(4)
  set attachmentId($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAttachmentId() => $_has(3);
  @$pb.TagNumber(4)
  void clearAttachmentId() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isThumbnail => $_getBF(4);
  @$pb.TagNumber(5)
  set isThumbnail($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsThumbnail() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsThumbnail() => clearField(5);
}

