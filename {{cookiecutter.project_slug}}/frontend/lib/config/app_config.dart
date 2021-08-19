part 'app_config_local.dart';
part 'app_config_dev.dart';

class AppConfig {
  final String env;
  final String apiEndpoint;

  const AppConfig({
    required this.env,
    required this.apiEndpoint,
  });
}

AppConfig getConfig() {
  AppConfig _config;
  const _env = String.fromEnvironment('app.flavor');
  switch (_env) {
    case 'dev':
      _config = _configDev;
      break;
    default:
      _config = _configLocal;
  }
  return _config;
}

final AppConfig config = getConfig();
