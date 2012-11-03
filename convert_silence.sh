for i in silence/*.wav ; do
    echo $i
    b=`basename $i .wav`
    lame $i mp3/$b.mp3
done
