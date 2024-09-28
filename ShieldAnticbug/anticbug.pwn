#include <a_samp>

#define COR_VERMELHA 0xAA3333AA

#undef MAX_PLAYERS
#define MAX_PLAYERS 500 // Altere para a contagem máxima de jogadores do seu servidor.

#define MAX_SLOTS 48

new JogadorParado[MAX_PLAYERS];
new IDArma[MAX_PLAYERS];
new VerificaAgachamento[MAX_PLAYERS];
new Municao[MAX_PLAYERS][MAX_SLOTS];

new NomesArmas[][32] = {
    {"Soco"}, // 0
    {"Soco Inglês"}, // 1
    {"Clube de Golfe"}, // 2
    {"Cacetete"}, // 3
    {"Faca"}, // 4
    {"Bat de Baseball"}, // 5
    {"Pá"}, // 6
    {"Taco de Bilhar"}, // 7
    {"Katana"}, // 8
    {"Serra Elétrica"}, // 9
    {"Dildo Roxo"}, // 10
    {"Vibrador"}, // 11
    {"Vibrador"}, // 12
    {"Vibrador"}, // 13
    {"Flores"}, // 14
    {"Cane"}, // 15
    {"Granada"}, // 16
    {"Gás Lacrimogêneo"}, // 17
    {"Molotov"}, // 18
    {" "}, // 19
    {" "}, // 20
    {" "}, // 21
    {"Colt 45"}, // 22
    {"Pistola Silenciada"}, // 23
    {"Desert Eagle"}, // 24
    {"Shotgun"}, // 25
    {"Sawn-Off"}, // 26
    {"SPAS"}, // 27
    {"Uzi"}, // 28
    {"MP5"}, // 29
    {"AK-47"}, // 30
    {"M4"}, // 31
    {"Tec-9"}, // 32
    {"Rifle de Caça"}, // 33
    {"Rifle de Precisão"}, // 34
    {"Lançador de Foguetes"}, // 35
    {"Lançador de Foguetes Guiados"}, // 36
    {"Lança-Chamas"}, // 37
    {"Minigun"}, // 38
    {"Cargador de Satélite"}, // 39
    {"Detonador"}, // 40
    {"Spray"}, // 41
    {"Extintor de Incêndio"}, // 42
    {"Câmera"}, // 43
    {"Óculos de Visão Noturna"}, // 44
    {"Óculos de Visão Infravermelha"}, // 45
    {"Paraquedas"}, // 46
    {"Pistola Falsa"} // 47
};

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" Anti C Bug - ShieldProtection v1.4.3 ");
    print("            por Collw ");
    print("--------------------------------------\n");
    return 1;
}

public OnFilterScriptExit()
{
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_FIRE) && (oldkeys & KEY_CROUCH) && !((oldkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) || 
       (oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE))) {
        switch(GetPlayerWeapon(playerid)) {
            case 23..25, 27, 29..34, 41: {
                if(Municao[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
                    OnPlayerCBug(playerid);
                }
                return 1;
            }
        }
    }

    if(VerificaAgachamento[playerid] == 1) {
        switch(IDArma[playerid]) {
            case 23..25, 27, 29..34, 41: {
                if((newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) && 
                   GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                    if(Municao[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
                        OnPlayerCBug(playerid);
                    }
                }
            }
        }
    }

    else if(((newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE) && !((newkeys & KEY_SPRINT) || (newkeys & KEY_JUMP))) ||
             (newkeys & KEY_FIRE) && !((newkeys & KEY_SPRINT) || (newkeys & KEY_JUMP)) ||
             (JogadorParado[playerid] && (newkeys & KEY_FIRE) && (newkeys & KEY_HANDBRAKE)) ||
             (JogadorParado[playerid] && (newkeys & KEY_FIRE)) ||
             (newkeys & KEY_FIRE) && (oldkeys & KEY_CROUCH) && !((oldkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE)) ||
             (oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH) && !((newkeys & KEY_FIRE) || (newkeys & KEY_HANDBRAKE))) {
        SetTimerEx("CrouchCheck", 3000, 0, "d", playerid);
        VerificaAgachamento[playerid] = 1;
        IDArma[playerid] = GetPlayerWeapon(playerid);
        Municao[playerid][GetPlayerWeapon(playerid)] = GetPlayerAmmo(playerid);
        return 1;
    }
    
    return 1;
}

public OnPlayerUpdate(playerid)
{
    new Teclas, ud, lr;
    GetPlayerKeys(playerid, Teclas, ud, lr);
    if(VerificaAgachamento[playerid] == 1) {
        switch(IDArma[playerid]) {
            case 23..25, 27, 29..34, 41: {
                if((Teclas & KEY_CROUCH) && !((Teclas & KEY_FIRE) || (Teclas & KEY_HANDBRAKE)) && 
                   GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) {
                    if(Municao[playerid][GetPlayerWeapon(playerid)] > GetPlayerAmmo(playerid)) {
                        OnPlayerCBug(playerid);
                    }
                }
            }
        }
    }

    if(!ud && !lr) { JogadorParado[playerid] = 1; }
    else { JogadorParado[playerid] = 0; }
    
    return 1;
}

forward OnPlayerCBug(playerid);
public OnPlayerCBug(playerid) {
    new nomeJogador[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomeJogador, sizeof(nomeJogador));
    new mensagem[128];
    format(mensagem, sizeof(mensagem), "O sistema automatico expulsou %s por tentar usar C-Bug com a arma (%s!)", nomeJogador, NomesArmas[IDArma[playerid]]);
    SendClientMessageToAll(COR_VERMELHA, mensagem);
    
    // Adicionando o diálogo
    new dialogMensagem[512]; // Tamanho aumentado para conter toda a mensagem

    format(dialogMensagem, sizeof(dialogMensagem),  "{ffffff}Você foi expulso por tentar usar {ff0000}C-Bug{ffffff} com a arma (%s)!\n", NomesArmas[IDArma[playerid]]);
    strcat(dialogMensagem, "{ffffff}A utilização do C-Bug é considerada uma violação das regras do servidor.\n\n");
    strcat(dialogMensagem, "{ffffff}Repetidas tentativas de uso poderão resultar em punições adicionais, incluindo {ff0000}bans{ffffff} temporários ou permanentes.\n");

    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, "{FF0000}ShieldProtection {FFFFFF}- Created by {ff00ff}Collw", dialogMensagem, "OK", "");


    
    // Atrasar a expulsão para garantir que o diálogo seja exibido
    SetTimerEx("KickPlayer", 100, 0, "d", playerid);
    
    VerificaAgachamento[playerid] = 0;
    return 1;
}

forward KickPlayer(playerid);
public KickPlayer(playerid) {
    Kick(playerid);
    return 1;
}

forward CrouchCheck(playerid);
public CrouchCheck(playerid) {
    VerificaAgachamento[playerid] = 0;
    return 1;
}
