10 rem ## gorillas ##
20 clr
30 def fn ran(x)=int(rnd(0)*x)+1
35 sm=241
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
160 gosub 2520:rem read sprites data
170 gosub 2270:rem init sound
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
550 m=1:gosub 2430
560 h$="*    *    *    *    *    *    *    *    *    "
570 v$="{left}{down}*{left}{down} {left}{down} {left}{down} {left}{down} "
580 v$=v$+v$+v$+v$+v$
590 poke 646,red
600 a=1:b=1
610 print chr$(home);mid$(h$,a,40);
620 print mid$(v$,b,57)
630 print chr$(home);mid$(v$,21-b,57)
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
1010 sp=0:b=0:x=140:y=160:c=8:gosub 1200:rem set left gorilla
1020 sp=1:b=0:x=190:y=160:c=8:gosub 1200:rem set right gorilla
1030 k=1
1040 for t=1 to 1000:next
1050 for m=2 to 5
1060 k=1-k
1070 poke 2040,sm+1+k:rem set bank
1080 poke 2041,sm+2-k:rem set bank
1090 gosub 2430
1100 next
1110 for t=1 to 500:next
1120 for n=1 to 4
1130 k=1-k
1140 poke 2040,sm+1+k:rem set bank
1150 poke 2041,sm+2-k:rem set bank
1160 m=6:gosub 2430
1170 next
1180 return

1190 rem ## place sprite (sp,b,c,x,y) ##
1200 poke v+39+sp,c:rem set color
1210 poke 2040+sp,sm+b:rem set bank
1220 xh=int(x/256):xl=x-256*xh
1230 poke v+sp*2,xl
1240 if xh=0 then poke v+16,peek(v+16) and (255-2^sp):rem extra x-coordinate
1245 if xh=1 then poke v+16,peek(v+16) or (2^sp):rem extra x-coordinate
1250 poke v+sp*2+1,y
1260 poke v+21,peek(v+21) or (2^sp):rem enable sprite
1270 return

1280 rem ## play game ##
1282 poke 53281,darkblue:rem set blue for background
1283 poke 53280,darkblue:rem set blue for border
1290 j=0
1300 for g=1 to numgames
1310 print chr$(147):rem clear screen
1340 poke 19,1:poke v+21,0
1350 hit=0
1360 sp=0:b=3:x=172:y=50:c=7:gosub 1200:rem set sun happy
1370 gosub 1640:rem make city scape
1380 gosub 2130:rem place gorillas
1400 poke 646,white
1410 x=0:y=0:gosub 460:print p1$
1420 x=40-len(p2$):y=0:gosub 460:print p2$
1430 y=22:sp1$=str$(tw(1)):sp2$=str$(tw(2))
1440 text$=right$(sp1$,len(sp1$)-1)+">Score<"+right$(sp2$,len(sp2$)-1):gosub 500
1450 x=0:y=0:gosub 460
1460 p=j+1:gosub 1500:rem do shot
1465 j=1-j
1470 if hit=0 then 1460
1480 next
1490 return

1500 rem ## do shot (playernum) ##
1510 if p=1 then x=0
1520 if p=2 then x=27
1530 poke 646,3
1540 y=1:gosub 460:input "Angle:";an
1550 y=2:gosub 460:input "Velocity:";ve
1560 if p=2 then an=180-an
1570 y=1:gosub 460:print spc(80);
1580 gosub 1611
1600 return

1610 rem ## plot shot (angle, velocity, playernum)
1611 poke 2040+p,sm+p:rem set bank
1612 m=8:gosub 2430
1613 poke 2040+p,sm:rem set bank

1614 sp=3:b=6:c=7:x=xs(p):y=ys(p)-8
1615 if p=2 then x=x+16
1616 an=an/180*3.141592
1617 poke v+39+sp,c:rem set color
1618 x0=x:y0=y:ix=cos(an)*ve:iy=sin(an)*ve:w=1:t=0
1619 yp=v+sp*2+1:xp=v+sp*2:pk=4
1620 x=x0+(ix*t)+(.5*(w/5)*t*t):y=y0+((-1*(iy*t))+(.5*gravity*t*t))*.6

1621 if x>350 or x<18 then 1636
1622 if y<0 then 1631
1623 poke v+21,7:poke xp,x and 255
1624 if x<=255 then poke v+16,pk and 247:rem extra x-coordinate
1625 if x>255 then poke v+16,pk or 8:rem extra x-coordinate
1626 poke yp,y
1627 poke 2040+sp,sm+b:rem set bank
1628 poke v+21,15

1629 bp=1024+int((y-47)/8)*40+INT((x-24)/8):if peek(bp)<>32 and y>75 then poke bp,32:m=7:gosub 2430:goto 1636
1630 cs=peek(v+30)
1631 if (cs and 1)=1 then print "sun":end
1632 if (cs and 2)=2 and p=1 then print "p1":end
1633 if (cs and 2)=4 and p=2 then print "p2":end
 
1634 t=t+.1:b=b+1:if b>9 then b=6
1635 goto 1620
1636 poke v+21,7
1638 return

1640 rem ## make city scape ##
1650 l4$="{left}{left}{left}{left}{down}"
1660 l5$="{left}{left}{left}{left}{left}{down}"
1670 b$(0)="{cm i}{cm i}{cm i}{cm f}"+l4$
1680 b$(1)="{cm i}{cm i}{cm i}{cm i}{cm f}"+l5$
1690 b$(2)="{reverse on}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l4$
1700 b$(3)="{reverse on}{cm c}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l5$
1710 print chr$(147):rem clear screen
1720 c$="{white}{cyan}{pink}{light blue}{light gray}"
1730 bc=8
1740 for i=0 to 9:w(i)=0:next
1750 if fnran(10)>6 then bc=9:goto 1800
1760 for i=1 to 4
1770 x=fnran(9)-1:if w(x)=1 then 1770
1780 w(x)=1
1790 next
1800 mh=17
1810 ml=2
1820 sl=fnran(4)
1830 if sl=1 then h0=ml:a=1:rem upward slope
1840 if sl=2 then h0=mh:a=-1:rem downward slope
1850 if sl=3 then h0=mh:rem "v" slope
1860 if sl=4 then h0=ml:rem Inverted "v" slope
1870 bh=h0
1880 for i=0 to bc
1890 h(i)=bh
1900 if sl=3 and i<5 then a=-1
1910 if sl=3 and i>5 then a=1
1920 if sl=4 and i>5 then a=-1
1930 if sl=4 and i<5 then a=1
1940 h0=h0+a
1950 bh=h0+a*fnran(10)
1960 if bh>mh then bh=mh
1970 if bh<ml then bh=ml
1980 next i
1990 x=0
2000 for i=0 to bc
2010 y0=23-h(i)
2020 cr$=mid$(c$,fnran(5),1)
2030 k=0
2040 y=y0:gosub 460
2050 for y=y0 to 23
2060 print cr$;b$(k+w(i));
2070 k=2
2080 next
2090 x=x+4+w(i)
2100 next
2110 x=0:y=0:gosub 460
2120 return

2130 rem ## place gorillas #
2140 n=fnran(2)
2150 x0=(w(0)+4)*8:x1=0:aj=x0/(4+(1-w(0))*2)
2160 if n=2 then x1=(w(1)+4)*8:aj=x1/(4+(1-w(1))*2)
2170 x=x0+x1-aj:xs(1)=x
2180 y=217-h(n-1)*8:ys(1)=y
2190 sp=1:b=0:c=8:gosub 1200:rem set gorilla
2200 n=fnran(2)
2210 x0=(w(bc)+4)*8:x1=0:aj=x0/(4+(1-w(bc))*2)
2220 if n=2 then x1=(w(bc-1)+4)*8:aj=x1/(4+(1-w(bc-1))*2)
2230 x=341-x0-x1+aj:xs(2)=x
2240 y=217-h(bc+1-n)*8:ys(2)=y
2250 sp=2:b=0:c=8:gosub 1200:rem set gorilla
2260 return

2270 rem ## init sid ##
2280 s=54272
2290 wf=32
2300 FOR sw=s to s+24:poke sw,0:next sw
2310 POKE S+24,15
2320 POKE S+2,0
2330 POKE S+3,0
2340 POKE S+5,0:rem ad
2350 POKE S+6,240:rem sr
2360 dim fh%(126):dim fl%(126):dim dr%(126):dim p%(8)
2370 j=2
2380 for i=1 to 126
2390 read fh%(i), fl%(i), dr%(i)
2400 if dr%(i)=0 and i<>126 then p%(j)=i+1:j=j+1
2410 next
2420 return

2430 rem ## play seqment (m) ##
2440 q=p%(m)
2450 poke s,fl%(q):poke s+1,fh%(q)
2460 poke s+4,wf+1
2470 for t=1 to dr%(q):next
2480 poke s+4,wf
2490 q=q+1
2500 if dr%(q)<>0 then 2450
2510 return

2520 REM ## read sprites data ##
2530 for l=sm*64 to sm*64+64*15-1
2540 read d:poke l,d
2550 next
2560 return

2570 rem ## sprite data ##
2580 rem gorilla
2590 DATA 0,126,0,0,195,0,0,255
2600 DATA 0,0,219,0,0,126,0,0
2610 DATA 60,0,7,255,192,31,239,240
2620 DATA 63,239,248,127,215,252,122,56
2630 DATA 188,121,255,60,61,255,120,31
2640 DATA 255,240,1,255,0,7,199,192
2650 DATA 15,131,224,15,1,224,15,1
2660 DATA 224,15,1,224,7,131,192,0

2670 rem g left hand up
2680 DATA 30,126,0,60,195,0,56,255
2690 DATA 0,120,219,0,120,126,0,60
2700 DATA 60,0,63,255,192,31,239,240
2710 DATA 7,239,248,7,215,252,2,56
2720 DATA 188,1,255,60,1,255,120,1
2730 DATA 255,240,1,255,0,7,199,192
2740 DATA 15,131,224,15,1,224,15,1
2750 DATA 224,15,1,224,7,131,192,0

2760 rem g right hand up
2770 DATA 0,126,240,0,195,120,0,255
2780 DATA 56,0,219,60,0,126,60,0
2790 DATA 60,120,7,255,248,31,239,240
2800 DATA 63,239,192,127,215,192,122,56
2810 DATA 128,121,255,0,61,255,0,31
2820 DATA 255,0,1,255,0,7,199,192
2830 DATA 15,131,224,15,1,224,15,1
2840 DATA 224,15,1,224,7,131,192,0

2850 rem sun smile
2860 DATA 0,16,0,1,17,0,1,17,0
2870 DATA 24,146,48,4,254,64,3,255,128
2880 DATA 199,255,198,55,183,216,15,147,224
2890 DATA 15,255,224,255,255,254,15,255,224
2900 DATA 14,254,224,55,57,216,199,199,198
2910 DATA 3,255,128,4,254,64,24,146,48
2920 DATA 1,17,0,1,17,0,0,16,0,0

2930 rem sun shock
2940 DATA 0,16,0,1,17,0,1,17,0
2950 DATA 24,146,48,4,254,64,3,255,128
2960 DATA 199,255,198,55,187,216,15,17,224
2970 DATA 15,187,224,255,255,254,15,199,224
2980 DATA 15,131,224,55,131,216,199,199,198
2990 DATA 3,255,128,4,254,64,24,146,48
3000 DATA 1,17,0,1,17,0,0,16,0,0

3010 REM right arrow
3020 DATA 0,0,0,8,0,0,12,0,0
3030 DATA 254,0,0,254,0,0,12,0,0
3040 DATA 8,0,0,0,0,0,0,0,0
3050 DATA 0,0,0,0,0,0,0,0,0
3060 DATA 0,0,0,0,0,0,0,0,0
3070 DATA 0,0,0,0,0,0,0,0,0
3080 DATA 0,0,0,0,0,0,0,0,0,0

3090 REM banana up
3100 DATA 0,0,0,0,0,0,0,0,0
3110 DATA 66,0,0,126,0,0,60,0,0
3120 DATA 0,0,0,0,0,0,0,0,0
3130 DATA 0,0,0,0,0,0,0,0,0
3140 DATA 0,0,0,0,0,0,0,0,0
3150 DATA 0,0,0,0,0,0,0,0,0
3160 DATA 0,0,0,0,0,0,0,0,0,0

3170 REM banana left
3180 DATA 0,0,0,24,0,0,12,0,0
3190 DATA 12,0,0,12,0,0,12,0,0
3200 DATA 24,0,0,0,0,0,0,0,0
3210 DATA 0,0,0,0,0,0,0,0,0
3220 DATA 0,0,0,0,0,0,0,0,0
3230 DATA 0,0,0,0,0,0,0,0,0
3240 DATA 0,0,0,0,0,0,0,0,0,0

3250 REM banana down
3260 DATA 0,0,0,0,0,0,60,0,0
3270 DATA 126,0,0,66,0,0,0,0,0
3280 DATA 0,0,0,0,0,0,0,0,0
3290 DATA 0,0,0,0,0,0,0,0,0
3300 DATA 0,0,0,0,0,0,0,0,0
3310 DATA 0,0,0,0,0,0,0,0,0
3320 DATA 0,0,0,0,0,0,0,0,0,0

3330 REM banana right
3340 DATA 0,0,0,24,0,0,48,0,0
3350 DATA 48,0,0,48,0,0,48,0,0
3360 DATA 24,0,0,0,0,0,0,0,0
3370 DATA 0,0,0,0,0,0,0,0,0
3380 DATA 0,0,0,0,0,0,0,0,0
3390 DATA 0,0,0,0,0,0,0,0,0
3395 DATA 0,0,0,0,0,0,0,0,0,0

3410 REM explosion 1
3420 DATA 0,0,0,0,0,0,0,0,0
3430 DATA 0,0,0,0,0,0,0,0,0
3440 DATA 0,0,0,0,0,0,0,0,0
3450 DATA 0,16,0,0,56,0,0,16,0
3460 DATA 0,0,0,0,0,0,0,0,0
3470 DATA 0,0,0,0,0,0,0,0,0
3480 DATA 0,0,0,0,0,0,0,0,0,0

3490 REM explosion 2
3500 DATA 0,0,0,0,0,0,0,0,0
3510 DATA 0,0,0,0,0,0,0,0,0
3520 DATA 0,0,0,0,0,0,0,16,0
3530 DATA 0,56,0,0,124,0,0,56,0
3540 DATA 0,16,0,0,0,0,0,0,0
3550 DATA 0,0,0,0,0,0,0,0,0
3560 DATA 0,0,0,0,0,0,0,0,0,0

3570 REM explosion 3
3580 DATA 0,0,0,0,0,0,0,0,0
3590 DATA 0,0,0,0,0,0,0,0,0
3600 DATA 0,24,0,0,126,0,0,126,0
3610 DATA 0,255,0,0,255,0,0,255,0
3620 DATA 0,126,0,0,126,0,0,24,0
3630 DATA 0,0,0,0,0,0,0,0,0
3640 DATA 0,0,0,0,0,0,0,0,0,0

3650 REM explosion 4
3660 DATA 0,0,0,0,0,0,0,0,0
3670 DATA 0,60,0,0,255,0,3,255,192
3680 DATA 3,255,192,7,255,224,7,255,224
3690 DATA 15,255,240,15,255,240,15,255,240
3700 DATA 15,255,240,7,255,224,7,255,224
3710 DATA 3,255,192,3,255,192,0,255,0
3720 DATA 0,60,0,0,0,0,0,0,0,0

3730 REM explosion 5
3740 DATA 0,0,0,0,126,0,1,255,128
3750 DATA 7,255,224,15,255,240,15,255,240
3760 DATA 31,255,248,31,255,248,63,255,252
3770 DATA 63,255,252,63,255,252,63,255,252
3780 DATA 63,255,252,63,255,252,31,255,248
3790 DATA 31,255,248,15,255,240,15,255,240
3800 DATA 7,255,224,1,255,128,0,126,0,0

3810 rem ## music data ##
3820 data 8,97,100,9,104,100,10,143,100
3830 data 9,104,100,8,97,100,9,104,100
3840 data 10,143,240,8,97,240,8,97,240
3850 data 0,0,0,15,210,133,0,0,75
3860 data 15,210,75,14,24,75,14,24,75
3870 data 0,0,75,15,210,75,0,0,75
3880 data 15,210,75,0,0,75,15,210,75
3890 data 14,24,75,14,24,75,14,24,75
3900 data 0,0,75,15,210,133,0,0,75
3910 data 15,210,75,14,24,75,14,24,75
3920 data 0,0,75,15,210,75,0,0,0
3930 data 0,0,300,19,239,133,0,0,75
3940 data 19,239,75,17,194,75,17,194,75
3950 data 0,0,75,19,239,75,0,0,75
3960 data 19,239,75,0,0,75,19,239,75
3970 data 17,194,75,17,194,75,17,194,75
3980 data 0,0,75,19,239,133,0,0,75
3990 data 19,239,75,17,194,75,17,194,75
4000 data 0,0,75,19,239,75,0,0,0
4010 data 0,0,300,23,181,133,0,0,75
4020 data 23,181,75,21,31,75,21,31,75
4030 data 0,0,75,23,181,75,0,0,75
4040 data 23,181,75,0,0,75,23,181,75
4050 data 21,31,75,21,31,75,21,31,75
4060 data 0,0,75,23,181,133,0,0,75
4070 data 23,181,75,21,31,75,21,31,75
4080 data 0,0,75,23,181,75,0,0,0
4090 data 0,0,300,31,165,133,0,0,75
4100 data 31,165,75,28,49,75,28,49,75
4110 data 0,0,75,23,181,75,0,0,75
4120 data 23,181,75,0,0,75,23,181,75
4130 data 21,31,75,21,31,75,21,31,75
4140 data 0,0,75,15,210,133,0,0,75
4150 data 15,210,75,14,24,75,14,24,75
4160 data 0,0,75,15,210,75,0,0,0
4170 data 5,71,48,5,152,48,6,71,48
4180 data 5,71,48,5,152,48,4,180,48
4190 data 4,48,48,0,0,0
4200 data 5,71,8,5,152,8,6,71,8
4210 data 5,71,8,5,152,8,4,180,8
4220 data 4,48,8,0,0,0,6,167,37
4230 data 4,48,18,7,233,75,7,119,18
4240 data 0,0,0

