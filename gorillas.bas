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
34 poke 53281,black:rem set black for background
36 poke 53280,black:rem set black for border
38 poke 646,white
40 print chr$(147):y=11:tx$="Reading data...":gosub 110
42 gosub 564:rem read sprites data
44 gosub 514:rem init sound
46 gosub 56:rem  intro
48 gosub 148:rem get inputs
50 gosub 184:rem gorilla intro
52 gosub 268:rem play game
54 end

56 rem ## intro ##
58 print chr$(147):rem clear screen
60 print:print
64 print spc(12);"{white}G O R I L L A S"
68 print:print
70 print spc(3);"{gray}Copyright (c) IBM Corporation 1991"
72 print spc(2);"Ported for C64 by Babak Mahmoudabadi"
74 print
76 print spc(2);"Your mission is to hit your opponent"
78 print spc(2);"with the exploding banana by varying"
80 print spc(2);"the angle and power of your throw, "
82 print spc(2);"taking into account wind speed, "
84 print spc(2);"gr, and the city skyline. The "
86 print spc(2);"wind speed is shown by a directional"
88 print spc(2);"arrow at the bottom of the playing"
90 print spc(2);"field, its length relative to its"
92 print spc(2);"strength."
94 print:print:print:print
96 print spc(7);"Press any key to continue"
97 m=1:gosub 546
98 gosub 118:rem call SparklePauserun
100 return

102 rem ## locate (x, y) ##
104 poke py,y: poke px,x:sys 58640:return

110 rem ## print at center (y, tx$) ##
112 poke py,y:poke px,20-(len(tx$)/2):sys 58732
114 print tx$;
116 return

118 rem ## sparkle pause ##
122 h$="*    *    *    *    *    *    *    *    *    "
124 v$="{left}{down}*{left}{down} {left}{down} {left}{down} {left}{down} "
126 v$=v$+v$+v$+v$+v$
128 poke 646,red
130 a=1:b=1
132 print chr$(home);mid$(h$,a,40);
134 print mid$(v$,b,57)
136 print chr$(home);mid$(v$,21-b,57)
138 print mid$(h$,7-a,40);
140 a=a+1:b=b+3
142 get k$:if k$<>"" then return
144 if a > 5 then 130
146 goto 132

148 rem ## get inputs ##
150 print chr$(147):rem clear screen
152 poke 646,gray
154 y=6:x=0:gosub 104
156 input "Name of Player 1 (Default='Player 1')   "; p1$
158 if p1$="" then p1$="Player 1"
160 p1$=left$(p1$, 10)
162 y=8:x=0:gosub 104
164 input "Name of Player 2 (Default='Player 2')   "; p2$
166 if p2$="" then p2$="Player 2"
168 p2$=left$(p2$, 10)
170 y=10:x=0:gosub 104
172 input "Play to how many total points(Default=3)"; ng
174 if ng=0 then ng=3
176 y=12:x=0:gosub 104
178 input "Gravity in Meters/Sec (Earth=9.8)       "; gr
180 if gr=0 then gr=9.8
182 return

184 rem ## gorilla intro ##
186 y=14:tx$= "--------------":gosub 110
188 y=16:tx$="V = View Intro":gosub 110
190 y=18:tx$="P = Play Game":gosub 110
192 y=20:tx$="Your Choice?":gosub 110
194 get k$:if k$="" then 194
196 if k$<>"v" then return
198 poke 53281,darkblue:rem set blue for background
200 poke 53280,darkblue:rem set blue for border
202 print chr$(147):rem clear screen
204 poke 646,white
206 y=2:tx$="G O R I L L A S":gosub 110
208 y=5:tx$="STARRING:":gosub 110
210 y=7:tx$=p1$ + " AND " + p2$:gosub 110
212 sp=1:b=0:x=140:y=160:c=8:gosub 250:rem set left gorilla
214 sp=2:b=0:x=190:y=160:c=8:gosub 250:rem set right gorilla
216 k=1
218 for t=1 to 1000:next
220 for m=2 to 5
222 k=1-k
224 poke 2041,sm+1+k:rem set bank
226 poke 2042,sm+2-k:rem set bank
228 gosub 546
230 next
232 for t=1 to 500:next
234 for n=1 to 4
236 k=1-k
238 poke 2041,sm+1+k:rem set bank
240 poke 2042,sm+2-k:rem set bank
242 m=6:gosub 546
244 next
246 return

248 rem ## place sprite (sp,b,c,x,y) ##
250 poke v+39+sp,c:rem set color
252 poke 2040+sp,sm+b:rem set bank
254 xh=int(x/256):xl=x-256*xh
256 poke v+sp*2,xl
258 if xh=0 then poke v+16,peek(v+16) and (255-2^sp):rem extra x-coordinate
260 if xh=1 then poke v+16,peek(v+16) or (2^sp):rem extra x-coordinate
262 poke v+sp*2+1,y
264 poke v+21,peek(v+21) or (2^sp):rem enable sprite
266 return

268 rem ## play game ##
269 sc%(1)=0:sc%(2)=0
270 poke 53281,darkblue:rem set blue for background
272 poke 53280,darkblue:rem set blue for border
274 j=0
276 for g=1 to ng
278 print chr$(147):rem clear screen
280 poke 19,1:poke v+21,0
282 hit=0
284 sp=3:b=3:x=172:y=50:c=7:gosub 250:rem set sun happy
286 gosub 388:rem make city scape
288 gosub 486:rem place gorillas
290 poke 646,white
292 x=0:y=0:gosub 102:print p1$
294 x=40-len(p2$):y=0:gosub 102:print p2$
296 y=22:so$=str$(sc%(1)):st$=str$(sc%(2))
297 tx$=right$(so$,len(so$)-1)+">Score<"+right$(st$,len(st$)-1):gosub 110
300 x=0:y=0:gosub 102
302 p=j+1:gosub 312:rem do shot
304 j=1-j
306 if hit=0 then 302
308 next
310 return

312 rem ## do shot (playernum) ##
313 poke 2040+3,sm+3:rem set sun smile
314 if p=1 then x=0
316 if p=2 then x=27
318 poke 646,3
320 y=1:gosub 102:input "Angle:";an
322 y=2:gosub 102:input "Velocity:";ve
324 if p=2 then an=180-an
326 y=1:gosub 102:print spc(80);
328 gosub 334
330 return

332 rem ## plot shot (angle, velocity, playernum)
334 poke 2040+p,sm+p:rem toss banana
336 m=8:gosub 546
338 poke 2040+p,sm:rem set bank
340 sp=4:b=6:c=7:x=xs(p):y=ys(p)-8
342 if p=2 then x=x+16
344 an=an/180*3.141592
346 poke v+39+sp,c:rem set color
348 x0=x:y0=y:ix=cos(an)*ve:iy=sin(an)*ve:w=1:t=0
350 yp=v+sp*2+1:xp=v+sp*2:pk=4
352 x=x0+(ix*t)+(.5*(w/5)*t*t):y=y0+((-1*(iy*t))+(.5*gr*t*t))*.6
354 if x>350 or x<18 then poke v+21,14:return
356 if y<0 then 376
358 poke v+21,14:poke xp,x and 255
359 rem get k$:if k$="" then 359
360 if x<=255 then poke v+16,pk and 239:rem extra x-coordinate
362 if x>255 then poke v+16,pk or 16:rem extra x-coordinate
364 poke yp,y
366 poke 2040+sp,sm+b:rem set bank
368 poke v+21,30
369 bp=1024+int((y-47)/8)*40+int((x-24)/8)
370 if peek(bp)<>32 and y>75 then poke v+21,14:poke bp,32:m=7:gosub 546:return
372 cs=peek(v+30)
374 if (cs and 8)<>0 then poke 2040+3,sm+4 
375 if (cs and 22)>16 then hit=1:poke v+21,14:goto 378
376 t=t+.1:b=b+1:if b>9 then b=6
377 goto 352
378 rem print cs:stop
379 hp=(cs and 6)/2:sp=0:b=10:x=xs(hp)-12:y=ys(hp):c=2:gosub 250:poke v+29,1:sn=1:m=7:gosub 548 
380 for b=11 to 14
381 poke 2040,sm+b:gosub 549 
382 next
383 ap=2-hp+1:poke v+21,8+ap*2
384 for n=1 to 4
385 r=1-r:poke 2040+ap,sm+1+r:m=6:gosub 546:rem set bank
386 next
387 poke v+30,0:sc%(ap)=sc%(ap)+1:return

388 rem ## make city scape ##
390 l4$="{left}{left}{left}{left}{down}"
392 l5$="{left}{left}{left}{left}{left}{down}"
394 b$(0)="{cm i}{cm i}{cm i}{cm f}"+l4$
396 b$(1)="{cm i}{cm i}{cm i}{cm i}{cm f}"+l5$
398 b$(2)="{reverse on}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l4$
400 b$(3)="{reverse on}{cm c}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l5$
402 print chr$(147):rem clear screen
404 c$="{white}{cyan}{pink}{light blue}{light gray}"
406 bc=8
408 for i=0 to 9:w(i)=0:next
410 if fnran(10)>6 then bc=9:goto 420
412 for i=1 to 4
414 x=fnran(9)-1:if w(x)=1 then 414
416 w(x)=1
418 next
420 mh=17
422 ml=2
424 sl=fnran(4)
426 if sl=1 then h0=ml:a=1:rem upward slope
428 if sl=2 then h0=mh:a=-1:rem downward slope
430 if sl=3 then h0=mh:rem "v" slope
432 if sl=4 then h0=ml:rem Inverted "v" slope
434 bh=h0
436 for i=0 to bc
438 h(i)=bh
440 if sl=3 and i<5 then a=-1
442 if sl=3 and i>5 then a=1
444 if sl=4 and i>5 then a=-1
446 if sl=4 and i<5 then a=1
448 h0=h0+a
450 bh=h0+a*fnran(10)
452 if bh>mh then bh=mh
454 if bh<ml then bh=ml
456 next i
458 x=0
460 for i=0 to bc
462 y0=23-h(i)
464 cr$=mid$(c$,fnran(5),1)
466 k=0
468 y=y0:gosub 102
470 for y=y0 to 23
472 print cr$;b$(k+w(i));
474 k=2
476 next
478 x=x+4+w(i)
480 next
482 x=0:y=0:gosub 102
484 return

486 rem ## place gorillas #
488 n=fnran(2)
490 x0=(w(0)+4)*8:x1=0:aj=x0/(4+(1-w(0))*2)
492 if n=2 then x1=(w(1)+4)*8:aj=x1/(4+(1-w(1))*2)
494 x=x0+x1-aj:xs(1)=x
496 y=217-h(n-1)*8:ys(1)=y
498 sp=1:b=0:c=8:gosub 250:rem set gorilla
500 n=fnran(2)
502 x0=(w(bc)+4)*8:x1=0:aj=x0/(4+(1-w(bc))*2)
504 if n=2 then x1=(w(bc-1)+4)*8:aj=x1/(4+(1-w(bc-1))*2)
506 x=341-x0-x1+aj:xs(2)=x
508 y=217-h(bc+1-n)*8:ys(2)=y
510 sp=2:b=0:c=8:gosub 250:rem set gorilla
512 return

514 rem ## init sid ##
516 s=54272
518 wf=32
520 FOR sw=s to s+24:poke sw,0:next sw
522 POKE S+24,15
524 POKE S+2,0
526 POKE S+3,0
528 POKE S+5,0:rem ad
530 POKE S+6,240:rem sr
532 dim fh%(126):dim fl%(126):dim dr%(126):dim p%(8)
534 j=1:p%(j)=1:j=j+1
536 for i=1 to 126
538 read fh%(i), fl%(i), dr%(i)
540 if dr%(i)=0 and i<>126 then p%(j)=i+1:j=j+1
542 next
544 return

546 rem ## play seqment (m) ##
547 sn=0
548 q=p%(m)
549 if dr%(q)=0 then return
550 poke s,fl%(q):poke s+1,fh%(q)
552 poke s+4,wf+1
554 for t=1 to dr%(q):next
556 poke s+4,wf
558 q=q+1
560 if sn=1 then return
562 goto 549

564 REM ## read sprites data ##
566 for l=sm*64 to sm*64+64*15-1
568 read d:poke l,d
570 next
572 return

574 rem ## sprite data ##
576 rem gorilla
578 DATA 0,126,0,0,195,0,0,255
580 DATA 0,0,219,0,0,126,0,0
582 DATA 60,0,7,255,192,31,239,240
584 DATA 63,239,248,127,215,252,122,56
586 DATA 188,121,255,60,61,255,120,31
588 DATA 255,240,1,255,0,7,199,192
590 DATA 15,131,224,15,1,224,15,1
592 DATA 224,15,1,224,7,131,192,0
594 rem g left hand up
596 DATA 30,126,0,60,195,0,56,255
598 DATA 0,120,219,0,120,126,0,60
600 DATA 60,0,63,255,192,31,239,240
602 DATA 7,239,248,7,215,252,2,56
604 DATA 188,1,255,60,1,255,120,1
606 DATA 255,240,1,255,0,7,199,192
608 DATA 15,131,224,15,1,224,15,1
610 DATA 224,15,1,224,7,131,192,0
612 rem g right hand up
614 DATA 0,126,240,0,195,120,0,255
616 DATA 56,0,219,60,0,126,60,0
618 DATA 60,120,7,255,248,31,239,240
620 DATA 63,239,192,127,215,192,122,56
622 DATA 128,121,255,0,61,255,0,31
624 DATA 255,0,1,255,0,7,199,192
626 DATA 15,131,224,15,1,224,15,1
628 DATA 224,15,1,224,7,131,192,0
630 rem sun smile
632 DATA 0,16,0,1,17,0,1,17,0
634 DATA 24,146,48,4,254,64,3,255,128
636 DATA 199,255,198,55,183,216,15,147,224
638 DATA 15,255,224,255,255,254,15,255,224
640 DATA 14,254,224,55,57,216,199,199,198
642 DATA 3,255,128,4,254,64,24,146,48
644 DATA 1,17,0,1,17,0,0,16,0,0
646 rem sun shock
648 DATA 0,16,0,1,17,0,1,17,0
650 DATA 24,146,48,4,254,64,3,255,128
652 DATA 199,255,198,55,187,216,15,17,224
654 DATA 15,187,224,255,255,254,15,199,224
656 DATA 15,131,224,55,131,216,199,199,198
658 DATA 3,255,128,4,254,64,24,146,48
660 DATA 1,17,0,1,17,0,0,16,0,0
662 REM right arrow
664 DATA 0,0,0,8,0,0,12,0,0
666 DATA 254,0,0,254,0,0,12,0,0
668 DATA 8,0,0,0,0,0,0,0,0
670 DATA ,,,,,,,,
672 DATA ,,,,,,,,
674 DATA ,,,,,,,,
676 DATA ,,,,,,,,,
678 REM banana up
680 DATA ,,,,,,,,
682 DATA 66,0,0,126,0,0,60,0,0
684 DATA ,,,,,,,,
686 DATA ,,,,,,,,
688 DATA ,,,,,,,,
690 DATA ,,,,,,,,
692 DATA ,,,,,,,,,
694 REM banana left
696 DATA 0,0,0,24,0,0,12,0,0
698 DATA 12,0,0,12,0,0,12,0,0
700 DATA 24,0,0,0,0,0,0,0,0
702 DATA ,,,,,,,,
704 DATA ,,,,,,,,
706 DATA ,,,,,,,,
708 DATA ,,,,,,,,,
710 REM banana down
712 DATA 0,0,0,0,0,0,60,0,0
714 DATA 126,0,0,66,0,0,0,0,0
716 DATA ,,,,,,,,
718 DATA ,,,,,,,,
720 DATA ,,,,,,,,
722 DATA ,,,,,,,,
724 DATA ,,,,,,,,,
726 REM banana right
728 DATA 0,0,0,24,0,0,48,0,0
730 DATA 48,0,0,48,0,0,48,0,0
732 DATA 24,0,0,0,0,0,0,0,0
734 DATA ,,,,,,,,
736 DATA ,,,,,,,,
738 DATA ,,,,,,,,
740 DATA ,,,,,,,,,
742 REM explosion 1
744 DATA ,,,,,,,,
746 DATA ,,,,,,,,
748 DATA ,,,,,,,,
750 DATA 0,16,0,0,56,0,0,16,0
752 DATA ,,,,,,,,
754 DATA ,,,,,,,,
756 DATA ,,,,,,,,,
758 REM explosion 2
760 DATA ,,,,,,,,
762 DATA ,,,,,,,,
764 DATA 0,0,0,0,0,0,0,16,0
766 DATA 0,56,0,0,124,0,0,56,0
768 DATA 0,16,0,0,0,0,0,0,0
770 DATA ,,,,,,,,
772 DATA ,,,,,,,,,
774 REM explosion 3
776 DATA ,,,,,,,,
778 DATA ,,,,,,,,
780 DATA 0,24,0,0,126,0,0,126,0
782 DATA 0,255,0,0,255,0,0,255,0
784 DATA 0,126,0,0,126,0,0,24,0
786 DATA ,,,,,,,,
788 DATA ,,,,,,,,,
790 REM explosion 4
792 DATA ,,,,,,,,
794 DATA 0,60,0,0,255,0,3,255,192
796 DATA 3,255,192,7,255,224,7,255,224
798 DATA 15,255,240,15,255,240,15,255,240
800 DATA 15,255,240,7,255,224,7,255,224
802 DATA 3,255,192,3,255,192,0,255,0
804 DATA 0,6,,,,,,,,
806 REM explosion 5
808 DATA 0,0,0,0,126,0,1,255,128
810 DATA 7,255,224,15,255,240,15,255,240
812 DATA 31,255,248,31,255,248,63,255,252
814 DATA 63,255,252,63,255,252,63,255,252
816 DATA 63,255,252,63,255,252,31,255,248
818 DATA 31,255,248,15,255,240,15,255,240
820 DATA 7,255,224,1,255,128,0,126,0,0

822 rem ## music data ##
824 data 8,97,100,9,104,100,10,143,100
826 data 9,104,100,8,97,100,9,104,100
828 data 10,143,240,8,97,240,8,97,240
830 data 0,0,0,15,210,133,0,0,75
832 data 15,210,75,14,24,75,14,24,75
834 data 0,0,75,15,210,75,0,0,75
836 data 15,210,75,0,0,75,15,210,75
838 data 14,24,75,14,24,75,14,24,75
840 data 0,0,75,15,210,133,0,0,75
842 data 15,210,75,14,24,75,14,24,75
844 data 0,0,75,15,210,75,0,0,0
846 data 0,0,300,19,239,133,0,0,75
848 data 19,239,75,17,194,75,17,194,75
850 data 0,0,75,19,239,75,0,0,75
852 data 19,239,75,0,0,75,19,239,75
854 data 17,194,75,17,194,75,17,194,75
856 data 0,0,75,19,239,133,0,0,75
858 data 19,239,75,17,194,75,17,194,75
860 data 0,0,75,19,239,75,0,0,0
862 data 0,0,300,23,181,133,0,0,75
864 data 23,181,75,21,31,75,21,31,75
866 data 0,0,75,23,181,75,0,0,75
868 data 23,181,75,0,0,75,23,181,75
870 data 21,31,75,21,31,75,21,31,75
872 data 0,0,75,23,181,133,0,0,75
874 data 23,181,75,21,31,75,21,31,75
876 data 0,0,75,23,181,75,0,0,0
878 data 0,0,300,31,165,133,0,0,75
880 data 31,165,75,28,49,75,28,49,75
882 data 0,0,75,23,181,75,0,0,75
884 data 23,181,75,0,0,75,23,181,75
886 data 21,31,75,21,31,75,21,31,75
888 data 0,0,75,15,210,133,0,0,75
890 data 15,210,75,14,24,75,14,24,75
892 data 0,0,75,15,210,75,0,0,0
894 data 5,71,48,5,152,48,6,71,48
896 data 5,71,48,5,152,48,4,180,48
898 data 4,48,48,0,0,0,5,71,8
900 data 5,152,8,6,71,8,5,71,8
902 data 5,152,8,4,180,8,4,48,8
904 data 0,0,0,6,167,37,4,48,18
906 data 7,233,75,7,119,18,0,0,0