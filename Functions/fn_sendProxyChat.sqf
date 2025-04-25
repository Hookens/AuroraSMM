/*
    Function: sendProxyChat
    Version: 1.0
    Author: Hookens
    Makes an NPC send a sideChat message to nearby players. Only players within the specified radius will receive it.
    By default, only players on the same side as the NPC will see it, unless 'isGlobal' is set to true.

    Params:
    0: OBJECT - The NPC speaking
    1: STRING - The message to transmit
    2: NUMBER - Radius (in meters)
    3: BOOL (optional) - isGlobal (default: false)
                         false = only players on the side of the NPC
                         true  = all nearby players

    Example (side-only):
    [broski, "Where my NATO bros at?", 50] call AuroraTools_fnc_sendProxyChat;

    Example (global):
    [broski, "CSAT can CSUCK my balls", 50, true] call AuroraTools_fnc_sendProxyChat;
*/

params ["_npc", "_message", "_radius", ["_isGlobal", false]];

private _name = name _npc;
if (_name == "") then {
    _name = getText(configOf _npc >> "displayName");
};

private _sideColors = [
    west, "#004C99",
    east, "#800000",
    resistance, "#008000",
    civilian, "#660080"
];

private _side = side _npc;
private _color = (_sideColors select { _x#0 == _side }) param [0, "#FFFFFF"];

private _coloredName = format ["<t color='%1'>%2</t>", _color, _name];
private _formattedMessage = format ["%1: %2", _coloredName, _message];

private _pos = getPos _npc;

private _targets = allPlayers select {
    (_x distanceSqr _pos) < (_radius * _radius) &&
    { _isGlobal || { side _x == _side } }
};

{
    _x sideChat _formattedMessage;
} forEach _targets;