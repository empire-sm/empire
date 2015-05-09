b = Buffer.alloc(s, s.sampleRate * 4)
b.normalize
~rec = { RecordBuf.ar(AudioIn.ar(1,4), b, 0, 2, 0 loop:0, trigger:0) }

~player.play

//~trig = { TDuty.kr(Dseq([1,2,1,1,2,1,0.5,0.5,2,1,1,1,2,1,1,2,1,2,0.5,0.5,0.5,0.5]/4, inf)) }

~rate = 4

~player = { Pan2.ar(PitchShift.ar(PlayBuf.ar(1,b,0.125,1,loop:0),LFNoise0.kr(~rate)))};

~player.stop;