import 'package:appwrite/appwrite.dart';
import 'package:riverpod/riverpod.dart';
import '../constants/constants.dart';

final appwriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppWriteConstants.apiEndpoint)
      .setProject(AppWriteConstants.projectId)
      .setSelfSigned(status: true);
});

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
});

final appwriteStorageProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Storage(client);
});