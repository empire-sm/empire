~ampTracker =
	{
	var out2 = Amplitude.kr(AudioIn.ar(1)) * 10,
	trig = Impulse.kr(1/8);
	Poll.kr(trig, out2, "Amp");
	out2.postln;
}.value;



~ampR1 = Routine.run({

	~test = {Pan2.ar(SinOsc.ar(100, (~val + 4)),0,0.2)};

	~test.play;

	do({
		1.wait;
		~ampVal = { Amplitude.kr(AudioIn.ar(1)) * 100 + 1 };
	}).loop;
});

~ampR1.free;



~test.stop;

~test.scope;




(
SynthDef(\freqpoll,{
var input = SoundIn.ar(0);
var pitchoutput = Pitch.kr(input);
var rate= ControlRate.ir*0.5; //faster than this and triggers can get dropped

SendTrig.kr(Impulse.kr(rate),1,pitchoutput[0]);

}).send(s)
)

(
OSCresponder(s.addr,'/tr',{ arg time,responder,msg; var q = Array.new;
[time,responder,msg].postln;
q = q.shift(1);
q.put(0, msg);
q.yield;
}).add
); 