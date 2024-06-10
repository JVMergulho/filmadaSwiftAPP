# filmadaSwiftAPP

APP for the first Apple Developer Academy - UFPE challenge

## Sobre o APP

Filmada é um APP que recomenda filmes com base no seu dia.

Primeiro você precisa escolher o idioma original do filme. Após isso, é só responder um pequeno quiz sobre seu humor atual e depois selecionar “Finalizar” para encontrar o seu filme ideal. 

Desenvolvido por João Vitor Mergulhão

## Como Funciona

As respostas dadas pelo usuário às perguntas do quiz são mapeadas para alguns atributos: idioma original do filme, possíveis gêneros e duração máxima. 

Quando o quiz é finalizado, o APP faz uma requisição para a API do tmdb utilizando os atributos mapeados para montar a query.

Se tudo deu certo, uma lista de 20 filmes é recebida e embaralhada. Cada vez que o usuário selecionar "outra sugestão" o índice do filme atual é incrementado e as informações são atualizadas.


