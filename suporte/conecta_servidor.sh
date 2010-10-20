#!/bin/bash
# conecta_servidor
# Programa para conectar com o servidor ssh (herdado do sync2test-0.10.sh)
# 13/07/2010 - Luiz Sanches
# Versao 0.2

# Definicao de variaveis do programa
SCRIPT="synccode"
DIR_CONF="$HOME/.$SCRIPT"
ARQUIVO_CONF="$DIR_CONF/$SCRIPT.conf"

# Criacao do diretorio de configuracao do programa
[ ! -e "$DIR_CONF" ] && mkdir "$DIR_CONF"

if [ "$1" == "limpa" ]; then
	[ -e "$ARQUIVO_CONF" ] && rm "$ARQUIVO_CONF" && exit
fi

# Verifica a existencia do arquivo de configuracao, para carregamento das variaveis
if [ -e "$ARQUIVO_CONF" ]; then
	. $ARQUIVO_CONF
else
	echo ""
	echo "INFORME OS PARAMETROS ABAIXO PARA GUARDAR SUA CONEXAO."
	echo "* Para limpar, informe o parametro 'limpa' pelo console"
	echo "-------------------------------------------------------"
	echo ""

	echo "NOME DO USUARIO:"
	read USUARIO

	echo ""
	echo "IP DO SERVIDOR:"
	read SERVIDOR

	echo ""
	echo "NUMERO DA PORTA SSH:"
	read PORTA_SSH

	echo "USUARIO=\"$USUARIO\"" > $ARQUIVO_CONF
	echo "SERVIDOR=\"$SERVIDOR\"" >> $ARQUIVO_CONF
	echo "PORTA_SSH=\"$PORTA_SSH\"" >> $ARQUIVO_CONF
fi

# Criar autorizacao para nao pedir senha ao conectar via ssh
if [ ! -e "$HOME/.ssh/authorized_keys" ]; then
	ssh -p $PORTA_SSH "$USUARIO@$SERVIDOR" "mkdir ~/.ssh ; touch ~/.ssh/authorized_keys"
	ssh-keygen -t dsa -f ~/.ssh/id_dsa
	cat ~/.ssh/id_dsa.pub | ssh -p $PORTA_SSH "$USUARIO@$SERVIDOR" "cat - >> ~/.ssh/authorized_keys"
	cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
fi

ssh -p $PORTA_SSH $USUARIO@$SERVIDOR
