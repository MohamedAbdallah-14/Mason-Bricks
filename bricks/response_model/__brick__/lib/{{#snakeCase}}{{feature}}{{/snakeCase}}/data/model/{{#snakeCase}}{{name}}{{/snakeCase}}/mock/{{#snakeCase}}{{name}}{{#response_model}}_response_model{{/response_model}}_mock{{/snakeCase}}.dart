import '../../../../../core/faker/app_faker.dart';
import '../{{#snakeCase}}{{name}}{{/snakeCase}}{{#response_model}}_response_model{{/response_model}}.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}Mock {
//*this return the !same! instance every time it's called
  static final mock = random;

  //*this return the !different! instance every time it's called
   static {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}} get random => {{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}( {{#parameters}}
    {{parameter}}: {{^custom}}{{#list}}[{{/list}}{{/custom}}{{#fake_id}}AppFaker.randomId{{/fake_id}}{{#fake_bool}}AppFaker.randomBool{{/fake_bool}}{{#fake_email}}AppFaker.email{{/fake_email}}{{#fake_name}}AppFaker.name{{/fake_name}}{{#fake_phone_number}}AppFaker.phoneNumber{{/fake_phone_number}}{{#fake_sentence}}AppFaker.sentence{{/fake_sentence}}{{#fake_word}}AppFaker.word{{/fake_word}}{{#fake_dateTime}}AppFaker.dateTime{{/fake_dateTime}}{{#fake_image}}AppFaker.randomImage{{/fake_image}}{{^custom}}{{#list}}]{{/list}}{{/custom}}{{#custom}}{{{type}}}Mock.random{{#list}}List{{/list}}{{/custom}},{{/parameters}}
  );

  static List<{{#pascalCase}}{{name}}{{/pascalCase}}{{#response_model}}ResponseModel{{/response_model}}> get randomList => List.generate(
    AppFaker.randomInt(10),
    (index) => random,
  );

}

