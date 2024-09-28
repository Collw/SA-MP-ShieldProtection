# ShieldProtection - ShieldBan

**Versão:** 1.2.09  
**Desenvolvido por:** Collw

## Descrição

O **ShieldBan** faz parte do sistema de proteção **ShieldProtection**, desenvolvido para servidores SA-MP com o objetivo de fornecer segurança adicional ao servidor. Esse sistema gerencia jogadores banidos, exibindo informações detalhadas sobre o banimento e facilitando o processo de administração.

### Características

- **Banimento automático**: O sistema armazena informações dos jogadores banidos e impede seu acesso ao servidor.
- **Exibição de detalhes**: Quando um jogador banido tenta se reconectar, um diálogo personalizado com informações sobre o banimento é exibido.
- **Comando `/unban`**: Administradores podem desbanir jogadores de forma rápida e eficiente, removendo o arquivo de banimento.
- **Sistema de arquivos DOF2**: Utiliza arquivos `.ini` para armazenar informações dos banidos, como nome, staff responsável, motivo, e data/hora do banimento.

## Instalação

1. **Baixar o repositório:**
   - Clone o repositório ou faça o download do código.

2. **Configurar as bibliotecas necessárias:**
   - Inclua as bibliotecas abaixo no seu projeto:
     ```pawn
     #include <a_samp>
     #include <zcmd>
     #include <DOF2>
     #include <sscanf2>
     ```
   
3. **Copiar o código:**
   - Adicione o código à sua gamemode ou filterscript.

4. **Configurar o diálogo de banimento:**
   - O ID `Dialog_Banido` é usado para mostrar as informações de banimento ao jogador. Caso tenha outros diálogos no servidor, ajuste o ID de acordo.

5. **Compilar o código:**
   - Compile o código usando o compilador PAWN adequado ao seu projeto SA-MP.

## Comandos

### `/unban`
- **Uso:** `/unban [Nome do jogador]`
- **Descrição:** Remove o banimento de um jogador, excluindo seu arquivo de banimento na pasta `Banidos`.

### Exemplo de Comando:

- **Banimento**: Quando um jogador banido tenta entrar no servidor, ele verá uma mensagem como esta:

    ```
    Voce esta banido permanentemente do nosso servidor.

    Usuario: [NOME_DO_JOGADOR]
    Staff: [NOME_DO_ADMIN]
    Motivo: [MOTIVO]

    Banido em: [DIA/MES/ANO] às [HORA:MINUTOS:SEGUNDOS]

    Se voce foi banido por engano, entre em contato com nossa equipe pelo Discord.

    Discord: [LINK DISCORD]
    ```

- **Desbanimento**: O comando `/unban [Nome]` remove o banimento do jogador e envia uma mensagem para todos no servidor:
    ```
    ShieldBan: O administrador [ADMIN] desbaniu o jogador [NICK]
    ```

## Estrutura dos Arquivos

O sistema salva os jogadores banidos em arquivos `.ini` na pasta `Banidos`. Cada arquivo contém:

- **Banido**: Nome do jogador banido.
- **Staff**: Nome do administrador que aplicou o banimento.
- **Motivo**: Motivo do banimento.
- **Data e Hora**: Data e hora do banimento (Dia, Mês, Ano, Hora, Minutos, Segundos).

## Requisitos

- **Servidor SA-MP** versão 0.3.7 ou superior.
- **Bibliotecas**: `zcmd`, `sscanf2`, `DOF2`, `a_samp`.

## Customização

O sistema é altamente personalizável. Caso queira alterar o texto dos diálogos ou ajustar as permissões dos comandos, você pode editar os seguintes trechos no código:

- **Cores**: Modifique os códigos hexadecimais definidos em `#define` para personalizar as cores das mensagens.
- **Permissões**: Ajuste o nível mínimo de administrador na enum `PlayerInfo`.

## Suporte

Para dúvidas, sugestões ou melhorias, entre em contato com o desenvolvedor:

- **Desenvolvedor:** Collw
- **Discord:** [LINK DO DISCORD]
- **Email:** [EMAIL_DO_DESENVOLVEDOR]

## Licença

Este projeto é licenciado sob a **MIT License**. Sinta-se livre para usar, modificar e distribuir o sistema conforme necessário, mantendo os créditos originais.


