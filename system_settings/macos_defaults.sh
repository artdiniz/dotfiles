# https://www.idownloadblog.com/2020/01/15/how-to-lock-the-dock-on-mac/
# https://apple.stackexchange.com/questions/331537/preferences-changes-using-defaults-not-applied
# 2025
# https://github.com/Lupin3000/macOS?tab=readme-ov-file
# Keep dock and Cmd+Tab UI on laptop screen
# defaults write com.apple.Dock position-immutable -bool true
# _then killall Dock

# close System Preferecnes;
pkill -u "${USER}" -f "^/System/Applications/System Settings.app/Contents/MacOS/System Settings$" 2>/dev/null

# https://apple.stackexchange.com/questions/331537/preferences-changes-using-defaults-not-applied

# SystemSettings > A11Y > Pointer Control > Trackpad Options > Dragging style > Three Finger Drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad Dragging -int 0
defaults write com.apple.AppleMultitouchTrackpad DragLock -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1

defaults -currentHost write -g "com.apple.trackpad.threeFingerHorizSwipeGesture" -int 0
defaults -currentHost write -g "com.apple.trackpad.threeFingerTapGesture" -int 0
defaults -currentHost write -g "com.apple.trackpad.threeFingerVertSwipeGesture" -int 0
defaults -currentHost write -g "com.apple.trackpad.threeFingerDragGesture" -int 1

# Not sure? Enable user settings
defaults write com.apple.AppleMultitouchTrackpad UserPreferences -bool true

# # AppleMultitouchTrackpad - Click and Secondary Click
# defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false
# defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -bool false

# # AppleMultitouchTrackpad - Navigation
# defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2
# defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
# defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
# defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2

#TODO enable SystemSettings > A11Y > Zoom > Use Keyboard Shortcuts Zoom (Cmd+Option+8)
#TODO disable SystemSettings > Displays > Automatically adjust brightness

# SystemSettings > Desktop & Dock > Mission Control # Automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -int 0

# kill the preference cache process
# pkill -u "${USER}" -l "^/usr/sbin/cfprefsd agent$" 2>/dev/null
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# wait a second otherwise you get errors on the defaults commands
sleep 1

# TODO read all changed values and confirm changes

