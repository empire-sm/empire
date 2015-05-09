//Testing different filters in here...

~out13.play;
~out13 = {Pan2.ar(Formlet.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 1, 2),1,16), Pitch.kr(AudioIn.ar(1))/1.5), 0,1)};

~out13.release;

~out13.bus;