#!/bin/bash
# Script para limpar os diretorios de backup gerados pelo sync2test
# Ele deve apagar os diretorios diferentes do mes atual e mes anterior
# Luiz Sanches
# Versao 0.5 - 11/02/2010

echo "Limpando os diretorios de backup do siig..."

MES_ATUAL=$(date +%m)
ANO_ATUAL=$(date +%Y)

if [ $MES_ATUAL = "01" ]; then
	MES_ANTERIOR="12"
	ANO_ANTERIOR=$(($ANO_ATUAL - 1))
else
	MES_ANTERIOR=$(($MES_ATUAL - 1))
	ANO_ANTERIOR=$ANO_ATUAL
fi

if [ $MES_ANTERIOR -lt 10 ]; then
	MES_ANTERIOR="0$MES_ANTERIOR"
fi

PERIODO_ATUAL="$ANO_ATUAL-$MES_ATUAL"
PERIODO_ANTERIOR="$ANO_ANTERIOR-$MES_ANTERIOR"

mkdir /tmp/sync_tmp 2> /dev/null ; cd /tmp/sync_tmp

for dir_bkp in /var/www/bkp-siig*
do
	TESTE=$(basename $dir_bkp)
	# echo $TESTE

	for dir_data in $dir_bkp/*
	do
		DATA=$(basename $dir_data)
		# echo $DATA
		PERIODO=$(echo $DATA | cut -d"-" -f1,2)

		if [ $PERIODO != $PERIODO_ATUAL ] && [ $PERIODO != $PERIODO_ANTERIOR ]; then
			if [ -d $dir_data ]; then
				rm -rf $dir_data
			fi
		fi
	done	
done

ls /var/www/bkp-siig*
