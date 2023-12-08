// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.31.0
// 	protoc        v4.24.3
// source: desktop/pro/pro.proto

package pro

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	structpb "google.golang.org/protobuf/types/known/structpb"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type EmptyRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *EmptyRequest) Reset() {
	*x = EmptyRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *EmptyRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*EmptyRequest) ProtoMessage() {}

func (x *EmptyRequest) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use EmptyRequest.ProtoReflect.Descriptor instead.
func (*EmptyRequest) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{0}
}

type EmptyResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields
}

func (x *EmptyResponse) Reset() {
	*x = EmptyResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *EmptyResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*EmptyResponse) ProtoMessage() {}

func (x *EmptyResponse) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use EmptyResponse.ProtoReflect.Descriptor instead.
func (*EmptyResponse) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{1}
}

type ErrorResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Status uint32 `protobuf:"varint,1,opt,name=status,proto3" json:"status,omitempty"`
	Msg    string `protobuf:"bytes,2,opt,name=msg,proto3" json:"msg,omitempty"`
}

func (x *ErrorResponse) Reset() {
	*x = ErrorResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ErrorResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ErrorResponse) ProtoMessage() {}

func (x *ErrorResponse) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ErrorResponse.ProtoReflect.Descriptor instead.
func (*ErrorResponse) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{2}
}

func (x *ErrorResponse) GetStatus() uint32 {
	if x != nil {
		return x.Status
	}
	return 0
}

func (x *ErrorResponse) GetMsg() string {
	if x != nil {
		return x.Msg
	}
	return ""
}

type Duration struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Duration uint32 `protobuf:"varint,1,opt,name=duration,proto3" json:"duration,omitempty"`
}

func (x *Duration) Reset() {
	*x = Duration{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[3]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Duration) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Duration) ProtoMessage() {}

func (x *Duration) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[3]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Duration.ProtoReflect.Descriptor instead.
func (*Duration) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{3}
}

func (x *Duration) GetDuration() uint32 {
	if x != nil {
		return x.Duration
	}
	return 0
}

type Plan struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Id                     string           `protobuf:"bytes,1,opt,name=id,proto3" json:"id,omitempty"`
	Description            string           `protobuf:"bytes,2,opt,name=description,proto3" json:"description,omitempty"`
	BestValue              bool             `protobuf:"varint,3,opt,name=bestValue,proto3" json:"bestValue,omitempty"`
	UsdPrice               int64            `protobuf:"varint,4,opt,name=usdPrice,proto3" json:"usdPrice,omitempty"`
	Price                  map[string]int64 `protobuf:"bytes,5,rep,name=price,proto3" json:"price,omitempty" protobuf_key:"bytes,1,opt,name=key,proto3" protobuf_val:"varint,2,opt,name=value,proto3"`
	ExpectedMonthlyPrice   map[string]int64 `protobuf:"bytes,6,rep,name=expectedMonthlyPrice,proto3" json:"expectedMonthlyPrice,omitempty" protobuf_key:"bytes,1,opt,name=key,proto3" protobuf_val:"varint,2,opt,name=value,proto3"`
	TotalCostBilledOneTime string           `protobuf:"bytes,7,opt,name=totalCostBilledOneTime,proto3" json:"totalCostBilledOneTime,omitempty"`
	OneMonthCost           string           `protobuf:"bytes,8,opt,name=oneMonthCost,proto3" json:"oneMonthCost,omitempty"`
	TotalCost              string           `protobuf:"bytes,9,opt,name=totalCost,proto3" json:"totalCost,omitempty"`
	FormattedBonus         string           `protobuf:"bytes,10,opt,name=formattedBonus,proto3" json:"formattedBonus,omitempty"`
	RenewalText            string           `protobuf:"bytes,11,opt,name=renewalText,proto3" json:"renewalText,omitempty"`
}

func (x *Plan) Reset() {
	*x = Plan{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[4]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Plan) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Plan) ProtoMessage() {}

func (x *Plan) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[4]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Plan.ProtoReflect.Descriptor instead.
func (*Plan) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{4}
}

func (x *Plan) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

func (x *Plan) GetDescription() string {
	if x != nil {
		return x.Description
	}
	return ""
}

func (x *Plan) GetBestValue() bool {
	if x != nil {
		return x.BestValue
	}
	return false
}

func (x *Plan) GetUsdPrice() int64 {
	if x != nil {
		return x.UsdPrice
	}
	return 0
}

func (x *Plan) GetPrice() map[string]int64 {
	if x != nil {
		return x.Price
	}
	return nil
}

func (x *Plan) GetExpectedMonthlyPrice() map[string]int64 {
	if x != nil {
		return x.ExpectedMonthlyPrice
	}
	return nil
}

func (x *Plan) GetTotalCostBilledOneTime() string {
	if x != nil {
		return x.TotalCostBilledOneTime
	}
	return ""
}

func (x *Plan) GetOneMonthCost() string {
	if x != nil {
		return x.OneMonthCost
	}
	return ""
}

func (x *Plan) GetTotalCost() string {
	if x != nil {
		return x.TotalCost
	}
	return ""
}

func (x *Plan) GetFormattedBonus() string {
	if x != nil {
		return x.FormattedBonus
	}
	return ""
}

func (x *Plan) GetRenewalText() string {
	if x != nil {
		return x.RenewalText
	}
	return ""
}

type PlansResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Plans []*Plan `protobuf:"bytes,1,rep,name=plans,proto3" json:"plans,omitempty"`
}

func (x *PlansResponse) Reset() {
	*x = PlansResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[5]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *PlansResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PlansResponse) ProtoMessage() {}

func (x *PlansResponse) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[5]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PlansResponse.ProtoReflect.Descriptor instead.
func (*PlansResponse) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{5}
}

func (x *PlansResponse) GetPlans() []*Plan {
	if x != nil {
		return x.Plans
	}
	return nil
}

type Device struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Id      string `protobuf:"bytes,1,opt,name=id,proto3" json:"id,omitempty"`
	Name    string `protobuf:"bytes,2,opt,name=name,proto3" json:"name,omitempty"`
	Created uint64 `protobuf:"varint,3,opt,name=created,proto3" json:"created,omitempty"`
}

func (x *Device) Reset() {
	*x = Device{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[6]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *Device) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Device) ProtoMessage() {}

func (x *Device) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[6]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Device.ProtoReflect.Descriptor instead.
func (*Device) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{6}
}

func (x *Device) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

func (x *Device) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *Device) GetCreated() uint64 {
	if x != nil {
		return x.Created
	}
	return 0
}

type UserDetailsResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	UserId     uint64    `protobuf:"varint,1,opt,name=userId,proto3" json:"userId,omitempty"`
	Code       string    `protobuf:"bytes,2,opt,name=code,proto3" json:"code,omitempty"`
	Token      string    `protobuf:"bytes,3,opt,name=token,proto3" json:"token,omitempty"`
	Referral   string    `protobuf:"bytes,4,opt,name=referral,proto3" json:"referral,omitempty"`
	Email      string    `protobuf:"bytes,5,opt,name=email,proto3" json:"email,omitempty"`
	UserStatus string    `protobuf:"bytes,6,opt,name=userStatus,proto3" json:"userStatus,omitempty"`
	Locale     string    `protobuf:"bytes,7,opt,name=locale,proto3" json:"locale,omitempty"`
	Expiration uint64    `protobuf:"varint,8,opt,name=expiration,proto3" json:"expiration,omitempty"`
	Servers    []string  `protobuf:"bytes,9,rep,name=servers,proto3" json:"servers,omitempty"`
	Devices    []*Device `protobuf:"bytes,10,rep,name=devices,proto3" json:"devices,omitempty"`
}

func (x *UserDetailsResponse) Reset() {
	*x = UserDetailsResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[7]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *UserDetailsResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*UserDetailsResponse) ProtoMessage() {}

func (x *UserDetailsResponse) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[7]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use UserDetailsResponse.ProtoReflect.Descriptor instead.
func (*UserDetailsResponse) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{7}
}

func (x *UserDetailsResponse) GetUserId() uint64 {
	if x != nil {
		return x.UserId
	}
	return 0
}

func (x *UserDetailsResponse) GetCode() string {
	if x != nil {
		return x.Code
	}
	return ""
}

func (x *UserDetailsResponse) GetToken() string {
	if x != nil {
		return x.Token
	}
	return ""
}

func (x *UserDetailsResponse) GetReferral() string {
	if x != nil {
		return x.Referral
	}
	return ""
}

func (x *UserDetailsResponse) GetEmail() string {
	if x != nil {
		return x.Email
	}
	return ""
}

func (x *UserDetailsResponse) GetUserStatus() string {
	if x != nil {
		return x.UserStatus
	}
	return ""
}

func (x *UserDetailsResponse) GetLocale() string {
	if x != nil {
		return x.Locale
	}
	return ""
}

func (x *UserDetailsResponse) GetExpiration() uint64 {
	if x != nil {
		return x.Expiration
	}
	return 0
}

func (x *UserDetailsResponse) GetServers() []string {
	if x != nil {
		return x.Servers
	}
	return nil
}

func (x *UserDetailsResponse) GetDevices() []*Device {
	if x != nil {
		return x.Devices
	}
	return nil
}

type PaymentProvider struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Name string            `protobuf:"bytes,1,opt,name=name,proto3" json:"name,omitempty"`
	Data map[string]string `protobuf:"bytes,2,rep,name=data,proto3" json:"data,omitempty" protobuf_key:"bytes,1,opt,name=key,proto3" protobuf_val:"bytes,2,opt,name=value,proto3"`
}

func (x *PaymentProvider) Reset() {
	*x = PaymentProvider{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[8]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *PaymentProvider) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PaymentProvider) ProtoMessage() {}

func (x *PaymentProvider) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[8]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PaymentProvider.ProtoReflect.Descriptor instead.
func (*PaymentProvider) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{8}
}

func (x *PaymentProvider) GetName() string {
	if x != nil {
		return x.Name
	}
	return ""
}

func (x *PaymentProvider) GetData() map[string]string {
	if x != nil {
		return x.Data
	}
	return nil
}

type PaymentMethod struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Method    string             `protobuf:"bytes,1,opt,name=method,proto3" json:"method,omitempty"`
	Providers []*PaymentProvider `protobuf:"bytes,2,rep,name=providers,proto3" json:"providers,omitempty"`
}

func (x *PaymentMethod) Reset() {
	*x = PaymentMethod{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[9]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *PaymentMethod) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PaymentMethod) ProtoMessage() {}

func (x *PaymentMethod) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[9]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PaymentMethod.ProtoReflect.Descriptor instead.
func (*PaymentMethod) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{9}
}

func (x *PaymentMethod) GetMethod() string {
	if x != nil {
		return x.Method
	}
	return ""
}

func (x *PaymentMethod) GetProviders() []*PaymentProvider {
	if x != nil {
		return x.Providers
	}
	return nil
}

type PaymentMethodsResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Providers map[string]*structpb.ListValue `protobuf:"bytes,1,rep,name=providers,proto3" json:"providers,omitempty" protobuf_key:"bytes,1,opt,name=key,proto3" protobuf_val:"bytes,2,opt,name=value,proto3"`
}

func (x *PaymentMethodsResponse) Reset() {
	*x = PaymentMethodsResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[10]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *PaymentMethodsResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*PaymentMethodsResponse) ProtoMessage() {}

func (x *PaymentMethodsResponse) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[10]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use PaymentMethodsResponse.ProtoReflect.Descriptor instead.
func (*PaymentMethodsResponse) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{10}
}

func (x *PaymentMethodsResponse) GetProviders() map[string]*structpb.ListValue {
	if x != nil {
		return x.Providers
	}
	return nil
}

type LinkCodeResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Code     string `protobuf:"bytes,1,opt,name=code,proto3" json:"code,omitempty"`
	ExpireAt int64  `protobuf:"varint,2,opt,name=expireAt,proto3" json:"expireAt,omitempty"`
}

func (x *LinkCodeResponse) Reset() {
	*x = LinkCodeResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_desktop_pro_pro_proto_msgTypes[11]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *LinkCodeResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*LinkCodeResponse) ProtoMessage() {}

func (x *LinkCodeResponse) ProtoReflect() protoreflect.Message {
	mi := &file_desktop_pro_pro_proto_msgTypes[11]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use LinkCodeResponse.ProtoReflect.Descriptor instead.
func (*LinkCodeResponse) Descriptor() ([]byte, []int) {
	return file_desktop_pro_pro_proto_rawDescGZIP(), []int{11}
}

func (x *LinkCodeResponse) GetCode() string {
	if x != nil {
		return x.Code
	}
	return ""
}

func (x *LinkCodeResponse) GetExpireAt() int64 {
	if x != nil {
		return x.ExpireAt
	}
	return 0
}

var File_desktop_pro_pro_proto protoreflect.FileDescriptor

var file_desktop_pro_pro_proto_rawDesc = []byte{
	0x0a, 0x15, 0x64, 0x65, 0x73, 0x6b, 0x74, 0x6f, 0x70, 0x2f, 0x70, 0x72, 0x6f, 0x2f, 0x70, 0x72,
	0x6f, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x1c, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2f, 0x73, 0x74, 0x72, 0x75, 0x63, 0x74, 0x2e,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22, 0x0e, 0x0a, 0x0c, 0x45, 0x6d, 0x70, 0x74, 0x79, 0x52, 0x65,
	0x71, 0x75, 0x65, 0x73, 0x74, 0x22, 0x0f, 0x0a, 0x0d, 0x45, 0x6d, 0x70, 0x74, 0x79, 0x52, 0x65,
	0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x39, 0x0a, 0x0d, 0x45, 0x72, 0x72, 0x6f, 0x72, 0x52,
	0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x16, 0x0a, 0x06, 0x73, 0x74, 0x61, 0x74, 0x75,
	0x73, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0d, 0x52, 0x06, 0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x12,
	0x10, 0x0a, 0x03, 0x6d, 0x73, 0x67, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x03, 0x6d, 0x73,
	0x67, 0x22, 0x26, 0x0a, 0x08, 0x44, 0x75, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x12, 0x1a, 0x0a,
	0x08, 0x64, 0x75, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0d, 0x52,
	0x08, 0x64, 0x75, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x22, 0xb6, 0x04, 0x0a, 0x04, 0x50, 0x6c,
	0x61, 0x6e, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x02,
	0x69, 0x64, 0x12, 0x20, 0x0a, 0x0b, 0x64, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70, 0x74, 0x69, 0x6f,
	0x6e, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0b, 0x64, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
	0x74, 0x69, 0x6f, 0x6e, 0x12, 0x1c, 0x0a, 0x09, 0x62, 0x65, 0x73, 0x74, 0x56, 0x61, 0x6c, 0x75,
	0x65, 0x18, 0x03, 0x20, 0x01, 0x28, 0x08, 0x52, 0x09, 0x62, 0x65, 0x73, 0x74, 0x56, 0x61, 0x6c,
	0x75, 0x65, 0x12, 0x1a, 0x0a, 0x08, 0x75, 0x73, 0x64, 0x50, 0x72, 0x69, 0x63, 0x65, 0x18, 0x04,
	0x20, 0x01, 0x28, 0x03, 0x52, 0x08, 0x75, 0x73, 0x64, 0x50, 0x72, 0x69, 0x63, 0x65, 0x12, 0x26,
	0x0a, 0x05, 0x70, 0x72, 0x69, 0x63, 0x65, 0x18, 0x05, 0x20, 0x03, 0x28, 0x0b, 0x32, 0x10, 0x2e,
	0x50, 0x6c, 0x61, 0x6e, 0x2e, 0x50, 0x72, 0x69, 0x63, 0x65, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x52,
	0x05, 0x70, 0x72, 0x69, 0x63, 0x65, 0x12, 0x53, 0x0a, 0x14, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74,
	0x65, 0x64, 0x4d, 0x6f, 0x6e, 0x74, 0x68, 0x6c, 0x79, 0x50, 0x72, 0x69, 0x63, 0x65, 0x18, 0x06,
	0x20, 0x03, 0x28, 0x0b, 0x32, 0x1f, 0x2e, 0x50, 0x6c, 0x61, 0x6e, 0x2e, 0x45, 0x78, 0x70, 0x65,
	0x63, 0x74, 0x65, 0x64, 0x4d, 0x6f, 0x6e, 0x74, 0x68, 0x6c, 0x79, 0x50, 0x72, 0x69, 0x63, 0x65,
	0x45, 0x6e, 0x74, 0x72, 0x79, 0x52, 0x14, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x65, 0x64, 0x4d,
	0x6f, 0x6e, 0x74, 0x68, 0x6c, 0x79, 0x50, 0x72, 0x69, 0x63, 0x65, 0x12, 0x36, 0x0a, 0x16, 0x74,
	0x6f, 0x74, 0x61, 0x6c, 0x43, 0x6f, 0x73, 0x74, 0x42, 0x69, 0x6c, 0x6c, 0x65, 0x64, 0x4f, 0x6e,
	0x65, 0x54, 0x69, 0x6d, 0x65, 0x18, 0x07, 0x20, 0x01, 0x28, 0x09, 0x52, 0x16, 0x74, 0x6f, 0x74,
	0x61, 0x6c, 0x43, 0x6f, 0x73, 0x74, 0x42, 0x69, 0x6c, 0x6c, 0x65, 0x64, 0x4f, 0x6e, 0x65, 0x54,
	0x69, 0x6d, 0x65, 0x12, 0x22, 0x0a, 0x0c, 0x6f, 0x6e, 0x65, 0x4d, 0x6f, 0x6e, 0x74, 0x68, 0x43,
	0x6f, 0x73, 0x74, 0x18, 0x08, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0c, 0x6f, 0x6e, 0x65, 0x4d, 0x6f,
	0x6e, 0x74, 0x68, 0x43, 0x6f, 0x73, 0x74, 0x12, 0x1c, 0x0a, 0x09, 0x74, 0x6f, 0x74, 0x61, 0x6c,
	0x43, 0x6f, 0x73, 0x74, 0x18, 0x09, 0x20, 0x01, 0x28, 0x09, 0x52, 0x09, 0x74, 0x6f, 0x74, 0x61,
	0x6c, 0x43, 0x6f, 0x73, 0x74, 0x12, 0x26, 0x0a, 0x0e, 0x66, 0x6f, 0x72, 0x6d, 0x61, 0x74, 0x74,
	0x65, 0x64, 0x42, 0x6f, 0x6e, 0x75, 0x73, 0x18, 0x0a, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0e, 0x66,
	0x6f, 0x72, 0x6d, 0x61, 0x74, 0x74, 0x65, 0x64, 0x42, 0x6f, 0x6e, 0x75, 0x73, 0x12, 0x20, 0x0a,
	0x0b, 0x72, 0x65, 0x6e, 0x65, 0x77, 0x61, 0x6c, 0x54, 0x65, 0x78, 0x74, 0x18, 0x0b, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x0b, 0x72, 0x65, 0x6e, 0x65, 0x77, 0x61, 0x6c, 0x54, 0x65, 0x78, 0x74, 0x1a,
	0x38, 0x0a, 0x0a, 0x50, 0x72, 0x69, 0x63, 0x65, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x12, 0x10, 0x0a,
	0x03, 0x6b, 0x65, 0x79, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x03, 0x6b, 0x65, 0x79, 0x12,
	0x14, 0x0a, 0x05, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x03, 0x52, 0x05,
	0x76, 0x61, 0x6c, 0x75, 0x65, 0x3a, 0x02, 0x38, 0x01, 0x1a, 0x47, 0x0a, 0x19, 0x45, 0x78, 0x70,
	0x65, 0x63, 0x74, 0x65, 0x64, 0x4d, 0x6f, 0x6e, 0x74, 0x68, 0x6c, 0x79, 0x50, 0x72, 0x69, 0x63,
	0x65, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x12, 0x10, 0x0a, 0x03, 0x6b, 0x65, 0x79, 0x18, 0x01, 0x20,
	0x01, 0x28, 0x09, 0x52, 0x03, 0x6b, 0x65, 0x79, 0x12, 0x14, 0x0a, 0x05, 0x76, 0x61, 0x6c, 0x75,
	0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x03, 0x52, 0x05, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x3a, 0x02,
	0x38, 0x01, 0x22, 0x2c, 0x0a, 0x0d, 0x50, 0x6c, 0x61, 0x6e, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f,
	0x6e, 0x73, 0x65, 0x12, 0x1b, 0x0a, 0x05, 0x70, 0x6c, 0x61, 0x6e, 0x73, 0x18, 0x01, 0x20, 0x03,
	0x28, 0x0b, 0x32, 0x05, 0x2e, 0x50, 0x6c, 0x61, 0x6e, 0x52, 0x05, 0x70, 0x6c, 0x61, 0x6e, 0x73,
	0x22, 0x46, 0x0a, 0x06, 0x44, 0x65, 0x76, 0x69, 0x63, 0x65, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64,
	0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x02, 0x69, 0x64, 0x12, 0x12, 0x0a, 0x04, 0x6e, 0x61,
	0x6d, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x12, 0x18,
	0x0a, 0x07, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x64, 0x18, 0x03, 0x20, 0x01, 0x28, 0x04, 0x52,
	0x07, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x64, 0x22, 0x9e, 0x02, 0x0a, 0x13, 0x55, 0x73, 0x65,
	0x72, 0x44, 0x65, 0x74, 0x61, 0x69, 0x6c, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65,
	0x12, 0x16, 0x0a, 0x06, 0x75, 0x73, 0x65, 0x72, 0x49, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x04,
	0x52, 0x06, 0x75, 0x73, 0x65, 0x72, 0x49, 0x64, 0x12, 0x12, 0x0a, 0x04, 0x63, 0x6f, 0x64, 0x65,
	0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x63, 0x6f, 0x64, 0x65, 0x12, 0x14, 0x0a, 0x05,
	0x74, 0x6f, 0x6b, 0x65, 0x6e, 0x18, 0x03, 0x20, 0x01, 0x28, 0x09, 0x52, 0x05, 0x74, 0x6f, 0x6b,
	0x65, 0x6e, 0x12, 0x1a, 0x0a, 0x08, 0x72, 0x65, 0x66, 0x65, 0x72, 0x72, 0x61, 0x6c, 0x18, 0x04,
	0x20, 0x01, 0x28, 0x09, 0x52, 0x08, 0x72, 0x65, 0x66, 0x65, 0x72, 0x72, 0x61, 0x6c, 0x12, 0x14,
	0x0a, 0x05, 0x65, 0x6d, 0x61, 0x69, 0x6c, 0x18, 0x05, 0x20, 0x01, 0x28, 0x09, 0x52, 0x05, 0x65,
	0x6d, 0x61, 0x69, 0x6c, 0x12, 0x1e, 0x0a, 0x0a, 0x75, 0x73, 0x65, 0x72, 0x53, 0x74, 0x61, 0x74,
	0x75, 0x73, 0x18, 0x06, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0a, 0x75, 0x73, 0x65, 0x72, 0x53, 0x74,
	0x61, 0x74, 0x75, 0x73, 0x12, 0x16, 0x0a, 0x06, 0x6c, 0x6f, 0x63, 0x61, 0x6c, 0x65, 0x18, 0x07,
	0x20, 0x01, 0x28, 0x09, 0x52, 0x06, 0x6c, 0x6f, 0x63, 0x61, 0x6c, 0x65, 0x12, 0x1e, 0x0a, 0x0a,
	0x65, 0x78, 0x70, 0x69, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x18, 0x08, 0x20, 0x01, 0x28, 0x04,
	0x52, 0x0a, 0x65, 0x78, 0x70, 0x69, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x12, 0x18, 0x0a, 0x07,
	0x73, 0x65, 0x72, 0x76, 0x65, 0x72, 0x73, 0x18, 0x09, 0x20, 0x03, 0x28, 0x09, 0x52, 0x07, 0x73,
	0x65, 0x72, 0x76, 0x65, 0x72, 0x73, 0x12, 0x21, 0x0a, 0x07, 0x64, 0x65, 0x76, 0x69, 0x63, 0x65,
	0x73, 0x18, 0x0a, 0x20, 0x03, 0x28, 0x0b, 0x32, 0x07, 0x2e, 0x44, 0x65, 0x76, 0x69, 0x63, 0x65,
	0x52, 0x07, 0x64, 0x65, 0x76, 0x69, 0x63, 0x65, 0x73, 0x22, 0x8e, 0x01, 0x0a, 0x0f, 0x50, 0x61,
	0x79, 0x6d, 0x65, 0x6e, 0x74, 0x50, 0x72, 0x6f, 0x76, 0x69, 0x64, 0x65, 0x72, 0x12, 0x12, 0x0a,
	0x04, 0x6e, 0x61, 0x6d, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x6e, 0x61, 0x6d,
	0x65, 0x12, 0x2e, 0x0a, 0x04, 0x64, 0x61, 0x74, 0x61, 0x18, 0x02, 0x20, 0x03, 0x28, 0x0b, 0x32,
	0x1a, 0x2e, 0x50, 0x61, 0x79, 0x6d, 0x65, 0x6e, 0x74, 0x50, 0x72, 0x6f, 0x76, 0x69, 0x64, 0x65,
	0x72, 0x2e, 0x44, 0x61, 0x74, 0x61, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x52, 0x04, 0x64, 0x61, 0x74,
	0x61, 0x1a, 0x37, 0x0a, 0x09, 0x44, 0x61, 0x74, 0x61, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x12, 0x10,
	0x0a, 0x03, 0x6b, 0x65, 0x79, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x03, 0x6b, 0x65, 0x79,
	0x12, 0x14, 0x0a, 0x05, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x05, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x3a, 0x02, 0x38, 0x01, 0x22, 0x57, 0x0a, 0x0d, 0x50, 0x61,
	0x79, 0x6d, 0x65, 0x6e, 0x74, 0x4d, 0x65, 0x74, 0x68, 0x6f, 0x64, 0x12, 0x16, 0x0a, 0x06, 0x6d,
	0x65, 0x74, 0x68, 0x6f, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x06, 0x6d, 0x65, 0x74,
	0x68, 0x6f, 0x64, 0x12, 0x2e, 0x0a, 0x09, 0x70, 0x72, 0x6f, 0x76, 0x69, 0x64, 0x65, 0x72, 0x73,
	0x18, 0x02, 0x20, 0x03, 0x28, 0x0b, 0x32, 0x10, 0x2e, 0x50, 0x61, 0x79, 0x6d, 0x65, 0x6e, 0x74,
	0x50, 0x72, 0x6f, 0x76, 0x69, 0x64, 0x65, 0x72, 0x52, 0x09, 0x70, 0x72, 0x6f, 0x76, 0x69, 0x64,
	0x65, 0x72, 0x73, 0x22, 0xb8, 0x01, 0x0a, 0x16, 0x50, 0x61, 0x79, 0x6d, 0x65, 0x6e, 0x74, 0x4d,
	0x65, 0x74, 0x68, 0x6f, 0x64, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x44,
	0x0a, 0x09, 0x70, 0x72, 0x6f, 0x76, 0x69, 0x64, 0x65, 0x72, 0x73, 0x18, 0x01, 0x20, 0x03, 0x28,
	0x0b, 0x32, 0x26, 0x2e, 0x50, 0x61, 0x79, 0x6d, 0x65, 0x6e, 0x74, 0x4d, 0x65, 0x74, 0x68, 0x6f,
	0x64, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x2e, 0x50, 0x72, 0x6f, 0x76, 0x69,
	0x64, 0x65, 0x72, 0x73, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x52, 0x09, 0x70, 0x72, 0x6f, 0x76, 0x69,
	0x64, 0x65, 0x72, 0x73, 0x1a, 0x58, 0x0a, 0x0e, 0x50, 0x72, 0x6f, 0x76, 0x69, 0x64, 0x65, 0x72,
	0x73, 0x45, 0x6e, 0x74, 0x72, 0x79, 0x12, 0x10, 0x0a, 0x03, 0x6b, 0x65, 0x79, 0x18, 0x01, 0x20,
	0x01, 0x28, 0x09, 0x52, 0x03, 0x6b, 0x65, 0x79, 0x12, 0x30, 0x0a, 0x05, 0x76, 0x61, 0x6c, 0x75,
	0x65, 0x18, 0x02, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65,
	0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x56, 0x61,
	0x6c, 0x75, 0x65, 0x52, 0x05, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x3a, 0x02, 0x38, 0x01, 0x22, 0x42,
	0x0a, 0x10, 0x4c, 0x69, 0x6e, 0x6b, 0x43, 0x6f, 0x64, 0x65, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e,
	0x73, 0x65, 0x12, 0x12, 0x0a, 0x04, 0x63, 0x6f, 0x64, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x04, 0x63, 0x6f, 0x64, 0x65, 0x12, 0x1a, 0x0a, 0x08, 0x65, 0x78, 0x70, 0x69, 0x72, 0x65,
	0x41, 0x74, 0x18, 0x02, 0x20, 0x01, 0x28, 0x03, 0x52, 0x08, 0x65, 0x78, 0x70, 0x69, 0x72, 0x65,
	0x41, 0x74, 0x42, 0x2a, 0x5a, 0x28, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d,
	0x2f, 0x67, 0x65, 0x74, 0x6c, 0x61, 0x6e, 0x74, 0x65, 0x72, 0x6e, 0x2f, 0x6c, 0x61, 0x6e, 0x74,
	0x65, 0x72, 0x6e, 0x2d, 0x63, 0x6c, 0x69, 0x65, 0x6e, 0x74, 0x2f, 0x70, 0x72, 0x6f, 0x62, 0x06,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_desktop_pro_pro_proto_rawDescOnce sync.Once
	file_desktop_pro_pro_proto_rawDescData = file_desktop_pro_pro_proto_rawDesc
)

func file_desktop_pro_pro_proto_rawDescGZIP() []byte {
	file_desktop_pro_pro_proto_rawDescOnce.Do(func() {
		file_desktop_pro_pro_proto_rawDescData = protoimpl.X.CompressGZIP(file_desktop_pro_pro_proto_rawDescData)
	})
	return file_desktop_pro_pro_proto_rawDescData
}

var file_desktop_pro_pro_proto_msgTypes = make([]protoimpl.MessageInfo, 16)
var file_desktop_pro_pro_proto_goTypes = []interface{}{
	(*EmptyRequest)(nil),           // 0: EmptyRequest
	(*EmptyResponse)(nil),          // 1: EmptyResponse
	(*ErrorResponse)(nil),          // 2: ErrorResponse
	(*Duration)(nil),               // 3: Duration
	(*Plan)(nil),                   // 4: Plan
	(*PlansResponse)(nil),          // 5: PlansResponse
	(*Device)(nil),                 // 6: Device
	(*UserDetailsResponse)(nil),    // 7: UserDetailsResponse
	(*PaymentProvider)(nil),        // 8: PaymentProvider
	(*PaymentMethod)(nil),          // 9: PaymentMethod
	(*PaymentMethodsResponse)(nil), // 10: PaymentMethodsResponse
	(*LinkCodeResponse)(nil),       // 11: LinkCodeResponse
	nil,                            // 12: Plan.PriceEntry
	nil,                            // 13: Plan.ExpectedMonthlyPriceEntry
	nil,                            // 14: PaymentProvider.DataEntry
	nil,                            // 15: PaymentMethodsResponse.ProvidersEntry
	(*structpb.ListValue)(nil),     // 16: google.protobuf.ListValue
}
var file_desktop_pro_pro_proto_depIdxs = []int32{
	12, // 0: Plan.price:type_name -> Plan.PriceEntry
	13, // 1: Plan.expectedMonthlyPrice:type_name -> Plan.ExpectedMonthlyPriceEntry
	4,  // 2: PlansResponse.plans:type_name -> Plan
	6,  // 3: UserDetailsResponse.devices:type_name -> Device
	14, // 4: PaymentProvider.data:type_name -> PaymentProvider.DataEntry
	8,  // 5: PaymentMethod.providers:type_name -> PaymentProvider
	15, // 6: PaymentMethodsResponse.providers:type_name -> PaymentMethodsResponse.ProvidersEntry
	16, // 7: PaymentMethodsResponse.ProvidersEntry.value:type_name -> google.protobuf.ListValue
	8,  // [8:8] is the sub-list for method output_type
	8,  // [8:8] is the sub-list for method input_type
	8,  // [8:8] is the sub-list for extension type_name
	8,  // [8:8] is the sub-list for extension extendee
	0,  // [0:8] is the sub-list for field type_name
}

func init() { file_desktop_pro_pro_proto_init() }
func file_desktop_pro_pro_proto_init() {
	if File_desktop_pro_pro_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_desktop_pro_pro_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*EmptyRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*EmptyResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ErrorResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[3].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Duration); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[4].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Plan); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[5].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*PlansResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[6].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*Device); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[7].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*UserDetailsResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[8].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*PaymentProvider); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[9].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*PaymentMethod); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[10].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*PaymentMethodsResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_desktop_pro_pro_proto_msgTypes[11].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*LinkCodeResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_desktop_pro_pro_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   16,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_desktop_pro_pro_proto_goTypes,
		DependencyIndexes: file_desktop_pro_pro_proto_depIdxs,
		MessageInfos:      file_desktop_pro_pro_proto_msgTypes,
	}.Build()
	File_desktop_pro_pro_proto = out.File
	file_desktop_pro_pro_proto_rawDesc = nil
	file_desktop_pro_pro_proto_goTypes = nil
	file_desktop_pro_pro_proto_depIdxs = nil
}