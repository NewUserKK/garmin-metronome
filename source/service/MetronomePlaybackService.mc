import Toybox.Lang;
import Toybox.Timer;

class MetronomePlaybackService {
    private var stateController as MetronomeStateController;
    private var stateObserver as MetronomeStateObserver = method(:onStateChanged);

    private var timer as Timer.Timer?;
    private var beat = 0;
    private var beatCount = 0;

    private var soundFeedback = new SoundFeedback() as MetronomeFeedback;
    private var vibrationFeedback = new VibrationFeedback() as MetronomeFeedback;

    function initialize(
        stateController as MetronomeStateController
    ) {
        self.stateController = stateController;
    }

    function start() {
        stateController.observeState(stateObserver);
    }

    function stop() {
        stopPlayback(stateController.getState());
        stateController.removeStateObserver(stateObserver);
    }

    function onStateChanged(state as MetronomeState) as Void {
        if (state.isPlaying) {
            startPlayback(state);
        } else {
            stopPlayback(state);
        }
    }

    function startPlayback(state as MetronomeState) {
        resetTimer(state);

        // TODO: take note type into account
        var rate = 60000 / state.bpm;
        timer.start(
            method(:produceFeedback),
            rate,
            /*repeat=*/ true
        );
    }

    function produceFeedback() as Void {
        var state = stateController.getState();
        var isStrong = beat == 0;

        if (state.hasSoundFeedback) {
            soundFeedback.produceFeedback(isStrong);
        }

        if (state.hasVibrationFeedback) {
            vibrationFeedback.produceFeedback(isStrong);
        }

        beat = (beat + 1) % beatCount;
    }

    function resetTimer(state as MetronomeState) {
        if (timer != null) {
            timer.stop();
        }

        timer = new Timer.Timer();
        beat = 0;
        beatCount = state.notesInBar;
    }

    function stopPlayback(state as MetronomeState) {
        resetTimer(state);
        timer = null;
    }
}
