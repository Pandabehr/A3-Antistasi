_countX = 61;
while {!([player] call A3A_fnc_isMember)} do
	{
	_playerMembers = playableUnits select {([_x] call A3A_fnc_isMember) and (side group _x == teamPlayer)};
	if !(_playerMembers isEqualTo []) then
		{
		if (player distance2D (getMarkerPos respawnTeamPlayer) > memberDistance) then
			{
			_closestMember = [_playerMembers,player] call BIS_fnc_nearestPosition;
			if (player distance2d _closestMember > memberDistance) then
				{
				_countX = _countX - 1;
				}
			else
				{
				_countX = 61
				};
			}
		else
			{
			_countX = 61;
			};
		}
	else
		{
		_countX = 61;
		};
	if (_countX != 61) then
		{
		hint format ["You have to get closer to the HQ or the closest server member in %1 seconds. \n\n After this timeout you will be teleported to your HQ",_countX];
		sleep 1;
		if (_countX == 0) then {player setPos (getMarkerPos respawnTeamPlayer)};
		}
	else
		{
		sleep 60;
		};
	};