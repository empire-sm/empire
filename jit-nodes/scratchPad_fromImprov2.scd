//*********************
// ##sketch pad *******
//!@*******************
SynthDef( \writer, { |bufnum|
	DiskOut.ar(bufnum, In.ar( 0, 2 ) );
}).send( s );

{SinOsc.ar(440, 0.1 )}.play(s);

(
var loc = "~/Documents/soundsamples".standardizePath;
b = Buffer.alloc( s );
b.write( l, "aiff", "int16k",
)



(
	var stream, filteredStream, aoleanScale, pattern;
	aoleanScale = #[0,2,3,5,7,8,10];
	stream = Routine.new({
		10.do({ arg i; i.yield; })
	});
	// returns a Stream
	filteredStream = stream.collect({
		arg item;
		// filter out 0, 2, 4, 6, 8, 10
		if ( item.even,
			{ item },
			// add a tenth to filtered notes
			{ item + 10 } );
	});
	pattern = Pbind(
		\degree, filteredStream,
		\scale, aoleanScale
	);
	pattern.play( TempoClock(4) );
)

//@!*******************
// ##projects *********
//!@*******************

( 	// a Function findNumArgs: you pass in a Synth,
	// and a function to execute when findNumArgs
	// has found the number of arguments for that synth.
	var
		findNumArgs,
		returnFirstNotZero;
	findNumArgs =
		{
			arg
				syn,
				callback;
			var
				maxNumArgs 	= 20,
				numZeroes 	= 0,
				numArgs;
			syn.getn(
				0,
				maxNumArgs,
				{
					arg i;
					for(
						maxNumArgs-1,	// start at end
						0,				// go to zero
						{
							arg j;
							if(
								i[j] == 0, 	// if it is zero
								{
									numZeroes =
										numZeroes + 1
								}
							)
						}
					);
					numArgs =
						(maxNumArgs - numZeroes);
					callback.value(numArgs);
				}
			);
		}
	;
	// example of how to use
	findNumArgs.value(
		Synth( "pingring" ),  		// first param: Synth
		{ 							// 2nd param: Function
			arg val;
			val.postln;
		}
	);
)

// knob manipulates resonant freq
// of pingring - search for
// "//pingring" synthdef below.
(
	var
		synth,
		window,
		knob,
		knobPanel;
	synth = Synth("pingring");
	window = Window(
		"pingring example",
		Rect( 0, 0, 120, 150 )
	);
	window.addFlowLayout;
	knobPanel = 				// make panel for knob
		CompositeView			// and knob label
		(
			window,
			Rect( 0, 0, 120, 150 )
		);
	knobPanel.decorator =
		FlowLayout( knobPanel.bounds );
	knob = Knob(
		knobPanel,
		Rect( 0, 0, 100, 100 )
	);
	knobPanel.decorator.nextLine;
	JSCStaticText(
		knobPanel,
		Rect(0,0,100,15)
	)
		.string_( "Res Freq" )
		.align_( "center" );
	knob.action_
	(
		{
			(knob.value * 1000 + 500).postln;
			synth.set(
				"resFreq",
				 knob.value * 1000 + 500
			);
		}
	);
	window.front;
	synth.play(s);
)

//@!*******************
// ##sounds ***********
//!@*******************

( // cool soundstretch example. execute first:
b = Buffer.read(s, "/home/myer/Documents/soundsamples/sound.wav");
SynthDef(\stretchedFragments,
	{ |out, bufnum, start, time = 1, stretch = 1, amp = 1, attack = 0.01, decay = 0.05|
		var	sig =
			PlayBuf.ar(
				1, bufnum,
				rate: stretch.reciprocal,
				startPos: start,
				doneAction:2);
		sig = PitchShift.ar(sig, pitchRatio: stretch)
			* EnvGen.kr(
				Env.linen(attack, time, decay), doneAction: 2);
		Out.ar(out, sig ! 2)
	}).memStore;	// note memStore! Without this, arguments won't work
)
// cool soundstretch example with patterns, execute second://
(
	TempoClock.default.tempo = 1;
	p = Pbind(
		\instrument, \stretchedFragments,
		\bufnum, b,
		\start, Pwhite(0, (b.numFrames * 0.7).asInteger, inf),
		// note, delta is the amount of time before the event releases
		\delta, Pexprand(0.2, 1.5, inf), // between 1/5 second and 1 1/2 second
		// delta is re-used here under the name 'time' to play the buffer
		// in that much time
		\time, Pkey(\delta),
		\stretch, Pexprand(1.0, 4.0, inf),
		\amp, 0.5,
		\attack, 0.1,
		\decay, 0.2
	).play;
)// next things are for housekeeping with these examples:
p.stop;
b.free;	// be tidy! remember to clean up your Buffer

// pinging china cups
{ Ringz.ar(Dust.ar(3, 0.3), 2000, 2) }.scope(1, zoom:4);

// ringing noise
{ Ringz.ar(WhiteNoise.ar(0.005), 2000, 0.5) }.scope(1);

// modulate bandwidth noise resonance
{ Resonz.ar(WhiteNoise.ar(0.5), 2000, XLine.kr(1, 0.001, 8)) }.scope(1);

// beginning of dance mix
// modulate bandwidth noise res opposite direction
{ Resonz.ar(WhiteNoise.ar(0.5), 2000, XLine.kr(0.001, 1, 8)) }.scope(1);

// nice noises
{ LFClipNoise.ar(MouseX.kr(200, 10000, 1), 0.125) }.scope(1);
{ LFNoise0.ar(MouseX.kr(200, 10000, 1), 0.25) }.scope(1);
{ LFNoise1.ar(MouseX.kr(200, 10000, 1), 0.25) }.scope(1);
{ LFNoise2.ar(MouseX.kr(200, 10000, 1), 0.25) }.scope(1);
{ ClipNoise.ar(0.2) }.scope(1);
{ WhiteNoise.ar(0.2) }.scope(1);
{ PinkNoise.ar(0.4) }.scope(1);
{ BrownNoise.ar(0.2) }.scope(1);
{ GrayNoise.ar(0.2) }.scope(1);
{ Dust.ar(MouseX.kr(1,10000,1), 0.4) }.scope(1, zoom:4);
{ Dust2.ar(MouseX.kr(1,10000,1), 0.4) }.scope(1, zoom:4);
{ Crackle.ar(MouseX.kr(1,2), 0.5) }.scope(1);

// amazing triangle
// *microphone* voice
// modulator!
({
	var
		in,				// mic
		amp,			// amp of mic
		freq,			// freq of mic
		hasFreq,		// whether has freq
		out				// sound out
	;
	in =
		SoundIn.ar(1)
	;
	amp =
		Amplitude.kr(
			in,
			mul: 0.4
		)
	;
	# freq, hasFreq = 	// note that freq is read only
		Pitch.kr(in)	// while hasFreq isn't
	;
	out=
		if(
			hasFreq, 	// try hasFreq as freq! (careful)
			Pulse.ar(
				freq,  	// try freq as hasFreq! (intesting)
				0.5,
				0.1
			),
			SinOsc.ar(
				freq,
				0,
				0.1
			)
		)
	;
	6.do({
		out =
			AllpassN.ar(
				out,
				0.040,
				[
					0.040.rand,
					0.040.rand
				],
				2
			)
	});
	out
}.play)

// amazing voice organ!
(n = {
	var in,
		amp,
		freq,
		hasFreq,
		out
	;
	in =
			SoundIn.ar(
					0
		)
	;
	amp =
		Amplitude.kr(
			in,
			mul: 0.4
		)
	;
	# freq, hasFreq =  // what does # do here?
		Pitch.kr(in)
	;
	out =
		Mix.ar(
			LFTri.ar(
				freq *
				[			// three triangle waves
					0.5,	// low octave
					1,	    // medium octave
					2 		// high octave
				]
			)
		) * amp
	;
	6.do({
		out = AllpassN.ar(
			out,
			0.040,
			[
				0.040.rand,
				0.040.rand
			],
			2
		)
	});
	out
}.play)

// nice chorus
// !see synthdef
({ Mix(
	Saw.ar(
		[440,443,437],	// 3 freq's
		0.1
	)
)}.scope)

// nice little skuttler
// !see synthdef
({	Mix(
		Resonz.ar(
			Saw.ar(
				[440,443,437] +
				SinOsc.ar(
					100,
					0,
					5*200
				)
			),
			// frequency modulated sawtooth wave
			// with chorusing
			XLine.kr(
				10000,
				10,
				10,
				doneAction:2
			),
			Line.kr( //vary bandwidth (rq) over time
				1,
				0.05,
				10
			),
			mul:	//amplitude modulation
				LFSaw.kr(
					Line.kr(13,17,3),
					0.5,
					0.5
				) *
				Line.kr(
					1,
					0,
					10
				)
			// end mul
		)
	)
}.scope)

// robot voice (requires mic)
// use input amplitude to control Pulse amplitude - use headphones to prevent feedback.
(
~robot = {
	Pulse.ar(
		90,
		0.3,
		Amplitude.kr(
			SoundIn.ar(0)
		)
	)
}.play;


// tremulous shimmering spaceship
(
	play({
		Mix.fill(
			8,
			{ 	SinOsc.ar(
				500 + 500.0.rand,
				0,
				0.05)
			}
		);
	})
)

// amazing sin wave
({ 	LPF.ar(
		Saw.ar(
			200,
			0.1
		),
		SinOsc.kr(
			XLine.kr(
				0.7,
				300,
				20),
			0,
			3600,
			4000
		)
	)
}.play;)

// amazing resonant low pass filter example
({ RLPF.ar(
	Saw.ar(
		200,
		0.1),
	FSinOsc.kr(
		XLine.kr(
			0.7,
			300,
			20),
		0,
		3600,
		4000),
	0.2)
}.play;)

// sweeping the cutoff of a
// lowpass filter on white
// noise from high to low
({LPF.ar(
	WhiteNoise.ar(
		0.1
	),
	Line.kr(
		10000,
		1000,
		1,
		doneAction:2
	)
)}.scope)

// modulate number of harmonics w/
// band limited impulse generator
({Blip.ar(
	200,
	Line.kr(
		1,
		100,
		20),
	0.2)
}.play;)

// a little nintendo airplane
// taking off
{ LFNoise0.ar(
	XLine.kr(
		1000,
		10000,
		10),
	0.25)
}.play;

// a little robot thinking
({ SinOsc.ar(
		LFNoise0.ar( 	// using LFNoise0 as random
			4, 			// freq generator
			400,
			450),
		0,
		0.2)
}.play;)

// a little graph of the difference
// between Impulse and LFNoise0
({
	var
		freq = 1000
	;
	[
		LFNoise0.ar(freq),
		Impulse.ar(freq) // single sample impulses)
	]
}.plot)

// a little flying saucer
// warbling off
({	var ctl = HPF.kr(	// high pass filter
		LFSaw.kr(5),	// RAW saw for harmonics (5 Hz)
		SinOsc.kr(		// Sin affects cutoff freq:
			XLine.kr(	// but line affects sin freq:
				0.07,   // goes from 0.07 Hz
				30,     // to 30 Hz
				20),   	// over 20 seconds
			0, 			// no phase displacement on sin
			35,			// amp is 35
			40)		    // gain is 40
	);					// notice all these are kr
	SinOsc.ar(		    // and effect this ar
		ctl * 200 + 500)	// start at 500 and go up to 700
	* 0.1;				// play at 10% volume
}.play;)

// same example but with the mouse
// real fun - wire this up to a nob sometime.
// almost like music in the
// canteena in tatooine in mos eisley
({	var ctl = HPF.kr(
		LFSaw.kr(
			5,
			0.1),
		MouseX.kr(
			2,
			200,
			1));
	SinOsc.ar(
		ctl * 200 + 400)
		* 0.1;
}.play;
)

// modulate filter frequency
// with the cursor position
// fun!
({ BPF.ar(		// band pass butterworth
	Saw.ar(		// band limited saw
		200,	// at 200 Hz
		0.5),   // and 0.5 amplitude
	MouseX.kr(
		100,	// modulate cutoff from 100 Hz
		10000,	// to 10k Hz
		1),  	// use exponential mapping
	0.3) 		// RQ is 0.3: bandwidth is a third of cutoff
}.play;)

// mouse!
// BPF on control signals:
// schizophrenic night bird!
({	var vib =
		BPF.kr(
			PinkNoise.kr, 	// crazy noise seed
			MouseX.kr(		// cutoff with mouse between
				1,			// 1 Hz and
				100,		// 100 Hz
				1
			),				// exponential mapping
			0.3
		)					// bandwidth is 30% of cutoff
		* 10;				// multiply amplitude by 10
	SinOsc.ar(			// create sin wave
		vib * 200 + 600)// where that freq is 600 +/- 200
		* 0.2			// at 20% volume
}.play;)

// get ready to dance
// with the wind!
({ 	Resonz.ar(
		WhiteNoise.ar(0.5), 	// noise at half vol
		XLine.kr(				// exponential line
			1000,				// from 1000
			8000,				// to 8000
			10),				// that lasts 10 seconds
		0.05)			// bandwidth is 5% of center freq
}.play)				// which means: spike in middle

// dive bomb bee
({Saw.ar(
	EnvGen.kr(				// freq input
		Env.new(
			[10000,20],		// 10k to 20 Hz
			[0.5]			// half a second
		)
	),
	EnvGen.kr(				// amp input
		Env.new(
			[0.1,0],
			[2.0]
		)
	)
)}.play)

//FM sound
({
SinOsc.ar(
	SinOsc.ar(10,0,10,440),
	0.0,
	EnvGen.kr(
		Env.new(
			[0.5,0.0],
			[1.0]),
			doneAction:2) // free cpu when done
	)
}.scope
)

// amazing buzz bee - frightening!
({	Saw.ar(
		SinOsc.ar(
			1,
			0,
			10,
			440),
		Line.kr(
			0,
			1,
			1,
			doneAction:2)) // free server on line, too!
}.scope)

//@!**********************
// ##synthdefs ***********
//!@**********************

//pingring
(
	SynthDef
	(
		"pingring",
		{
			arg
				resFreq=2000,
				freq=3,
				gap=2;
			Out.ar
			(
				0,
				Ringz.ar
				(
					Dust.ar
					(
						freq,
						freq/10
					),
					resFreq,
					gap
				)
			)
		}
	).send(s)
)

// my first synthdef
(SynthDef(
	"nice_chorus",
	{							// begin function to return
		arg 					// one argument
			freq=440			// frequency default value
		;
		Out.ar(
			0,
			Mix(
				Saw.ar(
					[
						freq,
						freq+3,
						freq-3
					],
					0.1
				)
			)
		)
	}
).send(s))
// playing the synthdef
a=Synth("nice_chorus");				// default Synth
b=Synth("nice_chorus",["freq",660]);
c=Synth("nice_chorus",["freq",880]);
//end my first synthdef

//my second synthdef
(SynthDef(
	"little_skuttler",
	{
		arg
			freq=440,
			modAmp=5*200,
			time=10
		;
		Out.ar(
			0,
			Mix(
				Resonz.ar(
					Saw.ar( 			// sawtooth input
						SinOsc.ar( 		// freq modulated
							100,
							0,			// no phase offset
							// note, mod here can be greater than
							// 1 because the amplitude of this
							// sin is modulating the freq of
							// the saw
							modAmp		// mul: 1000!
						) +
						[ 				// with chorusing
							freq,
							freq+3,
							freq-3
						]
					),
					XLine.kr( 			// change center freq
						10000,			// from 10k
						10, 			// to 10 Hz
						time, 			// over this much time
						doneAction:2 	// then kill
					),
					Line.kr( //vary filter bandwidth (rq) in time
						1,
						0.05,
						time
					),
					mul:	//now, amplitude modulation:
						LFSaw.kr(
							Line.kr(
								13, 	// go from 13 Hz
								17,		// to 17 Hz
								time/3	// over time
							),
							0.5,		// phase
							0.5			// mul
						) *				// mul by
						Line.kr(		// values changing
							1,			// from 1
							0,			// to zero
							time,	    // over time
							doneAction:2 // kill when done
						)
					// end mul
				)
			)
		)
	}
).send(s))
a=Synth("little_skuttler");
(
	b=Synth(
		"little_skuttler",
		[
			"freq",220,
			"time",1
		]
	)
)
//end of my second synthdef 'little skuttler'

//@!*************************
// ##functions **************
//!@*************************

// function that lets you select from random ways of
// producing random numbers, and then returns an
// array of ten numbers produced with that way.
(
	var rand10Chooser;
	rand10Chooser = {
		arg mode;
		Array.fill(
			10,
			{
				var return;
				return= switch(
					mode,
					0, {2.rand},
					1, {2.0.rand},
					2, {2.rand2},
					3, {2.0.rand2},
					4, {rrand(2,4)},
					5, {rrand(2.0,4.0)},
					6, {exprand(1.0,10.0)}
				);
				return
			}
		)
	};
	// now show it works
    rand10Chooser.value(7.rand).postln;
)



// function that selects random
// successive nums from [1.0,0.5,0.25]
// to fill up one bar's worth of beats.
(
	var randVolFunc;
	randVolFunc={
		arg numBeats;
		Array.fill(
			numBeats,
			{
				[
					1.0,
					0.5,
					0.25
				].choose
			}
		)
	};
	// generate one bar (4 beats)
	randVolFunc.value(4).postln;
)

// function that takes an arg n
// that returns an array of n random
// numbers between 1 and 10, sorted
// into decreasing order.
(
	var randArrayFunc;
	randArrayFunc={
		arg n;
		Array.rand(n,1,10).sort.reverse
	};
	// test results
	randArrayFunc.value(3).postln;
	randArrayFunc.value(10).postln;
)

//@!*************************
// ##patterns ***************
//!@*************************

// nice octive displacement melody
(
var a = Pseq( (0,1..8), inf );
var b = Pseq( (5,5.5..6.5), inf );
Pbind(
	\dur, 0.125,
	\degree, a,
	\amp, 0.1,
	\octave, b
).play
)

// example of using Ppatlace
(Pbind(*[
	scale: #[0,1,3,4,7,9,11],
	degree: Ppatlace( [
			Prand((0..6)), Pn(0,8)
		], inf ),
	dur: 0.25])).play;
)

// excellent JIT programming example from Pnsym help
(
// load a synthdef
s.boot;
SynthDef("gpdef",
	{ arg out=0, freq=440, sustain=0.05, amp=0.1, pan;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain), doneAction:2) * amp;
		Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, env), pan))
	}).store;
)
Pdefn(\x, Pn(1, 3));
Pdefn(\y, Prand([5, 9, 1], 2));
Pdefn(\z, Pdefn(\y) * 2);
(
Pdef(\play,
	Pbind(
		\instrument, \gpdef,
		\harmonic, Pnsym(Pseq([\x, \x, Prand([\x, \y]), [\z, \y], \y], inf)).trace,
		\dur, 0.2, \note, 10
	)
).play;
)
// change root pattern:
Pdefn(\x, Pn(2, 3));
Pdefn(\x, Pseq([1, 3, 1, 2, 1, 4, 5]));
Pdefn(\x, Pseq([1, 3, 1, 2, [1, 3], 4, 5]));

// excellent harmonic pattern from PG_Cookbook01_BasicSequencing.scd
(
	p = Pbind(
		\degree,
			// start with an arithmetic series
			Pseries(
				// that begins with seven
				7,
				// and is added to a number that changes
				// regularly between 1 and 3
				Pwhite(1, 3, inf)
				// but could be positive or negative
				* Prand(#[-1, 1], inf), inf)
					// but make sure the result is
					// within [0,14]
					.fold(0, 14) + Prand(
						#[
							[0, -2, -4],
							[0, -3, -5],
							[0, -2, -5],
							[0, -1, -4]
						], inf
					),
		\dur, Pwrand(#[1, 0.5], #[0.8, 0.2], inf)
	).play;
)
(
	var
		possibleChords,
		possibleMultiplier,
		possibleDuration,
		pattern;
	possibleChords = #[
		[0, -2, -4],
		[0, -3, -5],
		[0, -2, -5],
		[0, -1, -4]
  	];
	possibleMultiplier = {
		| startNum = 7 |
		var rand, randSign, sequence, bounded;
		rand = Pwhite( 1, 3, inf );
		randSign = Prand(#[-1,1], inf);
		sequence = Pseries(
			startNum,
			rand * randSign
		);
		bounded = sequence.fold( 0, 2*startNum );
	};
	possibleDuration =
		Pwrand( #[1, 0.5], #[0.8, 0.2], inf );
	pattern = Pbind(
		\degree, possibleChords * possibleMultiplier.value,
		\dur, possibleDuration
	);
	pattern.play;
)

( // a cool one with neat overlaps
var a = Pseq( (0,1..8), inf );
var b = Pseq( (5,5.5..6.5), inf );
Pbind(
	\dur, 0.125,
	\degree, a,
	\amp, 0.1,
	\octave, b
).play
)

var n;
n = 60;
a = Pbind(\freq, n.midicps).play(quant:1.0);
a.stop;
b = Pbind(\freq, (n-9).midicps).play(quant:1.0);
b.stop;

(
Pbind(
	\dur,0.125,
	\midinote, Pseq(
		#[0,4,0,7,4,0,0] + 60, inf),
	\amp, Prand([0.125,0.2, 0.25],inf)
).play(quant:1.0);
)

(
var a = Pshuf( [1, 1, 0, 1, 0], 3 );
Pbind(
	\dur, 0.125,
	\midinote, a*7 + 60,
	\amp, a*0.1
).play
)

//@!*************************
// ##examples ***************
//!@*************************

// example: fullscreen
(
w = Window.new( "fullscreen", Window.screenBounds );
w.view.background = Color.yellow;
w.front;
w.fullScreen;
)

// example: grains
(
	{
		var
			singrain1,
			singrain2,
			sfgrain;
		singrain1=
			SinOsc.ar(
				440,
				0,
				XLine.kr(
					1.0,
					0.0001,
					0.05
				)
			);
		singrain2=
			FSinOsc.ar(
				800,
				0.0,
				Line.kr(
					1.0,
					0,
					0.05
				).squared
			);
		sfgrain=(
			PlayBuf.ar(
				1,
				b.bufnum,
				BufRateScale.kr(
					b.bufnum
				)
			)
		) *
		EnvGen.kr(
			Env(
				[0,1,1,0],
				[0.01,0.01,0.01],
				-4
			)
		);
		[
			singrain1,
			singrain2,
			sfgrain
		]
	}.plot(0.1,s)
)

//simple sine grain synthdef - note the all important doneAction
(
	SynthDef(
		\sinegrain,
		{
			arg
				pan,
				freq,
				amp;
			var grain;
			grain=
				SinOsc.ar
				(
					freq,
					0,
					amp
				) *
				(
					XLine.kr(
						1.001,
						0.001,
						0.1,
						doneAction:2
					) - 0.001
				);
			Out.ar(
				0,
				Pan2.ar(grain, pan)
			)
		}
	).send(s);
)
( // part 2
	{
		100.do
		{
			arg i;
			Synth(
				"sinegrain",
				[
					"freq",
					rrand(100,10000),
					"amp",
					exprand(0.05,0.1),
					"pan",
					1.0.rand2
				]
			);
			0.01.wait
		};
	}.fork
)
( // part 3
	{
		200.do{
			arg i;
			var timeprop = (i/199.0)**3;
			Synth(
				\sinegrain,
				[
					\freq,
					exprand(100,5000-(20*i)), // random with exponential distribution between 100 and 1000 then 5000
					\amp,
					exprand(0.05,0.1),
					\pan,
					1.0.rand2
				]
			);
			rrand(
				(timeprop*0.1).max(0.01),
				timeprop*0.3
			).wait
		};
	}.fork
)

//simple playbuf grain synthdef - note the all important doneAction
(
	SynthDef(
		\sfgrain,
		{
			arg
				bufnum=0,
				pan=0.0,
				startPos=0.0,
				amp=0.1,
				dur=0.04;
			var grain;
			grain=
				PlayBuf.ar(
					1,
					bufnum,
					BufRateScale.kr(bufnum),
					1,
					BufFrames.ir(bufnum)*startPos,
					0
				) *
					(EnvGen.kr(
						Env.perc(
							0.01,
							dur
						),
						doneAction:2
						)-0.001
					);
		Out.ar(
			0,
			Pan2.ar(grain, pan)
		)
		}
	).send(s);
)

// example: scrub through soundfile with mouse
(
	//.read brings in the whole sound at once
	b = Buffer.read(s,"/home/myer/sound.wav");

	//using Mouse to scrub through-
	//X position is normalised position
	//0 to 1 phase through the source file
	SynthDef(
		"bufrd",
		{
			arg
				out=0,
				bufnum=0;
			Out.ar(
				out,
				Pan2.ar(
					BufRd.ar(
						1,
						bufnum,
						K2A.ar(
							BufFrames.ir(b.bufnum)*
							MouseX.kr(0.0,1.0)
						).lag(MouseY.kr(0.0,1.0))
					),
					0.0
				)
			)
		}
	).play(s);
)

// example of sound sample buffers
// with guis -
( // synthdefs with sound buffers part 1
	//this loads into a buffer the default sound that comes with SuperCollider
	//.read brings in the whole sound at once
	b = Buffer.read(s,"/home/myer/sound.wav");

	SynthDef("playbuf",{ arg out=0,bufnum=0, rate=1, trigger=1, startPos=0, loop=1;
		Out.ar(out,
			Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop),0.0)
		)
	}).send(s);
)
// example of how to to play normal
Synth(\playbuf, [\out, 0, \bufnum, b.bufnum]);
// example of how to play at half rate
Synth(\playbuf, [\out, 0, \bufnum, b.bufnum, \rate, 0.5]);
( // synth defs with sound buffers part 2
	var
		w,
		rateslid,
		trigslid,
		startposslid,
		loopslid,
		a;
	// another synthdef: playbuf
	a = Synth(
			\playbuf,
			[
				\out,
				0,
				\bufnum,
				b.bufnum
			]
	);
	w = Window(
		"PlayBuf Example",
		Rect(10,200,300,150)
	);
	w.front;
	//control positioning of new GUI elements
	w.view.decorator= FlowLayout(w.view.bounds);
	//James' shortcut slider class
	//100@24 means a Point of size 100 by 24
	//|ez| is the same as arg ez;  -
	//the slider object is being passed
	//into the callback action function
	rateslid=
		EZSlider(
			w,
			250@24,
			"Rate",
			ControlSpec(
				0.5,
				10,
				'exponential',
				0.1
			),
			{
				|ez|
				a.set(
					\rate,
					ez.value
				)
			},
			1
		);
	trigslid=
		EZSlider(
			w,
			250@24,
			"Trigger",
			ControlSpec(
				0,
				1,
				'lin',
				1
			),
			{
				|ez|
				a.set(
					\trigger,
					ez.value
				)
			},
			1
		);
	startposslid=
		EZSlider(
			w,
			250@24,
			"StartPos",
			ControlSpec(
				0.0,
				1.0,
				'lin',
				0.01
			),
			{
				|ez|
				a.set(
					\startPos,
					ez.value
				)
			},
			0
		);
	loopslid=
		EZSlider(
			w,
			250@24,
			"Loop",
			ControlSpec(
				0,
				1,
				'lin',
				0.1
			),
			{
				|ez|
				a.set(
					\loop,
					ez.value
				)
			},
			1
		);
	w.onClose_({a.free;});
)
( //part 3 // sweet granular reconstruction of sound
	{
		200.do{
			arg i;
			var timeprop = (i/199.0)**3;
			Synth(
				\sfgrain,
				[
					\bufnum,
					b.bufnum,
					\startPos,
					rrand(
						0.0,
						timeprop
					),
					\amp,
					exprand(
						0.005,
						0.1
					),
					\pan,
					1.0.rand2
				]
			);
			rrand(
				(timeprop*0.1).max(0.01),
				timeprop*0.4
			).wait
		};
	}.fork
)
( // using slide to adjust grain
	var
		w,
		slid,
		lastval;
	lastval=0.0;
	w =
		Window(
			"My Window",
			Rect(100,500,200,200)
		);
	//A 200 by 200 window appears at screen co-ordinates (100, 500)
	slid =
		Slider(w,Rect(10,10,150,40)); //a basic slider object
	slid.action_({lastval= slid.value;}); //this is the callback- the function is called whenever you move the slider
	{
		inf.do{
			arg i;
			var prop, timestart, timeend;
			prop= (i%300)/300;
			timestart= prop*0.8;
			timeend= prop*(0.8+(0.1*lastval));
			Synth(
				\sfgrain,
				[
					\bufnum,
					b.bufnum,
					\startPos,
					rrand(
						timestart,
						timeend
					),
					\amp,
					exprand(0.005,0.1),
					\pan,
					lastval.rand2,
					\dur,
					0.1+(lastval*0.5)
				]
			);
			//max in this to avoid ever going near 0.0 wait time, which would crash the computer!
			(((lastval*0.2)+0.01).max(0.01)).wait
		};
	}.fork;
	w.front;
)

// example of do loops and subscheduling
(
{

	4.do{arg j;

		{

			8.do{arg i;

				Synth(\bleep, [\note,48+(i*3.3)+j ,\amp, (1.0-(i/8))]);
				0.5.wait;
			}

		}.fork;

		4.0.wait;
	}
}.fork;
)

// example of knobs
(
	var
		w,					// window
		border = 10,
		size = 100,
		numKnobs = 5
	;
	w = Window.new
	(
		"Knob Example",
		Rect.new
		(
			0,
			0,
			numKnobs * size + 24,
			size
		),
		resizable: false
	);
	w.addFlowLayout;
	w.view.background =
		Color( 0.6, 0.8, 0.8 );
	numKnobs.do
	(
		{
			arg i;
			// Here Button returns the
			// button class for the current kit
			k = Knob
			(
				w,
				Rect
				(
					rrand( 20, 300 ),
					rrand( 20, 300 ),
					size,
					size
				)
			);
			k.action_(
				{
					|v|
					[
						"action func",
						v.value
					].postln;
				}
			);
		}
	);
	w.front;
)

({ 	// example of .fork as replacement
	// for Routine
	5.do
	{
		"hello".postln;
		1.0.wait
	}
}.fork(TempoClock(1)))

(	// example of how to use repeating
	// inside a routine with waits
	var r;
	r = Routine.new
	(
		{
			16.do(
				{
					arg i;
					Synth(
						\bleep,
						[
							\note,
							36+(3*i)
						]
					);
					// yield and wait mean
					// (does yeild return a value,
					// while wait doesn't?)
					(rrand( 0.2, 0.5 )).wait;
				}
			);
		}
	);
	r.play;
)

( // example of .wait in routines
	var r;
	r = Routine.new({
		"I just began!".postln;
		1.0.wait;
		"1 second later".postln;
		2.0.wait;
		"finished".postln;
	});

	r.play; //defaults to TempoClock.default;
)

( // world's simplest Routine demo
	r=Routine
	({					// note, routine's constructor
		1.yield; 		// takes a function that yeilds
		2.yield;		// several times. after you've
		3.yield;		// run out of yeilds, it returns
	})					// nil.
)
r.value; //run this line four times

// how to use AppClock to move a window
( // stop everything with F12 / cmd+. to stop moving
	var w, i;
	i = 0;
	w = Window(
		"My Window",
		Rect(100, 0, 200, 50),
		resizable:false
	);
	// A 200 by 200 window appears
	// at screen co-ordinates (100, 0)
	w.front;
	//schedule moves and resizes for the window
	// don't use SystemClock here!
	AppClock.sched(
		0.0,
		{
			w.bounds_(
				Rect(
					100, (10 * i) % 500,
					rrand(200,400),
					50
				)
			);
			i=i+1;
			0.125
		}
	);
)


// basic example of scheduling
( // part 1
	SynthDef(
		"bleep",
		{
			arg
				out=0,
				note=60,
				amp=0.5,
				pan=0.0;
			var
				freq,
				env;
			freq =
				note.midicps; 	// midi cycles per second
			env = EnvGen.ar
			(
				Env
				(
					[0,1,1,0],
					[0.01, 0.1, 0.2]
				),
				levelScale:amp,
				doneAction:2 				// IMPORTANT
			);
			Out.ar
			(
				out,
				Pan2.ar
				(
					Blip.ar(freq) * env,
					pan
				)
			)
		}
	).load(s);
)
( // part 2: making the basic rhythm
	SystemClock.sched
	(
		0.0,					//start 0.0 sec from now
		{						//a function to sched
			Synth("bleep");		//synthdef above
			1					//repeat every second
		}
	)
)
( // part 3: different rhythms (fun)
	SystemClock.sched
	(
		1.0,					//start in 1.0 sec
		{
			Synth
			(
				"bleep",
				[					// args:
					"note",			// midi #s of notes:
					(
						#[  		//# makes it fixed
							0, 		// root
							2,  	// M2
							4, 		// m3
							5,		// P4
							7,		// P5
							9		// M6
						]
						+ 48		// middle c?
					).choose,
					"pan",
					1.0.rand2		// [-1,1]
				]
			);
		// random choice of time until repeat:
		[0.25,0.3,0.7,0.1].choose
		}
	)
)
( // part four, using a TempoClock
	var t;
	// make a new tempoclock at
	// tempo 120 bpm = 2 beats per second
	t = TempoClock(2);
	t.schedAbs(
		0,
		{
			// start at absolute beat 0 immediately
			arg ... args;
			//  post the input arguments
			// to our event function
			args.postln;
			//  (will post logical time in
			// beats, elapsed time
			//  in seconds of enclosing
			// thread and this clock)
			Synth(\bleep);// make a bleep
			1.0	// reschedules every beat
		}
	)
)
( // part 5: scheduling with weighted probabilities
	t = TempoClock.default;
	t.schedAbs(
		t.elapsedBeats.ceil, 	// start @ next beat
		{
			Synth(
				\bleep,
				[
					\note,
					[36,40,43].choose,
					\pan,
					1.0.rand2
				]
			);
			[				// repeat at some number of beats
				0.25,		//from the array-
				0.5,
				1.0,
				nil			// nil means stop
			].wchoose(		//weighted choice of selecting
				[			// the repetitions above:
					0.5,	// 50% chance of 16th note
					0.4,    // 40% chance of eighth note
					0.05,	// 5% chance of quarter note
					0.05	// 5% chance of stopping.
				] 			// there must be as many weights
			); 				// as items to pick from and must
		}					// add up to 1.
	)
)
( // part 6: scheduling tempo changes
	var u;
	u=TempoClock(3.5); 		// 1.2 bps = 60*1.2 = 70 bpm
	u.schedAbs(
		0.0,			// try to start 5 s ago!
		{				// loud burst of events
			arg
				beat,
				sec;
			[beat,sec].postln;
			Synth(
				\bleep,
				[
					\note,
					rrand(		// random note
						60.0,   // between midi60
						67.0    // and midi67
					)
				]
			);
			0.5					// repeat every 1/2 sec
		}
	);
	// now schedule some tempo changes:
	u.schedAbs(
		8.0,
		{
			u.tempo_(2);
			nil
		}
	);
	u.schedAbs(
		12.0,
		{
			u.tempo_(7);
			nil
		}
	);
	u.schedAbs(
		17.2,
		{
			u.tempo_(1);
			nil
		}
	);
	u.schedAbs(
		20.0,
		{	// what does this do?
			u.clear; // schedule stop for 7 s fn
		}
	);
)
( // part 7; // Changing Tempo via a UI control
	var
		w,
		u,
		slid,
		button;
	w = Window(
		"tempo control test",
		Rect(100,100,200,40),
		resizable:false
	);
	slid = Slider(
		w, Rect(0,0,200,20)
	);
	button = Button(
		w, Rect(60,20,40,20)
	);
	button.states_([["kill"]]);
	w.front;
	slid.action_		// set action of slider to
	(					// update tempo
		{
			// slider range is always 0.0-1.0,
			// so mapped in the code
			u.tempo_(2*(slid.value)+1)
		}
	);
	button.action_({u.clear; w.close;});
	u = TempoClock(1);
	u.schedAbs(
		0.0, 				// start now
		{
			arg
				beat,
				sec;
			[beat,sec].postln;  // print the beats & sec
			Synth(
				\bleep,
				[\note, rrand(60, 100)] // rand note
			);
			1.0							// repeat each s
		}
	);
)
( // part 8: how to schedule using more than one clock
	var u,v;
	u = TempoClock(1.2);
	v = TempoClock(1.3);
	u.schedAbs( 	// schedule on the one tempo clock
		0,
		{
			Synth(
				\bleep,
				[
					\note,
					rrand(41.8,47.5),
					\pan,
					-0.5
				]
			);
			1.0
		}
	);
	v.schedAbs(		// schedule on the other tempo clock
		0,
		{
			Synth(
				\bleep,
				[\pan, 0.5]
			);
			1.0
		}
	);
	SystemClock.sched(
		10.9,  			// sched a stop 10 sec from now
		{
			u.clear; v.clear;
		}
	);
)

// very nice example of a button grid
// also good example of generic programming
// style that's cross platform!!!
(
	// Window returns the window class
	// for the current kit
	w = Window
	(
		"my name is...",
		Rect( 128, 64, 340, 360 ),
		resizable: false
	);
	// comment the following out for no decorator
	w.view.decorator =
		FlowLayout( w.view.bounds );
	// you can use this instead of
	// the above line for brevity:
	// w.addFlowLayout
	w.view.background = Color( 0.6, 0.8, 0.8 );
	32.do
	(
		{
			arg i;
			// Here Button returns the
			// button class for the current kit
			b = Button
			(
				w,
				Rect
				(
					rrand( 20, 300 ),
					rrand( 20, 300 ),
					75,
					24
				)
			);
			b.states =
				[
					[
						"Start " ++ i,
						Color.black,
						Color.rand
					],
					[
						"Stop " ++ i,
						Color.white,
						Color.red
					]
				];
		}
	);
	w.front;
)

// very nice example of JSCEnvelopeView
// an envellope viewer / editor
// to select + move several points, press the mouse
// somewhere on the panel and drag a rubberband.
// to extend the rubberband-selection, keep shift pressed.
//
// alternatively, shift+click on successive nodes.
//
// to deselect all, click somewhere on the panel.
// to deselect a single node, shift+click on it.
(
a = JSCWindow( "envelope", Rect( 200, 450, 250, 100 ));
b = JSCEnvelopeView( a, Rect( 4, 4, 230, 80 ))
	.selectionColor_( Color.red )
	.resize_( 5 )
	.action_({ arg b; [ b.index, b.value ].postln }) // print last clicked index along with all node values
	.value_([[ 0.0, 0.1, 0.5, 1.0 ], [ 0.1, 1.0, 0.8, 0.0 ]]); // set the initial node values (x and y)
a.front;
)

// cool visualize sound file samples
(
    f = nil;
    w = JSCWindow
	(
		"Soundfile View",
		Rect( 300, 300, 770, 270 )
	);
    JSCStaticText
	(
		w,
		Rect( 20, 10, 40, 20 )
	)
        .align_( \right )
        .string_( "Path:" );
    x = JSCDragSink( w, Rect( 70, 10, 650, 20 ))
        .resize_( 2 )
        .action_
		(
			{
				arg b;
				if
				(
					f.notNil,
					{
						f.close;
						f = nil;
					}
				);
				f = SoundFile.new;
				f.openRead( b.object );
				GUI.useID
				(
					"swing",
					{
						f.inspect
					}
				);
				a.soundfile         = f;
				a.gridOn            = false;
				y.lo                = 0;
				y.hi                = 1;
				a.readWithTask
				(
					0,
					f.numFrames,
					doneAction:
					{
						arg b;
						a.gridResolution =
							(
								b.soundfile.numFrames /
									(b.soundfile.sampleRate * 16)
							).max(0.1);
						a.gridOn = true;
					}
				);
			// a.read( 0, f.numFrames ); // warning...
			}
		);
    JSCButton
	(
		w,
		Rect( 730, 10, 20, 20 )
	)
        .resize_( 3 )
        .states_([[ "..." ]])
        .action_
		(
			{
				arg b;
				SwingDialog.getPaths
				(
					{
						arg paths;
						x.object =
							paths.first;
						x.doAction;
					},
					maxSize: 1
				);
        	}
		);
    a = JSCSoundFileView
	(
		w,
		Rect( 20, 40, 700, 180 )
	)
    	.resize_(5);
    a.elasticMode       	= 1;
    a.timeCursorOn      	= true;
    a.timeCursorColor       = Color.red;
	// a.timeCursorPosition = 2500;
    y = JSCRangeSlider(
		w,
		Rect( 20, 230, 700, 20 )
	)
        .resize_(8)
        .action_(
			{
				arg b;
				a.zoomToFrac
				(
					b.range.max
					(
						a.bounds.width /
							a.numFrames.max(1)
					)
				);
				if
				(
					b.range < 1,
					{
						a.scrollTo
						(
							b.lo /
								(1 - b.range)
						)
					}
				);
			}
		);
    JSCSlider(
		w,
		Rect( 730, 40, 20, 180 )
	)
        .resize_( 6 )
        .value_( 0.5 )
        .action_
		(
			{
				arg b;
				a.yZoom =
					b.value.linexp
					(
						0,
						1,
						0.02,
						50.0
					);
        	}
		);
    w.front;
)

// cool gui example: multislider
( // part 1
	//use as table
	var size;
	size = 350 / 6;
	a = JSCWindow(
		"test",
		Rect(200 , 450, 360, 150), // 10 more w,h than ...
		resizable:false
	);
	a.view.decorator =
		FlowLayout(a.view.bounds);
	b = JSCMultiSliderView(
		a,
		Rect(0, 0, 350, 140) 	// ... this (see above)
	);
	c = Array.new;
	size.do(
		{
			arg i;
			c = c.add(0.01 * i);
		}
	);
	c = c.reverse;
	b.value_(c);
	b.isFilled_(true);
	// width in pixels of each stick
	b.indexThumbSize_(2.0);
	// spacing on the value axis
	b.gap_(4);
	// if you want it to snap to a grid
	//	b.step = 0.125;
	b.resize = 5;       // so the view adjusts with the window bounds
	a.front;
)
( // optional second part to flip on side
	b.resize = 1;
	b.indexIsHorizontal_(false);
	a.bounds_(Rect(200 , 450, 120, 410));
	b.bounds_( Rect(10, 10, 100, 390));
	b.background_(Color.black);
	b.strokeColor_(Color.white);
	b.fillColor_(Color.white);
	b.gap = 1;
	a.front;
)

// really cool example using sound and
// a 2D slider.
( // part 1
	SynthDef(
		"filterme",
		{
			arg
				freq=1000,
				rq=0.5
			;
			Out.ar(
				0,
				Pan2.ar(
					BPF.ar(
						Impulse.ar(
							LFNoise0.kr(
								15,
								500,
								1000
							),
							0.1,
							WhiteNoise.ar(2)
						),
						freq,
						rq
					)
				)
			)
		}
	).send(s);
)
( // part 2
	var
		w,
		slid2d,
		syn
	;
	w=
		JSCWindow(
			"My Window",
			Rect(100,300,200,200),
			resizable:false
		)
	;
	slid2d=
		JSC2DSlider(
			w,
			Rect(5,5,190,190)
		)
	;
    slid2d.knobColor_(
		Color( 0.125, 0.6, 0.25, 0.8 )
	);
	syn=
		Synth("filterme")
	;
	slid2d.action_(
		{
			[
				slid2d.x,
				slid2d.y
			].postln;
			syn.set(
				"freq", 100+(10000*slid2d.y),
				"rq", 0.01+(0.09*slid2d.x)
			);
		}
	);
	w.front;
	w.onClose={
		syn.free;
	};
)

// example of how to make guis
// look good with my window manager
(
    var win;
    win = JSCWindow(
		"JSC2DSlider",
		Rect( 100, 100, 340, 140 ),
		resizable: false  	// !! this line is the difference!
	);
    n = JSC2DSlider(
		win,
		Rect( 20, 20, 80, 80 )
	).x_( 1 ).y_( 1 );
    n.knobColor_(
		Color( 0.75, 0.125, 0.25, 0.8 )
	);
    n = JSC2DSlider(
		win,
		Rect( 120, 20, 80, 80 )
	).x_( 0.5 ).y_( 0.5 );
    n.knobColor_(
		Color( 0.125, 0.6, 0.25, 0.8 )
	);
    n = JSC2DSlider(
		win,
		Rect( 220, 20, 80, 80 )
	).x_( 0 ).y_( 0 );
    n.knobColor_(
		Color( 0.125, 0.25, 0.75, 0.8 )
	);
    win.front;
)
// basic slider example (GUI)
(
	var
		w,
		slid,
		cs
	;
	w=
		JSCWindow(
			"My Window",
			Rect(
				100,
				500,
				200,
				200
			)
		)
	;
	slid=
		JSCSlider(
			w,
			Rect(
				10,
				10,
				150,
				40
			)
		)
	;
	cs=
		ControlSpec( 	// use this
			20, 		// to turn
			20000,		// the nums
			'exp',		// into a
			10,			// useful range
			1000
		)
	;
	slid.action_(
		{
			cs.map(
				slid.value
			).postln;
		}
	);
	w.front;
)

// great example of how to loop
// one second of mic over and over
(
	var b;
    b=Buffer.alloc(s,44100*(10),1);	//1 second mono buffer
~inLoop=	{
		//continuously record in a loop,
		//recording to the buffer we just declared
		//each record cycle multiplies the old data
		RecordBuf.ar(
		AudioIn.ar(1),
			b.bufnum,
			0.25,
			1.0,
			0.6,
			1,
			1,
			1
		);
		//playback the captured buffer
		//in a loop, backwards
		Pan2.ar(PlayBuf.ar(
			1,
			b.bufnum, -0.6
		), 3.rand2,0.85
	);
	};
)

~inLoop.play;

~inLoop.clear;

// example: really cool granular
// reconstruction of mic sound
// given a file sound that it tries
// to trigger parts of
( // step 1: load the sample to synthesize from
	 s.sendMsg(
	 	"b_allocRead",
		10,
		"/home/myer/Documents/soundsamples/74755__jordanthebamf__CERAMIC_PING_12.wav"
	);
)
( // step 2: play the stuff
	var fftbuf;
	fftbuf=Buffer.alloc(s,2048,1);
	{
		var b =
			10,
			source1,
			detect;
		source1= SoundIn.ar(0);
		detect= PV_HainsworthFoote.ar(
			FFT(
				fftbuf.bufnum,
				source1
			),
			1.0, 0.0, 0.7, 0.01);
		TGrains.ar(
			2, detect, b,
			LFNoise0.kr(10,0.2,1.0),
			MouseX.kr(0,BufDur.kr(b)),
			MouseY.kr(0.1,0.5),
			LFNoise0.kr(10,1.0),
			0.5,
			2
		);
}.play
)

// example of thresholding the noise
// on mic audio input
({
	var input,inputAmp,threshhold,gate;
	var basefreq;
	input = SoundIn.ar(
		0,
		0.7						// input at 70% vol
	);
	inputAmp = Amplitude.ar(
		input
	);
	threshhold = 0.01;			// noise gating threshold
	gate = Lag.ar(
		inputAmp > threshhold,
		0.005					// tell it to lag 5 ms
	);
	Pan2.ar(
		(input * gate),
		0,
		0.7
	)
}.play;)

// amazing ring modulation
// on microphone with mouse
({
	Pan2.ar(
		SinOsc.ar(
			MouseX.kr(
				0.001,
				110,
				'exponential'
			)
		) *
		SoundIn.ar(
			0,
			0.7
		),
		0,
		0.7
	)
}.play)

// how to get sound in, basic
// careful of feedback! tuned
// to mic + headphones
({
	Pan2.ar(
		SoundIn.ar(
			1,
			0.7
		),
		0,
		0.5
	)
}.play;)

// amazing, strummable guitar
// use mouse to strum strings
({
	var pitch, mousex, out;
	pitch = [ 52, 57, 62, 67, 71, 76 ];		// e a d g b e
	mousex = MouseX.kr;
	out = Mix.fill(
		pitch.size,
		{ 	arg i;
			var trigger, pluck, period, string;
			// place trigger points from 0.25 to 0.75
			trigger = HPZ1.kr(
				mousex > (0.25 + (i * 0.1))
			).abs;
		pluck = PinkNoise.ar(
			Decay.kr(
				trigger,
				0.05
			)
		);
		period = pitch.at(i).midicps.reciprocal;
		string = CombL.ar(
			pluck,
			period,
			period,
			4
		);
		Pan2.ar(
			string,
			i * 0.2 - 0.5
		);
	});
	LPF.ar(out, 12000);
	LeakDC.ar(out);
}.play;)

// example of mouse as trigger
({
	var trig,mx;
	mx=MouseX.kr(
		0.0,
		1.0
	);
	//this is a UGen which compares
	// mx to the constant signal
	// 0.5 at krate
	trig= mx>0.5;
	SinOsc.ar(
		440,
		0,
		0.1*trig
	)
}.play;)

// example of trigger in a given region
({
	var trig,mx,my;
	mx=MouseX.kr(
		0.0,
		1.0
	);
	my=MouseY.kr(
		0.0,
		1.0
	);
	trig= if(
		//if is a UGen here, * is
		//equivalent to logical AND
		(mx>0.3) * (mx<0.5) *
			(my>0.3) * (my<0.7),
		1,
		0
	);
	SinOsc.ar(
		440,
		0,
		0.1*trig
	)
}.play;)

// example of many mouse regions,
// dedicated to harmonics.
(
	var vals, buf, s;
	var numharm,basefreq;
	numharm=11; 	//number of harmonics
	basefreq=66;	//base frequency of series
	s=Server.local;
	vals= basefreq*(
		Array.series(
			numharm,
			1,
			1
		)
	);
	buf=Buffer(
		s,
		vals.size,
		1
	);
	// alloc and set the values
	s.listSendMsg(
		buf.allocMsg(
			buf.setnMsg(
				0,
				vals
			)
		)
	);
	// play function
	{
		SinOsc.ar(
			Index.kr(
				buf.bufnum,
				MouseX.kr(
					0,
					numharm)
			),
			0,
			0.1
		)
	}.play
)

// example of three regions with mouse
// there are three distinct states
// left, middle and right of the screen
(
	var vals, buf, s;
	s=Server.local;
	vals= [100,200,300];
	buf=Buffer(
		s,
		vals.size,
		1
	);
	// alloc and set the values
	s.listSendMsg(
		buf.allocMsg(
			buf.setnMsg(
				0,
				vals
			)
		)
	);
	// play function
	{
		SinOsc.ar(
			Index.ar(
				buf.bufnum,
				MouseX.kr(
					0,
					vals.size+1
				)
			),
			0,
			0.2)
	}.play
)

// example of synthdef construct
(SynthDef(
	"sine", 			// use name 'sine' for synth
	{Out.ar(			// tell what to output
		0,				// which bus to use (the first)
		SinOsc.ar(		// start the description of the sound
			Rand(
				440,
				880
			),
			0,
			0.1
		)				// end the description of the sound
	)}					// end the instructions for output
).load(s);)				// tell the system about it
// example of how to call (play) that synthdef
a=Synth("sine");
// to load and play in one step, use .play(s)
// instead of .load(s).

// example of synthdef with arguments
(SynthDef(
	"sine",
	{
		arg 				// note
			freq=440,		// comma delimited args
			amp=0.1;	    // with default examples
		Out.ar(
			0,
			SinOsc.ar(
				freq,		// using argument 'freq'
				0,
				amp			// using argument 'amp'
			)
		)
	}
).load(s))
// example of how to call default arguments
Synth("sine");
// example of how to call (play) SynthDef with arguments
Synth("sine",["freq",880]); // note use of quotes here
// I could have used \sine and \freq
// another variation with more than one argument
c=Synth("sine",["freq",660,"amp",0.5]);
// to stop just one, use this
c.free;

// check out this cool way of writing a function!
// good style!
({
	var
		source,
		line,
		filter
	;
	source=
		LFNoise0.ar(400);
	line=
		Line.kr(
			10000,
			1000,
			10
		)
	;
	filter=
		Resonz.ar(
			source,
			line,
			0.1
		)
	;
	// last thing is returned from function
	// in curly brackets,
	// i.e. this is the final sound we hear
	filter
}.scope;)

// example of good programming style conventions
({
	var
		carrier,
		modulator,
		carrfreq,
		modfreq
	;
	carrfreq=
		MouseX.kr(
			440,
			5000,
			'exponential'
		)
	;
	modfreq=
		MouseY.kr(
			1,
			5000,
			'exponential'
		)
	;
	carrier=
		SinOsc.ar(
			carrfreq,
			0,
			0.5
		)
	;
	modulator=
		SinOsc.ar(
			modfreq,
			0,
			0.25,
			0.25
		)
	;
	carrier*modulator;
}.scope)

// these are the same - except for mono and stereo
{SinOsc.ar(400,0,0.1) + SinOsc.ar(660,0,0.1)}.scope // mono
{SinOsc.ar([400,660],0,0.1)}.scope // stereo
{Mix(SinOsc.ar([400,660],0,0.1))}.scope // back to mono

// envelope visualizing example
Env.new([1000,20],[1.0]).plot

// sound file example - sounds amazing!
// sound file example step 1
(
	 b = Buffer.read( s, "/home/myer/Documents/soundsamples/74755__jordanthebamf__CERAMIC_PING_12.wav" );
)
// sound file example step 2
({
	var modf, ind, modulator;
	var b1;
	b1= b.bufnum;
	modf= MouseX.kr(1,4400, 'exponential');
	ind=MouseY.kr(0.0,1.0, 'linear');
	modulator= SinOsc.kr(modf,0,10*modf*ind, 440);
	PlayBuf.ar(
		1,
		b1,
		BufRateScale.kr(b1)* (modulator/440),
		1,
		0,
		1)
}.scope;)

// example of filling array
// to do stuff
// you'll only hear the first
// two of four frequencies
// if you have just a stereo output
({
	var freqs,array;
	freqs= [440,443,447,455.7];
	array=Array.fill(
		4,						// four elements in array
		{
			arg i;				// function argument i
			SinOsc.ar(
				freqs.at(i),  	// make sin at freq i
				0,
				0.1
			)
		}
	);
	array 						// return the array
}.scope)

//@!********************
// ##tips **************
//!@********************

// tips on recording to disk
// surprisingly not easy
DiskOut

// tips on live programming / JIT programming
help file for JITLib

// tips on sequencing with patterns
// shift k on this
Streams

// tips on control structures: shift k on this
Control-Structures

// looking for the right sound? shift k on this
Tour_of_UGens

// exponential notation
1e2 = 100
2e4 = 2^4 = 16

// about routines: to play and then reset
r.reset
r.play(SystemClock)
r.reset;
r.play(TempoClock(3))

// when performing manipulations of guis
// don't use SystemClock, use AppClock
// one way to do this is to do this:
{
	//GUI code here
}.defer

// there is a default tempoclock
t= TempoClock.default;
t.elapsedBeats;					// how many beats elapsed
t.bar;							// how many bars elapsed
t.elapsedBeats.ceil; 			// next beat
t.elapsedBeats.floor; 			//find last beat

// tips on scheduling
[Routine]
[Task]
[SystemClock]
[TempoClock]
[AppClock]
// start something at next whole beat
t=TempoClock.default;
t.schedAbs(t.elapsedBeats.ceil ...

// tips on GUI components
JSCWindow.viewPalette // really nice
JSCMultiSliderView
JSCEnvelopeView
JSCSoundFileView
JSCMovieView
JPen

// tips on mapping ranges of values to other ranges
ControlSpec

// tips on my SuperCollider folder
/usr/share/SuperCollider

// tips on classes for tablets and joysticks:
HIDDeviceService.buildDeviceList;
SC2DTabletSlider
HIDDeviceService
GeneralHID
MouseButton
KeyState
SerialPort

// tips on onset detectors
Onsets
PV_HainsworthFoote
PV_JensenAndersen

// tips on obtaining a grid freq scope
FreqScope.new

// tips on random numbers
2.rand // picks integers from [0,1]
2.0.rand // picks random floats less than 2
2.rand2 // picks random ints from [-2,2]
2.0.rand2 // picks random floats from (-2,2)
rrand(2,4) // picks random ints from [2,4]
rrand(2.0,4.0) // picks random floats from (2.0,4.0)
exprand(1.0,10.0) // picks random floats from (1.0,10.0)
// what is this last one really doing??

// tips on midi
MIDIClient.init
MIDIIn
MIDIOut
MIDIResponder

//@!************************
// ##questions *************
//!@************************

// why doesn't this work: ------------------
// execute the code below to find out a key's keycode
// the char and keycode of any key you press will be printed in the post window
(
	w = Window.new("I catch keystrokes");
	w.view.keyDownAction = { arg view, char, modifiers, unicode, keycode; [char, keycode].postln; };
	w.front;
)
// then execute this and then press the 'j' key
(
	w.front; // something safe to type on
	{ SinOsc.ar(800, 0, KeyState.kr(38, 0, 0.1)) }.play;
)

// (does yeild return a value,
// while wait doesn't?)

// -- What are the keyboard shortcuts for scvim? are any 'left out'?

// what is the keyboard shortcut for 'find method in help' in scvim? for example, put cursor on .fill, and shift k doesn't bring up the help for Array.fill

// -- Where is the SuperCollider application directory when using scvim? Is it the same as scvim?

// why doesn't this work in scvim?
// from 5.1 of collins tutorial
(
	var doc;
	SynthDef(
		"typeofsound",
		{Out.ar(
			0,
			Line.kr(1,0,0.1,doneAction:2)*
				VarSaw.ar(
					Rand(100,1000),
					0,
					Rand(0.1,0.8),
					0.1
				)
		)}
	).send(s);
	//this text window you're reading from!
	doc = Document.current;
	doc.keyDownAction_(
		{arg ...args;
		[args[1],args[3]].postln;
		Synth("typeofsound");
	});
)

//@!*********************
// ##todo ***************
//!@*********************

// -- make the tab stops for .sc files 2 or 3 chars

