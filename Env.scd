Env.new.plot;
s.plotTree;
s.freeAll;

(
x = {
	var sig, env, freq;
	env = XLine.kr(1, 0.01 , 10, doneAction:2);
	freq = XLine.kr(525.3, 65.4, 9, doneAction:0);
	sig = Pulse.ar(freq) * env;
}.play;
)

(
 a = {
	var sig, env;
	env = EnvGen.kr(Env.new(
		[0, 1, 1, 0],
		[2, 3, 4],
		[3, -3, -4]),
	    doneAction:2);
	sig = Pulse.ar(LFPulse.kr(10).range(800, 900)) * env;
	Out.ar(0, sig);
	Out.ar(1, sig);
}
)

a.play;


Env.new([0, 1, 1, 0], [2, 3, 4], [3, -3, -4]).plot;


{ LFPulse.kr(4).range(800, 900)}.plot(1);


