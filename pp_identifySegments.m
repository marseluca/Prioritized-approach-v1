function segments = pp_identifySegments(paths,trajectories)
    
    % This function identifies which segment of the path 
    % A given point belongs to
    
    global nRobots;
    segments = {};

    for j=1:nRobots

        segments{j} = [];
        currentSegment = 1;
        for i=1:length(trajectories{j}.x_tot)
            segments{j}(i) = currentSegment;

            currentTrajectoryPoint = [trajectories{j}.x_tot(i), trajectories{j}.y_tot(i)];
            currentPathPoint = paths{j}(currentSegment+1,:);

            if norm(currentTrajectoryPoint-currentPathPoint)<0.5
                currentSegment = currentSegment + 1;
            end
        end

    end

end

