10 rem ## gorillas ##
12 clr
14 def fn ran(x)=int(rnd(0)*x)+1
16 sm=241
18 v=53248
20 py=214:px=211
22 home=19:down=17
24 left=157:right=29
26 black=0:white=1:red=2
28 darkblue=6:gray=15
30 poke 53272,23:rem set lower case
32 poke v+21,0
34 poke 53281,black
36 poke 53280,black
38 poke 646,white
40 print chr$(147)
42 y=11:tx$="Reading data...":gosub 114
44 gosub 632:rem read sprites data
46 gosub 578:rem init sound
48 gosub 68:rem  intro
50 gosub 152:rem get inputs
52 gosub 188:rem gorilla intro
54 gosub 272:rem play game
56 print chr$(147)
58 y=11:tx$="{purple}Would you like to play again?(y/n)":gosub 114
60 get k$:if k$="" then 60
62 if k$="y" or k$=chr$(13) then 50
64 print chr$(147)
66 end

68 rem ## intro ##
70 print chr$(147)
72 print:print
74 print spc(12);"{white}G O R I L L A S"
76 print:print
78 print spc(3);"{gray}Copyright (c) IBM Corporation 1991"
80 print spc(2);"Ported for C64 by Babak Mahmoudabadi"
82 print
84 print spc(2);"Your mission is to hit your opponent"
86 print spc(2);"with the exploding banana by varying"
88 print spc(2);"the angle and power of your throw, "
90 print spc(2);"taking into account wind speed, "
92 print spc(2);"gr, and the city skyline. The "
94 print spc(2);"wind speed is shown by a directional"
96 print spc(2);"arrow at the bottom of the playing"
98 print spc(2);"field, its length relative to its"
100 print spc(2);"strength."
102 m=1:gosub 610
104 gosub 122:rem call SparklePause
106 return

108 rem ## locate (x, y) ##
110 poke py,y: poke px,x:sys 58640
112 return

114 rem ## print at center (y, tx$) ##
116 poke py,y:poke px,20-(len(tx$)/2):sys 58732
118 print tx$;
120 return

122 rem ## sparkle pause ##
124 y=24:tx$= "Press any key to continue":gosub 114
126 h$="*    *    *    *    *    *    *    *    *    "
128 v$="{left}{down}*{left}{down} {left}{down} {left}{down} {left}{down} "
130 v$=v$+v$+v$+v$+v$
132 poke 646,red
134 a=1:b=1
136 print chr$(home);mid$(h$,a,40);
138 print mid$(v$,b,57)
140 print chr$(home);mid$(v$,21-b,57)
142 print mid$(h$,7-a,40);
144 a=a+1:b=b+3
146 get k$:if k$<>"" then return
148 if a>5 then 134
150 goto 136

152 rem ## get inputs ##
154 print chr$(147)
156 poke 646,gray
158 y=6:x=0:gosub 110
160 input "Name of Player 1 (Default = 'Player 1') "; p1$
162 if p1$="" then p1$="Player 1"
164 p1$=left$(p1$, 10)
166 y=8:x=0:gosub 110
168 input "Name of Player 2 (Default = 'Player 2') "; p2$
170 if p2$="" then p2$="Player 2"
172 p2$=left$(p2$, 10)
174 y=10:x=0:gosub 110
176 input "Play to how many total points(Default=3)"; ng
178 if ng=0 then ng=3
180 y=12:x=0:gosub 110
182 input "Gravity in Meters/Sec (Earth = 9.8)     "; gr
184 if gr=0 then gr=9.8
186 return

188 rem ## gorilla intro ##
190 y=14:tx$= "--------------":gosub 114
192 y=16:tx$="V = View Intro":gosub 114
194 y=18:tx$="P = Play Game":gosub 114
196 y=20:tx$="Your Choice?":gosub 114
198 get k$:if k$="" then 198
200 if k$<>"v" then return
202 poke 53281,darkblue
204 poke 53280,darkblue
206 print chr$(147)
208 poke 646,white
210 y=2:tx$="G O R I L L A S":gosub 114
212 y=5:tx$="STARRING:":gosub 114
214 y=7:tx$=p1$ + " AND " + p2$:gosub 114
216 sp=1:b=0:x=140:y=160:c=8:gosub 254:rem set left hand
218 sp=2:b=0:x=190:y=160:c=8:gosub 254:rem set right hand
220 k=1
222 for t=1 to 1000:next
224 for m=2 to 5
226 k=1-k
228 poke 2041,sm+1+k
230 poke 2042,sm+2-k
232 gosub 610
234 next
236 for t=1 to 500:next
238 for n=1 to 4
240 k=1-k
242 poke 2041,sm+1+k
244 poke 2042,sm+2-k
246 m=6:gosub 610
248 next
250 return

252 rem ## place sprite (sp,b,c,x,y) ##
254 poke v+39+sp,c:rem set color
256 poke 2040+sp,sm+b:rem set bank
258 xh=int(x/256):xl=x-256*xh
260 poke v+sp*2,xl
262 if xh=0 then poke v+16,peek(v+16) and (255-2^sp)
264 if xh=1 then poke v+16,peek(v+16) or (2^sp):rem extra x-coordinate
266 poke v+sp*2+1,y
268 poke v+21,peek(v+21)or(2^sp):rem enable sprite
270 return

272 rem ## play game ##
274 tw%(1)=0:tw%(2)=0
276 poke 53281,darkblue
278 poke 53280,darkblue
280 j=0
282 for g=1 to ng
284 print chr$(147)
286 poke 19,1:poke v+21,0
288 gosub 432:rem make city scape
290 gosub 550:rem place gorillas
292 sp=3:b=3:x=172:y=50:c=7:gosub 254:rem sun smile
294 hit=0
296 poke 646,white
298 x=0:y=0:gosub 108:print p1$
300 x=40-len(p2$):y=0:gosub 108:print p2$
302 y=22:sa$=str$(tw%(1)):sb$=str$(tw%(2))
304 tx$=right$(sa$,len(sa$)-1)+">Score<"+right$(sb$,len(sb$)-1):gosub 114
306 x=0:y=0:gosub 108
308 p=j+1:gosub 334:rem do shot
310 j=1-j
312 if hit=0 then 296
314 next
316 poke v+21,0
318 poke 53281,0:poke 53280,0:poke 646,gray:print chr$(147)
320 y=8:tx$="GAME OVER!":gosub 114
322 y=10:tx$="Score:":gosub 114
324 y=11:tx$=p1$+"    "+str$(tw%(1)):gosub 114
326 y=12:tx$=p2$+"    "+str$(tw%(2)):gosub 114
330 gosub 122
332 return

334 rem ## do shot (playernum) ##
336 poke 2040+3,sm+3:rem sun smile
338 if p=1 then x=0
340 if p=2 then x=27
342 poke 646,3
344 y=1:gosub 108:input "Angle:";an
346 y=2:gosub 108:input "Velocity:";ve
348 if p=2 then an=180-an
350 x=0:y=0:gosub 108:print spc(120);
352 gosub 357
354 return

356 rem ## plot shot (angle, velocity, playernum)
357 rw=0:if wd>0 then rw=32
358 poke 2040+p,sm+p:rem toss banana
360 m=8:gosub 610
362 poke 2040+p,sm
364 sp=4:b=6:c=7:x=xs(p):y=ys(p)-8
366 if p=2 then x=x+16
368 an=an/180*3.141592
370 poke v+39+sp,c:rem set color
372 x0=x:y0=y:ix=cos(an)*ve:iy=sin(an)*ve:t=0
374 yp=v+sp*2+1:xp=v+sp*2:pk=4
376 x=x0+(ix*t)+(.5*(wd/5)*t*t):y=y0+((-1*(iy*t))+(.5*gr*t*t))*.6
378 if x>350 or x<18 then poke v+21,14+rw:return
380 if y<0 then 404
382 poke v+21,14+rw:poke xp,x and 255
384 if x<=255 then poke v+16,pk and 239
386 if x>255 then poke v+16,pk or 16:rem extra x-coordinate
388 poke yp,y
390 poke 2040+sp,sm+b
392 poke v+21,30+rw
394 bp=1024+int((y-47)/8)*40+int((x-24)/8)
396 if peek(bp)<>32 and y>75 then poke v+21,14+rw:poke bp,32:m=7:gosub 610:return
398 cs=peek(v+30)
400 if (cs and 8)<>0 then poke 2040+3,sm+4
402 if (cs and 22)>16 then hit=1:poke v+21,14+rw:goto 408
404 t=t+.1:b=b+1:if b>9 then b=6
406 goto 376
408 hp=(cs and 6)/2:sp=0:b=10:x=xs(hp)-12:y=ys(hp):c=2:gosub 254:poke v+29,1
409 sn=1:m=7:gosub 614
410 for b=11 to 14
412 poke 2040,sm+b:gosub 616
414 next
416 ap=2-hp+1:poke v+21,8+ap*2+rw
418 for n=1 to 4:rem victory dance
420 r=1-r:poke 2040+ap,sm+1+r
422 m=6:gosub 610
424 next
426 poke v+30,0
428 tw%(ap)=tw%(ap)+1
430 return

432 rem ## make city scape ##
434 l4$="{left}{left}{left}{left}{down}"
436 l5$="{left}{left}{left}{left}{left}{down}"
438 b$(0)="{cm i}{cm i}{cm i}{cm f}"+l4$
440 b$(1)="{cm i}{cm i}{cm i}{cm i}{cm f}"+l5$
442 b$(2)="{reverse on}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l4$
444 b$(3)="{reverse on}{cm c}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l5$
446 print chr$(147)
448 c$="{white}{cyan}{pink}{light blue}{light gray}"
450 bc=8
452 for i=0 to 9:w(i)=0:next
454 if fnran(10)>6 then bc=9:goto 464
456 for i=1 to 4
458 x=fnran(9)-1:if w(x)=1 then 458
460 w(x)=1
462 next
464 mh=17
466 ml=2
468 sl=fnran(4)
470 if sl=1 then h0=ml:a=1:rem upward slope
472 if sl=2 then h0=mh:a=-1:rem downward slope
474 if sl=3 then h0=mh:rem "v" slope
476 if sl=4 then h0=ml:rem Inverted "v" slope
478 bh=h0
480 for i=0 to bc
482 h(i)=bh
484 if sl=3 and i<5 then a=-1
486 if sl=3 and i>5 then a=1
488 if sl=4 and i>5 then a=-1
490 if sl=4 and i<5 then a=1
492 h0=h0+a
494 bh=h0+a*fnran(10)
496 if bh>mh then bh=mh
498 if bh<ml then bh=ml
500 next i
502 x=0
504 for i=0 to bc
506 y0=23-h(i)
508 cr$=mid$(c$,fnran(5),1)
510 k=0
512 y=y0:gosub 108
514 for y=y0 to 23
516 print cr$;b$(k+w(i));
518 k=2
520 next
522 x=x+4+w(i)
524 next
526 x=0:y=0:gosub 108
528 wd=fnran(10)-5
530 if fnran(3)<>1 then 536
532 if wd>0 then wd=wd+fnran(10)
534 if wd<=0 then wd=wd-fnran(10)
536 if wd=0 then return
538 poke 646,4
540 ln$="{192}{192}{192}{192}{192}":ln$=ln$+ln$+ln$:tx$=mid$(ln$,1,abs(wd))
542 if wd<0 then tx$="{arrow left}"+tx$
544 if wd>0 then tx$=tx$+" ":sp=5:b=5:x=24+(19+int(len(tx$)/2))*8:y=242:c=4:gosub 254
546 y=24:gosub 114
548 return

550 rem ## place gorillas #
552 n=fnran(2)
554 x0=(w(0)+4)*8:x1=0:aj=x0/(4+(1-w(0))*2)
556 if n=2 then x1=(w(1)+4)*8:aj=x1/(4+(1-w(1))*2)
558 x=x0+x1-aj:xs(1)=x
560 y=217-h(n-1)*8:ys(1)=y
562 sp=1:b=0:c=8:gosub 254:rem set gorilla
564 n=fnran(2)
566 x0=(w(bc)+4)*8:x1=0:aj=x0/(4+(1-w(bc))*2)
568 if n=2 then x1=(w(bc-1)+4)*8:aj=x1/(4+(1-w(bc-1))*2)
570 x=341-x0-x1+aj:xs(2)=x
572 y=217-h(bc+1-n)*8:ys(2)=y
574 sp=2:b=0:c=8:gosub 254:rem set gorilla
576 return

578 rem ## init sid ##
580 s=54272
582 wf=32
584 FOR sw=s to s+24:poke sw,0:next sw
586 POKE S+24,15
588 POKE S+2,0
590 POKE S+3,0
592 POKE S+5,0:rem ad
594 POKE S+6,240:rem sr
596 dim fh%(126):dim fl%(126):dim dr%(126):dim p%(8)
598 j=1:p%(j)=1:j=j+1
600 for i=1 to 126
602 read fh%(i), fl%(i), dr%(i)
604 if dr%(i)=0 and i<>126 then p%(j)=i+1:j=j+1
606 next
608 return

610 rem ## play seqment (m) ##
612 sn=0
614 q=p%(m)
616 if dr%(q)=0 then return
618 poke s,fl%(q):poke s+1,fh%(q)
620 poke s+4,wf+1
622 for t=1 to dr%(q):next
624 poke s+4,wf
626 q=q+1
628 if sn=1 then return
630 goto 616

632 REM ## read sprites data ##
634 for l=sm*64 to sm*64+64*15-1
636 read d:poke l,d
638 next
640 return

642 rem ## sprite data ##
646 DATA 0,126,0,0,195,0,0,255
648 DATA 0,0,219,0,0,126,0,0
650 DATA 60,0,7,255,192,31,239,240
652 DATA 63,239,248,127,215,252,122,56
654 DATA 188,121,255,60,61,255,120,31
656 DATA 255,240,1,255,0,7,199,192
658 DATA 15,131,224,15,1,224,15,1
660 DATA 224,15,1,224,7,131,192,0
664 DATA 30,126,0,60,195,0,56,255
666 DATA 0,120,219,0,120,126,0,60
668 DATA 60,0,63,255,192,31,239,240
670 DATA 7,239,248,7,215,252,2,56
672 DATA 188,1,255,60,1,255,120,1
674 DATA 255,240,1,255,0,7,199,192
676 DATA 15,131,224,15,1,224,15,1
678 DATA 224,15,1,224,7,131,192,0
682 DATA 0,126,240,0,195,120,0,255
684 DATA 56,0,219,60,0,126,60,0
686 DATA 60,120,7,255,248,31,239,240
688 DATA 63,239,192,127,215,192,122,56
690 DATA 128,121,255,0,61,255,0,31
692 DATA 255,0,1,255,0,7,199,192
694 DATA 15,131,224,15,1,224,15,1
696 DATA 224,15,1,224,7,131,192,0
700 DATA 0,16,0,1,17,0,1,17,0
702 DATA 24,146,48,4,254,64,3,255,128
704 DATA 199,255,198,55,183,216,15,147,224
706 DATA 15,255,224,255,255,254,15,255,224
708 DATA 14,254,224,55,57,216,199,199,198
710 DATA 3,255,128,4,254,64,24,146,48
712 DATA 1,17,0,1,17,0,0,16,0,0
716 DATA 0,16,0,1,17,0,1,17,0
718 DATA 24,146,48,4,254,64,3,255,128
720 DATA 199,255,198,55,187,216,15,17,224
722 DATA 15,187,224,255,255,254,15,199,224
724 DATA 15,131,224,55,131,216,199,199,198
726 DATA 3,255,128,4,254,64,24,146,48
728 DATA 1,17,0,1,17,0,0,16,0,0
732 DATA 0,0,0,8,0,0,12,0,0
734 DATA 254,0,0,254,0,0,12,0,0
736 DATA 8,0,0,0,0,0,0,0,0
738 DATA ,,,,,,,,
740 DATA ,,,,,,,,
742 DATA ,,,,,,,,
744 DATA ,,,,,,,,,
748 DATA ,,,,,,,,
750 DATA 66,0,0,126,0,0,60,0,0
752 DATA ,,,,,,,,
754 DATA ,,,,,,,,
756 DATA ,,,,,,,,
758 DATA ,,,,,,,,
760 DATA ,,,,,,,,,
764 DATA 0,0,0,24,0,0,12,0,0
766 DATA 12,0,0,12,0,0,12,0,0
768 DATA 24,0,0,0,0,0,0,0,0
770 DATA ,,,,,,,,
772 DATA ,,,,,,,,
774 DATA ,,,,,,,,
776 DATA ,,,,,,,,,
780 DATA 0,0,0,0,0,0,60,0,0
782 DATA 126,0,0,66,0,0,0,0,0
784 DATA ,,,,,,,,
786 DATA ,,,,,,,,
788 DATA ,,,,,,,,
790 DATA ,,,,,,,,
792 DATA ,,,,,,,,,
796 DATA 0,0,0,24,0,0,48,0,0
798 DATA 48,0,0,48,0,0,48,0,0
800 DATA 24,0,0,0,0,0,0,0,0
802 DATA ,,,,,,,,
804 DATA ,,,,,,,,
806 DATA ,,,,,,,,
808 DATA ,,,,,,,,,
812 DATA ,,,,,,,,
814 DATA ,,,,,,,,
816 DATA ,,,,,,,,
818 DATA 0,16,0,0,56,0,0,16,0
820 DATA ,,,,,,,,
822 DATA ,,,,,,,,
824 DATA ,,,,,,,,,
828 DATA ,,,,,,,,
830 DATA ,,,,,,,,
832 DATA 0,0,0,0,0,0,0,16,0
834 DATA 0,56,0,0,124,0,0,56,0
836 DATA 0,16,0,0,0,0,0,0,0
838 DATA ,,,,,,,,
840 DATA ,,,,,,,,,
844 DATA ,,,,,,,,
846 DATA ,,,,,,,,
848 DATA 0,24,0,0,126,0,0,126,0
850 DATA 0,255,0,0,255,0,0,255,0
852 DATA 0,126,0,0,126,0,0,24,0
854 DATA ,,,,,,,,
856 DATA ,,,,,,,,,
860 DATA ,,,,,,,,
862 DATA 0,60,0,0,255,0,3,255,192
864 DATA 3,255,192,7,255,224,7,255,224
866 DATA 15,255,240,15,255,240,15,255,240
868 DATA 15,255,240,7,255,224,7,255,224
870 DATA 3,255,192,3,255,192,0,255,0
872 DATA 0,6,,,,,,,,
876 DATA 0,0,0,0,126,0,1,255,128
878 DATA 7,255,224,15,255,240,15,255,240
880 DATA 31,255,248,31,255,248,63,255,252
882 DATA 63,255,252,63,255,252,63,255,252
884 DATA 63,255,252,63,255,252,31,255,248
886 DATA 31,255,248,15,255,240,15,255,240
888 DATA 7,255,224,1,255,128,0,126,0,0

890 rem ## music data ##
892 data 8,97,100,9,104,100,10,143,100
894 data 9,104,100,8,97,100,9,104,100
896 data 10,143,240,8,97,240,8,97,240
898 data 0,0,0,15,210,133,0,0,75
900 data 15,210,75,14,24,75,14,24,75
902 data 0,0,75,15,210,75,0,0,75
904 data 15,210,75,0,0,75,15,210,75
906 data 14,24,75,14,24,75,14,24,75
908 data 0,0,75,15,210,133,0,0,75
910 data 15,210,75,14,24,75,14,24,75
912 data 0,0,75,15,210,75,0,0,0
914 data 0,0,300,19,239,133,0,0,75
916 data 19,239,75,17,194,75,17,194,75
918 data 0,0,75,19,239,75,0,0,75
920 data 19,239,75,0,0,75,19,239,75
922 data 17,194,75,17,194,75,17,194,75
924 data 0,0,75,19,239,133,0,0,75
926 data 19,239,75,17,194,75,17,194,75
928 data 0,0,75,19,239,75,0,0,0
930 data 0,0,300,23,181,133,0,0,75
932 data 23,181,75,21,31,75,21,31,75
934 data 0,0,75,23,181,75,0,0,75
936 data 23,181,75,0,0,75,23,181,75
938 data 21,31,75,21,31,75,21,31,75
940 data 0,0,75,23,181,133,0,0,75
942 data 23,181,75,21,31,75,21,31,75
944 data 0,0,75,23,181,75,0,0,0
946 data 0,0,300,31,165,133,0,0,75
948 data 31,165,75,28,49,75,28,49,75
950 data 0,0,75,23,181,75,0,0,75
952 data 23,181,75,0,0,75,23,181,75
954 data 21,31,75,21,31,75,21,31,75
956 data 0,0,75,15,210,133,0,0,75
958 data 15,210,75,14,24,75,14,24,75
960 data 0,0,75,15,210,75,0,0,0
962 data 5,71,48,5,152,48,6,71,48
964 data 5,71,48,5,152,48,4,180,48
966 data 4,48,48,0,0,0,5,71,8
968 data 5,152,8,6,71,8,5,71,8
970 data 5,152,8,4,180,8,4,48,8
972 data 0,0,0,6,167,37,4,48,18
974 data 7,233,75,7,119,18,0,0,0