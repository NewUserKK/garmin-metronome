import Toybox.WatchUi;
import Toybox.Lang;

class PlaybackButton extends WatchUi.Button {
    public var playbackButtonPlayingState as WatchUi.Bitmap;
    public var playbackButtonStoppedState as WatchUi.Bitmap;

    public function initialize(options) {
        WatchUi.Button.initialize(options);
        playbackButtonPlayingState = new WatchUi.Bitmap({:rezId=>Rez.Drawables.PlaybackStopIcon});
        playbackButtonStoppedState = new WatchUi.Bitmap({:rezId=>Rez.Drawables.PlaybackPlayIcon});
    }
}
