import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, removeKeysP)
import System.IO

main :: IO ()
main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/carlo/.xmobarrc"
    spawn "/home/carlo/work/github/dotfiles/bin/tray_and_gnome_session.sh"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        -- , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((controlMask, xK_F8), spawn "keepassx /home/carlo/keepassx.kdb")
        , ((controlMask, xK_F9), spawn "nautilus")
        , ((controlMask, xK_F10), spawn "thunderbird")
        , ((controlMask, xK_F11), spawn "mate-terminal")
        , ((controlMask, xK_F12), spawn "firefox")
        ] `removeKeysP`
        [ "M-e", "M-q" ]
