~out.play;

(
SynthDef("grain", { arg i_out = 0, pan;
    var env;
    env = EnvGen.kr(Env.perc(0.001, 0.003, 0.2),doneAction:2);
    Out.ar(i_out, Pan2.ar(FSinOsc.ar(Rand(1000,10000)), pan) * env)
}).send(s);
)

// a target for the grains
~someInput.ar(2); // initialize to 2 channels audio
~out = ~someInput;

(
t = Task({
    loop({
        s.sendMsg("/s_new","grain",-1,0,0,
            \i_out, ~someInput.index, // returns the bus index of the proxy
            \pan, [1, 1, -1].choose * 0.2
        );
        [0.01, 0.02].choose.wait;
    })
});
)
t.play;

// different filters;

~out.fadeTime = 1.0;

~out = { BPF.ar(~someInput.ar, MouseX.kr(100, 18000, 1), 0.1) };

~out = { CombL.ar(~someInput.ar * (LFNoise0.ar(2) > 0), 0.2, 0.2, MouseX.kr(0.1, 5, 1)) };

~out = { RLPF.ar(~someInput.ar, LFNoise1.kr(3, 1000, 1040), 0.05) };


t.stop;


// end