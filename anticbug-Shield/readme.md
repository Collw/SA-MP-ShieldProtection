# Anti C Bug - ShieldProtection

## Descrição
O **Anti C Bug - ShieldProtection** é um script para SA-MP (San Andreas Multiplayer) que visa detectar e expulsar jogadores que tentam utilizar a técnica conhecida como **C-Bug**. O sistema é projetado para manter a integridade do jogo, garantindo uma experiência mais justa para todos os jogadores.

## Funcionalidades
- **Detecção de C-Bug**: Monitora os inputs do jogador para identificar tentativas de uso do C-Bug.
- **Expulsão Automática**: Jogadores que tentam utilizar C-Bug são expulsos automaticamente.
- **Mensagens Personalizadas**: Mensagens claras são enviadas aos jogadores expulsos, informando o motivo da expulsão.
- **Diálogo Informativo**: Um diálogo é exibido ao jogador quando ele é expulso, explicando as regras sobre o uso do C-Bug.

## Estrutura do Código
O script é escrito na linguagem Pawn e utiliza a API do SA-MP. Aqui estão algumas das principais definições e funções:

- `MAX_PLAYERS`: Define o número máximo de jogadores no servidor.
- `NomesArmas`: Uma lista que contém os nomes das armas disponíveis no jogo.
- `OnPlayerKeyStateChange`: Monitora as alterações nas teclas pressionadas pelos jogadores.
- `OnPlayerCBug`: Função que lida com a expulsão do jogador e a exibição da mensagem de diálogo.

## Instalação
1. Clone ou baixe este repositório.
2. Coloque o arquivo `.pwn` no diretório de filtros do seu servidor SA-MP.
3. Compile o script utilizando o **Pawn Compiler**.
4. Inicie seu servidor SA-MP.

## Uso
Este script deve ser adicionado ao seu servidor SA-MP para que possa detectar e expulsar jogadores que tentam utilizar o C-Bug. Após a instalação, o sistema começará a monitorar automaticamente os jogadores.

## Licença
Este projeto está sob a licença [MIT License](LICENSE).

## Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests para melhorias ou correções de bugs.

## Contato
Se você tiver alguma dúvida ou sugestão, sinta-se à vontade para entrar em contato:

- **Autor**: Collw
- **Discord**: [ycollw]

## Versão
- **Versão**: 1.4.3
