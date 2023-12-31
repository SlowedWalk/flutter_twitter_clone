class AppWriteConstants {
  static const String databaseId = '653fbc6ed8fdfe8f11ef';
  static const String projectId = '653fb8e7782ab01e4db0';
  static const String apiEndpoint = 'https://cloud.appwrite.io/v1';
  static const String apiKey = '7ead6515b27d03f0d06c5c1ebf9d343dd304cf24b9de7892c395d0bc56196997ff45b54923b7522468e3efa83bfc153c7a6d075c49258d712082e6d6de8a9e3fa9b08650fbdc07062c8ec7d8b91880a7eb9fb48d3989eb82711cf6023cee87aa86bba464d132c7a84f0775a454484b18691a03fa87d7f2def85d8e6a310bcbc1';
  static const String usersCollectionId = '6543583086af022ec431';
  static const String tweetsCollectionId = '6548ffd88628bd518953';
  static const String imagesBucketId = '6549f50f76770613edb8';

  // https://cloud.appwrite.io/v1/storage/buckets/6549f50f76770613edb8/files/6549f778e503400f184b/view?project=653fb8e7782ab01e4db0&mode=admin
  static String getImageUrl(String imageId) =>
      '$apiEndpoint/storage/buckets/$imagesBucketId/files/$imageId/view?project=$projectId&mode=admin';
}
