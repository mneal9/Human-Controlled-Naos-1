module(..., package.seeall);

require('Body')
require('walk')
require('vector')
require('util')
require('Config')
require('wcm')
require('Speak')
require('gcm')


-- maximum walk velocity
maxStep = 0.06;

-- ball detection timeout
tLost = 5.0;

-- maximum ball distance threshold
rFar = 0.45;

function entry()
  print(_NAME.." entry");

--TAKEN FROM DRIBBLE

end

function update()

  local t = Body.get_time();

-- get ball position
  ball = wcm.get_ball();
  ballR = math.sqrt(ball.x^2 + ball.y^2);
  attackBearing = wcm.get_attack_bearing();
 
  ca = math.cos(attackBearing);
  sa = math.sin(attackBearing);
  xAttack = .5 * ((ca * ball.x - sa * ball.y) - 0.05);
  yAttack = .8 * (sa * ball.x + ca * ball.y);

  vx = ca * xAttack + sa * yAttack;
  vy = -sa * xAttack + ca * yAttack;

  scale = math.min(maxStep/math.sqrt(vx^2 + vy^2), 1); 
  vx = scale * vx;
  vy = scale * vy;

  aBall = math.atan2(ball.y, ball.x + 0.10);
  va = .5 * aBall;

  -- walk will be alined to ball location
  walk.set_velocity(vx, vy, va);

--LOST
  if (t - ball.t > tLost) then
    return "ballLost";
  end

--continues until shared memory's next body state is changed
  nextState = gcm.get_fsm_body_next_state();
  if (nextState ~= _NAME) then
    return "done";
  end

end

function exit()
  print(_NAME..' exit');
end

