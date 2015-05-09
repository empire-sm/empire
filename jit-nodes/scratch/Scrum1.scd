p.pop;

~out_h1.ar;
~out_h1.play;
~out_h1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.1, Line.kr(1.125,0.5,5,~ampVal),0,2),12,14),700),0,Line.kr(0.1,0.5,4))};

~out_h1.release(15);

~out_l1.play;
~out_l1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),[1.1,2.1], 0.5,0),14,2),8000),0,1.7)};

~out_h1.stop;
~out_l1.release(15);


~out_h2.release(40);

~out_h2.release;
~out_l1.ar;
~out_l1.play;
~out_l1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1),0.5, 0.25,0),8,32),8000),0,1.2)};

~out_l3.release(10);

~out_l1.scope

~filterTop = ~freqVal * 8;

//

~out_h2.play;
~out_h2 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.3, 2.2/3,0,0),18,2),18000),Line.kr(-1,1,40),1)};
~out_h2.release(10);

~out_l3 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 1/3, 2/3,0,4),22,4),8000),Line.kr(-1,1,30),Line.kr(0.01,1,10,2))};
~out_l3.play;
~out_l3.release(4);

~out_h4 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 5/6, 2/3,0,1.5),6,12),2000),0,Line.kr(0,1,1/3,1.5))};
~out_h4.play;
~out_h4.release(4);

~out_h5 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(2), 0.15,1.75),14,3),17000),Line.kr(-1,0,10,3),0.45)};

~out_h5.play;

~out_h6 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(3), 0.15,2.25),14,3),17000),Line.kr(1,0,10,3),0.45)};
~out_h6.play;

~out_h5.release(14);
~out_h6.release(14);



~out_h5 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.15,0.5,Line.kr(0,3,0.25,~ampVal)),14,6.5*~ampVal),17000),Line.kr(-0.25,0.25,1,1.2),1.2)};
~out_h5.play;
~out_h5.release(4);

~out_h2.stop;

~out_sub1.play;
~out_sub1 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.5, 0.125),32,4),8000),0,1)};
~out_sub1.stop;

~out_sub5 = {Pan2.ar(DelayC.ar(PitchShift.ar(HPF.ar(AudioIn.ar(1),50), 0.5/~ampVal,1,1,10/~ampVal),12,32),0,1.8)};
~out_sub5.play;

~out_sub5.stop;

~ampVal2=~ampVal*10/4

~out_sub2.play;


~out_sub1.release(10);
~out_sub2.release(10);

~out10.stop;
~out10.free;

~out5.stop;
~out5.free;

~out5.bus

~out_sub2 = {Pan2.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 1.5,[Line.kr(1.25,0.125,10),Line.kr(0.25,1.5,4)]),2,12),0,Line.kr(0.25,1,1.25,1.5))};
~out_sub2.release(12);



~out_h3.play;
~out_h3 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.5, 2.5),0.05,0.25),2000),0,Line.kr(1.15,0.2,2,1.2))};
~out_h3.release;


~out_h8.play;
~out_h8 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.05, 2.5),64,15),12000),0,Line.kr(1.15,0.2,2,1.2))};
~out_h8.release(12);

~out_h9.play;
~out_h9 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.05, 3.25),4,1),18000),Line.kr(-1,1,10),Line.kr(0.15,1.2,7,0.2))};
~out_h9.release(12);



~out_l1.play;

(
~out_l1 = { arg control; Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 0.125, 2+control),control,(4/control) + 32-(control*8)),1000),0,1)};
~out_l1.map(\control, ~ampVal*3);
)

~out_l1.scope

~out_l1.clear;


