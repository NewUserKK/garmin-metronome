import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeApp extends Application.AppBase {

    private var stateController as MetronomeStateController or Null;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        stateController = new MetronomeStateController();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        stateController = null;
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new MetronomeView(stateController), new MetronomeDelegate(stateController) ];
    }

}

function getApp() as MetronomeApp {
    return Application.getApp() as MetronomeApp;
}
