import Toybox.Lang;

class MetronomeState {
    public var bpm = 120;
    public var isPlaying = false;
    public var notesInBar = 4;
    public var noteType = 4;

    public var hasSoundFeedback = true;
    public var hasVibrationFeedback = false;

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

    public function setHasSoundFeedback(value as Boolean) as MetronomeState {
        var state = copy();
        state.hasSoundFeedback = value;
        return state;
    }

    public function setHasVibrationFeedback(value as Boolean) as MetronomeState {
        var state = copy();
        state.hasVibrationFeedback = value;
        return state;
    }

    function copy() as MetronomeState {
        var state = new MetronomeState();
        state.bpm = self.bpm;
        state.isPlaying = self.isPlaying;
        state.notesInBar = self.notesInBar;
        state.noteType = self.noteType;
        state.hasSoundFeedback = self.hasSoundFeedback;
        state.hasVibrationFeedback = self.hasVibrationFeedback;
        return state;
    }
}

class MetronomeEvent {
    class GoBack extends MetronomeEvent {
        function initialize() { MetronomeEvent.initialize(); }
    }
}
