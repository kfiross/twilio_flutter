import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Twilio_Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TwilioFlutter twilioFlutter;

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: "",
        authToken: "",
        messagingServiceSid: "",
        twilioNumber: "");
    super.initState();
  }

  void sendSms() async {
    twilioFlutter.sendSMS(toNumber: '', messageBody: 'hello world');
  }

  void sendSmsAlphaNumeric() async {
    twilioFlutter.sendSMS(name: "", toNumber: '', messageBody: 'hello world');
  }
  


  void sendWhatsApp() {
    twilioFlutter.sendWhatsApp(toNumber: '', messageBody: 'hello world');
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);

    await twilioFlutter.getSMS('***************************');
  }

  void sendScheduledSms() async {
    await twilioFlutter.sendScheduledSms(
        toNumber: '',
        messageBody: 'hello world',
        sendAt: '2024-02-18T16:18:55Z');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'Click the button to send SMS.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSms,
        tooltip: 'Send Sms',
        child: Icon(Icons.send),
      ),
    );
  }
}
