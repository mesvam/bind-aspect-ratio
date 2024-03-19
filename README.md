Since `video-aspect` was replaced with `video-aspect-override`, we can no longer easily modify video aspect ratio with keybinds in `input.conf` (e.g. `[ multiply video-aspect-override 0.95`) since the default value of `video-aspect-override` is now `-1` rather than taking on the video's actual aspect ratio.

This script provides a workaround by detecting the video's aspect ratio, and writes it into `video-aspect-override` so the keybinding works as expected.
