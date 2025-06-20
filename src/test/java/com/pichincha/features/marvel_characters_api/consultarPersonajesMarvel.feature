@REQ_HU-01 @HU01 @marvel_characters_api @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: HU-01 API de personajes de Marvel (microservicio para consultar y gestionar personajes)
  Background:
    * url port_marvel_characters_api
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:1 @consultarPersonajes @solicitudExitosa200
  Scenario: T-API-HU-01-CA01-Obtener todos los personajes 200 - karate
    * path '/ezamoram/api/characters'
    When method GET
    Then status 200
    # And match response != null
    # And match response[0].name != null

  @id:2 @obtenerPersonajePorId @solicitudExitosa200
  Scenario: T-API-HU-01-CA02-Obtener personaje por ID existente 200 - karate
    * path '/ezamoram/api/characters/1'
    When method GET
    Then status 200
    # And match response.id == 1
    # And match response.name != null

  @id:3 @obtenerPersonajePorId @personajeNoExiste404
  Scenario: T-API-HU-01-CA03-Obtener personaje por ID inexistente 404 - karate
    * path '/ezamoram/api/characters/999'
    When method GET
    Then status 404
    # And match response.status == 404
    # And match response.message contains 'no encontrado'

  @id:4 @crearPersonaje @solicitudExitosa201
  Scenario: T-API-HU-01-CA04-Crear personaje exitosamente 201 - karate
    * path '/ezamoram/api/characters'
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request jsonData
    When method POST
    Then status 201
    # And match response.id != null
    # And match response.name == jsonData.name

  @id:5 @crearPersonaje @camposRequeridosFaltantes400
  Scenario: T-API-HU-01-CA05-Crear personaje con campos requeridos faltantes 400 - karate
    * path '/ezamoram/api/characters'
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character_invalid.json')
    And request jsonData
    When method POST
    Then status 400
    # And match response.status == 400
    # And match response.message contains 'requerido'

  @id:6 @actualizarPersonaje @solicitudExitosa200
  Scenario: T-API-HU-01-CA06-Actualizar personaje exitosamente 200 - karate
    * path '/ezamoram/api/characters/1'
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    And request jsonData
    When method PUT
    Then status 200
    # And match response.name == jsonData.name
    # And match response.description == jsonData.description

  @id:7 @actualizarPersonaje @personajeNoExiste404
  Scenario: T-API-HU-01-CA07-Actualizar personaje inexistente 404 - karate
    * path '/ezamoram/api/characters/999'
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    And request jsonData
    When method PUT
    Then status 404
    # And match response.status == 404
    # And match response.message contains 'no encontrado'

  @id:8 @eliminarPersonaje @solicitudExitosa204
  Scenario: T-API-HU-01-CA08-Eliminar personaje exitosamente 204 - karate
    * path '/ezamoram/api/characters/1'
    When method DELETE
    Then status 204
    # And match response == ''
    # And match header Content-Length == '0'

  @id:9 @eliminarPersonaje @personajeNoExiste404
  Scenario: T-API-HU-01-CA09-Eliminar personaje inexistente 404 - karate
    * path '/ezamoram/api/characters/999'
    When method DELETE
    Then status 404
    # And match response.status == 404
    # And match response.message contains 'no encontrado'

  @id:10 @crearPersonaje @errorServidor500
  Scenario: T-API-HU-01-CA10-Crear personaje con error del servidor 500 - karate
    * path '/ezamoram/api/characters'
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character_error.json')
    And request jsonData
    When method POST
    Then status 500
    # And match response.status == 500
    # And match response.message contains 'interno'