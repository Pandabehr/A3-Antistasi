if (player != theBoss) exitWith {hint "Only Player Commander is allowed to move HQ assets"};
private ["_thingX","_playerX","_id","_sites","_markerX","_size","_positionX"];

_thingX = _this select 0;
_playerX = _this select 1;
_id = _this select 2;

if (!(isNull attachedTo _thingX)) exitWith {hint "The asset you want to move is being moved by another player"};
if (vehicle _playerX != _playerX) exitWith {hint "You cannot move HQ assets while in a vehicle"};

if ({!(isNull _x)} count (attachedObjects _playerX) != 0) exitWith {hint "You have other things attached, you cannot move this"};
_sites = markersX select {sidesX getVariable [_x,sideUnknown] == teamPlayer};
_markerX = [_sites,_playerX] call BIS_fnc_nearestPosition;
_size = [_markerX] call A3A_fnc_sizeMarker;
_positionX = getMarkerPos _markerX;
if (_playerX distance2D _positionX > _size) exitWith {hint "This asset needs to be closer to it relative zone center to be able to be moved"};

_thingX removeAction _id;
_thingX attachTo [_playerX,[0,2,1]];

private _actionX = _playerX addAction ["Drop Here", {detach (_this select 3 select 0); player removeAction (_this select 2);}, [_thingX],0,false,true,"",""];

waitUntil {sleep 1; (_playerX != attachedTo _thingX) or (vehicle _playerX != _playerX) or (_playerX distance2D _positionX > (_size-3)) or !([_playerX] call A3A_fnc_canFight) or (!isPlayer _playerX)};

if (_playerX == attachedTo _thingX) then {
  detach _thingX;
  _playerX removeAction _actionX;
};

/*
for "_i" from 0 to (_playerX addAction ["",""]) do
	{
	_playerX removeAction _i;
	};
*/

_thingX addAction ["Move this asset", "moveHQObject.sqf",nil,0,false,true,"","(_this == theBoss)"];

_thingX setPosATL [getPosATL _thingX select 0,getPosATL _thingX select 1,0];
_thingX setVectorUp surfaceNormal position _thingX;

if (vehicle _playerX != _playerX) exitWith {hint "You cannot move HQ assets while in a vehicle"};

if  (_playerX distance2D _positionX > _size) exitWith {hint "This asset cannot be moved more far away for its zone center"};
