import 'package:emailjs/emailjs.dart' as emailjs;

class ContactService {
  static const _serviceId = 'YOUR_SERVICE_ID'; // from EmailJS
  static const _templateId = 'YOUR_TEMPLATE_ID'; // from EmailJS
  static const _publicKey = 'YOUR_PUBLIC_KEY'; // from EmailJS

  Future<bool> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await emailjs.send(
        _serviceId,
        _templateId,
        {'name': name, 'email': email, 'message': message},
        const emailjs.Options(publicKey: _publicKey), // Corrected line
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
