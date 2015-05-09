//reverb experiments... scrum3.5 +companding (side-chaining but with more cool options!)
(
SynthDef(\test, {arg roomsize, revtime, damping, inputbw, spread = 15, drylevel, earlylevel,
        taillevel;
    var a = SoundIn.ar(0);
//    var a = PlayBuf.ar(1, 0);
    Out.ar(0, Compander.ar(GVerb.ar(
        a,
        roomsize,
        revtime,
        damping,
        inputbw,
        spread,
        drylevel.dbamp,
        earlylevel.dbamp,
        taillevel.dbamp,
		        roomsize, 0.3),a,0.5,1,~pitchTracker/10))}).add
)
~ampVal2 = ~ampVal*15;
r = Synth(\test, [\roomsize, 20, \revtime, 0.5, \damping, 0.1, \inputbw, 0.34, \drylevel -30, \earlylevel, -31, \taillevel, -29]);
r.free

~freqArray = { Pitch.kr(AudioIn.ar(1)) };

~pitchTest = {Pitch.kr(AudioIn.ar(1)) };

///////////

(
~pitchTest2 =
	{
	var out = Pitch.kr(AudioIn.ar(1), initFreq: 190, minFreq: 190, maxFreq: 4400);
	Poll.kr(Impulse.kr(1/2), out[0], "Freq:"); // UGen that prints the output value in the post window.
// out.poll; // shorthand method that creates a Poll ugen.
// out.do({ arg o, i; o.poll(5, "pan2 out" + i) });
out.postln; // lang side will post the object (array of outputs proxies)
};
)
~pitchTest2.clear;.


~out5.clear;


~out6.stop;