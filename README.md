# FOFlet Formant Synthesis

This is a class project that synthensizes vowel formants using Rodet's FOF (Formant Wave Synthesis) techniques. There are four 5 files that are created to be ran with MATLAB. However the references to spectrogram can be removed and it will be compatible with Octave. It should be fairly trivial to implement in numpy/scipy/matplotlib as well.

## Generating Vowel Formants
run the file FOF.m
This has all of the parameters for the vowels, and will call the functions defined in vowel.m and FOFlet.m

## Extra fun
Plot3FOFlet.m is a function called by plot_fof.m none of which is required to generate formants

## Extra Extra fun
Create your own formant definitions, and pass them through the vowel.m function.
