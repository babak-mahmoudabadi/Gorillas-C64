10 rem ## gorillas ##
20 clr
30 def fn ran(x)=int(rnd(0)*x)+1
40 v=53248
50 py=214:px=211
60 home=19:down=17
70 left=157:right=29
80 black=0:white=1:red=2
90 darkblue=6:gray=15
100 poke 53272,23:rem set lower case
110 poke v+21,0
120 poke 53281,black:rem set black for background
130 poke 53280,black:rem set black for border
140 poke 646,white
150 print chr$(147):y=11:text$="Reading data...":gosub 500
160 gosub 2410:rem read sprites data
170 gosub 2160:rem init sound
180 gosub 230:rem call intro
190 gosub 690:rem get inputs
200 gosub 870:rem gorilla intro
210 gosub 1280:rem play game
220 end

230 rem ## intro ##
240 print chr$(147):rem clear screen
250 print:print
260 poke 646,white
270 print spc(12);"G O R I L L A S"
280 poke 646,gray
290 print:print
300 print spc(3);"Copyright (c) IBM Corporation 1991"
310 print spc(2);"Ported for C64 by Babak Mahmoudabadi"
320 print
330 print spc(2);"Your mission is to hit your opponent"
340 print spc(2);"with the exploding banana by varying"
350 print spc(2);"the angle and power of your throw, "
360 print spc(2);"taking into account wind speed, "
370 print spc(2);"gravity, and the city skyline. The "
380 print spc(2);"wind speed is shown by a directional"
390 print spc(2);"arrow at the bottom of the playing"
400 print spc(2);"field, its length relative to its"
410 print spc(2);"strength."
420 print:print:print:print
430 print spc(7);"Press any key to continue"
440 gosub 540:rem call SparklePauserun
450 return

460 REM ## locate ##
470 POKE 214, y: POKE 211,x
480 SYS 58640
490 RETURN

500 rem ## print at center (y, text$) ##
510 poke py,y:poke px,20-(len(text$)/2):sys 58732
520 print text$;
530 return

540 rem ## sparkle pause ##
550 m=1:gosub 2320
560 h$="*    *    *    *    *    *    *    *    *    "
570 v$="{left}{down}*{left}{down} {left}{down} {left}{down} {left}{down} "
580 v$=v$+v$+v$+v$+v$
590 poke 646,red
600 a=1:b=1
610 print chr$(home)+mid$(h$,a,40);
620 print mid$(v$,b,57)
630 print chr$(home)+mid$(v$,21-b,57)
640 print mid$(h$,7-a,40);
650 a=a+1:b=b+3
660 get k$:if k$<>"" then return
670 if a > 5 then 600
680 goto 610

690 rem ## get inputs ##
700 print chr$(147):rem clear screen
710 poke 646,gray
720 poke py,6:poke px,0:sys 58732
730 input "Name of Player 1 (Default = 'Player 1') "; p1$
740 if p1$="" then p1$="Player 1"
750 p1$=left$(p1$, 10)
760 poke py,8:poke px,0:sys 58732
770 input "Name of Player 2 (Default = 'Player 2') "; p2$
780 if p2$="" then p2$="Player 2"
790 p2$=left$(p2$, 10)
800 poke py,10:poke px,0:sys 58732
810 input "Play to how many total points(Default=3)"; numgames
820 if numgames=0 then numgames=3
830 poke py,12:poke px,0:sys 58732
840 input "Gravity in Meters/Sec (Earth = 9.8)     "; gravity
850 if gravity=0 then gravity=9.8
860 return

870 rem ## gorilla intro ##
880 y=14:text$= "--------------":gosub 500
890 y=16:text$="V = View Intro":gosub 500
900 y=18:text$="P = Play Game":gosub 500
910 y=20:text$="Your Choice?":gosub 500
920 get k$:if k$="" then 920
930 if k$<>"v" then return
940 poke 53281,darkblue:rem set blue for background
950 poke 53280,darkblue:rem set blue for border
960 print chr$(147):rem clear screen
970 poke 646,white
980 y=2:text$="G O R I L L A S":gosub 500
990 y=5:text$="STARRING:":gosub 500
1000 y=7:text$=p1$ + " AND " + p2$:gosub 500
1010 sp=0:b=0:x=140:y=160:c=8:gosub 1190:rem set left gorilla
1020 sp=1:b=0:x=190:y=160:c=8:gosub 1190:rem set right gorilla
1030 k=0
1040 for t=1 to 1000:next
1050 for m=2 to 5
1060 k=1-k
1070 poke 2040,192+1+k:rem set bank
1080 poke 2041,192+2-k:rem set bank
1090 gosub 2320
1100 next
1110 for t=1 to 500:next
1120 for n=1 to 4
1130 k=1-k
1140 poke 2040,192+1+k:rem set bank
1150 poke 2041,192+2-k:rem set bank
1160 m=6:gosub 2320
1170 next
1180 return

1190 rem ## place sprite (sp,b,c,x,y) ##
1200 poke v+39+sp,c:rem set color
1210 poke 2040+sp,192+b:rem set bank
1220 xh=int(x/256):xl=x-256*xh
1230 poke v+sp*2,xl
1240 if xh=1 then poke v+16,peek(v+16) or (2^sp):rem extra x-coordinate
1250 poke v+sp*2+1,y
1260 poke v+21,peek(v+21) or (2^sp):rem enable sprite
1270 return

1280 rem ## play game ##
1285 j=1
1290 for g=1 to numgames
1300 print chr$(147):rem clear screen
1310 poke 53281,darkblue:rem set blue for background
1320 poke 53280,darkblue:rem set blue for border
1330 poke 19,1
1340 poke v+21,0
1350 sp=0:b=3:x=172:y=50:c=7:gosub 1190:rem set sun happy
1360 gosub 1560:rem make city scape
1370 gosub 2020:rem place gorillas
1380 j=1-j
1390 poke 646,white
1400 x=0:y=0:gosub 460:print p1$
1410 x=40-len(p2$):y=0:gosub 460:print p2$
1420 y=22:sp1$=str$(tw(1)):sp2$=str$(tw(2))
1430 text$=right$(sp1$,len(sp1$)-1)+">Score<"+right$(sp2$,len(sp2$)-1):gosub 500
1440 x=0:y=0:gosub 460
1450 p=j+1:gosub 1480:rem do shot
1455 if hit<>1 then 1380
1460 next g
1470 return

1480 rem ## do shot (playernum) ##
1490 if p=1 then x=0
1500 if p=2 then x=26
1510 poke 646,3
1520 y=1:gosub 460:input "Angle: ";an
1530 y=2:gosub 460:input "Velocity: ";ve
1540 if p=2 then an=180-an
1541 y=1:gosub 460:print spc(40);
1542 y=2:gosub 460:print spc(40);
1546 hit=1
1550 return

1560 rem ## make city scape ##
1570 l4$="{left}{left}{left}{left}{down}"
1580 l5$="{left}{left}{left}{left}{left}{down}"
1590 b$(0)="{cm i}{cm i}{cm i}{cm f}"+l4$
1600 b$(1)="{cm i}{cm i}{cm i}{cm i}{cm f}"+l5$
1610 b$(2)="{reverse on}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l4$
1620 b$(3)="{reverse on}{cm c}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l5$
1630 print chr$(147):rem clear screen
1640 c$="{white}{cyan}{pink}{light blue}{light gray}"
1645 for i=0 to 8:w(i)=0:next
1650 for i=1 to 4
1660 x=fnran(9)-1:if w(x)=1 then 1660
1670 w(x)=1
1680 next
1690 mh=14
1700 ml=2
1710 s=fnran(4)
1720 if s=1 then h0=ml:a=1:rem upward slope
1730 if s=2 then h0=mh:a=-1:rem downward slope
1740 if s=3 then h0=mh:rem "v" slope
1750 if s=4 then h0=ml:rem Inverted "v" slope
1760 bh=h0
1770 for i=0 to 8
1780 h(i)=bh
1790 if s=3 and i<5 then a=-1
1800 if s=3 and i>5 then a=1
1810 if s=4 and i>5 then a=-1
1820 if s=4 and i<5 then a=1
1830 h0=h0+a
1840 bh=h0+a*fnran(10)
1850 if bh>mh then bh=mh
1860 if bh<ml then bh=ml
1870 next i
1880 x=0
1890 for i=0 to 8
1900 y0=23-h(i)
1910 cr$=mid$(c$,fnran(5),1)
1920 k=0
1930 y=y0:gosub 460
1940 for y=y0 to 23
1950 print cr$;b$(k+w(i));
1960 k=2
1970 next
1980 x=x+4+w(i)
1990 next
2000 x=0:y=0:gosub 460
2010 return

2020 rem ## place gorillas #
2030 n=fnran(2)
2040 x0=(w(0)+4)*8:x1=0:aj=x0/(4+(1-w(0))*2)
2050 if n=2 then x1=(w(1)+4)*8:aj=x1/(4+(1-w(1))*2)
2060 x=x0+x1-aj
2070 y=217-h(n-1)*8
2080 sp=1:b=0:c=8:gosub 1190:rem set gorilla
2090 n=fnran(2)
2100 x0=(w(8)+4)*8:x1=0:aj=x0/(4+(1-w(8))*2)
2110 if n=2 then x1=(w(7)+4)*8:aj=x1/(4+(1-w(7))*2)
2120 x=341-x0-x1+aj
2130 y=217-h(9-n)*8
2140 sp=2:b=0:c=8:gosub 1190:rem set gorilla
2150 return

2160 rem ## init sid ##
2170 s=54272
2180 wf=32
2190 FOR sw=s to s+24:poke sw,0:next sw
2200 POKE S+24,15
2210 POKE S+2,0
2220 POKE S+3,0
2230 POKE S+5,0:rem ad
2240 POKE S+6,240:rem sr
2250 dim fh%(113):dim fl%(113):dim dr%(113):dim p%(6)
2260 j=2
2270 for i=1 to 113
2280 read fh%(i), fl%(i), dr%(i)
2290 if dr%(i)=0 and i<>113 then p%(j)=i+1:j=j+1
2300 next
2310 return

2320 rem ## play seqment (m) ##
2330 j=p%(m)
2340 poke s,fl%(j):poke s+1,fh%(j)
2350 poke s+4,wf+1
2360 for t=1 to dr%(j):next
2370 poke s+4,wf
2380 j=j+1
2390 if dr%(j)<>0 then 2340
2400 return

2410 REM ## read sprites data ##
2420 for l=12288 to 12287+64*5
2430 read d:poke l,d
2440 next
2450 return

2460 rem ## sprite data ##
2470 DATA 0,126,0,0,195,0,0,255
2480 DATA 0,0,219,0,0,126,0,0
2490 DATA 60,0,7,255,192,31,239,240
2500 DATA 63,239,248,127,215,252,122,56
2510 DATA 188,121,255,60,61,255,120,31
2520 DATA 255,240,1,255,0,7,199,192
2530 DATA 15,131,224,15,1,224,15,1
2540 DATA 224,15,1,224,7,131,192,0
2550 DATA 0,126,240,0,195,120,0,255
2560 DATA 56,0,219,60,0,126,60,0
2570 DATA 60,120,7,255,248,31,239,240
2580 DATA 63,239,192,127,215,192,122,56
2590 DATA 128,121,255,0,61,255,0,31
2600 DATA 255,0,1,255,0,7,199,192
2610 DATA 15,131,224,15,1,224,15,1
2620 DATA 224,15,1,224,7,131,192,0
2630 DATA 30,126,0,60,195,0,56,255
2640 DATA 0,120,219,0,120,126,0,60
2650 DATA 60,0,63,255,192,31,239,240
2660 DATA 7,239,248,7,215,252,2,56
2670 DATA 188,1,255,60,1,255,120,1
2680 DATA 255,240,1,255,0,7,199,192
2690 DATA 15,131,224,15,1,224,15,1
2700 DATA 224,15,1,224,7,131,192,0
2710 DATA 0,16,0,1,17,0,1,17,0
2720 DATA 24,146,48,4,254,64,3,255,128
2730 DATA 199,255,198,55,183,216,15,147,224
2740 DATA 15,255,224,255,255,254,15,255,224
2750 DATA 14,254,224,55,57,216,199,199,198
2760 DATA 3,255,128,4,254,64,24,146,48
2770 DATA 1,17,0,1,17,0,0,16,0,0
2780 DATA 0,16,0,1,17,0,1,17,0
2790 DATA 24,146,48,4,254,64,3,255,128
2800 DATA 199,255,198,55,187,216,15,17,224
2810 DATA 15,187,224,255,255,254,15,199,224
2820 DATA 15,131,224,55,131,216,199,199,198
2830 DATA 3,255,128,4,254,64,24,146,48
2840 DATA 1,17,0,1,17,0,0,16,0,0

2850 rem ## music data ##
2860 data 8,97,100,9,104,100,10,143,100
2870 data 9,104,100,8,97,100,9,104,100
2880 data 10,143,240,8,97,240,8,97,240
2890 data 0,0,0,15,210,133,0,0,75
2900 data 15,210,75,14,24,75,14,24,75
2910 data 0,0,75,15,210,75,0,0,75
2920 data 15,210,75,0,0,75,15,210,75
2930 data 14,24,75,14,24,75,14,24,75
2940 data 0,0,75,15,210,133,0,0,75
2950 data 15,210,75,14,24,75,14,24,75
2960 data 0,0,75,15,210,75,0,0,0
2970 data 0,0,300,19,239,133,0,0,75
2980 data 19,239,75,17,194,75,17,194,75
2990 data 0,0,75,19,239,75,0,0,75
3000 data 19,239,75,0,0,75,19,239,75
3010 data 17,194,75,17,194,75,17,194,75
3020 data 0,0,75,19,239,133,0,0,75
3030 data 19,239,75,17,194,75,17,194,75
3040 data 0,0,75,19,239,75,0,0,0
3050 data 0,0,300,23,181,133,0,0,75
3060 data 23,181,75,21,31,75,21,31,75
3070 data 0,0,75,23,181,75,0,0,75
3080 data 23,181,75,0,0,75,23,181,75
3090 data 21,31,75,21,31,75,21,31,75
3100 data 0,0,75,23,181,133,0,0,75
3110 data 23,181,75,21,31,75,21,31,75
3120 data 0,0,75,23,181,75,0,0,0
3130 data 0,0,300,31,165,133,0,0,75
3140 data 31,165,75,28,49,75,28,49,75
3150 data 0,0,75,23,181,75,0,0,75
3160 data 23,181,75,0,0,75,23,181,75
3170 data 21,31,75,21,31,75,21,31,75
3180 data 0,0,75,15,210,133,0,0,75
3190 data 15,210,75,14,24,75,14,24,75
3200 data 0,0,75,15,210,75,0,0,0
3210 data 5,71,48,5,152,48,6,71,48
3220 data 5,71,48,5,152,48,4,180,48
3230 data 4,48,48,0,0,0

