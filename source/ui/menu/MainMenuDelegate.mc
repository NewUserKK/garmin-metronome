import Toybox.WatchUi;

class MainMenuDelegate extends WatchUi.Menu2InputDelegate {
    private var stateController as MetronomeStateController;

    function initialize(stateController as MetronomeStateController) {
        Menu2InputDelegate.initialize();
        self.stateController = stateController;
    }

    function onSelect(item as WatchUi.MenuItem) {
        var id = item.getId();

        switch (id) {
            case :menuSoundFeedback:
                stateController.toggleSoundFeedback();
                break;

            case :menuVibrationFeedback:
                stateController.toggleVibrationFeedback();
                break;
        }
    }
}
