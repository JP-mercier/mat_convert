^6::
    ; Start the script in game, in your character screen.

    ; ================================ Input/math =================================

    InputBox, mat_choice, Prisms & Shards to enhancement cores, Which material is consumed?`n`nEnter 1 for Prisms`nEnter 2 for Ascendant shards

    If (ErrorLevel = 1) 
    {
        Return
    }

    ; Prisms Input box
    If (mat_choice = 1) {

        InputBox, mat_nbr, Prisms & Shards to enhancement cores, How many prisms must be tranformed?

        glimmer := mat_nbr*6650
        shards := mat_nbr*10
        enh_cores := mat_nbr*3
        gunsmith_mats := mat_nbr*2

        If (ErrorLevel = 1) 
        {
            Return
        }

        MsgBox, You will need:`n%glimmer% Glimmer`n%gunsmith_mats% Gunsmith materials`n%shards% Legendary shards`n`nYou will gain:`n%enh_cores% Enhancement cores

    } 

    ; Ascendant shards Input box
    Else If (mat_choice = 2) {
        InputBox, mat_nbr, Prisms & Shards to enhancement cores, How many ascendant shards must be tranformed?

        glimmer := mat_nbr*11650
        shards := mat_nbr*19
        prisms := mat_nbr*3
        enh_cores := mat_nbr*3
        gunsmith_mats := mat_nbr*2

        If (ErrorLevel = 1) 
        {
            Return
        }

        MsgBox, You will need:`n%glimmer% Glimmer`n%gunsmith_mats% Gunsmith materials`n%shards% Legendary shards`n`nYou will gain:`n%enh_cores% Enhancement cores`n%prisms% Prisms
    }

    Else {
        MsgBox, Incorrect input
        Return
    }

    full_rotation := Floor(mat_nbr / 9)
    partial_rotation := Mod(mat_nbr, 9)
    
    ; ============================= full rotation(s) =============================

    Sleep, 250

    WinActivate, Destiny 2
    
    Sleep, 1250

    If (mat_choice = 1)
    {
        upgrade_loop := 3
    }
    Else If (mat_choice = 2)
    {
        upgrade_loop := 5
    }

    Loop, %full_rotation%
    {
        ; Move to collection
        Send, a
        Sleep, 500
        Send, a
        Sleep, 10
        Mouse_Move(1100,400)
        Sleep, 700
        Click
        Sleep, 500

        Mouse_Move(650,1100)
        Sleep, 700
        Click
        Send ^{Right}
        Mouse_Move(1000,1050)

        ; buy 9 class items
        Loop 9
        {
            Sleep, 500
            Click, Down
            Sleep, 3300
            Click, Up
        }
        Sleep, 100

        ; Back to character screen
        Send, {Esc}
        Sleep, 500
        Send, d
        Sleep, 500
        Send, d
        Sleep, 500

        Loop 9 
        {
            Mouse_Move(1870,1050)
            Sleep, 300

            ; Inspecting the class item
            Mouse_Move(1980,1050)
            Sleep, 500
            Click, right

            ; Upgrading
            Mouse_Move(1020,520)
            Sleep, 4500
            Loop %upgrade_loop%
            {
                Sleep, 500
                Click, Down
                Sleep, 1100
                Click, Up
            }

            ; Returning to character screen
            Send, {Esc}
            Sleep, 1000
            Mouse_Move(1870,1050)
            Sleep, 300
            Mouse_Move(1980,1050)
            Sleep, 300
            ; Deleting the class item
            del_class_item()
        }
    }

    ; =========================== partial rotation ===========================

    If (%partial_rotation% != 0) {
        ; Move to collection
        Send, a
        Sleep, 500
        Send, a
        Sleep, 10
        Mouse_Move(1100,400)
        Sleep, 700
        Click
        Sleep, 500

        Mouse_Move(650,1100)
        Sleep, 700
        Click
        Send ^{Right}
        Mouse_Move(1000,1050)

        ; buy some class items
        Loop %partial_rotation%
        {
            Sleep, 500
            Click, Down
            Sleep, 3300
            Click, Up
        }
        Sleep, 100

        ; Back to character screen
        Send, {Esc}
        Sleep, 500
        Send, d
        Sleep, 500
        Send, d
        Sleep, 500

        Loop %partial_rotation%
        {
            Mouse_Move(1870,1050)
            Sleep, 300

            ; Inspecting the class item
            Mouse_Move(1980,1050)
            Sleep, 500
            Click, right

            ; Upgrade
            Mouse_Move(1020,520)
            Sleep, 1000
            Loop %upgrade_loop%
            {
                Sleep, 500
                Click, Down
                Sleep, 1100
                Click, Up
            }

            ; Returning to character screen
            Send, {Esc}
            Sleep, 1000
            Mouse_Move(1870,1050)
            Sleep, 300
            Mouse_Move(1980,1050)
            Sleep, 300
            ; Deleting the class item
            del_class_item()
        }
    }

    If (mat_choice = 1)
    {
        MsgBox, You spent:`n%glimmer% Glimmer`n%gunsmith_mats% Gunsmith materials`n%shards% Legendary shards`n`nYou gained:`n%enh_cores% Enhancement cores
    }
    Else If (mat_choice = 2)
    {
        MsgBox, You spent:`n%glimmer% Glimmer`n%gunsmith_mats% Gunsmith materials`n%shards% Legendary shards`n`nYou gained:`n%enh_cores% Enhancement cores`n%prisms% Prisms
    }

Return

; ========================== functions ==========================

del_class_item()
{
    Sleep, 100
    Send, {f Down}
    Sleep, 1200
    Send, {f Up}
    Sleep, 100
}

Mouse_Move(cord_x, cord_y)
{
    MouseMove, cord_x * (A_ScreenWidth / 2560), cord_y * (A_ScreenHeight / 1440), 1
}

; ========================== Controls ==========================

^4::
    Reload
Return

^5::
    Pause, Toggle
return

^7::
ExitApp

