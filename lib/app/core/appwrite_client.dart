import 'package:appwrite/appwrite.dart';
import 'package:twitter_clone/app/constants/constants.dart';

Client client = Client()
    .setEndpoint(AppWriteConstants.apiEndpoint)
    .setProject(AppWriteConstants.projectId)
    .setSelfSigned(status: true); // For self signed certificates, only use for development