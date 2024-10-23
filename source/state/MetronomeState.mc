import Toybox.Lang;

class MetronomeState {
    public var bpm = 120;
    public var isPlaying = false;

    function setBpm(bpm as Integer) as MetronomeState {
        var state = copy();
        state.bpm = bpm;
        return state;
    }

    function setIsPlaying(value as Boolean) as MetronomeState {
        var state = copy();
        state.isPlaying = value;
        return state;
    }

    function copy() as MetronomeState {
        var state = new MetronomeState();
        state.bpm = self.bpm;
        state.isPlaying = self.isPlaying;
        return state;
    }
}

typedef MetronomeStateObserver as Method(state as MetronomeState) as Void;

const MIN_BPM = 25;
const MAX_BPM = 300;

class MetronomeStateController {
    private var state = new MetronomeState();

    private var observers = [] as Array<MetronomeStateObserver>;

    public function addObserver(
        observer as Method(state as MetronomeState) as Void
    ) {
        observers.add(observer);
    }

    public function removeObserver(
        observer as Method(state as MetronomeState) as Void
    ) {
        observers.remove(observer);
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

    public function reset() {
        setState(new MetronomeState());
    }

    public function getState() as MetronomeState {
        return state;
    }

    private function setState(state as MetronomeState) {
        self.state = state;
        for (var i = 0; i < observers.size(); i++) {
            observers[i].invoke(state);
        }
    }
}
