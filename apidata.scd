d = CSVFileReader.read("/home/agrathwohl/code/empire/data.csv")
d = d.collect{ |it| it.asFloat };

~precip   = d[0][0]
~humidity = d[0][1]
~clouds   = d[0][2]
~wind     = d[0][3]
~temp     = d[0][4]
~precipInt = d[0][5]

d.postcs;


(
////BBCUT PROCS AND TIMING MECHANISMS\\\\
~pbsfunc = ~precip; //Amount of modulation performed on the pitch.
~pbchance = ~humidity; //Likelihood of performing the modulation.
~countdown = ~wind; //Length in minutes routines will pause before changing to new synths/instructions.
)

(
////FILTER CUTOFFS\\\\
~lpf  = ~temp;      //[ ~lpf, ~lpf*2, ~lpf*3, ~lpf*4 ].choose
~rand = ~precipInt; //[ ~rand, ~rand*5, ~rand*10, ~rand*50 ].choose
)

~out4.ar;
~out4.fadeTime = 5.0;
~out4.play;
~coef = 2.5;
~out4 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), [ ~precip, ~precip*2, ~precip*5 ].choose, ~coef),4,5),[ ~lpf*5*~coef, ~lpf*10*~coef, ~lpf*15*~coef, ~lpf*30*~coef ].choose),0,1.5)}; //does it work? i dunno, test with garrett