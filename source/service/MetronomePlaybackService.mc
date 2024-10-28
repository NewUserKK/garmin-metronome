import Toybox.Lang;
import Toybox.Timer;

class MetronomePlaybackService {
    private var stateController as MetronomeStateController;
    private var stateObserver as MetronomeStateObserver = method(:onStateChanged);

    private var timer as Timer.Timer?;
    private var beat = 0;
    private var beatCount = 0;

    private var soundFeedback = new SoundFeedback();

    function initialize(
        stateController as MetronomeStateController
    ) {
        self.stateController = stateController;
    }

    function start() {
        stateController.addObserver(stateObserver);
    }

    function stop() {
        stateController.removeObserver(stateObserver);
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
            method(:onTimer),
            rate,
            /*repeat=*/ true
        );
    }

    function onTimer() as Void {
        var isLoud = beat == 0;
        soundFeedback.playSound(
            /*isLoud=*/ isLoud
        );

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
