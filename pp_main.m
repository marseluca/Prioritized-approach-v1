%% TRAJECTORY COMPUTATION

clear all
close all

openfig("warehouse.fig");
paths = {};
paths = load("C:\Users\Luca\Desktop\Collaborative path\paths_registration.mat").paths_registration;

global nRobots;
nRobots = size(paths,2);

for j=1:nRobots
    paths{j} = unique(paths{j},'rows','stable');
end

%% VARIABLES
robotSize = 20;
collisionThreshold = 20;
maxVelocity = 20;

animation = false;
animVelocity = 8;
recordAnimation = false;
solveCollisions = false;

global samplingTime;
samplingTime = 0.1;

% Create random path colors
global pathColors;
pathColors = distinguishable_colors(nRobots);



%% GET THE LONGEST PATH and ITS FINISH TIME
distances = [];
for j=1:nRobots

        % Calculate paths' distances
        totalDistance = 0;
        for i=2:size(paths{j},1)
            segmentDistance = norm(paths{j}(i-1,:)-paths{j}(i,:));
            totalDistance = totalDistance + segmentDistance;
        end

        distances = [distances, totalDistance];

end

maxDistanceIndex = find(distances==max(distances));
firstTrajectory = pp_interpolatePath(paths{maxDistanceIndex},maxVelocity);
tmax = firstTrajectory.t_tot(end);

%% PLAN THE VECTOR OF MAX VELOCITIES ACCORDINGLY

maxVelocities = zeros(1,nRobots);
for j=1:nRobots

        if j==maxDistanceIndex
            maxVelocities(j) = maxVelocity;
        else
            maxVelocities(j) = distances(j)/tmax;
        end

end

maxVelocities 

%% INTERPOLATION
trajectories = {};
for j=1:nRobots
    trajectories{j} = pp_interpolatePath(paths{j},maxVelocities(j));
end

% Plot the trajectories
pp_plotPathOnMap(paths,trajectories);

% Plot positions, velocities and accelerations
pp_producePlots(trajectories);

%% COLLISION CHECKING
collisions = {};
for j=1:nRobots
    collisions{j} = pp_checkCollisionForOneRobot(trajectories,collisionThreshold,j);
end

% Plot collisions
previousCollisionTime = -Inf;
if ~isempty(collisions) 
    for i=1:size(collisions,2)
        for j=1:size(collisions{i},1)
            % Avoid plotting the collision between the same robot
            % That happens in the range of 5 seconds
            if abs(collisions{i}(j,5)-previousCollisionTime)>5
                figure(1)
                k = collisions{i}(j,3);
                plot(trajectories{i}.x_tot(k),trajectories{i}.y_tot(k),"o","Color",pathColors(i,:),"MarkerSize",8);
            end
            previousCollisionTime = collisions{i}(j,5);
        end
    end
end

figure(1)
%% COLLISION SOLVING
if ~isempty(collisions) && solveCollisions
    
    tic
    % optimizedVector = pp_collisionFreeVelocities1(paths,collisionThreshold,maxVelocity);
    optimizedVector = pp_collisionFreeVelocities2(paths,collisionThreshold,maxVelocity,maxVelocities);

    for j=1:nRobots
        vmax = optimizedVector(j);
        trajectories{j} = pp_interpolatePath(paths{j},vmax);
    end
    toc
    
end


%% ANIMATION
if animation
    fprintf("\nPress enter to animate...\n")
    pp_animateTrajectory(trajectories,robotSize,recordAnimation,animVelocity);
end

figure(1)
saveas(gcf,'warehouse.png')