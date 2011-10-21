module(..., package.seeall);

require('Body')
require('gcm')

state = nil

function entry()
  print(_NAME..' entry');

  state = gcm.get_next_body_state();

end

function update()
  nextState = gcm.get_next_body_state();

  if (state ~= nextState) then
    if (nextState == 'bodySearch') then
      return 'search';
    end
    if (nextState == 'bodyApproach') then
      return 'approach';
    end
    if (nextState == 'bodyKick') then
      return 'kick';
    end
    if (nextState == 'bodyOrbit') then
      return 'orbit';
    end
    if (nextState == 'bodyGotoCenter') then
      return 'center';
    end
    if (nextState == 'bodyPosition') then
      return 'position';
    end
  end
end

function exit()
end
