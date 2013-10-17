import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    spawn "mate-session"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        } `additionalKeys`
        [ ((controlMask, xK_F11), spawn "mate-terminal")
        , ((controlMask, xK_F12), spawn "/opt/firefox/firefox") ]
