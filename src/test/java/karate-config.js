function() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
	baseUrl: 'https://petstore.swagger.io/v2/user',
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}
// Agregar en la sección de configuración base
config.port_marvel_characters_api = 'http://localhost:8080';

// Agregar en la sección de entorno dev
if (env == 'dev') {
  // otras configuraciones...
  config.port_marvel_characters_api = 'https://api-dev.empresa.com/marvel';
}

// Agregar en la sección de entorno qa
else if (env == 'qa') {
  // otras configuraciones...
  config.port_marvel_characters_api = 'https://api-qa.empresa.com/marvel';
}
