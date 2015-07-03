/*NEED:
~spec
~ampVal*/

~out4.play;
~out4 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.3, [0.25,0.25]),32.5,8),12500),0,1.5)};
~out4.release(61);
~out4.stop;
//
~out2.play;
~out2 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.3, [2.5,1.75]),5,8),12500),0,1.3)};
~out2.release(31);
~out2.stop;
//
~outsub.play;
~outsub= {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.25, 0.75,0,~ampVal*4),16,42),8000),0,1.7)};
~outsub.release(10);

~out5.play;
~out5 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), Line.kr(3,2,1,2.5), 2,0,~spec),12,4),17000),0,1.5)};
~out5 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 1, 2.5),2,14),17000),0,Line.kr(2,0.1,0.25,1.1))};
~out5.stop;

~out6.play;
~out6 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.25, 3),22,32),7000),Line.kr(-1,1,2),1.5)};
~out6.release(4);





~l1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.35, 2.125,~spec,~ampVal/5),12,6),13000),0,1.7)}; //test synth
~l1.play;

~l1.release(5);