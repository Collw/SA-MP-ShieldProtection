#include <a_samp>
#include <zcmd>

#define COLOR_RED 0xFF0000FF
#define DIALOG_PLATFORM 1000

// Defini��o de status de login
enum PlayerData {
    pPlatform,   // 0 = PC, 1 = Mobile
    pLoggedIn    // 0 = n�o logado, 1 = logado
};

new PlayerInfo[MAX_PLAYERS][PlayerData];

// Quando o jogador conecta, inicializa o status de login
public OnPlayerConnect(playerid) {
    PlayerInfo[playerid][pLoggedIn] = 0; // Jogador ainda n�o logado
    return 1;
}

// Quando o jogador faz login, marca como logado
public OnPlayerLogin(playerid) {
    PlayerInfo[playerid][pLoggedIn] = 1; // Jogador fez login
    return 1;
}

// Exibe a sele��o de plataforma apenas ap�s o login e no spawn
public OnPlayerSpawn(playerid) {
    if (PlayerInfo[playerid][pLoggedIn] == 1) { // Verifica se o jogador est� logado
        ShowPlayerDialog(playerid, DIALOG_PLATFORM, DIALOG_STYLE_LIST, "Selecione sua plataforma", "PC\nMobile", "Selecionar", "Cancelar");
    }
    return 1;
}

// Fun��o de callback para o di�logo de sele��o de plataforma
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if (dialogid == DIALOG_PLATFORM && response) {
        if (listitem == 0) {
            PlayerInfo[playerid][pPlatform] = 0; // PC
            SendClientMessage(playerid, COLOR_RED, "Voc� selecionou PC como sua plataforma.");
        } else if (listitem == 1) {
            PlayerInfo[playerid][pPlatform] = 1; // Mobile
            SendClientMessage(playerid, COLOR_RED, "Voc� selecionou Mobile como sua plataforma.");
        }
    }
    return 1;
}

// Timer para verificar lock-on entre jogadores
public OnGameModeInit() {
    SetTimer("CheckLockOn", 100, true); // Timer que chama a fun��o "CheckLockOn" a cada 100ms
    return 1;
}

forward CheckLockOn();
forward Float:GetDistanceBetweenPoints3D(Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2);

// Fun��o para calcular a dist�ncia 3D entre dois pontos
public Float:GetDistanceBetweenPoints3D(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2) {
    return floatsqroot((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1));
}

// Fun��o para desativar o lock-on de jogadores mobile
public CheckLockOn() {
    new Float:playerPos[3], Float:attackerPos[3], dist;

    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
            GetPlayerPos(i, playerPos[0], playerPos[1], playerPos[2]);

            for (new j = 0; j < MAX_PLAYERS; j++) {
                if (i != j && IsPlayerConnected(j)) {
                    GetPlayerPos(j, attackerPos[0], attackerPos[1], attackerPos[2]);
                    dist = GetDistanceBetweenPoints3D(playerPos[0], playerPos[1], playerPos[2], attackerPos[0], attackerPos[1], attackerPos[2]);

                    if (dist < 5.0 && PlayerInfo[i][pPlatform] == 1) { // Verifica se o alvo � mobile
                        DisableLockOn(j, i);
                    }
                }
            }
        }
    }
    return 1;
}

stock DisableLockOn(attacker, target) {
    SendClientMessage(attacker, COLOR_RED, "Voc� est� tentando usar lock-on em um jogador mobile. Ataque cancelado.");
    new Float:attackerPos[3];
    GetPlayerPos(attacker, attackerPos[0], attackerPos[1], attackerPos[2]);
    SetPlayerPos(attacker, attackerPos[0], attackerPos[1], attackerPos[2]);
    return 1;
}
