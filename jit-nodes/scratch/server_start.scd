s = Server("aServer", NetAddr("127.0.0.1", 56789));		// "localhost" is a synonym for an ip of 												// "127.0.0.1"

s.boot;

// define a synthesis engine
SynthDef("sine", { Out.ar(0, SinOsc.ar(440, 0, 0.2)) }).send(s);

// schedule (run) synthesis
s.sendMsg("s_new", "sine", n = s.nextNodeID, 0, 1);

// stop the synth (delete it)
s.sendMsg("/n_free", n);

// (optionally) stop the server
s.quit;