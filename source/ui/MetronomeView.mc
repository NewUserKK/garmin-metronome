import Toybox.Graphics;
import Toybox.WatchUi;

class MetronomeView extends WatchUi.View {

    private var stateController as MetronomeStateController;
    private var stateObserver as MetronomeStateObserver = method(:onStateChanged);

    private var bpmLabel as WatchUi.Text or Null;

    function initialize(
        stateController as MetronomeStateController
    ) {
        self.stateController = stateController;
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        bpmLabel = WatchUi.View.findDrawableById("bpm_text") as WatchUi.Text;
    }

    function onShow() as Void {
        stateController.addObserver(stateObserver);
    }

    function onUpdate(dc as Dc) as Void {
        renderState(stateController.getState());
        View.onUpdate(dc);
    }

    function onHide() as Void {
        bpmLabel = null;
        stateController.removeObserver(stateObserver);
    }

    hidden function onStateChanged(state as MetronomeState) as Void {
        WatchUi.requestUpdate();
    }

    private function renderState(state as MetronomeState) as Void {
        var bpmText = state.bpm.format("%d");
        bpmLabel.setText(bpmText);
    }
}
