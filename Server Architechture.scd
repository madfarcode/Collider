s.plotTree;
s.meter;

(
SynthDef.new(\blip, {
	arg out, fund = 300, dens=2, decay=0.2;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(fund, fund*4).round(fund);
	sig = SinOsc.ar(freq.postln) * 0.25;
	trig = Dust.kr(dens);
	sig = sig * EnvGen.kr(Env.perc(0.01, decay), trig);
	sig = Pan2.ar(sig, LFNoise0.kr(10));
	Out.ar(out, sig);
}).add;
)
(
SynthDef.new(\reverb, {
	arg in, out=0;
	var sig;
	sig = In.ar(in, 1);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;
	Out.ar(out, sig);
}).add;
)

s.options.numAudioBusChannels;
s.options.numOutputBusChannels = 4;
s.options.numInputBusChannels = 2;

s.reboot;
s.meter;
s.freeAll;

~reverbBus = Bus.audio(s, 1);
~reverbBus.index;


y = Synth.new(\reverb, [\in, ~reverbBus.index], ~fxGrp);

4.do {
	Synth.new(
		\blip,
		[
			\out, ~reverbBus.index,
			\fund.exprand(60,300).round(30)
		],
		~sourceGrp
	);
}

~sourceGrp = Group.new;
~fxGrp = Group.after(~sourceGrp);

~sourceGrp.freeAll;

x.free;
