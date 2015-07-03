
////BBCUT PROCS\\\\

( //Preparation
~pbsfunc = 0.25; //Amount of modulation performed on the pitch.
~pbchance = 0.84;
)

//NOTE: Make a good dynamics-related control variable for pbchance!

//y=BBCut2(CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.4,pbchance:0.85)), BBCPPermute.new(2,12,4)).play(u);
w=BBCut2(CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.7,pbchance:0.25)), BBCPPermute.new(48,256,8,12)).play(q);

y.proc_(BBCutProc11.new);
y.proc_(SQPusher1.new);
y.proc_(SQPusher2.new);
y.proc_(WarpCutProc1.new);
y.proc_(BBCPPermute.new(12,2,4));
y.proc_(BBCPPermute.new(48,256,8,12));

w.proc_(BBCPPermute.new(4,12,4));
w.proc_(BBCPPermute.new(12,44,2,4));
w.proc_(BBCPPermute.new(28,56,2,2));

y.proc_(BBCPPermute.new(48,256,8,12));

w.stop;

//y.proc_



//CutMixer.new(bus, volume, ampfunc, panfunc)

//w=CutGroup([CutStream1.new,CutMixer(0,1.0,Line.kr(0,1,10,20),{1.0.rand2})], BBCutProc11.new).play;

(
y = BBCut2(CutGroup([CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.2,pbchance:0.95)),CutMixer(0,1.7,SQPushFXAmp2.new(0.1),CutPan1.new(0.2))]), BBCPPermute.new(3,64,8,4)).play(u);
)

y.stop;

(
w = BBCut2(CutGroup([CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.6,pbchance:0.65)),CutMixer(0,1.8,SQPushFXAmp2.new(0.5),CutPan1.new)]), BBCPPermute.new(48,6,8)).play(q);
)

w.stop;

w.proc_(BBCPPermute.new(48,64,3));


(
i = BBCut2(CutGroup([CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.6,pbchance:0.65)),CutMixer(0,2.5,SQPushFXAmp2.new(0.5),0)]), BBCPPermute.new(64,128,2,2)).play(r);
)

i.proc_(BBCPPermute.new(12,6,4,4));

i.stop;


y.proc_(BBCutProc11.new);

i.proc_(ChooseCutProc(5,3,2));

y.proc_(BBCPPermute.new(2,2,2.5,5));

y.proc_(WarpCutProc1.new);

y.proc_(BBCPPermute.new(64,128,2,3));

w.stop;

w.free;

y.stop;

i.stop;

i.free;
