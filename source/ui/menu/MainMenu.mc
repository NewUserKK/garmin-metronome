import Toybox.Lang;
import Toybox.WatchUi;

class MainMenu extends Rez.Menus.MainMenu {
    private var stateController as MetronomeStateController;
    private var stateObserver as MetronomeStateObserver = method(:onStateChanged);

    private var soundFeedbackItem as WatchUi.ToggleMenuItem;
    private var vibrationFeedbackItem as WatchUi.ToggleMenuItem;

    public function initialize(stateController as MetronomeStateController) {
        Rez.Menus.MainMenu.initialize();

        self.stateController = stateController;

        soundFeedbackItem = getItem(findItemById(:menuSoundFeedback)) as WatchUi.ToggleMenuItem;
        vibrationFeedbackItem = getItem(findItemById(:menuVibrationFeedback)) as WatchUi.ToggleMenuItem;
    }

    function onShow() as Void {
        stateController.observeState(stateObserver);
        renderState(stateController.getState());
    }

    function onHide() as Void {
        stateController.removeStateObserver(stateObserver);
    }

    function onStateChanged(state as MetronomeState) as Void {
        renderState(state);
        WatchUi.requestUpdate();
    }

    private function renderState(state as MetronomeState) as Void {
        if (soundFeedbackItem.isEnabled() != state.hasSoundFeedback) {
            soundFeedbackItem.setEnabled(state.hasSoundFeedback);
        }

        if (vibrationFeedbackItem.isEnabled() != state.hasVibrationFeedback) {
            vibrationFeedbackItem.setEnabled(state.hasVibrationFeedback);
        }
    }
}
