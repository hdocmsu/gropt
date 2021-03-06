%% Simple diffusion solver
params = struct;
params.mode = 'diff_bval';
params.gmax = 0.04;
params.smax = 200.0;
params.MMT = 1; % M1 nulling
params.T_readout = 16.0;
params.T_90 = 4.0;
params.T_180 = 8.0;
params.dt = 500e-6;

G_min = get_min_TE_diff(250, 30.0, 200.0, params);

% Plotting 
tt = [0:numel(G_min)-1] .* params.dt .* 1e3;
figure();
plot(tt, G_min.*1000);
hold on;
plot([min(xlim()),max(xlim())],[0,0], 'k--');
title('G'); xlabel('t [ms]'); ylabel('G [mT/m]');

% Plot eddy currents
lam_max = 100; % maximum lambda [ms] for eddy spectrum analysis
[all_lam, all_e] = get_eddy(lam_max, G_min, params.dt);
figure();
plot(all_lam, all_e);
hold on;
plot([min(xlim()),max(xlim())],[0,0], 'k--');
title('Eddy Current Spectrum'); xlabel('lambda [ms]');

%% EN-CODE diffusion solver
% Null lambda = 40ms
params = struct;
params.mode = 'diff_bval';
params.gmax = 0.04;
params.smax = 200.0;
params.MMT = 1; % M1 nulling
params.T_readout = 16.0;
params.T_90 = 4.0;
params.T_180 = 8.0;
params.dt = 500e-6;
params.eddy_params = [];
params.eddy_params (:,end+1) = [40, 0, 1.0e-4, 0];

G_min = get_min_TE_diff(250, 30.0, 200.0, params);

% Plotting 
tt = [0:numel(G_min)-1] .* params.dt .* 1e3;
figure();
plot(tt, G_min.*1000);
hold on;
plot([min(xlim()),max(xlim())],[0,0], 'k--');
title('G'); xlabel('t [ms]'); ylabel('G [mT/m]');

% Plot eddy currents
lam_max = 100; % maximum lambda [ms] for eddy spectrum analysis
[all_lam, all_e] = get_eddy(lam_max, G_min, params.dt);
figure();
plot(all_lam, all_e);
hold on;
plot([min(xlim()),max(xlim())],[0,0], 'k--');
title('Eddy Current Spectrum'); xlabel('lambda [ms]');

    

%% Simple phase encode
% M0 = 10, nothing else

M0 = 10;
params = struct;
params.mode = 'free';
params.gmax = 0.05;
params.smax = 100.0;
params.moment_params = [];
params.moment_params(:,end+1) = [0, 0, 0, -1, -1, M0, 1.0e-4];
params.dt = 10e-6;

params.eddy_params = [];
params.eddy_params (:,end+1) = [5, 0, 1.0e-4, 0];

[G_min, T_min] = get_min_TE_free(params, 3.0);

% Plotting 
tt = [0:numel(G_min)-1] .* params.dt .* 1e3;
figure();
plot(tt, G_min.*1000);
hold on;
plot([min(xlim()),max(xlim())],[0,0], 'k--');
title('G'); xlabel('t [ms]'); ylabel('G [mT/m]');

% Plot eddy currents
lam_max = 100; % maximum lambda [ms] for eddy spectrum analysis
[all_lam, all_e] = get_eddy(lam_max, G_min, params.dt);
figure();
plot(all_lam, all_e);
hold on;
plot([min(xlim()),max(xlim())],[0,0], 'k--');
title('Eddy Current Spectrum'); xlabel('lambda [ms]');


%% Eddy comped phase encode
% M0 = 10, eddy comp lambda = 5ms

M0 = 10;
params = struct;
params.mode = 'free';
params.gmax = 0.05;
params.smax = 100.0;
params.moment_params = [];
params.moment_params(:,end+1) = [0, 0, 0, -1, -1, M0, 1.0e-4];
params.dt = 10e-6;

[G_min, T_min] = get_min_TE_free(params, 1.0);

% Plotting 
tt = [0:numel(G_min)-1] .* params.dt .* 1e3;
figure();
plot(tt, G_min.*1000);
hold on;
plot([min(xlim()),max(xlim())],[0,0], 'k--');
title('G'); xlabel('t [ms]'); ylabel('G [mT/m]');

% Plot eddy currents
lam_max = 100; % maximum lambda [ms] for eddy spectrum analysis
[all_lam, all_e] = get_eddy(lam_max, G_min, params.dt);
figure();
plot(all_lam, all_e);
hold on;
plot([min(xlim()),max(xlim())],[0,0], 'k--');
title('Eddy Current Spectrum'); xlabel('lambda [ms]');
