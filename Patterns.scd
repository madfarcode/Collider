~a = Buffer.read(s, "C:/Users/Jim/Desktop/SuperCollider/perc lofi/1.wav");
~b = Buffer.read(s, "C:/Users/Jim/Desktop/SuperCollider/perc lofi/2.wav");
~c = Buffer.read(s, "C:/Users/Jim/Desktop/SuperCollider/perc lofi/3.wav");
~a.play;
~b.play;
~c.play;

SynthDef.new(\bufplay, {
	arg buf=0, rate=1, amp=1, pan=0;
	var sig;
	sig = PlayBuf.ar(2, buf, BufRateScale.ir(buf) * rate, doneAction:2); /// (1(Outputnumber), 2(BufferSelect)));
	sig = Pan2.ar(sig, pan, amp);
	sig = FreeVerb.ar(sig, 0.2, 0.8, 0.2);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;


Pdef (
	\rhythm,
	Pbind(
		\instrument,\bufplay,
		\dur, Pseq([0.14], inf),
		\buf, Pseq(
			[
				Pseq((~a!2)++(~c!1)++(~a!1), 4),
				Pseq((~a!3)++(~c!1)++(~a!0), 1),
				Pseq((~a!1)++(~c!2)++(~a!1), 4),
            ],inf).trace,
		\rate, 1,
		\amp, Pseq([0.7,]++(0.2!7), inf),
	);
).play;



(
SynthDef.new(\sine, {
	arg  freq=440, atk=0.005, rel=0.7, amp=0.2, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env =EnvGen.kr(Env.new([0, 1, 0], [atk, rel],[1, -1]), doneAction:2).plot;
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0, sig);
}).add;
)

Synth.new(\sine)

~lead = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([0.14 ], inf).trace,
	\freq, Pseq([0 ,69, 71, 68, 69, 72, 62, 71, 64,62,60,59].midicps, 4).trace,
    \rel, Pwhite(1.0, 1.2, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
).play;

~pad = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([0.6, 0.6, 1.2, 0.6, 0.6], inf).trace,
	\freq, Pseq([57, 45, 57 ,56, 52].midicps, 4).trace,
    \rel, Pwhite(1.0, 1.2, inf),
	\amp, 0.2,
).play;

~lead.stop;
~pad.stop;

x = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([0.6, 0.15, 0.15], inf),
	\midinote, Pexprand(60, 67, inf),
	\harmonic, Pexprand(1, 80, inf).round.trace,
	\amp, Pkey(\harmonic). reciprocal * 0.3,
).play;

~rand= Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pwhite(0.05, 0.5, inf).trace,
	\freq, Pexprand(50,4000, inf).round(55).trace,
	\atk, Pwhite(2.0, 3.0, inf),
	\rel, Pwhite(1.0, 3.0, inf),
	\amp, Pexprand(0.01, 0.2, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
).play;


~rand.stop;
x.stop;

Pdef (
	\sinepad,
	Pbind(
		\type, \note,
		\instrument, \sine,
		\dur, Pwhite(0.05, 1.5, inf).trace,
		\freq, Pexprand(50,500, inf).round(55).trace,
		\atk, Pwhite(0.5, 1.5, inf),
		\rel, Pwhite(1.0, 3.0, inf),
		\amp, Pexprand(0.01, 0.2, inf),
		\pan, Pwhite(-0.8, 0.8, inf),
	);
).stop;





		