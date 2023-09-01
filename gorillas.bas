10 rem ## gorillas ##
20 def fn ran(x)=int(rnd(0)*x)+1
30 v=53248
40 py=214:px=211
50 home=19:down=17
60 left=157:right=29
70 black=0:white=1:red=2
80 darkblue=6:gray=15

90 poke 53272,23:rem set lower case
95 poke v+21,0
100 poke 53281,black:rem set black for background
110 poke 53280,black:rem set black for border
120 poke 646,white
130 print chr$(147):y=11:text$="Reading data...":gosub 460
140 gosub 2380:rem read sprites data
150 gosub 2130:rem init sound
160 gosub 210:rem call intro
170 gosub 890:rem get inputs
180 gosub 1070:rem gorilla intro
190 gosub 1560:rem play game
200 end

210 rem ## intro ##
220 print chr$(147):rem clear screen
230 print:print
240 poke 646,white
250 print spc(12);"G O R I L L A S"
260 poke 646,gray
270 print:print
280 print spc(3);"Copyright (c) IBM Corporation 1991"
290 print spc(2);"Ported for C64 by Babak Mahmoudabadi"
300 print
310 print spc(2);"Your mission is to hit your opponent"
320 print spc(2);"with the exploding banana by varying"
330 print spc(2);"the angle and power of your throw, "
340 print spc(2);"taking into account wind speed, "
350 print spc(2);"gravity, and the city skyline. The "
360 print spc(2);"wind speed is shown by a directional"
370 print spc(2);"arrow at the bottom of the playing"
380 print spc(2);"field, its length relative to its"
390 print spc(2);"strength."
400 print:print:print:print
410 print spc(7);"Press any key to continue"
420 gosub 500:rem call SparklePauserun
430 return

440 REM ## locate ##
450 POKE 214, y: POKE 211,x
451 SYS 58640
452 RETURN

460 rem ## print at center (y, text$) ##
470 poke py,y:poke px,20-(len(text$)/2):sys 58732
480 print text$;
490 return

500 rem ## sparkle pause ##
510 m=1:gosub 2290
690 h$="*    *    *    *    *    *    *    *    *    "
692 v$="{left}{down}*{left}{down} {left}{down} {left}{down} {left}{down} "
694 v$=v$+v$+v$+v$+v$
710 poke 646,red
715 a=1:b=1
725 print chr$(home)+mid$(h$,a,40);
755 print mid$(v$,b,57) 
756 print chr$(home)+mid$(v$,21-b,57)
757 print mid$(h$,7-a,40); 
759 a=a+1:b=b+3
820 get k$:if k$<>"" then return
860 if a > 5 then 715
880 goto 725

890 rem ## get inputs ##
900 print chr$(147):rem clear screen
910 poke 646,gray
920 poke py,6:poke px,0:sys 58732
930 input "Name of Player 1 (Default = 'Player 1') "; p1$
940 if p1$="" then p1$="Player 1"
950 p1$=left$(p1$, 10)
960 poke py,8:poke px,0:sys 58732
970 input "Name of Player 2 (Default = 'Player 2') "; p2$
980 if p2$="" then p2$="Player 2"
990 p2$=left$(p2$, 10)
1000 poke py,10:poke px,0:sys 58732
1010 input "Play to how many total points(Default=3)"; numgames
1020 if numgames=0 then numgames=3
1030 poke py,12:poke px,0:sys 58732
1040 input "Gravity in Meters/Sec (Earth = 9.8)     "; gravity
1050 if gravity=0 then gravity=9.8
1060 return

1070 rem ## gorilla intro ##
1080 y=14:text$= "--------------":gosub 460
1090 y=16:text$="V = View Intro":gosub 460
1100 y=18:text$="P = Play Game":gosub 460
1110 y=20:text$="Your Choice?":gosub 460
1120 get k$:if k$="" then 1120
1130 if k$<>"v" then return
1140 poke 53281,darkblue:rem set blue for background
1150 poke 53280,darkblue:rem set blue for border
1160 print chr$(147):rem clear screen
1170 poke 646,white
1180 y=2:text$="G O R I L L A S":gosub 460
1190 y=5:text$="STARRING:":gosub 460
1200 y=7:text$=p1$ + " AND " + p2$:gosub 460
1210 sp=0:b=0:x=140:y=160:c=8:gosub 1490:rem set left gorilla
1220 sp=1:b=0:x=190:y=160:c=8:gosub 1490:rem set right gorilla
1230 k=0
1240 for t=1 to 1000:next
1250 k=1-k
1260 poke 2040,192+1+k:rem set bank
1270 poke 2041,192+2-k:rem set bank
1280 m=2:gosub 2290
1290 k=1-k
1300 poke 2040,192+1+k:rem set bank
1310 poke 2041,192+2-k:rem set bank
1320 m=3:gosub 2290
1330 k=1-k
1340 poke 2040,192+1+k:rem set bank
1350 poke 2041,192+2-k:rem set bank
1360 m=4:gosub 2290
1370 k=1-k
1380 poke 2040,192+1+k:rem set bank
1390 poke 2041,192+2-k:rem set bank
1400 m=5:gosub 2290
1410 for t=1 to 500:next
1420 for n=1 to 4
1430 k=1-k
1440 poke 2040,192+1+k:rem set bank
1450 poke 2041,192+2-k:rem set bank
1460 m=6:gosub 2290
1470 next
1480 return

1490 rem ## place sprite (sp,b,c,x,y) ##
1500 poke v+39+sp,c:rem set color
1510 poke 2040+sp,192+b:rem set bank
1515 xh=int(x/256):xl=x-256*xh
1520 poke v+sp*2,xl
1525 if xh=1 then poke v+16,peek(v+16) or (2^sp):rem extra x-coordinate
1530 poke v+sp*2+1,y
1540 poke v+21,peek(v+21) or (2^sp):rem enable sprite
1550 return

1560 rem ## play game ##
1565 rem for g=1 to numgames
1570 print chr$(147):rem clear screen
1580 poke 53281,darkblue:rem set blue for background
1590 poke 53280,darkblue:rem set blue for border
1610 poke v+21,0
1615 sp=0:b=3:x=172:y=50:c=7:gosub 1490:rem set sun happy
1620 gosub 1650:rem make city scape
1630 gosub 2090:rem place gorillas
1631 rem loop
1632 poke 646,white
1633 x=0:y=0:gosub 440:print p1$
1634 x=40-len(p2$):y=0:gosub 440:print p2$
1635 y=22:sp1$=str$(tw(1)):sp2$=str$(tw(2))
1636 text$=right$(sp1$,len(sp1$)-1)+">Score<"+right$(sp2$,len(sp2$)-1):gosub 460
1637 x=0:y=0:gosub 440
1638 rem end loop
1639 rem next
1640 return
1641 rem ## do shot ##
1645 rem if p=1then
1649 retrun 
1650 rem ## make city scape ##
1655 l4$="{left}{left}{left}{left}{down}"
1658 l5$="{left}{left}{left}{left}{left}{down}"
1660 b$(0)="{cm i}{cm i}{cm i}{cm f}"+l4$
1670 b$(1)="{cm i}{cm i}{cm i}{cm i}{cm f}"+l5$
1680 b$(2)="{reverse on}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l4$
1690 b$(3)="{reverse on}{cm c}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l5$
1700 print chr$(147):rem clear screen
1710 c$="{white}{cyan}{pink}{light blue}{light gray}"
1720 for i=1 to 4
1730 x=fnran(9)-1:if w(x)=1 then 1730
1740 w(x)=1
1750 next
1760 mh=14
1770 ml=2
1800 s=fnran(4)
1810 if s=1 then h0=ml:a=1:rem upward slope
1820 if s=2 then h0=mh:a=-1:rem downward slope
1830 if s=3 then h0=mh:rem "v" slope
1840 if s=4 then h0=ml:rem Inverted "v" slope
1861 bh=h0
1862 for i=0 to 8
1863 h(i)=bh
1864 if s=3 and i<5 then a=-1
1865 if s=3 and i>5 then a=1
1866 if s=4 and i>5 then a=-1
1867 if s=4 and i<5 then a=1
1869 h0=h0+a
1870 bh=h0+a*fnran(10)
1871 if bh>mh then bh=mh
1872 if bh<ml then bh=ml
1873 next i

1879 x=0
1880 for i=0 to 8
1900 y0=23-h(i)
1910 cr$=mid$(c$,fnran(5),1)
1915 k=0
1916 y=y0:gosub 440
1920 for y=y0 to 23
1960 print cr$;b$(k+w(i));
1961 k=2
1970 next
2060 x=x+4+w(i)
2070 next
2075 x=0:y=0:gosub 440
2080 return

2090 rem ## place gorillas #
2092 n=fnran(2)
2095 x0=(w(0)+4)*8:x1=0:aj=x0/(4+(1-w(0))*2)
2096 if n=2 then x1=(w(1)+4)*8:aj=x1/(4+(1-w(1))*2)
2097 x=x0+x1-aj 
2098 y=217-h(n-1)*8
2100 sp=1:b=0:c=8:gosub 1490:rem set gorilla

2101 n=fnran(2)
2102 x0=(w(8)+4)*8:x1=0:aj=x0/(4+(1-w(8))*2)
2103 if n=2 then x1=(w(7)+4)*8:aj=x1/(4+(1-w(7))*2)
2104 x=341-x0-x1+aj 
2105 y=217-h(9-n)*8
2106 sp=2:b=0:c=8:gosub 1490:rem set gorilla
2107 return

2130 rem ## init sid ##
2140 s=54272
2150 wf=32
2160 FOR sw=s to s+24:poke sw,0:next sw
2170 POKE S+24,15
2180 POKE S+2,0
2190 POKE S+3,0
2200 POKE S+5,0:rem ad
2210 POKE S+6,240:rem sr
2220 dim fh%(113):dim fl%(113):dim dr%(113):dim p%(6)
2230 j=2
2240 for i=1 to 113
2250 read fh%(i), fl%(i), dr%(i)
2260 if dr%(i)=0 and i<>113 then p%(j)=i+1:j=j+1
2270 next
2280 return

2290 rem ## play seqment (m) ##
2300 j=p%(m)
2310 poke s,fl%(j):poke s+1,fh%(j)
2320 poke s+4,wf+1
2330 for t=1 to dr%(j):next
2340 poke s+4,wf
2350 j=j+1
2360 if dr%(j)<>0 then 2310
2370 return

2380 REM ## read sprites data ##
2390 for l=12288 to 12287+64*5
2400 read d:poke l,d
2410 next
2420 return

2430 rem ## sprite data ##
2520 DATA 0,126,0,0,195,0,0,255
2530 DATA 0,0,219,0,0,126,0,0
2540 DATA 60,0,7,255,192,31,239,240
2550 DATA 63,239,248,127,215,252,122,56
2560 DATA 188,121,255,60,61,255,120,31
2570 DATA 255,240,1,255,0,7,199,192
2580 DATA 15,131,224,15,1,224,15,1
2590 DATA 224,15,1,224,7,131,192,0
2600 DATA 0,126,240,0,195,120,0,255
2610 DATA 56,0,219,60,0,126,60,0
2620 DATA 60,120,7,255,248,31,239,240
2630 DATA 63,239,192,127,215,192,122,56
2640 DATA 128,121,255,0,61,255,0,31
2650 DATA 255,0,1,255,0,7,199,192
2660 DATA 15,131,224,15,1,224,15,1
2670 DATA 224,15,1,224,7,131,192,0
2680 DATA 30,126,0,60,195,0,56,255
2690 DATA 0,120,219,0,120,126,0,60
2700 DATA 60,0,63,255,192,31,239,240
2710 DATA 7,239,248,7,215,252,2,56
2720 DATA 188,1,255,60,1,255,120,1
2730 DATA 255,240,1,255,0,7,199,192
2731 DATA 15,131,224,15,1,224,15,1
2732 DATA 224,15,1,224,7,131,192,0
2735 DATA 0,16,0,1,17,0,1,17,0
2736 DATA 24,146,48,4,254,64,3,255,128
2737 DATA 199,255,198,55,183,216,15,147,224
2738 DATA 15,255,224,255,255,254,15,255,224
2739 DATA 14,254,224,55,57,216,199,199,198
2740 DATA 3,255,128,4,254,64,24,146,48
2741 DATA 1,17,0,1,17,0,0,16,0,0


2743 DATA 0,16,0,1,17,0,1,17,0
2744 DATA 24,146,48,4,254,64,3,255,128
2745 DATA 199,255,198,55,187,216,15,17,224
2746 DATA 15,187,224,255,255,254,15,199,224
2747 DATA 15,131,224,55,131,216,199,199,198
2748 DATA 3,255,128,4,254,64,24,146,48
2749 DATA 1,17,0,1,17,0,0,16,0,0


2760 rem ## music data ##
2770 data 8,97,100,9,104,100,10,143,100
2780 data 9,104,100,8,97,100,9,104,100
2790 data 10,143,240,8,97,240,8,97,240
2800 data 0,0,0,15,210,133,0,0,75
2810 data 15,210,75,14,24,75,14,24,75
2820 data 0,0,75,15,210,75,0,0,75
2830 data 15,210,75,0,0,75,15,210,75
2840 data 14,24,75,14,24,75,14,24,75
2850 data 0,0,75,15,210,133,0,0,75
2860 data 15,210,75,14,24,75,14,24,75
2870 data 0,0,75,15,210,75,0,0,0
2880 data 0,0,300,19,239,133,0,0,75
2890 data 19,239,75,17,194,75,17,194,75
2900 data 0,0,75,19,239,75,0,0,75
2910 data 19,239,75,0,0,75,19,239,75
2920 data 17,194,75,17,194,75,17,194,75
2930 data 0,0,75,19,239,133,0,0,75
2940 data 19,239,75,17,194,75,17,194,75
2950 data 0,0,75,19,239,75,0,0,0
2960 data 0,0,300,23,181,133,0,0,75
2970 data 23,181,75,21,31,75,21,31,75
2980 data 0,0,75,23,181,75,0,0,75
2990 data 23,181,75,0,0,75,23,181,75
3000 data 21,31,75,21,31,75,21,31,75
3010 data 0,0,75,23,181,133,0,0,75
3020 data 23,181,75,21,31,75,21,31,75
3030 data 0,0,75,23,181,75,0,0,0
3040 data 0,0,300,31,165,133,0,0,75
3050 data 31,165,75,28,49,75,28,49,75
3060 data 0,0,75,23,181,75,0,0,75
3070 data 23,181,75,0,0,75,23,181,75
3080 data 21,31,75,21,31,75,21,31,75
3090 data 0,0,75,15,210,133,0,0,75
3100 data 15,210,75,14,24,75,14,24,75
3110 data 0,0,75,15,210,75,0,0,0
3120 data 5,71,48,5,152,48,6,71,48
3130 data 5,71,48,5,152,48,4,180,48
3140 data 4,48,48,0,0,0

