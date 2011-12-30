# synccode - shell-script para sincronizar codigo-fonte entre servidores

## Usuarios e grupos
Os usuarios devem estar cadastrados no mesmo grupo de trabalho 
e deve ser dada permissao de escrita em todos os arquivos dos projetos para o grupo

E necessario a presenca de tres utilitarios do Linux no servidor:

* sed: para tratamento de string.
* rsync: para sincronizar os diretorios.
* dialog: para utilizar caixas de dialogo de interacao com o usuario.

## Instalacao no servidor
1. Abrir um terminal no Linux ou putty no Windows.

2. Copiar o programa para o diretorio do usuario no servidor ssh: `scp -P <porta> synccode <destino>`

   * Exemplo: `scp -P 22 synccode usuario@192.168.0.1:~/`

3. Digitar: `ssh -p <porta_ssh> usuario@ip_servidor <enter> <depois a senha de acesso>`

   * Exemplo: `ssh -p 22 usuario@192.168.0.1`

4. Se nao conectou como root, transforme-se: `sudo su` (para distribuicoes debian based)

5. Criar o diretorio /opt/synccode: `mkdir /opt/synccode`

6. Mover o programa para o diretorio criado: `mv synccode /opt/synccode`

7. Mudar o proprietario do diretorio: `chown usuario.grupo /opt/synccode`

8. Mudar as permissoes de acesso ao diretorio: `chmod 755 -R /opt/synccode`

9. Criar um link simbolico para o programa: `ln -s /opt/synccode/synccode /usr/local/bin/synccode`

10. Volte a ser usuario comum: `exit`

11. Execute o programa: `synccode`

12. Escolha o projeto e tecle `<enter>`.

13. Serao feitas algumas perguntas de configuracao do programa, caso nao haja mudancas tecle <enter> em cada opcao.
    * Diretorio de Destino = /var/www/
    * Porta do servico SSH = numero da porta
    * Arquivos devem vir marcados = (ON ou OFF)

    **OBS.:** Nao esqueca das barras no final do caminho dos diretorios.

14. A seguir sera feita a pergunta do departamento/gerencia em que trabalha.

15. A seguir podera selecionar um modulo ou demais pastas do projeto.

16. Segue abaixo o processo realizado pelo programa:
    * O codigo-fonte e baixado do repositorio de codigo em um diretorio temporario, dentro do diretorio base de destino.
    * Em seguida e sincronizado o diretorio temporario com o diretorio de destino do projeto.
    * E gravado um log dos arquivos sincronizados no diretorio do usuario.
    * Tambem e feito um backup (bkp-<projeto>) dentro do diretorio de destino com os arquivos que foram sincronizados.

## Arquivos de configuracao

**Os arquivos abaixo sao criados na instalacao do programa no diretorio /opt/synccode/**

1. `synccode.conf`: parametros que foram gravados na primeira execucao do programa, com o formato abaixo:

_VARIAVEL="conteudo"_

2. `projetos`: lista com o nome dos projetos, com o formato abaixo:

_projeto:descricao do projeto:tipo de repositorio:endereco do servidor:caminho do repositorio_

3. `gerencias`: lista com o nome das gerencias/departamentos, com o formato abaixo:

_sigla:descricao da gerencia_


**Os arquivos abaixo devem ser criados manualmente de acordo com cada projeto. ATENCAO: o nome do projeto deve ser o mesmo nome do diretorio principal do projeto.**

1. `<nome-do-projeto>_completo`: lista de diretorios de sincronizacao de todo o projeto, com o formato abaixo:

_titulo:descricao:diretorio de origem:diretorio de destino:modo de comunicacao_

**OBS.:** quando for necessario fazer a sincronizacao via ssh, o registro deve seguir o seguinte exemplo:

_PRODUCAO:projeto_homologacao -> projeto (PRODUCAO):projeto_homologacao:192.168.200.236@/var/www/#projeto:SSH_

2. `<nome-do-projeto>_exclude`: lista com diretorios que nao serao sincronizados, com o formato abaixo:

_/diretorio/subdiretorio/_

3. `<nome-do-projeto>_modulos`: lista dos modulos de cada gerencia, com o formato abaixo:

_sigla da gerencia:modulo:descricao do modulo:filtro1|filtro2|..._

## Autor
_Luiz Sanches_ (<http://luizsanches.wordpress.com>)

## Licenca
![CC-GNU-GPL](http://creativecommons.org/images/public/cc-GPL.png)

Este Software e licenciado sob a CC-GNU GPL
