10 rem ## gorillas ##
20 v=53248
30 py=214:px=211
40 home=19:down=17
50 left=157:right=29
60 black=0:white=1:red=2
70 darkblue=6:gray=15

80 poke 53272,23:rem set lower case
90 poke 53281,black:rem set black for background
100 poke 53280,black:rem set black for border
110 print chr$(147):y=11:text$="Reading data...":gosub 440

120 gosub 2110:rem read sprites data
130 gosub 1860:rem init sound
140 gosub 190:rem call intro
150 gosub 870:rem get inputs
160 gosub 1050:rem gorilla intro
170 rem gosub 1620:rem play game
180 end

190 rem ## intro ##
200 print chr$(147):rem clear screen
210 print:print
220 poke 646,white
230 print spc(12);"G O R I L L A S"
240 poke 646,gray
250 print:print
260 print spc(3);"Copyright (c) IBM Corporation 1991"
270 print spc(2);"Ported for C64 by Babak Mahmoudabadi"
280 print
290 print spc(2);"Your mission is to hit your opponent"
300 print spc(2);"with the exploding banana by varying"
310 print spc(2);"the angle and power of your throw, "
320 print spc(2);"taking into account wind speed, "
330 print spc(2);"gravity, and the city skyline. The "
340 print spc(2);"wind speed is shown by a directional"
350 print spc(2);"arrow at the bottom of the playing"
360 print spc(2);"field, its length relative to its"
370 print spc(2);"strength."
380 print:print:print:print
390 print spc(7);"Press any key to continue"
400 gosub 480:rem call SparklePauserun
410 return

420 REM ## locate ##
430 POKE 214, Y: POKE 211,X: SYS 58640: RETURN

440 rem ## print at center (y, text$) ##
450 poke py,y:poke px,20-(len(text$)/2):sys 58732
460 print text$;
470 return

480 rem ## sparkle pause ##
490 m=1:gosub 2020
500 for m=0 to 7
510 poke 2040+m,192
520 next
530 poke v+16,240
540 for i=0 to 6 step 2
550 poke v+i,24:next
560 for i=8 to 14 step 2
570 poke v+i,79:next
580 for i=39 to 46:poke v+i,red:next
590 p1=42+8
600 p2=42+8*6
610 p3=42+8*11
620 p4=42+8*16
630 q1=42+8*5
640 q2=42+8*10
650 q3=42+8*15
660 q4=42+8*20
670 a$ = "*    *    *    *    *    *    *    *    *    "
680 poke v+21,255
690 poke 646,red
700 a=1:k=0
710 z1=p1:z2=p2:z3=p3:z4=p4
720 w1=q1:w2=q2:w3=q3:w4=q4
730 print chr$(home);mid$(a$,a,40);
740 poke py,19:print
750 print mid$(a$,7-a,40);
760 poke v+1,z1:poke v+9,w1
770 poke v+3,z2:poke v+11,w2
780 poke v+5,z3:poke v+13,w3
790 poke v+7,z4:poke v+15,w4
800 get k$:if k$<>"" then poke v+21,0:return
810 a=a+1
820 if a>5 then 700
830 k=a-1
840 z1=z1+8:z2=z2+8:z3=z3+8:z4=z4+8
850 w1=w1-8:w2=w2-8:w3=w3-8:w4=w4-8
860 goto 730

870 rem ## get inputs ##
880 print chr$(147):rem clear screen
890 poke 646,gray
900 poke py,6:poke px,0:sys 58732
910 input "Name of Player 1 (Default = 'Player 1') "; p1$
920 if p1$="" then p1$="Player 1"
930 p1$=left$(p1$, 10)
940 poke py,8:poke px,0:sys 58732
950 input "Name of Player 2 (Default = 'Player 2') "; p2$
960 if p2$="" then p2$="Player 2"
970 p2$=left$(p2$, 10)
980 poke py,10:poke px,0:sys 58732
990 input "Play to how many total points(Default=3)"; numgames
1000 if numgames=0 then numgames=3
1010 poke py,12:poke px,0:sys 58732
1020 input "Gravity in Meters/Sec (Earth = 9.8)     "; gravity
1030 if gravity=0 then gravity=9.8
1040 return

1050 rem ## gorilla intro ##
1060 y=14:text$= "--------------":gosub 440
1070 y=16:text$="V = View Intro":gosub 440
1080 y=18:text$="P = Play Game":gosub 440
1090 y=20:text$="Your Choice?":gosub 440
1100 get k$:if k$="" then 1100
1110 if k$="p" then return
1120 poke 53281,darkblue:rem set blue for background
1130 poke 53280,darkblue:rem set blue for border
1140 print chr$(147):rem clear screen
1150 poke 646,white
1160 y=2:text$="G O R I L L A S":gosub 440
1170 y=5:text$="STARRING:":gosub 440
1180 y=7:text$=p1$ + " AND " + p2$:gosub 440
1190 sp=0:b=1:x=140:y=160:gosub 1470:rem set left gorilla
1200 sp=1:b=1:x=190:y=160:gosub 1470:rem set right gorilla
1210 k=0
1220 for t=1 to 1000:next
1230 k=1-k
1240 poke 2040,192+2+k:rem set bank
1250 poke 2041,192+3-k:rem set bank
1260 m=2:gosub 2020
1270 k=1-k
1280 poke 2040,192+2+k:rem set bank
1290 poke 2041,192+3-k:rem set bank
1300 m=3:gosub 2020
1310 k=1-k
1320 poke 2040,192+2+k:rem set bank
1330 poke 2041,192+3-k:rem set bank
1340 m=4:gosub 2020
1350 k=1-k
1360 poke 2040,192+2+k:rem set bank
1370 poke 2041,192+3-k:rem set bank
1380 m=5:gosub 2020
1390 for t=1 to 500:next
1400 for n=1 to 4
1410 k=1-k
1420 poke 2040,192+2+k:rem set bank
1430 poke 2041,192+3-k:rem set bank
1440 m=6:gosub 2020
1450 next
1460 return

1470 rem ## place gorilla (sp,b,x,y) ##
1480 poke v+39+sp,8:rem set color
1490 poke 2040+sp,192+b:rem set bank
1500 poke v+sp*2,x
1510 poke v+sp*2+1,y
1520 poke v+21,peek(v+21) or (2^sp):rem enable sprite
1530 return

1540 rem ## play game ##
1550 print chr$(147):rem clear screen
1560 poke 53281,darkblue:rem set blue for background
1570 poke 53280,darkblue:rem set blue for border
1580 poke 646,white
1590 poke v+21,0
1600 gosub 1620
1610 return

1620 rem ## make city scape ##
1630 l0=1944
1640 c0=56216
1650 l=l0
1660 c=c0
1670 w=int(rnd(0)*3)+3
1680 if l+w>1984 then w=1984-l-1
1690 h=int(rnd(0)*20)
1700 cr=int(rnd(0)*15)
1710 for i=0 to h
1720 for j=0 to w
1730 ch=252
1740 if j=w then ch=97
1750 if i=h then ch=98
1760 if j=w and i=h then ch=123
1770 poke l+j,ch
1780 poke c+j,cr
1790 next
1800 l=l-40:c=c-40
1810 next
1820 l0=l0+w+1
1830 c0=c0+w+1
1840 if l0<1984 then 1650
1850 return

1860 rem ## init sid ##
1870 s=54272
1880 wf=32
1890 FOR sw=s to s+24:poke sw,0:next sw
1900 POKE S+24,15
1910 POKE S+2,0
1920 POKE S+3,0
1930 POKE S+5,0:rem ad
1940 POKE S+6,240:rem sr
1950 dim fh%(113):dim fl%(113):dim dr%(113):dim p%(6)
1960 j=2
1970 for i=1 to 113
1980 read fh%(i), fl%(i), dr%(i)
1990 if dr%(i)=0 and i<>113 then p%(j)=i+1:j=j+1
2000 next
2010 return

2020 rem ## play seqment (m) ##
2030 j=p%(m)
2040 poke s,fl%(j):poke s+1,fh%(j)
2050 poke s+4,wf+1
2060 for t=1 to dr%(j):next
2070 poke s+4,wf
2080 j=j+1
2090 if dr%(j)<>0 then 2040
2100 return

2110 REM ## read sprites data ##
2120 for l=12288 to 12288+63+64*3
2130 read d:poke l,d
2140 next
2150 return

2160 rem ## sprite data ##
2170 DATA 0,0,0,102,0,0,60,0
2180 DATA 0,255,0,0,60,0,0,102
2190 DATA 0,0,0,0,0,0,0,0
2200 DATA 0,0,0,0,0,0,0,0
2210 DATA 0,0,0,0,0,0,0,0
2220 DATA 0,0,0,0,0,0,0,0
2230 DATA 0,0,0,0,0,0,0,0
2240 DATA 0,0,0,0,0,0,0,0
2250 DATA 0,126,0,0,195,0,0,255
2260 DATA 0,0,219,0,0,126,0,0
2270 DATA 60,0,7,255,192,31,239,240
2280 DATA 63,239,248,127,215,252,122,56
2290 DATA 188,121,255,60,61,255,120,31
2300 DATA 255,240,1,255,0,7,199,192
2310 DATA 15,131,224,15,1,224,15,1
2320 DATA 224,15,1,224,7,131,192,0
2330 DATA 0,126,240,0,195,120,0,255
2340 DATA 56,0,219,60,0,126,60,0
2350 DATA 60,120,7,255,248,31,239,240
2360 DATA 63,239,192,127,215,192,122,56
2370 DATA 128,121,255,0,61,255,0,31
2380 DATA 255,0,1,255,0,7,199,192
2390 DATA 15,131,224,15,1,224,15,1
2400 DATA 224,15,1,224,7,131,192,0
2410 DATA 30,126,0,60,195,0,56,255
2420 DATA 0,120,219,0,120,126,0,60
2430 DATA 60,0,63,255,192,31,239,240
2440 DATA 7,239,248,7,215,252,2,56
2450 DATA 188,1,255,60,1,255,120,1
2460 DATA 255,240,1,255,0,7,199,192
2470 DATA 15,131,224,15,1,224,15,1
2480 DATA 224,15,1,224,7,131,192,0


2490 rem ## music data ##
2500 data 8,97,100,9,104,100,10,143,100
2510 data 9,104,100,8,97,100,9,104,100
2520 data 10,143,240,8,97,240,8,97,240
2530 data 0,0,0,15,210,133,0,0,75
2540 data 15,210,75,14,24,75,14,24,75
2550 data 0,0,75,15,210,75,0,0,75
2560 data 15,210,75,0,0,75,15,210,75
2570 data 14,24,75,14,24,75,14,24,75
2580 data 0,0,75,15,210,133,0,0,75
2590 data 15,210,75,14,24,75,14,24,75
2600 data 0,0,75,15,210,75,0,0,0
2610 data 0,0,300,19,239,133,0,0,75
2620 data 19,239,75,17,194,75,17,194,75
2630 data 0,0,75,19,239,75,0,0,75
2640 data 19,239,75,0,0,75,19,239,75
2650 data 17,194,75,17,194,75,17,194,75
2660 data 0,0,75,19,239,133,0,0,75
2670 data 19,239,75,17,194,75,17,194,75
2680 data 0,0,75,19,239,75,0,0,0
2690 data 0,0,300,23,181,133,0,0,75
2700 data 23,181,75,21,31,75,21,31,75
2710 data 0,0,75,23,181,75,0,0,75
2720 data 23,181,75,0,0,75,23,181,75
2730 data 21,31,75,21,31,75,21,31,75
2740 data 0,0,75,23,181,133,0,0,75
2750 data 23,181,75,21,31,75,21,31,75
2760 data 0,0,75,23,181,75,0,0,0
2770 data 0,0,300,31,165,133,0,0,75
2780 data 31,165,75,28,49,75,28,49,75
2790 data 0,0,75,23,181,75,0,0,75
2800 data 23,181,75,0,0,75,23,181,75
2810 data 21,31,75,21,31,75,21,31,75
2820 data 0,0,75,15,210,133,0,0,75
2830 data 15,210,75,14,24,75,14,24,75
2840 data 0,0,75,15,210,75,0,0,0
2850 data 5,71,48,5,152,48,6,71,48
2860 data 5,71,48,5,152,48,4,180,48
2870 data 4,48,48,0,0,0

