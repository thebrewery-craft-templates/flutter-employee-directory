import 'package:flutter_dotenv/flutter_dotenv.dart';

final clientKey = DotEnv().env['client_key'];
final appId = DotEnv().env['app_id'];
final graphQLUrl = '${DotEnv().env['url']}/graphql';
