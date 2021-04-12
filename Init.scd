s.options.device = "ASIO : ASIO4ALL";
s.boot;

x = { SinOsc.ar(XLine.kr(3000, 500, 30), 0, 0.5) }.play;

x.free;

y = { SinOsc.ar(34.6*8*2, 1, 1.6, 0)}.play;
t = { SinOsc.ar(41.2*8*2, 1, 1.6, 0)}.play;
s = { SinOsc.ar(49.0*8*2, 1, 1.6, 0)}.play;
s.free;
y.free;
t.free;

(
z = {
	arg freq=400, amp=0.5;
	var sig;
	sig = SinOsc.ar(freq) * amp;
	Out.ar(0, sig);
	Out.ar(1, sig);
}.play;
)
var do
do = 32.7*16
z.set(\freq, do);
z.set(\freq, 1130);
z.set(\amp, 0.125);
z.set(\amp, 0.550);

z.free;

(
u = {
	arg freq, sig, amp = 1, rate = 2;
	freq = LFNoise0.kr(rate).exprange(200,1000);
	sig = SinOsc.ar(freq) * amp;
	Out.ar(0, sig);
	Out.ar(1, sig);
}.play;
)
u.set(\amp, 0.9);
u.set(\rate, 6);

u.free;

SynthDef.new(\sineTest, {
	arg freq, sig, amp = 1, rate = 2;
	freq = LFNoise0.kr(rate).exprange(200,1000);
	sig = SinOsc.ar(freq) * amp;
	Out.ar(0, sig);
}).add;
)

o = Synth.new(\sineTest, [\rate, 6]);

o.free;

(
SynthDef.new(\pulseTest, {
	arg ampHz=4, fund = 34.6, maxPartial = 16, width=0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
	amp1 = LFPulse.kr(ampHz, 0, 0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz, 0.5, 0.12) * 0.75;
	freq1 = LFNoise0.kr(7).exprange(fund, fund*maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(8, add:1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq1, width, amp2);
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.3, 0.9, 0.25);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)

p = Synth.new(\pulseTest);

p.set(\width, 0.8);
p.set(\fund,69.3 );
p.set(\maxPartial, 4);
p.set(\ampHz, 3);

p.free;

f = {PinkNoise.ar*0.5}.play;

f.free;






