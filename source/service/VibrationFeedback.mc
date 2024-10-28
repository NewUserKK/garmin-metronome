import Toybox.Lang;

class VibrationFeedback extends MetronomeFeedback {
    function initialize() {
        MetronomeFeedback.initialize();
    }

    function produceFeedback(isStrong as Boolean) {
        // TODO: test strength on real devices

        var vibrationRegular = new Attention.VibeProfile(
            /*strengthPercent*/ 80,
            /*duration*/ feedbackDurationMs
        );
        var vibrationStrong = new Attention.VibeProfile(
            /*strengthPercent*/ 100,
            /*duration*/ feedbackDurationMs
        );
        var vibrationProfile = isStrong ? vibrationStrong : vibrationRegular;

        Attention.vibrate([vibrationProfile]);
    }
}
