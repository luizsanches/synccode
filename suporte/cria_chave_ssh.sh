#!/bin/bash
# cria chave ssh do usuario
# Programa para criar chave ssh (herdado do script conecta_servidor.sh)
# 30/11/2009 - Luiz Sanches
# Versao 0.1

# Definicao de variaveis do programa
PORTA_SSH="1529"
USUARIO="$USER"
SERVIDOR="192.168.200.236"

# Criar autorizacao para nao pedir senha ao conectar via ssh
if [ ! -e "$HOME/.ssh/authorized_keys" ]; then
  ssh -p $PORTA_SSH "$USUARIO@$SERVIDOR" "mkdir ~/.ssh ; touch ~/.ssh/authorized_keys"

  ssh-keygen -t dsa -f ~/.ssh/id_dsa

  cat ~/.ssh/id_dsa.pub | ssh -p $PORTA_SSH "$USUARIO@$SERVIDOR" "cat - >> ~/.ssh/authorized_keys"

  cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
fi

ARQUIVO_TMP="/tmp/ssh_hostname.tmp"

[ -e "$ARQUIVO_TMP" ] && rm $ARQUIVO_TMP

ssh -p $PORTA_SSH "$USUARIO@$SERVIDOR" hostname > "$ARQUIVO_TMP"

CONECTOU=$(cat "$ARQUIVO_TMP")

[ -n "$CONECTOU" ] && echo "Chave publica SSH para o servidor de PRODUCAO criada com sucesso"
