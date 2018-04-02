import XMonad hiding (Tall)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.HintedTile
import XMonad.Layout.LayoutHints (layoutHints)
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)

import System.Exit
import System.IO
import Data.Monoid

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myBorderWidth   = 2
main = xmonad $ defaultConfig {
        terminal           = "xterm",
        modMask            = mod4Mask,
        workspaces         = ["Net", "Txt", "Muza", "Mine", "5", "6", "7", "8", "9"],
        normalBorderColor  = "#000000",
        focusedBorderColor = "#00FF00",
        manageHook         = composeOne [isFullscreen -?> doFullFloat],
        borderWidth        = myBorderWidth,
        keys               = myKeys,
        focusFollowsMouse  = True,
        layoutHook         = myLayout,
        logHook            = dynamicLogWithPP $ xmobarPP
                           {  ppTitle = xmobarColor "green" "" . shorten 60,
                              ppHiddenNoWindows = xmobarColor "grey" ""
                                     }
    }


myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    [ ((modMask              , xK_Return   ), spawn $ XMonad.terminal conf)
    , ((modMask              , xK_F11     ), spawn "amixer -q set Master 3- unmute")
    , ((modMask              , xK_F12     ), spawn "amixer -q set Master 3+ unmute")
    , ((modMask .|. shiftMask, xK_c        ), kill)
    , ((modMask              , xK_space    ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space    ), setLayout $ XMonad.layoutHook conf)
    , ((modMask              , xK_n        ), refresh)
    , ((modMask              , xK_Tab      ), windows W.focusDown)
    , ((modMask              , xK_j        ), windows W.focusDown)
    , ((modMask              , xK_k        ), windows W.focusUp)
    , ((modMask              , xK_m        ), windows W.focusMaster)
    , ((modMask .|. shiftMask, xK_Return   ), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j        ), windows W.swapDown)
    , ((modMask .|. shiftMask, xK_k        ), windows W.swapUp)
    , ((modMask              , xK_h        ), sendMessage Shrink)
    , ((modMask              , xK_l        ), sendMessage Expand)
    , ((modMask              , xK_t        ), withFocused $ windows . W.sink)
    , ((modMask              , xK_comma    ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period   ), sendMessage (IncMasterN (-1)))
    , ((modMask .|. shiftMask, xK_q        ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q        ), spawn "xmonad --recompile; xmonad --restart")
    , ((modMask              , xK_u       ), shellPrompt defaultXPConfig)
    , ((modMask,               xK_f     ), spawn "firefox")
    , ((modMask,               xK_p     ), spawn "spotify")
    , ((modMask,               xK_a     ), spawn "emacs")
    , ((modMask .|. shiftMask,  xK_l     ), spawn "xscreensaver-command -lock")
    , ((0                    , 0x1008ff19  ), spawn "emacs")
    , ((0                    , 0x1008ff81  ), spawn "spotify")
    , ((0                    , 0x1008ff18  ), spawn "firefox")
    , ((0                    , 0x1008ff1b  ), shellPrompt defaultXPConfig)
    , ((0                    , 0x1008ff30  ), spawn "xterm -e mc")
    , ((0                    , 0x1008ff13  ), spawn "amixer -q set Master 2dB+ unmute")
    , ((0                    , 0x1008ff11  ), spawn "amixer -q set Master 2dB-")
    , ((0                    , 0x1008ff12  ), spawn "amixer -D pulse set Master 1+ toggle")
    , ((0                    , 0x1008ff16  ), spawn "/home/dxtr/bin/sp prev") --prev
    , ((0                    , 0x1008ff17  ), spawn "/home/dxtr/bin/sp next") --next
    , ((0                    , 0x1008ff15  ), spawn "/home/dxtr/bin/sp play") -- stop
    , ((0                    , 0x1008ff14  ), spawn "/home/dxtr/bin/sp play") -- play/pause
    ]
    ++

    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    ++

    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myLayout = avoidStruts $ tiled ||| wideTiled ||| Full
  where
     tiled = HintedTile nmaster delta ratio Center Tall
     wideTiled = HintedTile nmaster delta ratio Center Wide
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100
