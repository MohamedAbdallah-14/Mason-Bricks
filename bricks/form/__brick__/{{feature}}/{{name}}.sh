sh ./{{name}}_format.sh
{{#new_feature}}mason make feature -o ../ -c ./config/{{feature}}/{{feature}}.json {{/new_feature}}{{#custom_parameters}}
mason make parameter -o ../ -c ./config/{{feature}}/data/model/parameter/{{name}}.json {{/custom_parameters}}{{#enums}}
mason make enum -o ../ -c ./config/{{feature}}/data/model/enum/{{name}}.json {{/enums}}
{{#request_model}}mason make request_model -o ../ -c ./config/{{feature}}/data/model/request_model/{{name}}.json{{/request_model}}{{#models}}
mason make response_model -o ../ -c ./config/{{feature}}/data/model/response_model/{{name}}.json {{/models}}
mason make request -o ../ -c ./config/{{feature}}/data/request/{{name}}.json
mason make repository -o ../ -c ./config/{{feature}}/data/repository/{{name}}.json --on-conflict append
mason make cubit -o ../ -c ./config/{{feature}}/logic/{{name}}.json
mason make {{#feature_list}}list_{{/feature_list}}screen -o ../ -c ./config/{{feature}}/view/{{name}}.json
