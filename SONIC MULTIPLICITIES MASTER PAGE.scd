////SONIC MULTIPLICITIES MASTER PAGE\\\\

/////PERFORMANCE SPECS\\\\\\\\

////Distance from mic: ~3 feet
////

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
r.play;
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
//
// (
// SynthDef("pitchTrig", {
//
// 	var mic = AudioIn.ar(1),
// 	trig = Impulse.kr(1/8),
// 	timer = Timer.kr(trig),
// 	var pitch = Poll.kr(1,Pitch.kr(mic)),
// 	filteredTrig = (timer > 2) * trig;
// 	SendTrig.kr(trig, 1, pitch[0]);
// }).send(s);
// )
//
// //Synth("pitchTrig");
//
// (
// f = OSCFunc({ arg a = Array.new;
//
// 	a = a.shift(1);  // shift array by one
// 	a = a.put(0, pitch[0]);  // add new values
// 	a.postln;
// }, '/tr', s.addr)
// )







f = Buffer.alloc(s,2048,1);

(
{ // Now try with your own voice
var in, chain;
in = SoundIn.ar([0,1]).mean;
chain = FFT(f, in);
~spec = Out.kr(Impulse.kr(100), SpecFlatness.kr(chain).poll(1));
}.scope;
)



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




///WHERE UGENS GO TO DIE\\\
e.free; //OSCFunc variable. kill this to kill dynamic warnings
~pitchTracker.clear;
~ampTracker.clear;