# audio-cutter
Set of scripts that allows to conert an audio file to a set of short .mp3 files

# convert.sh
Script that uses ffmpeg to convert a file to a .mp3 file

Example use: ./convert.sh path/to/audio/file.aa

# extract_cuts.py
Script that tries to filter a list of silences into a shorter list
in such way that each interval is aproximately N minutes (30 minutes by default)

Example use: python3 extract_cuts.py silence.txt 1800
silence.txt is created using ffmpeg exapmle:
ffmpeg -i $1 -af silencedetect=n=-50dB:d=3.0 -f null - 2> log.txt # finds silence in audio
sed '1,49 d' log.txt | sed '/size\|video\|start/d' | awk '{print int($5)}' > silence.txt # extracts oments of silence

1800 : number of seconds for one interval

# cut.sh
Script that uses extract_cuts.py and ffmpeg to find silence in an audio file.
It then uses ffmpeg to split the file at posisitons found by extract_cuts.py
The results are stored in a folder that is created in the same folder where the
original file is situated

Example use: ./cut.sh path/to/audio/file.mp3
