-- Copyright (C) 2024 mesvam
-- 
-- This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

-- allow key bindings to easily modify video aspect ratio by copying the aspect ratio into video-aspect-override
-- to workaround https://github.com/mpv-player/mpv/issues/13362
local original_video_aspect_override = mp.get_property_native("video-aspect-override") -- default = -1
mp.msg.debug(string.format("original video-aspect-override = %f", original_video_aspect_override))

local function set_aspect_override(_, video_aspect)
    if video_aspect ~= nil and mp.get_property_native("video-aspect-override") == -1 then
        mp.msg.debug(string.format("set video-aspect-override = %f", video_aspect))
        mp.set_property_native("video-aspect-override", video_aspect)
        mp.unobserve_property(set_aspect_override)
    end
end

-- reset on new file
local function reset_aspect_override()
    mp.msg.debug('reset to original aspect ratio')
    mp.set_property_native("video-aspect-override", original_video_aspect_override)
    mp.observe_property("video-params/aspect", "native", set_aspect_override)
end
mp.register_event('start-file', reset_aspect_override)
