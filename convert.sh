for i in longer/*.wav ; do
    echo $i
    b=`basename $i .wav`
    lame $i mp3/$b.mp3
done
