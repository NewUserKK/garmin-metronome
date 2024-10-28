import Toybox.Attention;
import Toybox.Lang;

class SoundFeedback extends MetronomeFeedback {
    function initialize() {
        MetronomeFeedback.initialize();
    }

    function produceFeedback(isStrong as Boolean) {
        var toneRegular = new Attention.ToneProfile(
            /*frequency*/ 440,
            /*duration*/ feedbackDurationMs
        );
        var toneLoud = new Attention.ToneProfile(
            /*frequency*/ 700,
            /*duration*/ feedbackDurationMs
        );
        var toneProfile = isStrong ? toneLoud : toneRegular;

        Attention.playTone({:toneProfile=>[toneProfile]});
    }
}
