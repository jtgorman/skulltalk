for i in scripts/*.script ; do
    echo $i
    b=`basename $i .script`
    text2wave -eval '(voice_us1_mbrola)' $i -o wavs/$b.wav
done
