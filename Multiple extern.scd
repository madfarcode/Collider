s.meter;
x = {[SinOsc.ar(500, 1, 0.01) , SinOsc.ar(800, 1, 0.3)]}.play;
x.free;


(
u = {
	arg osc1 = 7, osc2 = 1, osc3 = 2, osc4 = 6;
	var sig, amp, env;
	env = EnvGen.kr(Env.new(
		[0, 1, 0.5, 1, 0],
		[6, 7, 5, 9],
		[3, -3, -2, -4]),
	    doneAction:2

	);
	amp = SinOsc.kr([8,4,2]).range(0,0.8);
	sig = SinOsc.ar([130.8,82.4,98.0]);
	sig = (sig * amp) * env;
	sig = FreeVerb.ar(sig, 0.7, 0.8, 0.25);
	Splay.ar(sig);
}.play;
)

Env.new([0, 1, 0.5, 1, 0],[2, 3, 3, 4],[3, -3, -2, -4]).plot;

u.free;