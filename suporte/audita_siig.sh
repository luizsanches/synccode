#!/bin/bash
# Script para auditar diferencas entre os diretorios siig,
# verificar espacos ocupados por diretorios
# 21/10/2009 - Luiz Sanches

ORIGEM=$(pwd)
DIRETORIO="/var/www"
DIVISAO="================================================================="

echo "Gerando relatorio..."

echo $DIVISAO > espacos.txt
echo "Espaco ocupado pelos diretorios" >> espacos.txt
echo $DIVISAO >> espacos.txt
du -sh "$DIRETORIO/.sync2test/siig/" "$DIRETORIO/.sync2test/log/" "$DIRETORIO/siig/" "$DIRETORIO/siig_teste" "$DIRETORIO/siig_homologacao/" "$DIRETORIO/bkp-siig" "$DIRETORIO/bkp-siig_teste/" "$DIRETORIO/bkp-siig_homologacao" >> espacos.txt
echo "" >> espacos.txt
echo $DIVISAO >> espacos.txt
echo "Diferenca entre $DIRETORIO/siig e $DIRETORIO/siig_teste" >> espacos.txt
echo $DIVISAO >> espacos.txt

#ls -R "$DIRETORIO/siig" > siig.txt
cd "$DIRETORIO/siig"
find `pwd` -name "*.*" > "$ORIGEM/siig.txt"
cd $ORIGEM
sed '/sco\/arquivos/d' siig.txt > siig.tmp
mv siig.tmp siig.txt
#

#ls -R "$DIRETORIO/siig_teste" > siig_teste.txt
cd "$DIRETORIO/siig_teste"
find `pwd` -name "*.*" > "$ORIGEM/siig_teste.txt"
cd $ORIGEM
sed '/sco\/arquivos/d' siig_teste.txt > siig_teste.tmp
mv siig_teste.tmp siig_teste.txt
#

sed 's/siig_teste/siig/g' siig_teste.txt > temp.txt
mv temp.txt siig_teste.txt
diff siig.txt siig_teste.txt > diferenca_teste.txt

echo "" > diff_homologacao.txt
echo $DIVISAO >> diff_homologacao.txt
echo "Diferenca entre $DIRETORIO/siig_teste e $DIRETORIO/siig_homologacao" >> diff_homologacao.txt
echo $DIVISAO >> diff_homologacao.txt

#ls -R "$DIRETORIO/siig_homologacao" > siig_homologacao.txt
cd "$DIRETORIO/siig_homologacao"
find `pwd` -name "*.*" > "$ORIGEM/siig_homologacao.txt"
cd $ORIGEM
sed '/sco\/arquivos/d' siig_homologacao.txt > siig_homologacao.tmp
mv siig_homologacao.tmp siig_homologacao.txt
#

sed 's/siig_homologacao/siig/g' siig_homologacao.txt > temp.txt
mv temp.txt siig_homologacao.txt
diff siig_teste.txt siig_homologacao.txt > diferenca_homologacao.txt

clear

cat espacos.txt diferenca_teste.txt diff_homologacao.txt diferenca_homologacao.txt > resultado.txt
rm espacos.txt siig*.txt diferenca*.txt diff*.txt
cat resultado.txt | less
