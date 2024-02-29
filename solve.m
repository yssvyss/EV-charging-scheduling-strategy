function[simulation,fv] = solve(simulation,n,price,firstCost,EVdemand)
%% 定义函数
% Create an Instance of Optimization Problem
problem = ypea_problem();

% Set the Problem Type
problem.type = 'max';

% Define the Decision Variables
problem.vars = ypea_var('x', 'real', 'lower_bound',simulation(:,2)', 'upper_bound', (simulation(:,4)-simulation(:,3))');

% Define the Objective Function
f = @(x) fitness(x,n,price,firstCost,simulation,EVdemand);
problem.obj_func = @(sol) f(sol.x);
%% 求解

%% 人工蜂群（ABC）
% alg = ypea_abc();
% % Maximum Number of Iterations
% alg.max_iter = 100;
%
% % Population Size
% alg.pop_size = 100;
%
% % Number of Onlooker Bees
% alg.onlooker_count = 20;
%
% % Maximum Acceleration
% alg.max_acceleration = 0.5;
% best_sol = alg.solve(problem);
% simulation(:,5) = best_sol.solution.x';
% fv=best_sol.obj_value;
%% 粒子群优化（PSO）
alg = ypea_pso();

% Maximum Number of Iterations
alg.max_iter = 100;

% Population Size
alg.pop_size = 100;

% % Inertia Weight
% alg.w = 0.5;
% 
% % Inertia Weight Damp Rate
% alg.wdamp = 1;
% 
% % Personal Learning (Acceleration) Coefficient
% alg.c1 = 2;
% 
% % Global Learning (Acceleration) Coefficient
% alg.c2 = 2;

phi1 = 2.05;
phi2 = 2.05;
alg.use_constriction_coeffs(phi1, phi2);


%% 模拟退火（SA）
% alg = ypea_sa();
% % Maximum Number of Iterations
% alg.max_iter = 100;
%
% % Population Size
% alg.pop_size = 5;
%
% % Sub-Iretaions at a Fixed Temperature
% alg.max_sub_iter = 10;
%
% % Number of Moves (Neighbor Solutions) per Individual
% alg.move_count = 15;
%
% % Mutation Rate
% alg.mutation_rate = 1/problem.var_count;
%
% % Mutation Step Size
% alg.mutation_step_size = 0.5;
%
% % Mutation Step Size Damp Rate
% alg.mutation_step_size_damp = 1;
%
% % Initial Temperature
% alg.initial_temp = 10000;
%
% % Final Temperature
% alg.final_temp = 1;

%% 输出结果

best_sol = alg.solve(problem);
simulation(:,5) = best_sol.solution.x';
fv=best_sol.obj_value;
% [alg.w, alg.c1, alg.c2]
alg.run_time

end