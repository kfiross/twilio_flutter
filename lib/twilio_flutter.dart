library twilio_flutter;

import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/utils/request_utils.dart';
import 'package:twilio_flutter/src/sms/dto/sent_sms_data.dart';

import 'src/shared/services/service_locator.dart';
import 'src/sms/dto/message.dart';
import 'src/sms/services/twilio_sms_service.dart';

///
///Twilio’s Programmable SMS API helps you add robust messaging capabilities to your applications.
/// To use [TwilioFlutter] you will use your Twilio Account SID as the username and your Auth Token as the password for HTTP Basic authentication with Twilio.
///
class TwilioFlutter {
  late TwilioCreds _twilioCreds;
  late TwilioSMSService _smsService;

  /// Creates a TwilioFlutter Object with [accountSid] , [authToken] , [twilioNumber].
  /// [accountSid] , [authToken] , [twilioNumber]  Your Account Sid and Auth Token from twilio.com/console
  ///  Should be not null Strings.
  ///
  /// [twilioNumber] can later be changed.
  TwilioFlutter(
      {required String accountSid,
      required String authToken,
      required String twilioNumber}) {
    registerServices();
    String uri = RequestUtils.generateMessagesUrl(accountSid);
    String creds = RequestUtils.generateAuthString(accountSid, authToken);
    _twilioCreds = TwilioCreds(
        accountSid: accountSid,
        authToken: authToken,
        twilioNumber: twilioNumber,
        url: uri,
        cred: creds);
    _smsService =
        locator.get<TwilioSMSService>(instanceName: "TwilioSMSServiceImpl");
  }

  ///	sendSMS
  ///	 [toNumber] : The number to which text message has to be sent.
  ///	 [messageBody] : The content of the message to be sent.
  ///
  ///	Method called to send text messages to the specified phone number with given content.
  ///
  /// Returns
  ///	201 -> message sent successfully.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<int> sendSMS(
      {required String toNumber, required String messageBody}) async {
    return await _smsService.sendSMS(
        toNumber: toNumber,
        messageBody: messageBody,
        twilioCreds: _twilioCreds);
  }

  /// changeTwilioNumber
  /// [twilioNumber] : A non-null value for new twilio number
  void changeTwilioNumber(String twilioNumber) {
    this._twilioCreds.twilioNumber = twilioNumber;
  }

  /// Get all messages associated with your account
  /// Pass [pageSize] to get specific page sizes.
  /// [pageSize] value defaults to 20
  Future<SentSmsData> getSmsList({String? pageSize}) async {
    return await _smsService.getSmsList(
        pageSize: pageSize, twilioCreds: _twilioCreds);
  }

  /// Get all data of a specific message
  /// Pass [messageSid] as a non null Message SID.
  Future<Message> getSMS(String messageSid) async {
    return await _smsService.getSmsData(
        messageSID: messageSid, twilioCreds: _twilioCreds);
  }
}
