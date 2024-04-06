> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [lcamtuf.substack.com](https://lcamtuf.substack.com/p/radios-how-do-they-work)

> A brief introduction to antennas, superheterodyne receivers, and signal modulation schemes.

Radio communications play a key role in modern electronics, but to a hobbyist, the underlying theory is hard to parse. We get the general idea, of course: we know about frequencies and can probably explain the difference between amplitude modulation and frequency modulation. Yet, most of us find it difficult to articulate what makes a good antenna, or how a receiver can tune in to a specific frequency and ignore everything else.

In today’s article, I’m hoping to provide an introduction to radio that’s free of ham jargon and advanced math. To do so, I’m leaning on the concepts discussed in four earlier articles on this blog:

*   [Core concepts in electronic circuits](https://lcamtuf.substack.com/p/primer-core-concepts-in-electronic),
    
*   [Electromagnetic fields and energy storage](https://lcamtuf.substack.com/p/energy-in-electronic-circuits),
    
*   [Signal propagation delays and signal reflections](https://lcamtuf.substack.com/p/signal-reflections-in-electronic),
    
*   [Frequency domain analysis with DFT and DCT](https://lcamtuf.substack.com/p/not-so-fast-mr-fourier).
    

If you’re rusty on any of the above, I recommend jogging your memory first.

### Let’s build an antenna

If you’re familiar with the basics of electronics, a simple way to learn about antennas is to imagine a charged capacitor that’s being pulled apart until its internal electric field spills into the surrounding space:

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F57d23803-f7d6-4e2e-8011-a084f5ea4219_3110x1663.png)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F57d23803-f7d6-4e2e-8011-a084f5ea4219_3110x1663.png)_Turning a capacitor into a terrible antenna._

Electric fields can be visualized by plotting the paths of hypothetical positively-charged particles placed in the vicinity. For our ex-capacitor, we’d be seeing arc-shaped lines that connect the plates — and strictly speaking, extend on both sides all the way to infinity.

An unchanging electric field isn’t very useful for radio — but if we start moving the charges back and forth between the poles of an antenna, we get a cool relativistic effect: a train of alternating fields propagating at the speed of light, sneaking away with some of the energy that we previously could always get back from the capacitor’s static field.

In other words, say hello to electromagnetic waves:

A perfectly uniform waveform is still not useful for communications, but we can encode information by slightly altering the wave’s characteristics — for example, tweaking its amplitude. And if we do it this way, then owing to a clever trick we’ll discuss a bit later, simultaneous transmissions on different frequencies can be told apart on the receiving end.

But first, it’s time for a reality check: if we go back to our dismantled capacitor and hook it up to a signal source, it won’t actually do squat. When we pulled the plates apart, we greatly reduced the device’s capacitance, so we’re essentially looking at an open circuit; a pretty high voltage would be needed to shuffle a decent number of electrons back and forth. Without this motion — i.e., without a healthy current — the radiated energy is negligible.

The most elegant solution to this problem is known as a half-wavelength (“half-wave”) dipole antenna: two rods along a common axis, driven by a sinusoidal signal fed at the center, each rod exactly ¼ wavelength long. If you’re scratching your head, the conversion from frequency (_f,_ in Hz) to wavelength (_λ_) is:

The third value — _c_ — is the speed of light per second in your preferred unit of length.

The half-wave dipole has an interesting property: if we take signal propagation delays into account, we can see that every peak of the driving signal reaches the ends of the antenna perfectly in-phase with the bounce-back from the previous oscillation. This pattern of extra nudges results in a standing wave with considerable voltage swings at the far ends of the antenna. The other perk is a consistently low voltage — and low impedance — at the feed point. Together, these characteristics make the antenna remarkably efficient and easy to drive:

All dipoles made for odd multiples of half-wavelength (3/2 λ, 5/2 λ, …) exhibit this resonant behavior. Similar resonance is also present at even multiples (1 λ, 2 λ, …), but the standing wave ends up sitting in the wrong spot — constantly getting in the way of driving the antenna rather than aiding the task.

Other antenna lengths are not perfectly resonant, although they might be close enough. An antenna that’s way too short to resonate properly can be improved with an in-line inductor, which adds some current lag. You might have seen antennas with spring-like sections at the base; the practice called _electrical lengthening_. It doesn’t make a stubby antenna perform as well as a the real deal, but it helps keep the input impedance in check.

Now that we’re have a general grasp of half-wave dipoles, let’s go back to the antenna’s field propagation animation:

Note the two dead zones along the axis of the antenna; this is due to destructive interference of the electric fields. See if you can figure out why; remember that it takes the signal precisely one half of a cycle to travel along the length of this dipole.

Next, let’s consider what would happen if we placed an identical receiving antenna some distance away from the transmitter. Have a look at _receiver A_ on the right:

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe941fc1d-74d6-4765-bce5-0d95b7145975_1800x1016.jpeg)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe941fc1d-74d6-4765-bce5-0d95b7145975_1800x1016.jpeg)_Some receiver antenna scenarios._

It’s easy to see that the red dipole is “swimming” through a coherent pattern alternating electric fields; it experiences back-and-forth currents between its poles at the transmitter’s working frequency. Further, if the antenna’s length is chosen right, there should be constructive interference of the induced currents too, eventually resulting in much higher signal amplitudes.

The illustration also offers an intuitive explanation of something I didn’t mention before: that dipoles longer than ½ wavelength are more directional. If you look at _receiver B_ on the left, it’s clear that even a minor tilt of a long dipole results in the ends being exposed to opposing electric fields, yielding little or no net current flow.

Not all antennas are dipoles, but most operate in a similar way. Monopoles are just a minor riff on the theme, trading one half of the antenna for a connection to the ground. More complex shapes usually crop up as a way to maintain resonance at multiple frequencies or to fine-tune directionality. You might also bump into antenna arrays; these devices exploit patterns of constructive and destructive interference between digitally-controlled signals to flexibly focus on a particular spot.

### The ups and downs of signal modulation

Compared to antenna design, signal modulation is a piece of cake. There’s _amplitude modulation_ (AM), which changes the carrier’s amplitude to encode information; there’s _frequency modulation_ (FM), which shifts the carrier up and down; and there’s _phase modulation_ (PM) — well, you get the drift. We also have _quadrature amplitude modulation_ (QAM), which robustly conveys information via the _relative_ amplitude of two signals with phases offset by 90°.

In any case, once the carrier signal is isolated, demodulation is typically pretty easy to figure out. For AM, the process can be as simple as rectifying the amplified sine wave with a diode, and then running it through a lowpass filter to obtain the audio-frequency envelope. Other modulations are a bit more involved — FM and PM benefit from phase-locked loops to detect shifts — but most of it isn’t rocket surgery.

Still, there are two finer points to bring up about modulation. First, the rate of change of the carrier signal must be much lower than its running frequency. If the modulation is too rapid, you end up obliterating the carrier wave and turning it into wideband noise. The only reason why resonant antennas and conventional radio tuning circuits work at all is that almost nothing changes cycle-to-cycle — so in the local view, you’re dealing with a nearly-perfect, constant-frequency sine.

The other point is that counterintuitively, _all_ modulation is frequency modulation. Intuitively, AM might feel like a clever zero-bandwidth hack: after all, we’re just changing the amplitude of a fixed-frequency sine wave, so what’s stopping us from putting any number of AM transmissions a fraction of a hertz apart?

Well, no dice: recall from the [discussion of the Fourier transform](https://lcamtuf.substack.com/p/not-so-fast-mr-fourier) that any deviation from a steady sine introduces momentary artifacts in the frequency domain. The scale of the artifacts is proportional to the rate of change; AM is not special and takes up frequency bandwidth too. To illustrate, here’s a capture of a local AM station; we see audio modulation artifacts spanning multiple kHz on both sides of the carrier frequency:

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F816eaccd-380a-4c31-8faf-b7f653817b7a_1800x1201.jpeg)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F816eaccd-380a-4c31-8faf-b7f653817b7a_1800x1201.jpeg)_The talk of the town._

Indeed, all types of modulation boil down to taking a low-frequency signal band — such as audio — and transposing it in one way or another to a similarly-sized slice of the spectrum in the vicinity of some chosen center frequency.

At this point, some readers might object: the Fourier transform surely isn’t the only way to think about the frequency spectrum; just because we see halos on an FFT plot, it doesn’t mean they’re _really_ real. In an epistemological sense, this might be right. But as it happens, radio receivers work by doing something that walks and quacks _a lot_ like Fourier…

### Inside a superheterodyne receiver

As foreshadowed just moments ago, the basic operation of almost every radio receiver boils down to mixing (multiplying) the amplified antenna signal with a sine wave of a chosen frequency. This is eerily similar to how Fourier-adjacent transforms deconstruct complex signals into individual frequency components.

From the discussion of the discrete cosine transform (DCT) in the earlier article, you might remember that if a matching frequency is present in the input signal, the multiplication yields a waveform with a DC bias proportional to the magnitude of that frequency component. For all other input frequencies, the resulting waveforms average out to zero, if analyzed on a sufficiently long timescale.

But that averaging timescale is of interest too: in the aforementioned article, we informally noted that the resulting composite waveforms have shorter periods if the original frequencies are far apart, and longer periods if the frequencies are close. Well, as it turns out, for DCT, the low-frequency cycle is always _|f1 - f2|_, superimposed on top of a (less interesting) high-frequency component _f1 + f2_:

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F958fad5e-bec6-4632-a293-24b87427fb1a_1800x1041.png)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F958fad5e-bec6-4632-a293-24b87427fb1a_1800x1041.png)_Dropping some sick beats._

This behavior might seem puzzling, but it arises organically from the properties of sine waves. Let’s start with the semi-well-known _angle sum identity_, which has a [cute and easy proof](https://www.khanacademy.org/math/precalculus/x9e81a4f98389efdf:trig/x9e81a4f98389efdf:angle-addition/v/proof-angle-addition-cosine) involving triangles. The formula for that identity is:

From there, we can trivially show the following:

Divide both sides by two, flip it around, and you end up with a formula that equates the product of two sine frequencies to a sum of cosines running at _f1 - f2_ and _f1 + f2_:

Heck, we don’t even need to believe in trigonometry. A closely-related phenomenon has been known to musicians for ages: when you simultaneously play two very similar tones, you end up with an unexpected, slowly-pulsating “beat frequency”. Here’s a demonstration of a 5 Hz beat produced by combining 400 Hz and 405 Hz:

In any case, back to radio: it follows that if one wanted to receive transmissions centered around 10 MHz, a straightforward approach would be to mix the input RF signal with a 10 MHz sine. According to our formulas, this should put the 10.00 MHz signal at DC, downconvert 10.01 MHz to a 10 kHz beat (with an extra 20.01 MHz component), turn 10.02 MHz into 20 kHz (+ 20.02 MHz), and so forth. With the mixing done, the next step would be to apply a lowpass filter to the output, keeping only the low frequencies that are a part of the modulation scheme - and getting rid of everything else, including the unwanted _f1 + f2_ components.

The folly of this method becomes evident when you consider that beat frequencies exhibit symmetry around 0 Hz on the output side. In the aforementioned example, the input component at 9.99 MHz produces an image at 10 kHz too — precisely where 10.01 MHz was supposed to go. To avoid this mirroring, receivers mix the RF input with a frequency lower than the signal of interest, shifting it to a constant non-zero intermediate frequency (_fif_) — and then using bandpass filters to pluck out the relevant bits.

In this design — devised by Edwin Armstrong around 1919 and dubbed _superheterodyne_ — the fundamental mirroring behavior is still present, but the point of symmetry can be placed far away. With this trick up our sleeve, accidental mirror images of unrelated transmissions become easier to manage — for example, by designing the antenna to have a narrow frequency response and not pick up the offending signals at all, or by putting an RF lowpass filter in front of the mixer. The behavior of superheterodynes is sometimes taken into account for radio spectrum allocation purposes, too.

Subscribe

_For a thematic catalog of articles on electronics, [click here](https://lcamtuf.coredump.cx/offsite.shtml)._