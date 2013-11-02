import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

{-
main = do
    spawn "gnome-session"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        -- , modMask = mod4Mask
        } `additionalKeys`
        [ ((controlMask, xK_F10), spawn "/home/carlo/opt/thunderbird-24.1.0/thunderbird")
        , ((controlMask, xK_F11), spawn "gnome-terminal")
        , ((controlMask, xK_F12), spawn "/usr/bin/google-chrome")
        ]
-}

main = do
    xmproc <- spawnPipe "/home/carlo/.cabal/bin/xmobar /home/carlo/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        -- , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((controlMask, xK_F9), spawn "nautilus")
        , ((controlMask, xK_F10), spawn "/home/carlo/opt/thunderbird-24.1.0/thunderbird")
        , ((controlMask, xK_F11), spawn "gnome-terminal")
        , ((controlMask, xK_F12), spawn "/usr/bin/google-chrome")
        ]
