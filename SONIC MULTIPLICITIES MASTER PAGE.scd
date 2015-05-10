////SONIC MULTIPLICITIES MASTER PAGE\\\\

//INITS AND SETTINGS\\



////1. Run this code before booting the server.

(
o = Server.local.options;
o.memSize = (1 * 2048) * 1024;
s = Server.default;
)

////2. Run this code after booting the server.

(
p = ProxySpace.push(s);
p.fadeTime = 4;
p.clock = TempoClock.default;
p.clock.tempo = 1.3;
m = ProxyMixer(p, 16);
q = ExternalClock(TempoClock.new(40/60));
q.play;
r = ExternalClock(TempoClock.new(1)).play(quant:4);
u = ExternalClock(TempoClock.new(120/60));
u.play;
)

p.pop

(
SynthDef("dynDetect", {
	var mic = AudioIn.ar(1),
	amplitude = Amplitude.kr(mic)*10,
	trig = amplitude > 0.7,
	timer = Timer.kr(trig),  // how long since the last trigger?
	filteredTrig = (timer > 0.5) * trig;

	SendTrig.kr(filteredTrig, 0, amplitude);
}).send(s);

e = OSCFunc({
	"DAMN!".postln;
},'/tr', s.addr);
)

(
SynthDef("pitchTrig", {

	var mic = AudioIn.ar(1),
	trig = Impulse.kr(1/8),
	timer = Timer.kr(trig),
	var pitch = Poll.kr(1,Pitch.kr(mic)),
	filteredTrig = (timer > 2) * trig;
	SendTrig.kr(trig, 1, pitch[0]);
}).send(s);

f = OSCFunc({ arg a = Array.new;

	 a = a.shift(1);  // shift array by one
	a = a.put(0, pitch[0]);  // add new values
	a.postln;
}, '/tr', s.addr)
)

Synth("pitchTrig");


(
//TRACKING ROUTINES\\
///&&&&&&&&&&&&&&&\\\
///Connect HDSP input 9 to SC input 1


//Pitch tracking of microphone input

 //working
~pitchTracker =
	{
	var out = Pitch.kr(AudioIn.ar(1), initFreq: 190, minFreq: 190, maxFreq: 4400);
	Poll.kr(Impulse.kr(1/2), out[0], "Freq"); // UGen that prints the output value in the post window.
	Routine.run({
	do({
		1.wait;
		~freqVal = { out[0] };
	}).loop;// UGen that prints the output value in the post window.
	});
// out.poll; // shorthand method that creates a Poll ugen.
// out.do({ arg o, i; o.poll(5, "pan2 out" + i) });
	//out[0].postln; // lang side will post the object (array of outputs proxies)
//	0.5.do({
//	~pitchVal = out[0];
//	}).loop;
};


//Amplitude tracking of microphone input

 //working
~ampTracker =
	{
	var out2 = Amplitude.kr(AudioIn.ar(1)) * 10,
	trig = Impulse.kr(1/8);
	Poll.kr(trig, out2, "Amp");
	Routine.run({
	do({
		1.wait;
		~ampVal = { Amplitude.kr(AudioIn.ar(1)) * 100 + 1 };
	}).loop;// UGen that prints the output value in the post window.
	});
};
// out.poll; // shorthand method that creates a Poll ugen.
// out.do({ arg o, i; o.poll(5, "pan2 out" + i) });
//out2.postln; // lang side will post the object (array of outputs proxies)


Synth("dynDetect");

)

////GET YA STARTED\\\\
~out4.play;
~out4 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), [0.2,2.0], 0.5),1.5,2),2500),0,1.5)};
~out4.release(6);
//
~outsub.play;
~outsub= {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.25, 0.75,0,~ampVal*4),42,16),8000),0,1.7)};
~outsub.release(10);

~out5.play;
~out5 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), Line.kr(3,2,1,2.5), 2,0,1),2,14),17000),0,1.5)};
~out5 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 1, 2),2,14),17000),0,Line.kr(2,0.1,0.25,1.1))};
~out5.stop;

~out6.play;
~out6 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), [0.1,1.1], 1.75),2,12),17000),0,1.15)};
~out6.release(4);



////BBCUT PROCS\\\\

( //Preparation
~pbsfunc = 0.25; //Amount of modulation performed on the pitch.
~pbchance = 0.84;
)

//NOTE: Make a good dynamics-related control variable for pbchance!

y=BBCut2(CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.4,pbchance:0.85)), BBCPPermute.new(2,12,4)).play(u);
w=BBCut2(CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.7,pbchance:0.25)), BBCPPermute.new(48,256,8,12)).play(q);

y.proc_(BBCutProc11.new);
y.proc_(SQPusher1.new);
y.proc_(SQPusher2.new);
y.proc_(WarpCutProc1.new);
y.proc_(BBCPPermute.new(12,2,4));

y.proc_(BBCPPermute.new(4,12,4));
y.proc_(BBCPPermute.new(12,128,2,4));

w.proc_(BBCPPermute.new(48,256,8,12));

y.stop;
w.stop;

//y.proc_



//CutMixer.new(bus, volume, ampfunc, panfunc)

//w=CutGroup([CutStream1.new,CutMixer(0,1.0,Line.kr(0,1,10,20),{1.0.rand2})], BBCutProc11.new).play;

(
y = BBCut2(CutGroup([CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.2,pbchance:0.95)),CutMixer(0,1.7,SQPushFXAmp2.new(0.1),CutPan1.new(0.2))]), BBCPPermute.new(8,64,8,4)).play(u);
)

z.stop;

(
w = BBCut2(CutGroup([CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.6,pbchance:0.65)),CutMixer(0,2,SQPushFXAmp2.new(0.05),CutPan1.new)]), BBCPPermute.new(48,256,8,12)).play(q);
)


(
z = BBCut2(CutGroup([CutStream2.new(pbsfunc:SQPushFXPitch2.new(0.6,pbchance:0.65)),CutMixer(0,2.5,SQPushFXAmp2.new(0.5),0)]), BBCPPermute.new(64,4,2,2)).play(r);
)

z.proc_(BBCPPermute.new(128,2,4,0.25));


w.proc_(BBCutProc11.new);

w.proc_(ChooseCutProc(5,3,2));

z.proc_(BBCPPermute.new(32,12,12));

z.proc_(WarpCutProc1.new);

w.proc_(BBCPPermute.new(32,128,14,4));

w.stop;

w.free;

y.stop;

z=BBCut2(CutStream2.new, BBCPPermute.new(12,16)).play(r);

z.stop;

z.proc_(WarpCutProc1.new);

z.proc_(ChooseCutProc(17,2,2));

z.proc_(BBCutProc11.new);

z.proc_(BBCPPermute.new(14,32,12));

z.proc_(BBCPPermute.new(16,24,4));

c=BBCut2(CutStream2.new, BBCPPermute.new(64,4,1.25)).play(u);

c.stop;

c.proc_(WarpCutProc1.new);
c.proc_(BBCPPermute.new(32,4));



///WHERE UGENS GO TO DIE\\\
e.free; //OSCFunc variable. kill this to kill dynamic warnings
~pitchTracker.clear;
~ampTracker.clear;