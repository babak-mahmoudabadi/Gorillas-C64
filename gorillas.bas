10 rem ## gorillas ##
20 v=53248
30 py=214:px=211
40 home=19:down=17
50 left=157:right=29
60 black=0:white=1:red=2
70 darkblue=6:gray=15
80 ls=int(100/8)
90 poke 53272,23:rem set lower case
100 poke 53281,black:rem set black for background
110 poke 53280,black:rem set black for border
120 gosub 2490:rem read sprites data
130 gosub 210:rem set reading percent
140 gosub 1920:rem init sound
150 gosub 2090:rem read music data
160 gosub 250:rem call intro
170 gosub 930:rem get inputs
180 gosub 1110:rem gorilla intro
190 rem gosub 1620:rem play game
200 end

210 rem ## loading ##
220 lp=lp+ls:if lp>100 then lp=100
230 print chr$(147):y=11:text$="Reading data"+str$(lp)+"%":gosub 500
240 return

250 rem ## intro ##
260 print chr$(147):rem clear screen
270 print:print
280 poke 646,white
290 print spc(12);"G O R I L L A S"
300 poke 646,gray
310 print:print
320 print spc(3);"Copyright (c) IBM Corporation 1991"
330 print spc(2);"Ported for C64 by Babak Mahmoudabadi"
340 print
350 print spc(2);"Your mission is to hit your opponent"
360 print spc(2);"with the exploding banana by varying"
370 print spc(2);"the angle and power of your throw, "
380 print spc(2);"taking into account wind speed, "
390 print spc(2);"gravity, and the city skyline. The "
400 print spc(2);"wind speed is shown by a directional"
410 print spc(2);"arrow at the bottom of the playing"
420 print spc(2);"field, its length relative to its"
430 print spc(2);"strength."
440 print:print:print:print
450 print spc(7);"Press any key to continue"
460 gosub 540:rem call SparklePauserun
470 return

480 REM ## locate ##
490 POKE 214, Y: POKE 211,X: SYS 58640: RETURN

500 rem Print Center (y, text$)
510 poke py,y:poke px,20-(len(text$)/2):sys 58732
520 print text$;
530 return

540 rem ## sparkle pause ##
550 p=0:gosub 2400
560 for m=0 to 7
570 poke 2040+m,192
580 next
590 poke v+16,240
600 for i=0 to 6 step 2
610 poke v+i,24:next
620 for i=8 to 14 step 2
630 poke v+i,79:next
640 for i=39 to 46:poke v+i,red:next
650 p1=42+8
660 p2=42+8*6
670 p3=42+8*11
680 p4=42+8*16
690 q1=42+8*5
700 q2=42+8*10
710 q3=42+8*15
720 q4=42+8*20
730 a$ = "*    *    *    *    *    *    *    *    *    "
740 poke v+21,255
750 poke 646,red
760 a=1:k=0
770 z1=p1:z2=p2:z3=p3:z4=p4
780 w1=q1:w2=q2:w3=q3:w4=q4
790 print chr$(home);mid$(a$,a,40);
800 poke py,19:print
810 print mid$(a$,7-a,40);
820 poke v+1,z1:poke v+9,w1
830 poke v+3,z2:poke v+11,w2
840 poke v+5,z3:poke v+13,w3
850 poke v+7,z4:poke v+15,w4
860 get k$:if k$<>"" then poke v+21,0:return
870 a=a+1
880 if a>5 then 760
890 k=a-1
900 z1=z1+8:z2=z2+8:z3=z3+8:z4=z4+8
910 w1=w1-8:w2=w2-8:w3=w3-8:w4=w4-8
920 goto 790

930 rem ## get inputs ##
940 print chr$(147):rem clear screen
950 poke 646,gray
960 poke py,6:poke px,0:sys 58732
970 input "Name of Player 1 (Default = 'Player 1') "; p1$
980 if p1$="" then p1$="Player 1"
990 p1$=left$(p1$, 10)
1000 poke py,8:poke px,0:sys 58732
1010 input "Name of Player 2 (Default = 'Player 2') "; p2$
1020 if p2$="" then p2$="Player 2"
1030 p2$=left$(p2$, 10)
1040 poke py,10:poke px,0:sys 58732
1050 input "Play to how many total points(Default=3)"; numgames
1060 if numgames=0 then numgames=3
1070 poke py,12:poke px,0:sys 58732
1080 input "Gravity in Meters/Sec (Earth = 9.8)     "; gravity
1090 if gravity=0 then gravity=9.8
1100 return

1110 rem ## gorilla intro ##
1120 y=14:text$= "--------------":gosub 500
1130 y=16:text$="V = View Intro":gosub 500
1140 y=18:text$="P = Play Game":gosub 500
1150 y=20:text$="Your Choice?":gosub 500
1160 get k$:if k$="" then 1160
1170 if k$="p" then return
1180 poke 53281,darkblue:rem set blue for background
1190 poke 53280,darkblue:rem set blue for border
1200 print chr$(147):rem clear screen
1210 poke 646,white
1220 y=2:text$="G O R I L L A S":gosub 500
1230 y=5:text$="STARRING:":gosub 500
1240 y=7:text$=p1$ + " AND " + p2$:gosub 500
1250 sp=0:b=1:x=140:y=160:gosub 1530:rem set left gorilla
1260 sp=1:b=1:x=190:y=160:gosub 1530:rem set right gorilla
1270 k=0
1280 for t=1 to 1000:next
1290 k=1-k
1300 poke 2040,192+2+k:rem set bank
1310 poke 2041,192+3-k:rem set bank
1320 p=1:gosub 2400
1330 k=1-k
1340 poke 2040,192+2+k:rem set bank
1350 poke 2041,192+3-k:rem set bank
1360 p=2:gosub 2400
1370 k=1-k
1380 poke 2040,192+2+k:rem set bank
1390 poke 2041,192+3-k:rem set bank
1400 p=3:gosub 2400
1410 k=1-k
1420 poke 2040,192+2+k:rem set bank
1430 poke 2041,192+3-k:rem set bank
1440 p=4:gosub 2400
1450 for t=1 to 500:next
1460 for j=1 to 4
1470 k=1-k
1480 poke 2040,192+2+k:rem set bank
1490 poke 2041,192+3-k:rem set bank
1500 p=5:gosub 2400
1510 next
1520 return

1530 rem ## place gorilla (sp,b,x,y) ##
1540 poke v+39+sp,8:rem set color
1550 poke 2040+sp,192+b:rem set bank
1560 poke v+sp*2,x
1570 poke v+sp*2+1,y
1580 poke v+21,peek(v+21) or (2^sp):rem enable sprite
1590 return

1600 rem ## play game ##
1610 print chr$(147):rem clear screen
1620 poke 53281,darkblue:rem set blue for background
1630 poke 53280,darkblue:rem set blue for border
1640 poke 646,white
1650 poke v+21,0
1660 gosub 1680
1670 return

1680 rem ## make city scape ##
1690 l0=1944
1700 c0=56216
1710 l=l0
1720 c=c0
1730 w=int(rnd(0)*3)+3
1740 if l+w>1984 then w=1984-l-1
1750 h=int(rnd(0)*20)
1760 cr=int(rnd(0)*15)
1770 for i=0 to h
1780 for j=0 to w
1790 ch=252
1800 if j=w then ch=97
1810 if i=h then ch=98
1820 if j=w and i=h then ch=123
1830 poke l+j,ch
1840 poke c+j,cr
1850 next
1860 l=l-40:c=c-40
1870 next
1880 l0=l0+w+1
1890 c0=c0+w+1
1900 if l0<1984 then 1710
1910 return

1920 rem ## init sound ##
1930 f0=55
1940 d=4.101
1950 s=54272
1960 wf=32
1970 ad=0
1980 sr=240
1990 tm=1200
2000 ml=200:rem max notes
2010 nc=20:rem note count
2020 FOR sw=s to s+24:poke sw,0:next sw
2030 POKE S+24,15
2040 POKE S+2,0
2050 POKE S+3,0
2060 POKE S+5,ad
2070 POKE S+6,sr
2080 return

2090 rem ## read music data ##
2100 dim fh%(ml):dim fl%(ml):dim dr%(ml):dim m%(nc):m%(0)=0
2110 l=0:o=0:j=0:p=0
2120 read t$:rem print t$
2130 gosub 210:rem set reading percent
2140 if t$="end" then return
2150 i=1
2160 if i>len(t$) then 2120
2170 k=0
2180 a$=mid$(t$,i,1)
2190 n=asc(a$)-65
2200 b$=mid$(t$,i+1,1)
2210 bc$=mid$(t$,i+1,2)
2220 if a$=" " or a$="," then i=i+1:goto 2160
2230 if a$="." then i=i+1:j=j+1:p=p+1:m%(p)=j:goto 2160
2240 if a$="l" then l=int(tm/val(bc$)):i=i+3:goto 2160
2250 if a$="o" then o=val(b$):i=i+2:goto 2160
2260 if a$="a" or a$="b" then k=1
2270 if a$="b" or a$="c" then n=n+1
2280 if a$="d" then n=n+2
2290 if a$="e" or a$="f" then n=n+3
2300 if a$="g" then n=n+4
2310 if b$="+" or b$="#" then n=n+1:i=i+1
2320 if b$="-" then n=n-1:i=i+1
2330 n=n+(o+k)*12
2340 if a$="p" then f=0:goto 2360
2350 f=int(f0*2^(n/12)*d)
2360 fh%(j)=int(f/256):fl%(j)=int(f-256*fh%(j)):dr%(j)=l
2370 j=j+1
2380 i=i+1
2390 goto 2160

2400 rem ## play music ##
2410 i=m%(p)
2420 poke s,fl%(i):poke s+1,fh%(i):rem print fl%(i)+fh%(i)*256
2430 poke s+4,wf+1
2440 for t=1 to dr%(i):next
2450 poke s+4,wf
2460 i=i+1
2470 if dr%(i)<>0 then 2420
2480 return

2490 REM ### read sprites data ###
2500 for l=12288 to 12288+62+64*3
2510 read d:poke l,d
2520 next
2530 return

2540 rem ## asterisk sprite data ##
2550 DATA 0,0,0,102,0,0,60,0
2560 DATA 0,255,0,0,60,0,0,102
2570 DATA 0,0,0,0,0,0,0,0
2580 DATA 0,0,0,0,0,0,0,0
2590 DATA 0,0,0,0,0,0,0,0
2600 DATA 0,0,0,0,0,0,0,0
2610 DATA 0,0,0,0,0,0,0,0
2620 DATA 0,0,0,0,0,0,0,0
2630 DATA 0,126,0,0,195,0,0,255
2640 DATA 0,0,219,0,0,126,0,0
2650 DATA 60,0,7,255,192,31,239,240
2660 DATA 63,239,248,127,215,252,122,56
2670 DATA 188,121,255,60,61,255,120,31
2680 DATA 255,240,1,255,0,7,199,192
2690 DATA 15,131,224,15,1,224,15,1
2700 DATA 224,15,1,224,7,131,192,0
2710 DATA 0,126,240,0,195,120,0,255
2720 DATA 56,0,219,60,0,126,60,0
2730 DATA 60,120,7,255,248,31,239,240
2740 DATA 63,239,192,127,215,192,122,56
2750 DATA 128,121,255,0,61,255,0,31
2760 DATA 255,0,1,255,0,7,199,192
2770 DATA 15,131,224,15,1,224,15,1
2780 DATA 224,15,1,224,7,131,192,0
2790 DATA 30,126,0,60,195,0,56,255
2800 DATA 0,120,219,0,120,126,0,60
2810 DATA 60,0,63,255,192,31,239,240
2820 DATA 7,239,248,7,215,252,2,56
2830 DATA 188,1,255,60,1,255,120,1
2840 DATA 255,240,1,255,0,7,199,192
2850 DATA 15,131,224,15,1,224,15,1
2860 DATA 224,15,1,224,7,131,192,0

2870 data o3l12cdedcdl05ecc.
2880 data o3l09bl16pbaapbpbpbaaapl09bl16pbaapb.
2890 data o4l04pl09e-l16pe-d-d-pe-pe-pe-d-d-d-pl09e-l16pe-d-d-pe-.
2900 data o4l04pl09g-l16pg-eepg-pg-pg-eeepl09g-l16pg-eepg-.
2910 data o4l04pl09bl16pbaapg-pg-pg-eeepo3l09bl16pbaapb.
2920 data o2l25efgefdc.
2930 data end

