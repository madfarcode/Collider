
(
SynthDef.new(\sine, {
	arg  freq=440, atk=0.005, rel=0.7, amp=0.2, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env =EnvGen.kr(Env.new([0, 1, 0], [atk, rel],[1, -1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0, sig);
}).add;
)

Synth.new(\sine)

p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([2, 2, 1], inf).trace,
	\freq, Pseq([60, 65, 67].midicps, inf).trace,
    \rel, Pwhite(3.0, 4.0, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
).play;

u = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([3, 3, 2], inf).trace,
	\freq, Pseq([48, 53, 58].midicps, inf).trace,
    \rel, Pwhite(4.0, 5.0, inf),
	\atk, Pwhite(1.0, 2.0, inf),
	\amp, 0.2,
).play;

p .stop;
u.stop;

x = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([0.6, 0.15, 0.15], inf).trace,
	\midinote, Pexprand(60, 67, inf).trace,
).play;

d = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pwhite(0.05, 0.5, inf).trace,
	\freq, Pexprand(50,4000, inf).trace,
	\atk, Pwhite(2.0, 3.0, inf),
	\rel, Pwhite(1.0, 3.0, inf),
	\amp, Pexprand(0.01, 0.2, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
).play;


d.stop;
x.stop;