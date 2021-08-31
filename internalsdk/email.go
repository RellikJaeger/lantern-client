package internalsdk

import (
	"github.com/getlantern/flashlight/email"
)

// EmailMessage exposes the type email.Message as part of this package.
type EmailMessage email.Message

// EmailResponseHandler is used to return a response to the client in the
// event there's an error sending an email
type EmailResponseHandler interface {
	OnError(string)
}

// PutInt sets an integer variable
func (msg *EmailMessage) PutInt(key string, val int) {
	msg.putVar(key, val)
}

// PutString sets a string variable
func (msg *EmailMessage) PutString(key string, val string) {
	msg.putVar(key, val)
}

func (msg *EmailMessage) putVar(key string, val interface{}) {
	if msg.Vars == nil {
		msg.Vars = make(map[string]interface{})
	}
	msg.Vars[key] = val
}

// Send sends this EmailMessage using the email package.
func (msg *EmailMessage) Send(handler EmailResponseHandler) {
	emsg := email.Message(*msg)
	err := email.Send(&emsg)
	if err != nil {
		handler.OnError(err.Error())
	}
}
