#!/bin/bash
# conecta_servidor
# Programa para conectar com o servidor ssh (herdado do sync2test-0.10.sh)
# 22/09/2009 - Luiz Sanches
# Versao 0.1

# Definicao de variaveis do programa
SCRIPT="sync2test"
DIR_CONF="$HOME/.$SCRIPT"
ARQUIVO_CONF="$DIR_CONF/$SCRIPT.conf"

# Criacao do diretorio de configuracao do programa
[ ! -e "$DIR_CONF" ] && mkdir "$DIR_CONF"

# Verifica a existencia do arquivo de configuracao, para carregamento das variaveis
if [ -e "$ARQUIVO_CONF" ]; then
	. $ARQUIVO_CONF
else
	USUARIO=$1
	SERVIDOR=$2
	PORTA_SSH=$3

	if [ -z "$1" ] || [ -z  "$2" ] || [ -z "$3" ]; then
		echo "ATENCAO! O arquivo de configuracao da conexao nao foi encontrado"
		echo "Informe os parametros: NOME_USUARIO IP_SERVIDOR PORTA_SSH"
		exit
	fi

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
