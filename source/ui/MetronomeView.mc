import Toybox.Graphics;
import Toybox.WatchUi;

class MetronomeView extends WatchUi.View {

    private var stateController as MetronomeStateController;
    private var stateObserver as MetronomeStateObserver = method(:onStateChanged);
    private var eventObserver as MetronomeEventObserver = method(:onEvent);

    private var bpmLabel as WatchUi.Text?;

    private var playButton as WatchUi.Button?;
    private var stopButton as WatchUi.Button?;

    function initialize(
        stateController as MetronomeStateController
    ) {
        View.initialize();
        self.stateController = stateController;
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        bpmLabel = WatchUi.View.findDrawableById("bpmText") as WatchUi.Text;
        playButton = WatchUi.View.findDrawableById("playButton") as WatchUi.Button;
        stopButton = WatchUi.View.findDrawableById("stopButton") as WatchUi.Button;
    }

    function onShow() as Void {
        stateController.observeState(stateObserver);
        stateController.observeEvents(eventObserver);
        renderState(stateController.getState());
    }

    function onHide() as Void {
        stateController.stopPlayback();

        stateController.removeStateObserver(stateObserver);
        stateController.removeEventObserver(eventObserver);
    }

    function onStateChanged(state as MetronomeState) as Void {
        renderState(state);
        WatchUi.requestUpdate();
    }

    private function renderState(state as MetronomeState) as Void {
        var bpmText = state.bpm.format("%d");
        bpmLabel.setText(bpmText);

        if (state.isPlaying) {
            playButton.setVisible(false);
            stopButton.setVisible(true);
        } else {
            playButton.setVisible(true);
            stopButton.setVisible(false);
        }
    }

    function onEvent(event as MetronomeEvent) as Void {
        if (event instanceof MetronomeEvent.GoBack) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
    }
}
