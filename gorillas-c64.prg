
 � ## GORILLAS ## " V�53248 4 PY�214:PX�211 H( HOME�19:DOWN�17 ^2 LEFT�157:RIGHT�29 x< BLACK�0:WHITE�1:RED�2 �F DARKBLUE�6:GRAY�15 �P LS��(100�8) �Z � 53272,23:� SET LOWER CASE �d � 53281,BLACK:� SET BLACK FOR BACKGROUND 	n � 53280,BLACK:� SET BLACK FOR BORDER 4	x � 2490:� READ SPRITES DATA T	� � 210:� SET READING PERCENT l	� � 1920:� INIT SOUND �	� � 2090:� READ MUSIC DATA �	� � 250:� CALL INTRO �	� � 930:� GET INPUTS �	� � 1110:� GORILLA INTRO �	� � GOSUB 1620:REM PLAY GAME �	� � 
� � ## LOADING ## *
� LP�LP�LS:� LP�100 � LP�100 a
� � �(147):Y�11:TEXT$�"�EADING DATA"��(LP)�"%":� 500 g
� � y
� � ## INTRO ## �
� �(147):� CLEAR SCREEN �
�:� �
� 646,WHITE �
"� �12);"� � � � � � � �" �
,� 646,GRAY �
6�:� @� �3);"�OPYRIGHT (C) ��� �ORPORATION 1991" AJ� �2);"�ORTED FOR �64 BY �ABAK �AHMOUDABADI" GT� x^� �2);"�OUR MISSION IS TO HIT YOUR OPPONENT" �h� �2);"WITH THE EXPLODING BANANA BY VARYING" �r� �2);"THE ANGLE AND POWER OF YOUR THROW, " |� �2);"TAKING INTO ACCOUNT WIND SPEED, " 6�� �2);"GRAVITY, AND THE CITY SKYLINE. �HE " g�� �2);"WIND SPEED IS SHOWN BY A DIRECTIONAL" ��� �2);"ARROW AT THE BOTTOM OF THE PLAYING" ��� �2);"FIELD, ITS LENGTH RELATIVE TO ITS" ��� �2);"STRENGTH." ���:�:�:� �� �7);"�RESS ANY KEY TO CONTINUE" -�� 540:� CALL SPARKLEPAUSERUN 3�� F�� ## LOCATE ## h�� 214, Y: � 211,X: � 58640: � ��� PRINT CENTER (Y, TEXT$) ��� PY,Y:� PX,20�(�(TEXT$)�2):� 58732 �� TEXT$; �� �� ## SPARKLE PAUSE ## �&P�0:� 2400 �0� M�0 � 7 	:� 2040�M,192 D� N� V�16,240 0X� I�0 � 6 � 2 ?b� V�I,24:� Rl� I�8 � 14 � 2 av� V�I,79:� }�� I�39 � 46:� V�I,RED:� ��P1�42�8 ��P2�42�8�6 ��P3�42�8�11 ��P4�42�8�16 ��Q1�42�8�5 ��Q2�42�8�10 ��Q3�42�8�15 ��Q4�42�8�20 )�A$ � "*    *    *    *    *    *    *    *    *    " 8�� V�21,255 F�� 646,RED R�A�1:K�0 nZ1�P1:Z2�P2:Z3�P3:Z4�P4 �W1�Q1:W2�Q2:W3�Q3:W4�Q4 �� �(HOME);�(A$,A,40); � � PY,19:� �*� �(A$,7�A,40); �4� V�1,Z1:� V�9,W1 �>� V�3,Z2:� V�11,W2 
H� V�5,Z3:� V�13,W3 !R� V�7,Z4:� V�15,W4 @\� K$:� K$��"" � � V�21,0:� JfA�A�1 Zp� A�5 � 760 dzK�A�1 ��Z1�Z1�8:Z2�Z2�8:Z3�Z3�8:Z4�Z4�8 ��W1�W1�8:W2�W2�8:W3�W3�8:W4�W4�8 ��� 790 ��� ## GET INPUTS ## ��� �(147):� CLEAR SCREEN ��� 646,GRAY �� PY,6:� PX,0:� 58732 H�� "�AME OF �LAYER 1 (�EFAULT = '�LAYER 1') "; P1$ f�� P1$�"" � P1$�"�LAYER 1" y�P1$��(P1$, 10) ��� PY,8:� PX,0:� 58732 ��� "�AME OF �LAYER 2 (�EFAULT = '�LAYER 2') "; P2$ ��� P2$�"" � P2$�"�LAYER 2" �P2$��(P2$, 10) � PY,10:� PX,0:� 58732 P� "�LAY TO HOW MANY TOTAL POINTS(�EFAULT=3)"; NUMGAMES n$� NUMGAMES�0 � NUMGAMES�3 �.� PY,12:� PX,0:� 58732 �8� "�RAVITY IN �ETERS/�EC (�ARTH = 9.8)     "; GRAVITY �B� GRAVITY�0 � GRAVITY�9.8 �L� V� ## GORILLA INTRO ## (`Y�14:TEXT$� "--------------":� 500 NjY�16:TEXT$�"� = �IEW �NTRO":� 500 stY�18:TEXT$�"� = �LAY �AME":� 500 �~Y�20:TEXT$�"�OUR �HOICE?":� 500 ��� K$:� K$�"" � 1160 ��� K$�"P" � � ��� 53281,DARKBLUE:� SET BLUE FOR BACKGROUND �� 53280,DARKBLUE:� SET BLUE FOR BORDER 6�� �(147):� CLEAR SCREEN F�� 646,WHITE l�Y�2:TEXT$�"� � � � � � � �":� 500 ��Y�5:TEXT$�"��������:":� 500 ��Y�7:TEXT$�P1$ � " ��� " � P2$:� 500 ��SP�0:B�1:X�140:Y�160:� 1530:� SET LEFT GORILLA �SP�1:B�1:X�190:Y�160:� 1530:� SET RIGHT GORILLA #�K�0 6 � T�1 � 1000:� @
K�1�K ^� 2040,192�2�K:� SET BANK |� 2041,192�3�K:� SET BANK �(P�1:� 2400 �2K�1�K �<� 2040,192�2�K:� SET BANK �F� 2041,192�3�K:� SET BANK �PP�2:� 2400 �ZK�1�K d� 2040,192�2�K:� SET BANK &n� 2041,192�3�K:� SET BANK 5xP�3:� 2400 ?�K�1�K ]�� 2040,192�2�K:� SET BANK {�� 2041,192�3�K:� SET BANK ��P�4:� 2400 ��� T�1 � 500:� ��� J�1 � 4 ��K�1�K ��� 2040,192�2�K:� SET BANK ��� 2041,192�3�K:� SET BANK ��P�5:� 2400 �� �� 0�� ## PLACE GORILLA (SP,B,X,Y) ## L� V�39�SP,8:� SET COLOR k� 2040�SP,192�B:� SET BANK z� V�SP�2,X �"� V�SP�2�1,Y �,� V�21,�(V�21) � (2�SP):� ENABLE SPRITE �6� �@� ## PLAY GAME ## �J� �(147):� CLEAR SCREEN T� 53281,DARKBLUE:� SET BLUE FOR BACKGROUND I^� 53280,DARKBLUE:� SET BLUE FOR BORDER Yh� 646,WHITE fr� V�21,0 q|� 1680 w�� ��� ## MAKE CITY SCAPE ## ��L0�1944 ��C0�56216 ��L�L0 ��C�C0 ��W��(�(0)�3)�3 ��� L�W�1984 � W�1984�L�1 ��H��(�(0)�20) �CR��(�(0)�15) �� I�0 � H +�� J�0 � W 6�CH�252 H� J�W � CH�97 Z� I�H � CH�98 s� J�W � I�H � CH�123 �&� L�J,CH �0� C�J,CR �:� �DL�L�40:C�C�40 �N� �XL0�L0�W�1 �bC0�C0�W�1 �l� L0�1984 � 1710 �v� ��� ## INIT SOUND ## �F0�55 �D�4.101 �S�54272 %�WF�32 .�AD�0 9�SR�240 E�TM�1200 \�ML�200:� MAX NOTES s�NC�20:� NOTE COUNT ��� SW�S � S�24:� SW,0:� SW ��� S�24,15 ��� S�2,0 �� S�3,0 �� S�5,AD �� S�6,SR � � �*� ## READ MUSIC DATA ## &4� FH%(ML):� FL%(ML):� DR%(ML):� M%(NC):M%(0)�0 :>L�0:O�0:J�0:P�0 NH� T$:� PRINT T$ nR� 210:� SET READING PERCENT �\� T$�"END" � � �fI�1 �p� I��(T$) � 2120 �zK�0 ��A$��(T$,I,1) ��N��(A$)�65 ��B$��(T$,I�1,1) ��BC$��(T$,I�1,2) �� A$�" " � A$�"," � I�I�1:� 2160 B�� A$�"." � I�I�1:J�J�1:P�P�1:M%(P)�J:� 2160 m�� A$�"L" � L��(TM��(BC$)):I�I�3:� 2160 ��� A$�"O" � O��(B$):I�I�2:� 2160 ��� A$�"A" � A$�"B" � K�1 ��� A$�"B" � A$�"C" � N�N�1 ��� A$�"D" � N�N�2 ��� A$�"E" � A$�"F" � N�N�3 �� A$�"G" � N�N�4 7	� B$�"+" � B$�"#" � N�N�1:I�I�1 R	� B$�"-" � N�N�1:I�I�1 c	N�N�(O�K)�12 }$	� A$�"P" � F�0:� 2360 �.	F��(F0�2�(N�12)�D) �8	FH%(J)��(F�256):FL%(J)��(F�256�FH%(J)):DR%(J)�L �B	J�J�1 �L	I�I�1 �V	� 2160 �`	� ## PLAY MUSIC ## 
j	I�M%(P) @t	� S,FL%(I):� S�1,FH%(I):� PRINT FL%(I)+FH%(I)*256 O~	� S�4,WF�1 d�	� T�1 � DR%(I):� q�	� S�4,WF {�	I�I�1 ��	� DR%(I)��0 � 2420 ��	� ��	� ### READ SPRITES DATA ### ��	� L�12288 � 12288�62�64�3 ��	� D:� L,D ��	� ��	� �	� ## ASTERISK SPRITE DATA ## *�	� 0,0,0,102,0,0,60,0 E 
� 0,255,0,0,60,0,0,102 [

� 0,0,0,0,0,0,0,0 q
� 0,0,0,0,0,0,0,0 �
� 0,0,0,0,0,0,0,0 �(
� 0,0,0,0,0,0,0,0 �2
� 0,0,0,0,0,0,0,0 �<
� 0,0,0,0,0,0,0,0 �F
� 0,126,0,0,195,0,0,255 �P
� 0,0,219,0,0,126,0,0  Z
� 60,0,7,255,192,31,239,240 C d
� 63,239,248,127,215,252,122,56 f n
� 188,121,255,60,61,255,120,31 � x
� 255,240,1,255,0,7,199,192 � �
� 15,131,224,15,1,224,15,1 � �
� 224,15,1,224,7,131,192,0 � �
� 0,126,240,0,195,120,0,255 !�
� 56,0,219,60,0,126,60,0 #!�
� 60,120,7,255,248,31,239,240 G!�
� 63,239,192,127,215,192,122,56 g!�
� 128,121,255,0,61,255,0,31 �!�
� 255,0,1,255,0,7,199,192 �!�
� 15,131,224,15,1,224,15,1 �!�
� 224,15,1,224,7,131,192,0 �!�
� 30,126,0,60,195,0,56,255 "�
� 0,120,219,0,120,126,0,60 ""�
� 60,0,63,255,192,31,239,240 A"� 7,239,248,7,215,252,2,56 `"� 188,1,255,60,1,255,120,1 �"� 255,240,1,255,0,7,199,192 �""� 15,131,224,15,1,224,15,1 �",� 224,15,1,224,7,131,192,0 �"6� O3L12CDEDCDL05ECC. #@� O3L09BL16PBAAPBPBPBAAAPL09BL16PBAAPB. B#J� O4L04PL09E-L16PE-D-D-PE-PE-PE-D-D-D-PL09E-L16PE-D-D-PE-. z#T� O4L04PL09G-L16PG-EEPG-PG-PG-EEEPL09G-L16PG-EEPG-. �#^� O4L04PL09BL16PBAAPG-PG-PG-EEEPO3L09BL16PBAAPB. �#h� O2L25EFGEFDC. �#r� END   