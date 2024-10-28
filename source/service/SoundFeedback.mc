import Toybox.Attention;
import Toybox.Lang;

class SoundFeedback {
    function playSound(isLoud as Boolean) {
        var toneRegular = new Attention.ToneProfile(
            /*frequency*/ 440,
            /*duration*/ 150
        );
        var toneLoud = new Attention.ToneProfile(
            /*frequency*/ 700,
            /*duration*/ 150
        );
        var toneProfile = isLoud ? toneLoud : toneRegular;

        Attention.playTone({:toneProfile=>[toneProfile]});
    }
}
