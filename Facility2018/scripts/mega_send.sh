#���+   ���+�������+ ������+  �����+ 
#����+ �������+----+��+----+ ��+--��+
#��+����+��������+  ���  ���+��������
#���+��++�����+--+  ���   �����+--���
#��� +-+ ����������++������++���  ���
#+-+     +-++------+ +-----+ +-+  +-+
############################################################################################################                                                                                                                

# 
#��������� ������   ���_ _���� ____    ���������    ___������ ��� �� ������    ���������������  ������   ������  
#� � � _������  ���������� ���������_ ������   �    �  ��� ������ �����   �    � � � _����   � ��� � �������  ���
#� � _��� ����  ������    �������� _����������      � ���� ��������������      � � _��� ����   ��� �_� �����  ���
#  _��   ����   ������    ��� ������  �������  _    � ���� � ��� ��� ���  _      _��   ����  _ ������_  ���   ���
#���������� �����������   �������  ��������������     ���� � ���������������   �������������������� ����� �������
#��� ������ ������ � ��   �  �����������  �� �� �     � ��    � ������� �� �   ��� ������� �� �� �� ����� ������ 
#��� � � �  � � �� �  �      ����   �  � � � �  �       �     � ��� � � �  �   ��� � � � � �  �  �� � ��  � � �� 
#� � � � �� � � �  �      �    �    �  � �   �        �       �  �� �   �      � � � � �   �     ��   � � � � �  
#  � �        � �         �    �       �     �  �             �  �  �   �  �     � �       �  �   �         � �  
#�                                  �                                          �                                 
############################################################################################################


 
 #!/bin/bash
#
#Cria uma copia compactada com o nome Dados_.tar.gz no diretorio /tmp/backup
#contendo o diretorio /home/publica
#
#
#Variaveis de configura��o do script

echo ""
echo ""
echo ""
echo "Inciando Procedimento de Back-up"
echo "..."
echo "..."
echo "..."
echo "..."
echo "Aguarde Alguns Instantes para a Finaliza��o"

# Idade do arquivo em dias (+dias = acima de N dias)
#TIME="+10"

# Diret�rio de Destino
#DIR_DESTINO=/tmp/backup

DIR_BACKUP=/"/tmp/backup/";
DATA=$(date +'%d%m%y');
ARQUIVO="$DIR_BACKUP/Backup_$DATA.tar.gz";


#verifica se o diretorio exise, se o diretorio n�o existir cria o diretorio. -d verifica se existe, !-d verifica 
#se n�o existe.
if [ ! -d $DIR_BACKUP ]; then
mkdir $DIR_BACKUP;
fi
#fim do if;
#Compacta o arquivo e salva na pasta /tmp/backup.
tar -cvzf "$ARQUIVO" /var/home;
#Envia o Arquivo para o Mega.
megaput "$ARQUIVO"
#verifica se os aruivos estao a mais de um dia e deleta
echo "Removendo os backups, deixando sempre dos ultimos 1 dias"
find /tmp/backup -name "*.gz" -ctime +1 -exec rm {} \;
#find $DIR_DESTINO -type f -mtime $TIME -delete


echo "......."
echo "BACK-UP Conclu�do."

############################################################################################################
# use crontab -e 
# 0 */6 * * * /path-to-script //a cada seis horas
# service cron reload