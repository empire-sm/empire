//Scrum 3
///Dealing With: ambience signal (must get second microphone!)
////         and musical logic

s = Server.default;

~violinPitch = Pitch.kr(AudioIn.ar(1), initFreq: 190, minFreq: 190, maxFreq: 4400); //this outputs an array: [freq, hasFreq] --- if a pitch was found during the current analysis window, hasfreq==1, else if not found hasFreq==0. initFreq is output until hasFreq==1 (in this case, this means that it will output 190hz until it hears something)

//this means that it should only be evoked when it outputs [ ~somefreq, 1 ]

~pitchDenom = ~violinPitch[0]/10;

~out_h2.play;
~out_h2 = {Pan2.ar(RLPF.ar(DelayC.ar(PitchShift.ar(AudioIn.ar(1), 1, 6/4), ~pitchTracker.kr,16),17000),0,1.25)};

~violin = AudioIn.ar(1);

~sendVol=0.3;
~violinVol=1;
~violinVerb = {Pan2.ar(AudioIn.ar(1,~sendVol),0,~violinVol)};
~violinVerb.play;
~verbBus = ~violinVerb;
~verbVol = 1;