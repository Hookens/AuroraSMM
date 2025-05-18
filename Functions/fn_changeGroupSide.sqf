/*
    Function: changeGroupSide
    Version: 1.0
    Author: Hookens
    Changes the side of given groups.

    Params:
    0: ARRAY - The group or an array of groups to transfer
    1: SIDE  - The target side to switch to (e.g. east, west, resistance, civilian)

    Example (single group):
    [alpha1, east] call AuroraTools_fnc_changeGroupSide;

    Example (multiple groups):
    [[alpha1, alpha2, alpha3], east] call AuroraTools_fnc_changeGroupSide;
*/

params ["_groups", "_side"];

if (!(_side in [east, west, resistance, civilian])) exitWith {
    systemChat "Invalid side";
};

private _allGroups = if (typeName _groups == "ARRAY") then {
    _groups
} else {
    [_groups]
};

{
    private _group = _x;

    if (!isNull _group) then {
        private _units = units _group;
        private _newGroup = createGroup [_side, true];

        {
            if (!isNull _x) then {
                [_x] joinSilent _newGroup;
            };
        } forEach _units;
    };
} forEach _allGroups