module(..., package.seeall);

require('Body')
require('fsm')
require('gcm')

require('bodyIdle')
require('bodyStart')
require('bodyStop')
require('bodyReady')
require('bodySearch')
require('bodyApproach')
require('bodyKick')
require('bodyOrbit')
require('bodyGotoCenter')
require('bodyPosition')
--require('bodyObstacle')
--require('bodyObstacleAvoid')
require('bodyControl')

sm = fsm.new(bodyIdle); -- dont mess
sm:add_state(bodyStart); -- dont mess
sm:add_state(bodyStop); -- dont mess
sm:add_state(bodyReady); -- dont mess
sm:add_state(bodyControl); -- control state
sm:add_state(bodySearch);
sm:add_state(bodyApproach);
sm:add_state(bodyKick);
sm:add_state(bodyOrbit);
sm:add_state(bodyGotoCenter);
sm:add_state(bodyPosition);
--sm:add_state(bodyObstacle); -- does this even do anything?
--sm:add_state(bodyObstacleAvoid); -- does this even do anything?

sm:set_transition(bodyStart, 'done', bodyPosition); -- dont mess

-- transitions from control state to all other states
sm:set_transition(bodyControl, 'search', bodySearch);
sm:set_transition(bodyControl, 'approach', bodyApproach);
sm:set_transition(bodyControl, 'kick', bodyKick);
sm:set_transition(bodyControl, 'orbit', bodyOrbit);
sm:set_transition(bodyControl, 'center', bodyGotoCenter);
sm:set_transition(bodyControl, 'position', bodyPosition);

-- transitions to control state
sm:set_transition(bodyPosition, 'done', bodyControl);
sm:set_transition(bodySearch, 'done', bodyControl);
sm:set_transition(bodyApproach, 'done', bodyControl);
sm:set_transition(bodyKick, 'done', bodyControl);
sm:set_transition(bodyOrbit, 'done', bodyControl);
sm:set_transition(bodyApproach, 'done', bodyControl);
sm:set_transition(bodyGotoCenter, 'done', bodyControl);

--sm:set_transition(bodyObstacle, 'clear', bodyPosition);
--sm:set_transition(bodyObstacle, 'timeout', bodyObstacleAvoid);
--sm:set_transition(bodyObstacleAvoid, 'clear', bodyPosition);
--sm:set_transition(bodyObstacleAvoid, 'timeout', bodyPosition);

-- does this do anything??
sm:set_transition(bodyPosition, 'fall', bodyPosition);
sm:set_transition(bodyApproach, 'fall', bodyPosition);
sm:set_transition(bodyKick, 'fall', bodyPosition);

-- set state debug handle to shared memory settor
sm:set_state_debug_handle(gcm.set_fsm_body_state, gcm.set_fsm_body_next_state);


function entry()
  sm:entry()
end

function update()
  sm:update();
end

function exit()
  sm:exit();
end
