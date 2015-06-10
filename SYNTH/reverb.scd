(
~infiniteReverb = {
	arg feedback = 0.1;
	var sig, local;
	sig = SoundIn.ar(0);
	local = LocalIn.ar(2)+sig.dup;
	15.do{local = AllpassN.ar(local, 0.06, Rand(0.001,0.06), 3)};
	LocalOut.ar(local*feedback);
	Out.ar(0,sig+local);
};
)

~infiniteReverb.play;

~infiniteReverb.set(\feedback,0.05)

~infiniteReverb.clear;
