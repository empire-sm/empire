~out4.play;
~out4 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.1, 0.125),12,3),8000),0,1.15)};
~out4.stop;


~out10.play;
~out10 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.5, 1.25),5,14),18000),0,Line.kr(0.5,0.25,1.25,1.2))};
~out10.stop;


~outsub.play;
~outsub = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.15, 0.8,0.5,[Line.kr(1,2.5,14),Line.kr(2.5,0.5,1.4)]),~ampVal/2.5,16),18000),0,Line.kr(0,1,20))};

~outsub.stop;



~out_h2.stop;
~outsub.stop;



~outsub.release(5);

~out_sub2.stop;




~out_sub5.play;