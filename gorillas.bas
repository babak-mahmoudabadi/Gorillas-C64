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
42 y=11:tx$="Reading data...":gosub 116
44 gosub 594:rem read sprites data
46 gosub 540:rem init sound
48 gosub 68:rem  intro
50 gosub 152:rem get inputs
52 gosub 188:rem gorilla intro
54 gosub 272:rem play game
56 print chr$(147)
58 y=11:tx$="{purple}Would you like to play again?(y/n)":gosub 116
60 get k$:if k$="" then 60
62 if k$="y" then 50
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
106 m=1:gosub 572
108 gosub 124:rem call SparklePauserun
110 return

112 rem ## locate (x, y) ##
114 poke py,y: poke px,x:sys 58640:return

116 rem ## print at center (y, tx$) ##
118 poke py,y:poke px,20-(len(tx$)/2):sys 58732
120 print tx$;
122 return

124 rem ## sparkle pause ##
125 y=24:tx$= "Press any key to continue":gosub 116
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
148 if a > 5 then 134
150 goto 136

152 rem ## get inputs ##
154 print chr$(147)
156 poke 646,gray
158 y=6:x=0:gosub 114
160 input "Name of Player 1 (Default = 'Player 1') "; p1$
162 if p1$="" then p1$="Player 1"
164 p1$=left$(p1$, 10)
166 y=8:x=0:gosub 114
168 input "Name of Player 2 (Default = 'Player 2') "; p2$
170 if p2$="" then p2$="Player 2"
172 p2$=left$(p2$, 10)
174 y=10:x=0:gosub 114
176 input "Play to how many total points(Default=3)"; ng
178 if ng=0 then ng=3
180 y=12:x=0:gosub 114
182 input "Gravity in Meters/Sec (Earth = 9.8)     "; gr
184 if gr=0 then gr=9.8
186 return

188 rem ## gorilla intro ##
190 y=14:tx$= "--------------":gosub 116
192 y=16:tx$="V = View Intro":gosub 116
194 y=18:tx$="P = Play Game":gosub 116
196 y=20:tx$="Your Choice?":gosub 116
198 get k$:if k$="" then 198
200 if k$<>"v" then return
202 poke 53281,darkblue
204 poke 53280,darkblue
206 print chr$(147)
208 poke 646,white
210 y=2:tx$="G O R I L L A S":gosub 116
212 y=5:tx$="STARRING:":gosub 116
214 y=7:tx$=p1$ + " AND " + p2$:gosub 116
216 sp=1:b=0:x=140:y=160:c=8:gosub 254:rem set left gorilla
218 sp=2:b=0:x=190:y=160:c=8:gosub 254:rem set right gorilla
220 k=1
222 for t=1 to 1000:next
224 for m=2 to 5
226 k=1-k
228 poke 2041,sm+1+k:rem set bank
230 poke 2042,sm+2-k:rem set bank
232 gosub 572
234 next
236 for t=1 to 500:next
238 for n=1 to 4
240 k=1-k
242 poke 2041,sm+1+k:rem set bank
244 poke 2042,sm+2-k:rem set bank
246 m=6:gosub 572
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
268 poke v+21,peek(v+21) or (2^sp):rem enable sprite
270 return

272 rem ## play game ##
274 tw%(1)=0:tw%(2)=0
276 poke 53281,darkblue
278 poke 53280,darkblue
280 j=0
282 for g=1 to ng
284 print chr$(147)
286 poke 19,1:poke v+21,0
288 gosub 414:rem make city scape
290 gosub 512:rem place gorillas
292 sp=3:b=3:x=172:y=50:c=7:gosub 254:rem set sun happy
294 hit=0
296 poke 646,white
298 x=0:y=0:gosub 112:print p1$
300 x=40-len(p2$):y=0:gosub 112:print p2$
302 y=22:sa$=str$(tw%(1)):sb$=str$(tw%(2))
303 tx$=right$(sa$,len(sa$)-1)+">Score<"+right$(sb$,len(sb$)-1):gosub 116
304 x=0:y=0:gosub 112
305 p=j+1:gosub 318:rem do shot
306 j=1-j
307 if hit=0 then 296
308 next
309 poke v+21,0
310 poke 53281,0:poke 53280,0:poke 646,gray:print chr$(147)
311 y=8:tx$="GAME OVER!":gosub 116
312 y=10:tx$="Score:":gosub 116
313 y=11:tx$=p1$+"    "+str$(tw%(1)):gosub 116
314 y=12:tx$=p2$+"    "+str$(tw%(2)):gosub 116
315 y=24:tx$= "Press any key to continue":gosub 116
316 gosub 124
317 return

318 rem ## do shot (playernum) ##
320 poke 2040+3,sm+3:rem set sun smile
322 if p=1 then x=0
324 if p=2 then x=27
326 poke 646,3
328 y=1:gosub 112:input "Angle:";an
330 y=2:gosub 112:input "Velocity:";ve
332 if p=2 then an=180-an
334 x=0:y=0:gosub 112:print spc(120);
336 gosub 342
338 return

340 rem ## plot shot (angle, velocity, playernum)
342 poke 2040+p,sm+p:rem toss banana
344 m=8:gosub 572
346 poke 2040+p,sm:rem set bank
348 sp=4:b=6:c=7:x=xs(p):y=ys(p)-8
350 if p=2 then x=x+16
352 an=an/180*3.141592
354 poke v+39+sp,c:rem set color
356 x0=x:y0=y:ix=cos(an)*ve:iy=sin(an)*ve:w=1:t=0
358 yp=v+sp*2+1:xp=v+sp*2:pk=4
360 x=x0+(ix*t)+(.5*(w/5)*t*t):y=y0+((-1*(iy*t))+(.5*gr*t*t))*.6
362 if x>350 or x<18 then poke v+21,14:return
364 if y<0 then 388
366 poke v+21,14:poke xp,x and 255
368 if x<=255 then poke v+16,pk and 239
370 if x>255 then poke v+16,pk or 16:rem extra x-coordinate
372 poke yp,y
374 poke 2040+sp,sm+b:rem set bank
376 poke v+21,30
378 bp=1024+int((y-47)/8)*40+int((x-24)/8)
380 if peek(bp)<>32 and y>75 then poke v+21,14:poke bp,32:m=7:gosub 572:return
382 cs=peek(v+30)
384 if (cs and 8)<>0 then poke 2040+3,sm+4
386 if (cs and 22)>16 then hit=1:poke v+21,14:goto 392
388 t=t+.1:b=b+1:if b>9 then b=6
390 goto 360
392 hp=(cs and 6)/2:sp=0:b=10:x=xs(hp)-12:y=ys(hp):c=2:gosub 254:poke v+29,1:sn=1:m=7:gosub 576
394 for b=11 to 14
396 poke 2040,sm+b:gosub 578
398 next
400 ap=2-hp+1:poke v+21,8+ap*2
402 for n=1 to 4:rem victory dance
404 r=1-r:poke 2040+ap,sm+1+r:rem set bank
405 m=6:gosub 572
406 next
408 poke v+30,0
410 tw%(ap)=tw%(ap)+1
412 return

414 rem ## make city scape ##
416 l4$="{left}{left}{left}{left}{down}"
418 l5$="{left}{left}{left}{left}{left}{down}"
420 b$(0)="{cm i}{cm i}{cm i}{cm f}"+l4$
422 b$(1)="{cm i}{cm i}{cm i}{cm i}{cm f}"+l5$
424 b$(2)="{reverse on}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l4$
426 b$(3)="{reverse on}{cm c}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l5$
428 print chr$(147)
430 c$="{white}{cyan}{pink}{light blue}{light gray}"
432 bc=8
434 for i=0 to 9:w(i)=0:next
436 if fnran(10)>6 then bc=9:goto 446
438 for i=1 to 4
440 x=fnran(9)-1:if w(x)=1 then 440
442 w(x)=1
444 next
446 mh=17
448 ml=2
450 sl=fnran(4)
452 if sl=1 then h0=ml:a=1:rem upward slope
454 if sl=2 then h0=mh:a=-1:rem downward slope
456 if sl=3 then h0=mh:rem "v" slope
458 if sl=4 then h0=ml:rem Inverted "v" slope
460 bh=h0
462 for i=0 to bc
464 h(i)=bh
466 if sl=3 and i<5 then a=-1
468 if sl=3 and i>5 then a=1
470 if sl=4 and i>5 then a=-1
472 if sl=4 and i<5 then a=1
474 h0=h0+a
476 bh=h0+a*fnran(10)
478 if bh>mh then bh=mh
480 if bh<ml then bh=ml
482 next i
484 x=0
486 for i=0 to bc
488 y0=23-h(i)
490 cr$=mid$(c$,fnran(5),1)
492 k=0
494 y=y0:gosub 112
496 for y=y0 to 23
498 print cr$;b$(k+w(i));
500 k=2
502 next
504 x=x+4+w(i)
506 next
508 x=0:y=0:gosub 112
510 return

512 rem ## place gorillas #
514 n=fnran(2)
516 x0=(w(0)+4)*8:x1=0:aj=x0/(4+(1-w(0))*2)
518 if n=2 then x1=(w(1)+4)*8:aj=x1/(4+(1-w(1))*2)
520 x=x0+x1-aj:xs(1)=x
522 y=217-h(n-1)*8:ys(1)=y
524 sp=1:b=0:c=8:gosub 254:rem set gorilla
526 n=fnran(2)
528 x0=(w(bc)+4)*8:x1=0:aj=x0/(4+(1-w(bc))*2)
530 if n=2 then x1=(w(bc-1)+4)*8:aj=x1/(4+(1-w(bc-1))*2)
532 x=341-x0-x1+aj:xs(2)=x
534 y=217-h(bc+1-n)*8:ys(2)=y
536 sp=2:b=0:c=8:gosub 254:rem set gorilla
538 return

540 rem ## init sid ##
542 s=54272
544 wf=32
546 FOR sw=s to s+24:poke sw,0:next sw
548 POKE S+24,15
550 POKE S+2,0
552 POKE S+3,0
554 POKE S+5,0:rem ad
556 POKE S+6,240:rem sr
558 dim fh%(126):dim fl%(126):dim dr%(126):dim p%(8)
560 j=1:p%(j)=1:j=j+1
562 for i=1 to 126
564 read fh%(i), fl%(i), dr%(i)
566 if dr%(i)=0 and i<>126 then p%(j)=i+1:j=j+1
568 next
570 return

572 rem ## play seqment (m) ##
574 sn=0
576 q=p%(m)
578 if dr%(q)=0 then return
580 poke s,fl%(q):poke s+1,fh%(q)
582 poke s+4,wf+1
584 for t=1 to dr%(q):next
586 poke s+4,wf
588 q=q+1
590 if sn=1 then return
592 goto 578

594 REM ## read sprites data ##
596 for l=sm*64 to sm*64+64*15-1
598 read d:poke l,d
600 next
602 return

604 rem ## sprite data ##
606 rem gorilla
608 DATA 0,126,0,0,195,0,0,255
610 DATA 0,0,219,0,0,126,0,0
612 DATA 60,0,7,255,192,31,239,240
614 DATA 63,239,248,127,215,252,122,56
616 DATA 188,121,255,60,61,255,120,31
618 DATA 255,240,1,255,0,7,199,192
620 DATA 15,131,224,15,1,224,15,1
622 DATA 224,15,1,224,7,131,192,0
624 rem g left hand up
626 DATA 30,126,0,60,195,0,56,255
628 DATA 0,120,219,0,120,126,0,60
630 DATA 60,0,63,255,192,31,239,240
632 DATA 7,239,248,7,215,252,2,56
634 DATA 188,1,255,60,1,255,120,1
636 DATA 255,240,1,255,0,7,199,192
638 DATA 15,131,224,15,1,224,15,1
640 DATA 224,15,1,224,7,131,192,0
642 rem g right hand up
644 DATA 0,126,240,0,195,120,0,255
646 DATA 56,0,219,60,0,126,60,0
648 DATA 60,120,7,255,248,31,239,240
650 DATA 63,239,192,127,215,192,122,56
652 DATA 128,121,255,0,61,255,0,31
654 DATA 255,0,1,255,0,7,199,192
656 DATA 15,131,224,15,1,224,15,1
658 DATA 224,15,1,224,7,131,192,0
660 rem sun smile
662 DATA 0,16,0,1,17,0,1,17,0
664 DATA 24,146,48,4,254,64,3,255,128
666 DATA 199,255,198,55,183,216,15,147,224
668 DATA 15,255,224,255,255,254,15,255,224
670 DATA 14,254,224,55,57,216,199,199,198
672 DATA 3,255,128,4,254,64,24,146,48
674 DATA 1,17,0,1,17,0,0,16,0,0
676 rem sun shock
678 DATA 0,16,0,1,17,0,1,17,0
680 DATA 24,146,48,4,254,64,3,255,128
682 DATA 199,255,198,55,187,216,15,17,224
684 DATA 15,187,224,255,255,254,15,199,224
686 DATA 15,131,224,55,131,216,199,199,198
688 DATA 3,255,128,4,254,64,24,146,48
690 DATA 1,17,0,1,17,0,0,16,0,0
692 REM right arrow
694 DATA 0,0,0,8,0,0,12,0,0
696 DATA 254,0,0,254,0,0,12,0,0
698 DATA 8,0,0,0,0,0,0,0,0
700 DATA ,,,,,,,,
702 DATA ,,,,,,,,
704 DATA ,,,,,,,,
706 DATA ,,,,,,,,,
708 REM banana up
710 DATA ,,,,,,,,
712 DATA 66,0,0,126,0,0,60,0,0
714 DATA ,,,,,,,,
716 DATA ,,,,,,,,
718 DATA ,,,,,,,,
720 DATA ,,,,,,,,
722 DATA ,,,,,,,,,
724 REM banana left
726 DATA 0,0,0,24,0,0,12,0,0
728 DATA 12,0,0,12,0,0,12,0,0
730 DATA 24,0,0,0,0,0,0,0,0
732 DATA ,,,,,,,,
734 DATA ,,,,,,,,
736 DATA ,,,,,,,,
738 DATA ,,,,,,,,,
740 REM banana down
742 DATA 0,0,0,0,0,0,60,0,0
744 DATA 126,0,0,66,0,0,0,0,0
746 DATA ,,,,,,,,
748 DATA ,,,,,,,,
750 DATA ,,,,,,,,
752 DATA ,,,,,,,,
754 DATA ,,,,,,,,,
756 REM banana right
758 DATA 0,0,0,24,0,0,48,0,0
760 DATA 48,0,0,48,0,0,48,0,0
762 DATA 24,0,0,0,0,0,0,0,0
764 DATA ,,,,,,,,
766 DATA ,,,,,,,,
768 DATA ,,,,,,,,
770 DATA ,,,,,,,,,
772 REM explosion 1
774 DATA ,,,,,,,,
776 DATA ,,,,,,,,
778 DATA ,,,,,,,,
780 DATA 0,16,0,0,56,0,0,16,0
782 DATA ,,,,,,,,
784 DATA ,,,,,,,,
786 DATA ,,,,,,,,,
788 REM explosion 2
790 DATA ,,,,,,,,
792 DATA ,,,,,,,,
794 DATA 0,0,0,0,0,0,0,16,0
796 DATA 0,56,0,0,124,0,0,56,0
798 DATA 0,16,0,0,0,0,0,0,0
800 DATA ,,,,,,,,
802 DATA ,,,,,,,,,
804 REM explosion 3
806 DATA ,,,,,,,,
808 DATA ,,,,,,,,
810 DATA 0,24,0,0,126,0,0,126,0
812 DATA 0,255,0,0,255,0,0,255,0
814 DATA 0,126,0,0,126,0,0,24,0
816 DATA ,,,,,,,,
818 DATA ,,,,,,,,,
820 REM explosion 4
822 DATA ,,,,,,,,
824 DATA 0,60,0,0,255,0,3,255,192
826 DATA 3,255,192,7,255,224,7,255,224
828 DATA 15,255,240,15,255,240,15,255,240
830 DATA 15,255,240,7,255,224,7,255,224
832 DATA 3,255,192,3,255,192,0,255,0
834 DATA 0,6,,,,,,,,
836 REM explosion 5
838 DATA 0,0,0,0,126,0,1,255,128
840 DATA 7,255,224,15,255,240,15,255,240
842 DATA 31,255,248,31,255,248,63,255,252
844 DATA 63,255,252,63,255,252,63,255,252
846 DATA 63,255,252,63,255,252,31,255,248
848 DATA 31,255,248,15,255,240,15,255,240
850 DATA 7,255,224,1,255,128,0,126,0,0

852 rem ## music data ##
854 data 8,97,100,9,104,100,10,143,100
856 data 9,104,100,8,97,100,9,104,100
858 data 10,143,240,8,97,240,8,97,240
860 data 0,0,0,15,210,133,0,0,75
862 data 15,210,75,14,24,75,14,24,75
864 data 0,0,75,15,210,75,0,0,75
866 data 15,210,75,0,0,75,15,210,75
868 data 14,24,75,14,24,75,14,24,75
870 data 0,0,75,15,210,133,0,0,75
872 data 15,210,75,14,24,75,14,24,75
874 data 0,0,75,15,210,75,0,0,0
876 data 0,0,300,19,239,133,0,0,75
878 data 19,239,75,17,194,75,17,194,75
880 data 0,0,75,19,239,75,0,0,75
882 data 19,239,75,0,0,75,19,239,75
884 data 17,194,75,17,194,75,17,194,75
886 data 0,0,75,19,239,133,0,0,75
888 data 19,239,75,17,194,75,17,194,75
890 data 0,0,75,19,239,75,0,0,0
892 data 0,0,300,23,181,133,0,0,75
894 data 23,181,75,21,31,75,21,31,75
896 data 0,0,75,23,181,75,0,0,75
898 data 23,181,75,0,0,75,23,181,75
900 data 21,31,75,21,31,75,21,31,75
902 data 0,0,75,23,181,133,0,0,75
904 data 23,181,75,21,31,75,21,31,75
906 data 0,0,75,23,181,75,0,0,0
908 data 0,0,300,31,165,133,0,0,75
910 data 31,165,75,28,49,75,28,49,75
912 data 0,0,75,23,181,75,0,0,75
914 data 23,181,75,0,0,75,23,181,75
916 data 21,31,75,21,31,75,21,31,75
918 data 0,0,75,15,210,133,0,0,75
920 data 15,210,75,14,24,75,14,24,75
922 data 0,0,75,15,210,75,0,0,0
924 data 5,71,48,5,152,48,6,71,48
926 data 5,71,48,5,152,48,4,180,48
928 data 4,48,48,0,0,0,5,71,8
930 data 5,152,8,6,71,8,5,71,8
932 data 5,152,8,4,180,8,4,48,8
934 data 0,0,0,6,167,37,4,48,18
936 data 7,233,75,7,119,18,0,0,0