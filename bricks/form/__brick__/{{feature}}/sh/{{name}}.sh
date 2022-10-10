sh ./{{feature}}/sh/{{name}}_format.sh
{{#new_feature}}mason make feature -o ../ -c ./{{feature}}/{{feature}}.json {{/new_feature}}{{#custom_parameters}}
mason make parameter -o ../ -c ./{{feature}}/data/model/parameter/{{name}}.json {{/custom_parameters}}{{#enums}}
mason make enum -o ../ -c ./{{feature}}/data/model/enum/{{name}}.json {{/enums}}
{{#request_model}}mason make request_model -o ../ -c ./{{feature}}/data/model/request_model/{{name}}.json{{/request_model}}{{#models}}
mason make response_model -o ../ -c ./{{feature}}/data/model/response_model/{{name}}.json {{/models}}
mason make request -o ../ -c ./{{feature}}/data/request/{{name}}.json
mason make repository -o ../ -c ./{{feature}}/data/repository/{{name}}.json --on-conflict append
mason make cubit -o ../ -c ./{{feature}}/logic/{{name}}.json
mason make {{#feature_list}}list_{{/feature_list}}screen -o ../ -c ./{{feature}}/view/{{name}}.json
