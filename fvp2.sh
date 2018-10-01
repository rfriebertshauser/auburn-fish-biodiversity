#when recording with a GoPro HERO4, continuous recordings over 22 minutes will be 
#automatically split into multiple segments.
#it is assumed that the user has two videos from one recording session
#script can be easily manipulated for more videos
#
#
#to use, copy and past fvp2.sh into directory with target videos
#in bash, cd to directory containing target videos
#install ffmpeg
sudo apt-get install ffmpeg
#
#
#!/bin/bash
#make four directories for image sequences
mkdir -p pic1
echo
mkdir -p pic2
echo
mkdir -p pic3
echo
mkdir -p pic4
echo
#convert target .mp4’s into .avi’s
ffmpeg -i 1.mp4 -ar 22050 -b 5000k 1.avi
echo
ffmpeg -i 2.mp4 -ar 22050 -b 5000k 2.avi
echo
#combine .avi videos
ffmpeg -i "concat:1.avi|2.avi" -c:a copy -c:v copy combined.avi
echo
#rotate combined.avi 0.675 degrees CCW
ffmpeg -i join.avi -vf rotate=-0.675*PI/180 -ar 22050 -b 5000k rotate.avi
echo
#adjust resolution of rotate.avi to 1289x736 pixels
ffmpeg -i rotate.avi -filter:v scale=1289:736 -c:a copy -ar 22050 -b 5000k altres.avi
echo
#remove extraneous file
rm 1.avi
echo
#remove extraneous file
rm 2.avi
echo
#slice the first ten minutes of altres.avi into a new file
ffmpeg -i altres.avi -ss 00:00:00 -t 00:10:00 -c copy 1.avi
echo
#slice minute 10-20 of altres.avi into a new file
ffmpeg -i altres.avi -ss 00:10:00 -t 00:10:00 -c copy 2.avi
echo
#slice minute 20-30 of altres.avi into a new file
ffmpeg -i altres.avi -ss 00:20:00 -t 00:10:00 -c copy 3.avi
echo
#slice minute 30-40 of altres.avi into a new file
ffmpeg -i altres.avi -ss 00:30:00 -t 00:10:00 -c copy 4.avi
echo 
#!ATTENTION: POTENTIAL BUG IN FFMPEG!
#CREATION OF IMAGE SEQUENCE RESULTS IN A SEQUENCE WHERE THE FIRST TWO IMAGES ARE NOT
#CREATED USING THE RIGHT FRAME RATE. IGNORE FIRST TWO IMAGES!
#create image sequence for 1.avi
ffmpeg -i 1.avi -r 1 -f image2 -ar 22050 -b 5000k pic1/image-%4d.jpg
echo
cd -
echo
#create image sequence for 2.avi
ffmpeg -i 2.avi -r 1 -f image2 -ar 22050 -b 5000k pic2/image-%4d.jpg
echo
cd -
echo
#create image sequence for 3.avi
ffmpeg -i 3.avi -r 1 -f image2 -ar 22050 -b 5000k pic3/image-%4d.jpg
echo
cd -
echo
#create image sequence for 4.avi
ffmpeg -i 4.avi -r 1 -f image2 -ar 22050 -b 5000k pic4/image-%4d.jpg
echo
cd -
echo
#remove extraneous files
rm 1.avi
echo
rm 2.avi
echo
rm 3.avi
echo
rm 4.avi
echo
rm join.avi
echo
rm rotate.avi
echo
rm altres.avi
echo
rm 1.MP4
echo
rm 2.MP4
echo FISHY VIDEO PROCESSOR V1.1 HAS FINISHED!