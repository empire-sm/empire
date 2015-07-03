
( //setup vars

///OUTS///
~effect.ar;


///CONTROLS///
~lev1 = 0.1/~ampVal;
~lev2 = ~lev1 * 2.5;

~mic1 = {Pan2.ar(AudioIn.ar(1),0,1.25)}; //lets feed this into its own channel where it can hurt nobody

)

~mic1.play;

~verb.play;

~mic1 = {Pan2.ar(AudioIn.ar(1),0,1.25)};

~effect.play;
~effect.release(5);








~m1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.2, [2.25,1.5],~spec,~ampVal*1.25),12,32),8000),0,1.8)};

~m1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.5, (7/5)/4,~ampVal),4,32),13000),0,1.5)};


~m1.play;

~m1.release(15);


~m3 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),[0.2,1.1], 5/4,~ampVal/0.25,~spec),14,64),19000),0,1.35)};

~m3.play;

~m3.release(5);

~m3 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),[0.2,1.5], (10/5)/4,~ampVal/1.5),4,12),19000),0,1.5)};

~l1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.35, 0.125),34,22),300),0,1.8)}; //test synth
~l1.play;


~l2 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.1, 1.25),22,12),11000),0,Line.kr(1.2,2,3,0.5))};
~l2.play;


~m1.play;
~m1.stop;

~l1.stop;


~m2.play;

f = Routine.run({
	loop({
		1.25.wait;
~effect.read(~l2); //read synth into mix var -- does it work? can we get a second one in?
		1.5.wait;
		~effect.read(~m1);
	})
});


f.stop;


g = Routine.run({
	loop({
		1.25.wait;
~effect.read(~l1); //read synth into mix var -- does it work? can we get a second one in?
		1.5.wait;
		~effect.read(~m3);
	})
});


g.stop;




~out_sub2.play;
~out_sub2 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.2, 0.125),4,18),300),0,0.95)};

~out_h1.release(10);
~out_h3.release(30);
~m1.release(11);




~out_h3.play;
~out_h3 = {Pan2.ar(RLPF.ar(DelayC.ar(FreqShift.ar(AudioIn.ar(1),XLine.kr(0.1,0.18,3,1),~ampVal/0.5),4,24),9000),Line.kr(1,-0.5,10,1),Line.kr(0.3,1.135,19))};

~out_h3.release(15);





~l1.scope;














~mix.ar;



f.stop;

~mix.play;
~mix.stop;
~mix.clear;




















~out4b.play;
~out4b = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), [0.75,1.75],0.5),14,22),8000),0,1.25)};
~out4b.stop;

~out4c.play;
~out4c = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), [0.75,0.75],[0.75,1.25]),14,32),8000),0,1.65)};
~out4c.stop;

o = Routine.run({
	2.wait;
	~out4c = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), [0.75,1.75],[0.5,2.25]),14,2),8000),0,1.0)};
	2.wait;
	~out4c = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), [0.75,1.75],[2.25,0.25]),14,2),8000),0,1.5)};
});

o.stop;

~out4d.play;
~out4d = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.2,2.25),14,0.5),18000),Line.kr(-1,1,3.5/~ampVal),0.7)};

~out4d = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), [0.2,2.0],1.75,0,Line.kr(~ampVal/2,~ampVal,10)),14,2),8000),0,0.7)};
~out4d.release(20);
~out4d.stop;