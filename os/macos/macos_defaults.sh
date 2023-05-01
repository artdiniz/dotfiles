# https://www.idownloadblog.com/2020/01/15/how-to-lock-the-dock-on-mac/
# Keep dock and Cmd+Tab UI on laptop screen
# defaults write com.apple.Dock position-immutable -bool true
# _then killall Dock


# https://apple.stackexchange.com/questions/331537/preferences-changes-using-defaults-not-applied

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -bool false
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true



defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -bool false


#TODO enable SystemSettings > A11Y > Zoom > Use Keyboard Shortcuts Zoom (Cmd+Option+8)

