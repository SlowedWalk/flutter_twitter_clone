import 'package:appwrite/appwrite.dart';
import '../constants/constants.dart';

Client client = Client()
    .setEndpoint(AppWriteConstants.apiEndpoint)
    .setProject(AppWriteConstants.projectId)
    .setSelfSigned(status: true); // For self signed certificates, only use for development