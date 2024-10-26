import Toybox.Graphics;
import Toybox.WatchUi;

class MetronomeView extends WatchUi.View {

    private var stateController as MetronomeStateController;
    private var stateObserver as MetronomeStateObserver = method(:onStateChanged);

    private var bpmLabel as WatchUi.Text?;

    private var playbackButton as WatchUi.Button?;

    function initialize(
        stateController as MetronomeStateController
    ) {
        self.stateController = stateController;
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        bpmLabel = WatchUi.View.findDrawableById("bpmText") as WatchUi.Text;

        playbackButton = WatchUi.View.findDrawableById("playbackButton") as WatchUi.Button;
    }

    function onShow() as Void {
        stateController.addObserver(stateObserver);
        renderState(stateController.getState());
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }

    function onHide() as Void {
        stateController.removeObserver(stateObserver);
    }

    function onStateChanged(state as MetronomeState) as Void {
        renderState(state);
        WatchUi.requestUpdate();
    }

    private function renderState(state as MetronomeState) as Void {
        var bpmText = state.bpm.format("%d");
        bpmLabel.setText(bpmText);

        if (state.isPlaying) {
            playbackButton.setState(:playbackButtonPlayingState);
        } else {
            playbackButton.setState(:playbackButtonStoppedState);
        }
    }
}
