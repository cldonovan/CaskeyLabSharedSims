% CLD 

% Inputs:
%   t_array    --    the 1xNt array of evenly spaced time points (s) (set to kgrid.t_array in most cases)
%   freq       --    transmit frequency (Hz)
%   c_water    --    speed of sound in water (m/s)
%   amp        --    scalar element amplitude (au)
%   elemLocs   --    Nx3 array of element coordinates (m)
%   steerLoc   --    desired steer coordinate in US-space (m)
%   rampLength --    length of the up-ramp (periods)

% Outputs: 
%   signals    --    NxNt matrix of driving signals

function signals = makeFocusedSignalsFromLocations(t_array,freq,c_water,amp,elemLocs,steerLoc,rampLength)

    dim = size(elemLocs);

    N = dim(1);  

    amps = amp.*ones(N,1);

    phases = computePhasesGeometric(freq, c_water, elemLocs, steerLoc); 

    signals = createCWSignals(t_array,freq,amps,phases,rampLength);