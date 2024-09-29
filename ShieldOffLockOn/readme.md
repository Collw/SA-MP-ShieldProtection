# ShieldProtection - ShieldOffLockOn

**Versão:** 1.6.0  
**Desenvolvido por:** Collw

## Descrição

O **ShieldOffLockOn** faz parte do sistema de proteção **ShieldProtection**, projetado para servidores SA-MP com o objetivo de melhorar a jogabilidade e a experiência dos jogadores. Esse sistema desativa o recurso de **lock-on** (mirar automaticamente) para jogadores em dispositivos mobile, equilibrando a competição entre jogadores de diferentes plataformas.

### Características

- **Detecção de plataforma**: Ao spawnar, o jogador seleciona se está jogando no **PC** ou **Mobile** através de um diálogo personalizado.
- **Desativação de lock-on**: Jogadores mobile têm a proteção automática contra **lock-on**, impedindo que outros jogadores usem o recurso de mira automática contra eles.
- **Atualização automática**: O sistema verifica periodicamente a proximidade entre jogadores e desativa o lock-on para jogadores mobile, promovendo equilíbrio e justiça.

## Instalação

1. **Baixar o repositório:**
   - Clone o repositório ou faça o download do código.

2. **Configurar as bibliotecas necessárias:**
   - Inclua as bibliotecas abaixo no seu projeto:
     ```pawn
     #include <a_samp>
     #include <zcmd>
     ```

3. **Copiar o código:**
   - Adicione o código à sua gamemode ou filterscript.

4. **Configurar o diálogo de plataforma:**
   - O ID `DIALOG_PLATFORM` é usado para o jogador selecionar sua plataforma (PC ou Mobile). Caso tenha outros diálogos no servidor, ajuste o ID de acordo.

5. **Compilar o código:**
   - Compile o código usando o compilador PAWN adequado ao seu projeto SA-MP.

## Comandos

O sistema **ShieldOffLockOn** não requer comandos manuais, pois tudo acontece automaticamente no servidor. O sistema reconhece a plataforma do jogador e ajusta suas configurações adequadamente.

### Exemplo de Execução:

- **Seleção de Plataforma**: Quando o jogador spawnar no servidor, será exibido o seguinte diálogo para seleção da plataforma:
    ```
    Selecione sua plataforma:

    1. PC
    2. Mobile
    ```

- **Desativação de Lock-On**: Caso um jogador no PC tente usar lock-on em um jogador de Mobile, uma mensagem será exibida:
    ```
    Você está tentando usar lock-on em um jogador mobile. Ataque cancelado.
    ```

## Estrutura dos Arquivos

Este sistema não salva informações permanentemente, pois as informações da plataforma dos jogadores são armazenadas em memória enquanto eles estão conectados ao servidor. Quando um jogador se conecta, ele seleciona sua plataforma novamente.

## Requisitos

- **Servidor SA-MP** versão 0.3.7 ou superior.
- **Bibliotecas**: `zcmd`, `a_samp`.

## Customização

O sistema é altamente customizável. Caso deseje alterar o texto dos diálogos ou ajustar a distância de desativação do lock-on, você pode modificar os seguintes trechos no código:

- **Cores**: Modifique os códigos hexadecimais definidos em `#define` para personalizar as cores das mensagens.
- **Distância de desativação**: A função `CheckLockOn` pode ser ajustada para aumentar ou reduzir a distância mínima para desativar o lock-on.
- **Mensagens**: As mensagens de notificação para os jogadores podem ser personalizadas diretamente no código.

## Suporte

Para dúvidas, sugestões ou melhorias, entre em contato com o desenvolvedor:

- **Desenvolvedor:** Collw
- **Discord:** ycollw
- **Email:** collwdev@gmail.com

## Licença

Este projeto é licenciado sob a **MIT License**. Você está livre para usar, modificar e distribuir o sistema conforme necessário, desde que mantenha os créditos originais.
