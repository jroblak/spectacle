#import "SpectacleWindowAction.h"

// Actions that I don't care about (yet)
SpectacleWindowAction *const kSpectacleWindowActionTopHalf = @"SpectacleWindowActionTopHalf";
SpectacleWindowAction *const kSpectacleWindowActionBottomHalf = @"SpectacleWindowActionBottomHalf";
SpectacleWindowAction *const kSpectacleWindowActionUpperLeft = @"SpectacleWindowActionUpperLeft";
SpectacleWindowAction *const kSpectacleWindowActionLowerLeft = @"SpectacleWindowActionLowerLeft";
SpectacleWindowAction *const kSpectacleWindowActionUpperRight = @"SpectacleWindowActionUpperRight";
SpectacleWindowAction *const kSpectacleWindowActionLowerRight = @"SpectacleWindowActionLowerRight";
SpectacleWindowAction *const kSpectacleWindowActionNextThird = @"SpectacleWindowActionNextThird";
SpectacleWindowAction *const kSpectacleWindowActionPreviousThird = @"SpectacleWindowActionPreviousThird";

// Actions that are too complicated to implement right now
SpectacleWindowAction *const kSpectacleWindowActionUndo = @"SpectacleWindowActionUndo";
SpectacleWindowAction *const kSpectacleWindowActionRedo = @"SpectacleWindowActionRedo";
SpectacleWindowAction *const kSpectacleWindowActionLarger = @"SpectacleWindowActionLarger";
SpectacleWindowAction *const kSpectacleWindowActionSmaller = @"SpectacleWindowActionSmaller";
SpectacleWindowAction *const kSpectacleWindowActionNone = @"SpectacleWindowActionNone";
SpectacleWindowAction *const kSpectacleWindowActionCenter = @"SpectacleWindowActionCenter";

// Actions that are fully gap'd
SpectacleWindowAction *const kSpectacleWindowActionFullscreen = @"SpectacleWindowActionFullscreen";
SpectacleWindowAction *const kSpectacleWindowActionLeftHalf = @"SpectacleWindowActionLeftHalf";
SpectacleWindowAction *const kSpectacleWindowActionRightHalf = @"SpectacleWindowActionRightHalf";

// Unrelated actions
SpectacleWindowAction *const kSpectacleWindowActionNextDisplay = @"SpectacleWindowActionNextDisplay";
SpectacleWindowAction *const kSpectacleWindowActionPreviousDisplay = @"SpectacleWindowActionPreviousDisplay";


BOOL SpectacleIsUndoWindowAction(SpectacleWindowAction *action)
{
  return [action isEqualToString:kSpectacleWindowActionUndo];
}

BOOL SpectacleIsRedoWindowAction(SpectacleWindowAction *action)
{
  return [action isEqualToString:kSpectacleWindowActionRedo];
}

BOOL SpectacleIsNextDisplayWindowAction(SpectacleWindowAction *action)
{
  return [action isEqualToString:kSpectacleWindowActionNextDisplay];
}

BOOL SpectacleIsPreviousDisplayWindowAction(SpectacleWindowAction *action)
{
  return [action isEqualToString:kSpectacleWindowActionPreviousDisplay];
}

BOOL SpectacleIsMovingToDisplayWindowAction(SpectacleWindowAction *action)
{
  return SpectacleIsNextDisplayWindowAction(action) || SpectacleIsPreviousDisplayWindowAction(action);
}
