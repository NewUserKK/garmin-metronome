import Toybox.Lang;

class MetronomeState {
    public var bpm = 120;
    public var isPlaying = false;
    public var notesInBar = 4;
    public var noteType = 4;

    public function setBpm(bpm as Integer) as MetronomeState {
        var state = copy();
        state.bpm = bpm;
        return state;
    }

    public function setIsPlaying(value as Boolean) as MetronomeState {
        var state = copy();
        state.isPlaying = value;
        return state;
    }

    public function setNotesInBar(notesInBar as Integer) as MetronomeState {
        var state = copy();
        state.notesInBar = notesInBar;
        return state;
    }

    public function setNoteType(noteType as Integer) as MetronomeState {
        var state = copy();
        state.noteType = noteType;
        return state;
    }

    function copy() as MetronomeState {
        var state = new MetronomeState();
        state.bpm = self.bpm;
        state.isPlaying = self.isPlaying;
        state.notesInBar = self.notesInBar;
        state.noteType = self.noteType;
        return state;
    }
}

class MetronomeEvent {
    class GoBack extends MetronomeEvent {
        function initialize() { MetronomeEvent.initialize(); }
    }
}

typedef MetronomeStateObserver as Method(state as MetronomeState) as Void;
typedef MetronomeEventObserver as Method(event as MetronomeEvent) as Void;

const MIN_BPM = 25;
const MAX_BPM = 300;

class MetronomeStateController {
    private var state = new MetronomeState();

    private var stateObservers = [] as Array<MetronomeStateObserver>;
    private var eventObservers = [] as Array<MetronomeEventObserver>;

    public function observeState(observer as MetronomeStateObserver) {
        stateObservers.add(observer);
    }

    public function removeStateObserver(observer as MetronomeStateObserver) {
        stateObservers.remove(observer);
    }

    public function observeEvents(observer as MetronomeEventObserver) {
        eventObservers.add(observer);
    }

    public function removeEventObserver(observer as MetronomeEventObserver) {
        eventObservers.remove(observer);
    }

    public function togglePlay() {
        setState(state.setIsPlaying(!state.isPlaying));
    }

    public function changeBpm(delta as Integer) {
        var bpm = state.bpm + delta;

        if (bpm < MIN_BPM) {
            bpm = MIN_BPM;
        }

        if (bpm > MAX_BPM) {
            bpm = MAX_BPM;
        }

        setState(state.setBpm(bpm));
    }

    public function handleBack() {
        if (state.isPlaying) {
            togglePlay();
        } else {
            emitEvent(new MetronomeEvent.GoBack());
        }
    }

    public function reset() {
        setState(new MetronomeState());
    }

    public function getState() as MetronomeState {
        return state;
    }

    private function setState(state as MetronomeState) {
        self.state = state;
        for (var i = 0; i < stateObservers.size(); i++) {
            var observer = stateObservers[i];
            observer.invoke(state);
        }
    }

    private function emitEvent(event as MetronomeEvent) {
        for (var i = 0; i < eventObservers.size(); i++) {
            var observer = eventObservers[i];
            observer.invoke(event);
        }
    }
}
