import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Email {
  String _username;
  var smtpServer;

  Email() {
    _username = 'testsendmail484@gmail.com';
    smtpServer = gmail(_username, 'abc@123#');
  }

  //Envia um email para o destinatário, contendo a mensagem com o nome do sorteado
  Future<bool> sendMessage(
      String mensagem, String destinatario, String assunto) async {
    //Configurar a mensagem
    final message = Message()
      ..from = Address(_username, 'Nome')
      ..recipients.add(destinatario)
      ..subject = assunto
      ..text = mensagem;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());

      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}
