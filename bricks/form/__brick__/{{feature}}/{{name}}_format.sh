{{#new_feature}}npx prettier --write ./config/{{feature}}/{{feature}}.json {{/new_feature}}{{#custom_parameters}}
npx prettier --write ./config/{{feature}}/data/model/parameter/{{name}}.json {{/custom_parameters}}{{#enums}}
npx prettier --write ./config/{{feature}}/data/model/enum/{{name}}.json {{/enums}}
{{#request_model}}npx prettier --write ./config/{{feature}}/data/model/request_model/{{name}}.json{{/request_model}}{{#models}}
npx prettier --write ./config/{{feature}}/data/model/response_model/{{name}}.json {{/models}}
npx prettier --write ./config/{{feature}}/data/request/{{name}}.json
npx prettier --write ./config/{{feature}}/data/repository/{{name}}.json
npx prettier --write ./config/{{feature}}/logic/{{name}}.json
npx prettier --write ./config/{{feature}}/view/{{name}}.json
