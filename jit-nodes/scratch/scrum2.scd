(
var b,buf, clock;

clock= ExternalClock(TempoClock(2.1));

clock.play;

Routine.run({

buf= BBCutBuffer.alloc(s,44100*2,1); //allow 4 seconds worth of buffer space, ie up to 8 beats at 120bpm

s.sync; //this forces a wait for the Buffer to be allocated

y = BBCut2(CutStream2(s.options.numOutputBusChannels, buf), BBCutProc11.new).play(clock);
});

)

s=Server.default;

~pbsfunc = 0.75;

y=BBCut2(CutStream2.new(pbsfunc:SQPushFXPitch2.new(~pbsfunc,pbchance:0.3)), WarpCutProc1.new(4)).play;

y.end;



z=BBCut2(CutStream2.new, ChooseCutProc(0.25,4)).play;

z.end;

z.proc_(WarpCutProc1.new(4));

z.proc_(ChooseCutProc(1,24));

z.proc_(BBCutProc11.new);

z.proc_(BBCPPermute.new(4,16));