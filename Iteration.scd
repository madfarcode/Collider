[6, 4 ,5, 4].do{'hello'.postln};

(
[6, 4, 0.5, 10, 7].do{
	arg item;
	item.squared.postln;
}
)

(
x = Array.newClear(5);

[6, 4, 0.5, 10, 7].do{
	arg item, count;
	x[count] = item.squared;
}
)
x;

z = [6, 4, 0.5, 10, 7].collect(_.squared);

5.do{arg item; item.postln};

k = {VarSaw.ar(40!2, 0, 0.05)}.play;
k.free;

(
SynthDef.new(\iter, {
	arg freq = 261.6;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(Env.new(
		[0, 1, 1, 0],
		[2, 3, 4],
		[3, -3, -4]),
	    doneAction:2);
	15.do{
		temp = VarSaw.ar(
			freq * {Rand(0.99,1.02)}!2,
			{Rand(0.0,1.0)}!2,
			0.05
		);
		sum = sum + temp
	};
	sum = (sum * 0.05) * env;
	Out.ar(0, sum);
}).add;
)

f = Synth.new(\iter, [\freq, 66.midicps]);
f = Synth.new(\iter, [\freq, 68.midicps]);
f = Synth.new(\iter, [\freq, 70.midicps]);
f = Synth.new(\iter, [\freq, 71.midicps]);

f.free;

(
SynthDef.new(\iter2, {
	arg freq = 261.6;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(Env.new(
		[0, 1, 1, 0],
		[2, 3, 4],
		[3, -3, -4]),
	    doneAction:2);
	6.do{
		arg count;
		temp =  SinOsc.ar(freq * (count + 2) * LFNoise1.kr({Rand(0.05, 0.2)})!2).range(0.98,1.02);
		sum = sum + temp
	};
	temp = temp * LFNoise1.kr({Rand(0.5,8)}!2).exprange(0.01,1);
	sum = (sum * 0.08) * env;
	sum = FreeVerb.ar(sum, 0.7, 0.8, 0.25);
	Out.ar(0, sum);
}).add;
)

o = Synth.new(\iter2, [\freq, 66.midicps]);
o = Synth.new(\iter2, [\freq, 68.midicps]);
o = Synth.new(\iter2, [\freq, 70.midicps]);
o = Synth.new(\iter2, [\freq, 71.midicps]);

o.free;





	