



//bibliotecas obrigatorias.
#include <a_samp>
#include <zcmd>
#include <DOF2>
#include <sscanf2>

#define SCM(%0,%1,%2) SendClientMessage(%0,%1,%2) // Definição do SCM para SendClientMessage
#define Dialog_Banido       1 // mude de acordo com a quantidade de dialogs na sua gamemode.

//CORES
#define VERMELHO     0xFF0000FF
#define VERDE        0x00FF00FF


enum PlayerInfo // Ajuste conforme a demanda da sua gamemode.
{
    Admin,
    pBanido
};
new ID;
new AdminLevel[64];
new Logado[MAX_PLAYERS];
new info[MAX_PLAYERS][PlayerInfo];

// Função para obter o nome do jogador
stock PlayerName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

public OnPlayerRequestClass(playerid, classid)
{
    if (DOF2_FileExists(ContasBanidas(playerid)))
    {
        new string[999], dialog[999];
        
        format(string, sizeof(string), "{ffffff}Voce esta {ff0000}banido permanentemente{ffffff} do nosso servidor.\n\n");
        strcat(dialog, string);
        format(string, sizeof(string), "{FF6EC7}Usuario:{dcdcdc} %s\n", DOF2_GetString(ContasBanidas(playerid), "Banido"));
        strcat(dialog, string);
        format(string, sizeof(string), "{FF6EC7}Staff:{dcdcdc} %s\n", DOF2_GetString(ContasBanidas(playerid), "Staff"));
        strcat(dialog, string);
        format(string, sizeof(string), "{FF6EC7}Motivo:{dcdcdc} %s\n", DOF2_GetString(ContasBanidas(playerid), "Motivo"));
        strcat(dialog, string);
        format(string, sizeof(string), "{FF6EC7}Banido em:{dcdcdc} %d/", DOF2_GetInt(ContasBanidas(playerid), "Dia"));
        strcat(dialog, string);
        format(string, sizeof(string), "%d/", DOF2_GetInt(ContasBanidas(playerid), "Mes"));
        strcat(dialog, string);
        format(string, sizeof(string), "%d ", DOF2_GetInt(ContasBanidas(playerid), "Ano"));
        strcat(dialog, string);
        format(string, sizeof(string), "{FF6EC7}as:{dcdcdc} %d:", DOF2_GetInt(ContasBanidas(playerid), "Hora"));
        strcat(dialog, string);
        format(string, sizeof(string), "%d:", DOF2_GetInt(ContasBanidas(playerid), "Minutos"));
        strcat(dialog, string);
        format(string, sizeof(string), "%d\n\n", DOF2_GetInt(ContasBanidas(playerid), "Segundos"));
        strcat(dialog, string);
        format(string, sizeof(string), "Se voce foi banido por engano, entre em contato com nossa equipe pelo Discord.\n");
        strcat(dialog, string);
        format(string, sizeof(string), "Discord: [LINK DISCORD]\n\n ");
        strcat(dialog, string);
        format(string, sizeof(string), "{FF00FF}ShieldProtection - Crated by Collw");
        strcat(dialog, string);
        
        ShowPlayerDialog(playerid, Dialog_Banido, DIALOG_STYLE_MSGBOX, "{ffffff}[SEU SERVIDOR] - {ff0000}ShieldBan", dialog, "Ok", "");
        SetTimerEx("Kickar", 1000, false, "i", playerid);

        return 1;
    }

    return 1;
}

CMD:unban(playerid, params[])
{
    if (Logado[playerid] < 1)
        return SCM(playerid, VERMELHO, "Erro: {ffffff} Você não pode usar comandos sem estar logado.");
    
    if (info[playerid][Admin] < 4)
        return SCM(playerid, VERMELHO, "Erro: {FFFFFF} Você não tem permissão para usar este comando.");
    
    new Nick[24], string[128], FilePath[128];
    
    if (sscanf(params, "s[24]", Nick)) 
        return SCM(playerid, VERMELHO, "Erro: {FFFFFF} Use: /unban [Nick]");
    
    format(FilePath, sizeof(FilePath), "Banidos/%s.ini", Nick);
    
    if (!DOF2_FileExists(FilePath))
        return SCM(playerid, VERMELHO, "Erro: {FFFFFF} Este jogador não está banido ou o arquivo de banimento não foi encontrado.");
    
    if (fremove(FilePath))
    {
        format(string, sizeof(string), "{ff0000}ShieldBan: {ffffff}Você desbaniu o jogador %s com sucesso.", Nick);
        SCM(playerid, VERDE, string);
        
        format(string, sizeof(string), "{ff0000}ShieldBan: {ffffff}O administrador {FF6EC7}%s{FFFFFF} desbaniu o jogador {FF0000}%s", PlayerName(playerid), Nick);
        SendClientMessageToAll(VERDE, string);
    }
    else
    {
        SCM(playerid, VERMELHO, "Erro: {FFFFFF} Não foi possível remover o arquivo de banimento.");
    }

    return 1;
}

ContasBanidas(playerid)
{
    new string [50];
    format(string, sizeof(string), "Banidos/%s.ini", PlayerName(playerid));
    return string;
}

forward Kickar(playerid);
public Kickar(playerid)
{
    Kick(playerid);
    return 1;
}
