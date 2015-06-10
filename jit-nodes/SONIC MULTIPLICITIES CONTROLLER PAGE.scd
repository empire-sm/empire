//CONTROLS

~l1.ar;

~l1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 1.5, 2),2,12),8000),0,~lev2)};
~l2 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.5, 0.5),6,12),1000),0,~lev2)};

~l1.play;

~low = [~l1,~l2,~l3];

~lowOut = {Pan2.ar(SelectX.ar(Line.kr(0,1)*3,~low),0,~lev1)};

~low.stop;
~low.clear;

~out.ar;

~out.play;

~out[2]= ~test;

~test = {SinOsc.ar(440)};
~test2 = {SinOsc.ar(220)};

~test.play;

~test.stop;

~out.play;

~out.stop;

~out.clear;

~in.clear;

~in.kr;

~low = ~test + ~test2;

~low.play;

~low.stop;




~mic.clear;