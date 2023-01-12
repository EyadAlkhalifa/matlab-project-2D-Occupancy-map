clear; close all; clc

x_map = 100; %input('Give the width of the map: ');
y_map = 100; %input('Give the height of the map: ');

%% create the map, start, and target points
[map, x_start, y_start, x_target, y_target] = create_map(x_map, y_map);