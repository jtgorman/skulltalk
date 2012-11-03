for i in wavs/*.wav ; do
    echo $i
    b=`basename $i .wav`
    sox $i longer/$b\_longer.wav pad 1 1 
done
