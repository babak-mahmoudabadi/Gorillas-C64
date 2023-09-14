10 rem ## gorillas ##
11 clr
12 def fn ran(x)=int(rnd(0)*x)+1
13 sm=241
14 v=53248
15 py=214:px=211
16 home=19:down=17
17 left=157:right=29
18 black=0:white=1:red=2
19 darkblue=6:gray=15
20 poke 53272,23:rem set lower case
21 poke v+21,0
22 poke 53281,black:rem set black for background
23 poke 53280,black:rem set black for border
24 poke 646,white
25 print chr$(147):y=11:text$="Reading data...":gosub 60
26 gosub 287:rem read sprites data
27 gosub 262:rem init sound
28 gosub 33:rem call intro
29 gosub 79:rem get inputs
30 gosub 97:rem gorilla intro
31 gosub 139:rem play game
32 end

33 rem ## intro ##
34 print chr$(147):rem clear screen
35 print:print
36 poke 646,white
37 print spc(12);"G O R I L L A S"
38 poke 646,gray
39 print:print
40 print spc(3);"Copyright (c) IBM Corporation 1991"
41 print spc(2);"Ported for C64 by Babak Mahmoudabadi"
42 print
43 print spc(2);"Your mission is to hit your opponent"
44 print spc(2);"with the exploding banana by varying"
45 print spc(2);"the angle and power of your throw, "
46 print spc(2);"taking into account wind speed, "
47 print spc(2);"gravity, and the city skyline. The "
48 print spc(2);"wind speed is shown by a directional"
49 print spc(2);"arrow at the bottom of the playing"
50 print spc(2);"field, its length relative to its"
51 print spc(2);"strength."
52 print:print:print:print
53 print spc(7);"Press any key to continue"
54 gosub 64:rem call SparklePauserun
55 return

56 REM ## locate ##
57 POKE 214, y: POKE 211,x
58 SYS 58640
59 RETURN

60 rem ## print at center (y, text$) ##
61 poke py,y:poke px,20-(len(text$)/2):sys 58732
62 print text$;
63 return

64 rem ## sparkle pause ##
65 m=1:gosub 278
66 h$="*    *    *    *    *    *    *    *    *    "
67 v$="{left}{down}*{left}{down} {left}{down} {left}{down} {left}{down} "
68 v$=v$+v$+v$+v$+v$
69 poke 646,red
70 a=1:b=1
71 print chr$(home);mid$(h$,a,40);
72 print mid$(v$,b,57)
73 print chr$(home);mid$(v$,21-b,57)
74 print mid$(h$,7-a,40);
75 a=a+1:b=b+3
76 get k$:if k$<>"" then return
77 if a > 5 then 70
78 goto 71

79 rem ## get inputs ##
80 print chr$(147):rem clear screen
81 poke 646,gray
82 poke py,6:poke px,0:sys 58732
83 input "Name of Player 1 (Default = 'Player 1') "; p1$
84 if p1$="" then p1$="Player 1"
85 p1$=left$(p1$, 10)
86 poke py,8:poke px,0:sys 58732
87 input "Name of Player 2 (Default = 'Player 2') "; p2$
88 if p2$="" then p2$="Player 2"
89 p2$=left$(p2$, 10)
90 poke py,10:poke px,0:sys 58732
91 input "Play to how many total points(Default=3)"; numgames
92 if numgames=0 then numgames=3
93 poke py,12:poke px,0:sys 58732
94 input "Gravity in Meters/Sec (Earth = 9.8)     "; gravity
95 if gravity=0 then gravity=9.8
96 return

97 rem ## gorilla intro ##
98 y=14:text$= "--------------":gosub 60
99 y=16:text$="V = View Intro":gosub 60
100 y=18:text$="P = Play Game":gosub 60
101 y=20:text$="Your Choice?":gosub 60
102 get k$:if k$="" then 102
103 if k$<>"v" then return
104 poke 53281,darkblue:rem set blue for background
105 poke 53280,darkblue:rem set blue for border
106 print chr$(147):rem clear screen
107 poke 646,white
108 y=2:text$="G O R I L L A S":gosub 60
109 y=5:text$="STARRING:":gosub 60
110 y=7:text$=p1$ + " AND " + p2$:gosub 60
111 sp=0:b=0:x=140:y=160:c=8:gosub 130:rem set left gorilla
112 sp=1:b=0:x=190:y=160:c=8:gosub 130:rem set right gorilla
113 k=1
114 for t=1 to 1000:next
115 for m=2 to 5
116 k=1-k
117 poke 2040,sm+1+k:rem set bank
118 poke 2041,sm+2-k:rem set bank
119 gosub 278
120 next
121 for t=1 to 500:next
122 for n=1 to 4
123 k=1-k
124 poke 2040,sm+1+k:rem set bank
125 poke 2041,sm+2-k:rem set bank
126 m=6:gosub 278
127 next
128 return

129 rem ## place sprite (sp,b,c,x,y) ##
130 poke v+39+sp,c:rem set color
131 poke 2040+sp,sm+b:rem set bank
132 xh=int(x/256):xl=x-256*xh
133 poke v+sp*2,xl
134 if xh=0 then poke v+16,peek(v+16) and (255-2^sp):rem extra x-coordinate
135 if xh=1 then poke v+16,peek(v+16) or (2^sp):rem extra x-coordinate
136 poke v+sp*2+1,y
137 poke v+21,peek(v+21) or (2^sp):rem enable sprite
138 return

139 rem ## play game ##
140 poke 53281,darkblue:rem set blue for background
141 poke 53280,darkblue:rem set blue for border
142 j=0
143 for g=1 to numgames
144 print chr$(147):rem clear screen
145 poke 19,1:poke v+21,0
146 hit=0
147 sp=0:b=3:x=172:y=50:c=7:gosub 130:rem set sun happy
148 gosub 199:rem make city scape
149 gosub 248:rem place gorillas
150 poke 646,white
151 x=0:y=0:gosub 56:print p1$
152 x=40-len(p2$):y=0:gosub 56:print p2$
153 y=22:sp1$=str$(tw(1)):sp2$=str$(tw(2))
154 text$=right$(sp1$,len(sp1$)-1)+">Score<"+right$(sp2$,len(sp2$)-1):gosub 60
155 x=0:y=0:gosub 56
156 p=j+1:gosub 161:rem do shot
157 j=1-j
158 if hit=0 then 156
159 next
160 return

161 rem ## do shot (playernum) ##
162 if p=1 then x=0
163 if p=2 then x=27
164 poke 646,3
165 y=1:gosub 56:input "Angle:";an
166 y=2:gosub 56:input "Velocity:";ve
167 if p=2 then an=180-an
168 y=1:gosub 56:print spc(80);
169 gosub 172
170 return

171 rem ## plot shot (angle, velocity, playernum)
172 poke 2040+p,sm+p:rem set bank
173 m=8:gosub 278
174 poke 2040+p,sm:rem set bank

175 sp=3:b=6:c=7:x=xs(p):y=ys(p)-8
176 if p=2 then x=x+16
177 an=an/180*3.141592
178 poke v+39+sp,c:rem set color
179 x0=x:y0=y:ix=cos(an)*ve:iy=sin(an)*ve:w=1:t=0
180 yp=v+sp*2+1:xp=v+sp*2:pk=4
181 x=x0+(ix*t)+(.5*(w/5)*t*t):y=y0+((-1*(iy*t))+(.5*gravity*t*t))*.6

182 if x>350 or x<18 then 197
183 if y<0 then 192
184 poke v+21,7:poke xp,x and 255
185 if x<=255 then poke v+16,pk and 247:rem extra x-coordinate
186 if x>255 then poke v+16,pk or 8:rem extra x-coordinate
187 poke yp,y
188 poke 2040+sp,sm+b:rem set bank
189 poke v+21,15

190 bp=1024+int((y-47)/8)*40+INT((x-24)/8):if peek(bp)<>32 and y>75 then poke bp,32:m=7:gosub 278:goto 197
191 cs=peek(v+30)
192 if (cs and 1)=1 then print "sun":end
193 if (cs and 2)=2 and p=1 then print "p1":end
194 if (cs and 2)=4 and p=2 then print "p2":end

195 t=t+.1:b=b+1:if b>9 then b=6
196 goto 181
197 poke v+21,7
198 return

199 rem ## make city scape ##
200 l4$="{left}{left}{left}{left}{down}"
201 l5$="{left}{left}{left}{left}{left}{down}"
202 b$(0)="{cm i}{cm i}{cm i}{cm f}"+l4$
203 b$(1)="{cm i}{cm i}{cm i}{cm i}{cm f}"+l5$
204 b$(2)="{reverse on}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l4$
205 b$(3)="{reverse on}{cm c}{cm c}{cm c}{cm c}{reverse off}{cm k}"+l5$
206 print chr$(147):rem clear screen
207 c$="{white}{cyan}{pink}{light blue}{light gray}"
208 bc=8
209 for i=0 to 9:w(i)=0:next
210 if fnran(10)>6 then bc=9:goto 215
211 for i=1 to 4
212 x=fnran(9)-1:if w(x)=1 then 212
213 w(x)=1
214 next
215 mh=17
216 ml=2
217 sl=fnran(4)
218 if sl=1 then h0=ml:a=1:rem upward slope
219 if sl=2 then h0=mh:a=-1:rem downward slope
220 if sl=3 then h0=mh:rem "v" slope
221 if sl=4 then h0=ml:rem Inverted "v" slope
222 bh=h0
223 for i=0 to bc
224 h(i)=bh
225 if sl=3 and i<5 then a=-1
226 if sl=3 and i>5 then a=1
227 if sl=4 and i>5 then a=-1
228 if sl=4 and i<5 then a=1
229 h0=h0+a
230 bh=h0+a*fnran(10)
231 if bh>mh then bh=mh
232 if bh<ml then bh=ml
233 next i
234 x=0
235 for i=0 to bc
236 y0=23-h(i)
237 cr$=mid$(c$,fnran(5),1)
238 k=0
239 y=y0:gosub 56
240 for y=y0 to 23
241 print cr$;b$(k+w(i));
242 k=2
243 next
244 x=x+4+w(i)
245 next
246 x=0:y=0:gosub 56
247 return

248 rem ## place gorillas #
249 n=fnran(2)
250 x0=(w(0)+4)*8:x1=0:aj=x0/(4+(1-w(0))*2)
251 if n=2 then x1=(w(1)+4)*8:aj=x1/(4+(1-w(1))*2)
252 x=x0+x1-aj:xs(1)=x
253 y=217-h(n-1)*8:ys(1)=y
254 sp=1:b=0:c=8:gosub 130:rem set gorilla
255 n=fnran(2)
256 x0=(w(bc)+4)*8:x1=0:aj=x0/(4+(1-w(bc))*2)
257 if n=2 then x1=(w(bc-1)+4)*8:aj=x1/(4+(1-w(bc-1))*2)
258 x=341-x0-x1+aj:xs(2)=x
259 y=217-h(bc+1-n)*8:ys(2)=y
260 sp=2:b=0:c=8:gosub 130:rem set gorilla
261 return

262 rem ## init sid ##
263 s=54272
264 wf=32
265 FOR sw=s to s+24:poke sw,0:next sw
266 POKE S+24,15
267 POKE S+2,0
268 POKE S+3,0
269 POKE S+5,0:rem ad
270 POKE S+6,240:rem sr
271 dim fh%(126):dim fl%(126):dim dr%(126):dim p%(8)
272 j=2
273 for i=1 to 126
274 read fh%(i), fl%(i), dr%(i)
275 if dr%(i)=0 and i<>126 then p%(j)=i+1:j=j+1
276 next
277 return

278 rem ## play seqment (m) ##
279 q=p%(m)
280 poke s,fl%(q):poke s+1,fh%(q)
281 poke s+4,wf+1
282 for t=1 to dr%(q):next
283 poke s+4,wf
284 q=q+1
285 if dr%(q)<>0 then 280
286 return

287 REM ## read sprites data ##
288 for l=sm*64 to sm*64+64*15-1
289 read d:poke l,d
290 next
291 return

292 rem ## sprite data ##
293 rem gorilla
294 DATA 0,126,0,0,195,0,0,255
295 DATA 0,0,219,0,0,126,0,0
296 DATA 60,0,7,255,192,31,239,240
297 DATA 63,239,248,127,215,252,122,56
298 DATA 188,121,255,60,61,255,120,31
299 DATA 255,240,1,255,0,7,199,192
300 DATA 15,131,224,15,1,224,15,1
301 DATA 224,15,1,224,7,131,192,0
302 rem g left hand up
303 DATA 30,126,0,60,195,0,56,255
304 DATA 0,120,219,0,120,126,0,60
305 DATA 60,0,63,255,192,31,239,240
306 DATA 7,239,248,7,215,252,2,56
307 DATA 188,1,255,60,1,255,120,1
308 DATA 255,240,1,255,0,7,199,192
309 DATA 15,131,224,15,1,224,15,1
310 DATA 224,15,1,224,7,131,192,0
311 rem g right hand up
312 DATA 0,126,240,0,195,120,0,255
313 DATA 56,0,219,60,0,126,60,0
314 DATA 60,120,7,255,248,31,239,240
315 DATA 63,239,192,127,215,192,122,56
316 DATA 128,121,255,0,61,255,0,31
317 DATA 255,0,1,255,0,7,199,192
318 DATA 15,131,224,15,1,224,15,1
319 DATA 224,15,1,224,7,131,192,0
320 rem sun smile
321 DATA 0,16,0,1,17,0,1,17,0
322 DATA 24,146,48,4,254,64,3,255,128
323 DATA 199,255,198,55,183,216,15,147,224
324 DATA 15,255,224,255,255,254,15,255,224
325 DATA 14,254,224,55,57,216,199,199,198
326 DATA 3,255,128,4,254,64,24,146,48
327 DATA 1,17,0,1,17,0,0,16,0,0
328 rem sun shock
329 DATA 0,16,0,1,17,0,1,17,0
330 DATA 24,146,48,4,254,64,3,255,128
331 DATA 199,255,198,55,187,216,15,17,224
332 DATA 15,187,224,255,255,254,15,199,224
333 DATA 15,131,224,55,131,216,199,199,198
334 DATA 3,255,128,4,254,64,24,146,48
335 DATA 1,17,0,1,17,0,0,16,0,0
336 REM right arrow
337 DATA 0,0,0,8,0,0,12,0,0
338 DATA 254,0,0,254,0,0,12,0,0
339 DATA 8,0,0,0,0,0,0,0,0
340 DATA 0,0,0,0,0,0,0,0,0
341 DATA 0,0,0,0,0,0,0,0,0
342 DATA 0,0,0,0,0,0,0,0,0
343 DATA 0,0,0,0,0,0,0,0,0,0
344 REM banana up
345 DATA 0,0,0,0,0,0,0,0,0
346 DATA 66,0,0,126,0,0,60,0,0
347 DATA 0,0,0,0,0,0,0,0,0
348 DATA 0,0,0,0,0,0,0,0,0
349 DATA 0,0,0,0,0,0,0,0,0
350 DATA 0,0,0,0,0,0,0,0,0
351 DATA 0,0,0,0,0,0,0,0,0,0
352 REM banana left
353 DATA 0,0,0,24,0,0,12,0,0
354 DATA 12,0,0,12,0,0,12,0,0
355 DATA 24,0,0,0,0,0,0,0,0
356 DATA 0,0,0,0,0,0,0,0,0
357 DATA 0,0,0,0,0,0,0,0,0
358 DATA 0,0,0,0,0,0,0,0,0
359 DATA 0,0,0,0,0,0,0,0,0,0
360 REM banana down
361 DATA 0,0,0,0,0,0,60,0,0
362 DATA 126,0,0,66,0,0,0,0,0
363 DATA 0,0,0,0,0,0,0,0,0
364 DATA 0,0,0,0,0,0,0,0,0
365 DATA 0,0,0,0,0,0,0,0,0
366 DATA 0,0,0,0,0,0,0,0,0
367 DATA 0,0,0,0,0,0,0,0,0,0
368 REM banana right
369 DATA 0,0,0,24,0,0,48,0,0
370 DATA 48,0,0,48,0,0,48,0,0
371 DATA 24,0,0,0,0,0,0,0,0
372 DATA 0,0,0,0,0,0,0,0,0
373 DATA 0,0,0,0,0,0,0,0,0
374 DATA 0,0,0,0,0,0,0,0,0
375 DATA 0,0,0,0,0,0,0,0,0,0
376 REM explosion 1
377 DATA 0,0,0,0,0,0,0,0,0
378 DATA 0,0,0,0,0,0,0,0,0
379 DATA 0,0,0,0,0,0,0,0,0
380 DATA 0,16,0,0,56,0,0,16,0
381 DATA 0,0,0,0,0,0,0,0,0
382 DATA 0,0,0,0,0,0,0,0,0
383 DATA 0,0,0,0,0,0,0,0,0,0
384 REM explosion 2
385 DATA 0,0,0,0,0,0,0,0,0
386 DATA 0,0,0,0,0,0,0,0,0
387 DATA 0,0,0,0,0,0,0,16,0
388 DATA 0,56,0,0,124,0,0,56,0
389 DATA 0,16,0,0,0,0,0,0,0
390 DATA 0,0,0,0,0,0,0,0,0
391 DATA 0,0,0,0,0,0,0,0,0,0
392 REM explosion 3
393 DATA 0,0,0,0,0,0,0,0,0
394 DATA 0,0,0,0,0,0,0,0,0
395 DATA 0,24,0,0,126,0,0,126,0
396 DATA 0,255,0,0,255,0,0,255,0
397 DATA 0,126,0,0,126,0,0,24,0
398 DATA 0,0,0,0,0,0,0,0,0
399 DATA 0,0,0,0,0,0,0,0,0,0
400 REM explosion 4
401 DATA 0,0,0,0,0,0,0,0,0
402 DATA 0,60,0,0,255,0,3,255,192
403 DATA 3,255,192,7,255,224,7,255,224
404 DATA 15,255,240,15,255,240,15,255,240
405 DATA 15,255,240,7,255,224,7,255,224
406 DATA 3,255,192,3,255,192,0,255,0
407 DATA 0,60,0,0,0,0,0,0,0,0
408 REM explosion 5
409 DATA 0,0,0,0,126,0,1,255,128
410 DATA 7,255,224,15,255,240,15,255,240
411 DATA 31,255,248,31,255,248,63,255,252
412 DATA 63,255,252,63,255,252,63,255,252
413 DATA 63,255,252,63,255,252,31,255,248
414 DATA 31,255,248,15,255,240,15,255,240
415 DATA 7,255,224,1,255,128,0,126,0,0

416 rem ## music data ##
417 data 8,97,100,9,104,100,10,143,100
418 data 9,104,100,8,97,100,9,104,100
419 data 10,143,240,8,97,240,8,97,240
420 data 0,0,0,15,210,133,0,0,75
421 data 15,210,75,14,24,75,14,24,75
422 data 0,0,75,15,210,75,0,0,75
423 data 15,210,75,0,0,75,15,210,75
424 data 14,24,75,14,24,75,14,24,75
425 data 0,0,75,15,210,133,0,0,75
426 data 15,210,75,14,24,75,14,24,75
427 data 0,0,75,15,210,75,0,0,0
428 data 0,0,300,19,239,133,0,0,75
429 data 19,239,75,17,194,75,17,194,75
430 data 0,0,75,19,239,75,0,0,75
431 data 19,239,75,0,0,75,19,239,75
432 data 17,194,75,17,194,75,17,194,75
433 data 0,0,75,19,239,133,0,0,75
434 data 19,239,75,17,194,75,17,194,75
435 data 0,0,75,19,239,75,0,0,0
436 data 0,0,300,23,181,133,0,0,75
437 data 23,181,75,21,31,75,21,31,75
438 data 0,0,75,23,181,75,0,0,75
439 data 23,181,75,0,0,75,23,181,75
440 data 21,31,75,21,31,75,21,31,75
441 data 0,0,75,23,181,133,0,0,75
442 data 23,181,75,21,31,75,21,31,75
443 data 0,0,75,23,181,75,0,0,0
444 data 0,0,300,31,165,133,0,0,75
445 data 31,165,75,28,49,75,28,49,75
446 data 0,0,75,23,181,75,0,0,75
447 data 23,181,75,0,0,75,23,181,75
448 data 21,31,75,21,31,75,21,31,75
449 data 0,0,75,15,210,133,0,0,75
450 data 15,210,75,14,24,75,14,24,75
451 data 0,0,75,15,210,75,0,0,0
452 data 5,71,48,5,152,48,6,71,48
453 data 5,71,48,5,152,48,4,180,48
454 data 4,48,48,0,0,0,5,71,8
455 data 5,152,8,6,71,8,5,71,8
456 data 5,152,8,4,180,8,4,48,8
457 data 0,0,0,6,167,37,4,48,18
458 data 7,233,75,7,119,18,0,0,0