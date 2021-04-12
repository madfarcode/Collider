~b0 = Buffer.read(s, "C:/Users/Jim/Desktop/SuperCollider/sheep.wav");
~b0.play;
~b1 = Buffer.read(s, "C:/Users/Jim/Downloads/sirenpolice.wav");
~b1.play;

///FRAMES
~b0.numFrames;

///Channels
~b0.numChannels;

/// Samples
numSamples = numFrame * numChannels

/// Duration
~b1.duration;

///Buffer Number (bufnums);
~b0.bufnum;
~b1.bufnum;

/// Buffer Sample RATES
~b0.sampleRate;
s.sampleRate;

/// Summary
~b0.query;

/// Read only a part of a buffer

~b1_part2 = Buffer.read(s, "C:/Users/Jim/Downloads/sirenpolice.wav",1100000 ,1267813);
~b1_part2.zero;
~b1_part2.query;
~b1_part2.play;

///Import multiple Sounds

~piano = Array.new;
~folder = PathName.new("C:/Users/Jim/Desktop/SuperCollider/Piano à Q/");

(
~folder.entries.do({
	arg path;
	~piano = ~piano.add(Buffer.read(s, path.fullPath));
});
)
~piano.at(0).bufnum;
~piano.at(0).play;
~piano.at(2).play;
~piano.at(4).play;
~piano.at(5).play;
~piano.at(7).play;
~piano.at(9).play;
~piano.at(11).play;
~piano.at(0).play;

/// PlayBuf

(
SynthDef.new(\playbuf_test, {
	arg amp=0.5, out=0, buf, da=2;
	var sig;
	sig = PlayBuf.ar(2, buf, 0.3, doneAction:da); /// (1(Outputnumber), 2(BufferSelect))
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)

Synth.new(\playbuf_test, [\buf, ~piano.at(0).bufnum]);
Synth.new(\playbuf_test, [\buf, ~piano.at(3).bufnum]);
Synth.new(\playbuf_test, [\buf, ~piano.at(7).bufnum]);

s.freeAll;

/// BufRd

(
SynthDef.new(\playbuf_noise, {
	arg amp=0.5, out=0, buf, da=2,start, end, freq=1;
	var sig, ptr;
	ptr =  LFNoise1.ar(freq).range(start, end);
	sig = BufRd.ar(2, buf, ptr); /// (1(Outputnumber), 2(BufferSelect))
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)

Synth.new(\playbuf_noise, [\buf, ~piano.at(3).bufnum, \start, ~piano.at(0).numFrames/3 ,\end, ~piano.at(0).numFrames - 500, \freq, 1.5]);
Synth.new(\playbuf_noise, [\buf, ~piano.at(6).bufnum, \start, ~piano.at(0).numFrames/4 ,\end, ~piano.at(0).numFrames - 500, \freq, 0.5]);
Synth.new(\playbuf_noise, [\buf, ~piano.at(11).bufnum, \start, ~piano.at(0).numFrames/8 ,\end, ~piano.at(0).numFrames - 500, \freq, 1]);

s.freeAll;
~piano.at(0).query;






