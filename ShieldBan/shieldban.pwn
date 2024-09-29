/*
    --------------------------------------------------------
    |                ShieldProtection System                |
    |                                                       |
    |          Sistema de Proteção: ShieldBan               |
    |                                                       |
    |            Created by Collw                           |
    |                                                       |
    |               Versão: 1.2.09                          |
    --------------------------------------------------------
    
    Descrição:
    O ShieldBan faz parte do sistema de proteção ShieldProtection, 
    desenvolvido para fornecer maior segurança ao servidor. O sistema
    é responsável por identificar e gerenciar os jogadores banidos, 
    exibindo as informações necessárias ao jogador banido e facilitando
    o processo de administração.
    
    Observação:
    Sistema altamente personalizável e adaptado para servidores SA-MP.
*/



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

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" ShieldBan - ShieldProtection 1.2.09 ");
    print("   Sistema de banimento de players   ");
    print("            por Collw ");
    print("--------------------------------------\n");
    return 1;
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
//comando para desbanir
CMD:ban(playerid, params[])
{
    if (Logado[playerid] < 1)
        return SCM(playerid, VERMELHO, "Erro: {ffffff} Você não pode usar comandos sem estar logado.");
    
    if (info[playerid][Admin] < 4)
        return SCM(playerid, VERMELHO, "Erro: {FFFFFF} Você não tem permissão para usar este comando.");

    new ID, string[512], Motivo[50], Dia, Mes, Ano, Hora, Minutos, Segundos;

    // Verifica se os parâmetros estão corretos
    if (sscanf(params, "ds", ID, Motivo)) 
        return SendClientMessage(playerid, VERMELHO, ": {DCDCDC}Digite: /ban [ID] [motivo]");

    // Verifica se o jogador está conectado e logado
    if (!IsPlayerConnected(ID) || Logado[ID] == false) 
        return SCM(playerid, VERMELHO, "Erro:{ffffff} Jogador não conectado!");

    // Verifica se o administrador está tentando banir a si mesmo
    if (ID == playerid) 
        return SCM(playerid, VERMELHO, "Erro:{ffffff} Você não pode se banir.");

    // Verifica se o administrador tem um cargo inferior ao do alvo
    if (info[playerid][Admin] < info[ID][Admin])
        return SCM(playerid, VERMELHO, "Erro:{ffffff} Você não pode banir um administrador de cargo superior.");

    // Verifica se o administrador tem o mesmo cargo que o alvo
    if (info[playerid][Admin] == info[ID][Admin])
        return SCM(playerid, VERMELHO, "Erro:{ffffff} Você não pode banir um administrador do mesmo nível.");

    // Níveis de administrador para a mensagem
    new AdminLevel[50];
    if (info[playerid][Admin] == 1) AdminLevel = "Administrador";
    if (info[playerid][Admin] == 2) AdminLevel = "Administrador";
    if (info[playerid][Admin] == 3) AdminLevel = "Administrador";
    if (info[playerid][Admin] == 4) AdminLevel = "Administrador";
    if (info[playerid][Admin] == 5) AdminLevel = "Administrador";
    if (info[playerid][Admin] == 6) AdminLevel = "Administrador";
    if (info[playerid][Admin] == 7) AdminLevel = "Administrador";

    // Mensagem de banimento global
    format(string, sizeof(string), "{ff0000}ShieldBan: {ffffff} O %s {FF6EC7}%s {dcdcdc} baniu o jogador(a) {FF0000}%s{dcdcdc}. Motivo: %s", AdminLevel, PlayerName(playerid), PlayerName(ID), Motivo);
    SendClientMessageToAll(VERMELHO, string);

    // Mensagem para o administrador que baniu o jogador
    format(string, sizeof(string), "{ff0000}ShieldBan: {ffffff}Você baniu o jogador {FF0000}%s{FFFFFF}. Motivo: %s", PlayerName(ID), Motivo);
    SendClientMessage(playerid, VERDE, string); // Envia mensagem de confirmação para o administrador

    // Mensagem para o jogador banido
    format(string, sizeof(string), "Você foi banido(a) pelo Administrador %s. Motivo: %s", PlayerName(playerid), Motivo);
    SendClientMessage(ID, VERMELHO, string);

    // Registrar os detalhes do banimento
    getdate(Ano, Mes, Dia);
    gettime(Hora, Minutos, Segundos);
    DOF2_CreateFile(ContasBanidas(ID));
    DOF2_SetString(ContasBanidas(ID), "Staff", PlayerName(playerid));
    DOF2_SetString(ContasBanidas(ID), "Motivo", Motivo);
    DOF2_SetString(ContasBanidas(ID), "Banido", PlayerName(ID));
    DOF2_SetInt(ContasBanidas(ID), "Dia", Dia);
    DOF2_SetInt(ContasBanidas(ID), "Mes", Mes);
    DOF2_SetInt(ContasBanidas(ID), "Ano", Ano);
    DOF2_SetInt(ContasBanidas(ID), "Hora", Hora);
    DOF2_SetInt(ContasBanidas(ID), "Minutos", Minutos);
    DOF2_SetInt(ContasBanidas(ID), "Segundos", Segundos);
    DOF2_SaveFile();

    // Agendar o kick do jogador banido
    SetTimerEx("Kickar", 1000, false, "i", ID);

    return 1;
}
//comando para desbanir
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
/* função ContasBanidas gera e retorna o caminho de um arquivo .
ini associado ao jogador banido, utilizando seu nome para localizar o arquivo dentro da pasta "Banidos".*/

ContasBanidas(playerid)
{
    new string [50];
    format(string, sizeof(string), "Banidos/%s.ini", PlayerName(playerid));
    return string;
}
//Callback que kicka o player
forward Kickar(playerid);
public Kickar(playerid)
{
    Kick(playerid);
    return 1;
}
