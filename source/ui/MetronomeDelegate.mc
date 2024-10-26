import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeDelegate extends WatchUi.BehaviorDelegate {

    private var stateController as MetronomeStateController;

    function initialize(
        stateController as MetronomeStateController
    ) {
        BehaviorDelegate.initialize();
        self.stateController = stateController;
    }

    public function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();

        if (key == KEY_UP) {
            stateController.changeBpm(1);
        } else if (key == KEY_DOWN) {
            stateController.changeBpm(-1);
        } else if (key == KEY_ENTER) {
            stateController.togglePlay();
        }
    
        return true;
    }
}
