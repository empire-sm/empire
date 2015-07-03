f = Buffer.alloc(s,2048,1);

(
{ // Now try with your own voice
var in, chain;
in = SoundIn.ar([0,1]).mean;
chain = FFT(f, in);
~spec = Out.kr(Impulse.kr(100), SpecFlatness.kr(chain).poll(1));
}.scope;
)





( //this puts a message to the post window every minute!
~d = DayTimer(\otto);
~d.start;
	// do this every full minute - id so you can remove it again
~d.putDate(\perMin, { |date| date.second == 0 }, { "full minute!".postln });
)

~d.stop;


h = {SinOsc.ar(440,0,~spec)}.play;

h.free;

