% CLD

% Computes phases geomtrically to match IGT phases with k-Wave phases

% Inputs: 
%   frequency -- the frequency of the waveform in hZ
%   speed_of_sound -- the scalar speed of sound in the medium in m/s
%   element_locations -- Nx3 matrix with  positions of the elements relative to the origin, in m
%   steer_coord -- the location of the desired focus in US space in m

% Outputs:
%   phases -- an Nx1 vector of the phases in radians, meant to be applied
%   to a signal as: signal(k) = sin(2*pi*f*t_array + phase(k))

function phases = computePhasesGeometric(frequency,speed_of_sound,element_locations,steer_coord)

    dist_to_target = sqrt( (element_locations(:,1)-steer_coord(1)).^2 + ...
        (element_locations(:,2)-steer_coord(2)).^2 + ...
        (element_locations(:,3)-steer_coord(3)).^2 ); % m  
    
    time_to_target = dist_to_target ./ speed_of_sound; % sec
    inverse_time = max(time_to_target) - time_to_target; 
    
    phases = -1*(mod(inverse_time*2*pi*frequency, 2*pi) - pi/2); % match IGT phases