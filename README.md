skulltalk
=========

Small set of scripts to create "Bob", my Halloween cyberpunk oracle skull

![Bob](Bob.jpg "Bob")

How and why 
---------

So the way I created Bob was to summon, through arcane and unspeakable practices, an ancient and malevolent demon which I bound into the nearest handy receptacle, which happened to be computer speakers.  A puff of smoke later and he had transmogrified it to a more comfy set of speaker skulls.

Actually, no.  I found this skull shaped speaker for ten bucks at Walgreen in their Halloween section. I couldn't resist.  So the hardware was cheap, and the eyes glow in some relation of bass and volume and work as a speaker.  The voice of Bob is provided by the festival text-to-speech program.  I used sox to add some padding to the sound-tracks. I also used sox to generate some tracks with just silence, so when I had my playlist on shuffle it wouldn't just be Bob talking non-stop.  It seemed easier than fiddling with too many sound effect programs or trying to come up with my own Android sound app.

Setup
---------

You'll need festival. lame, and sox installed.  For the perl script, well, perl. Also, the bash scripts are quick and dirty and assume a bash shell.

I ended up going with a voice from the standard Ubuntu packages, but you might want to explore some other voices.  I found [a good forum post]:http://ubuntuforums.org/showthread.php?t=751169 on setting up some of the voices, but I didn't read enough into the comments.  Had some issues compiling some of the higher quality voices, so played around with the basic ones that come with festival.

Workflow
---------

1. ./make_directories.sh
2. Add some sayings to a text file, like possible_say.txt
3. perl create_scripts.pl possible_say.txt
4. ./wind_to_voice.sh
5. ./pad_silence.sh
6. ./convert.sh

Then create some reasonable stretches of silence via
1. sox -n -r 48000 silence/silence_n2.wav trim 0.0 n
2. ./convert_silence.sh

where n is some length of seconds

Then copy the mp3 folder onto whatever device you'll plug into Bob

### Creating scripts

I didn't want Bob speaking entire paragraphs, just some pithy sayings and short quotes.  So I assembled a file possible_says.txt, where each line was something that I would want Bob to possibly say

I had original intended that I would create then a set of scripts in the language festival uses in order to properly set up the voice.  However, poking around the manual and some other sites, I found the I figured out a better way with the use of -eval.  More on that later.

So now I just create a set of one-line text files w/ the extension .script in the scripts folder by running

```
./create_scripts.pl
```

### Convert text to wave files

The wind_to_voice.sh just loops over the files and does the following command

```
text2wave -eval '(voice_us1_mbrola)' file -o wavs/file.wav
```

I had been doing a more complicated set of procedures using
festival -w file.wav scripts/file.script, using the scripting language and each script file being something like.
```
(voice_us1_mbrola)
(SayText "Prophet! said I, thing of evil! prophet still, if bird or devil!")
```

### Pad silence

Running pad_silence.sh just adds a second of silence to each end of the file.
```
sox wavs/file.wav longer/file_longer.wav pad 1 1 
```
### Convert the wavs to mp3

The convert.sh is pretty straight-forward, looping over the wavs and essentially doing
```
lame longer/file_longer.wav mp3/file_longer.mp3
```

### Creating silence

I'm using a trick that I picked up at a sox tutorial at http://billposer.org/Linguistics/Computation/SoxTutorial.html#silence to create silence.

I essentially did a few wav files, like

sox -n -r 48000 silence/silence_n2.wav trim 0.0 60
sox -n -r 48000 silence/silence_n2.wav trim 0.0 120
sox -n -r 48000 silence/silence_n2.wav trim 0.0 300

Then did a modified version of one of the above shell scripts to convert those to wav via lame by running

```
./convert_silence.sh
```

Having both the silences and the sayings let me put my phone on shuffle, so Bob is actually always playing something, but he only makes audible noise at random time intervals.