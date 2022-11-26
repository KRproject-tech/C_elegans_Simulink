clc
clear all
close all hidden

%% delete
delete( '*.asv')

%% pathí Ç∑
add_pathes


%% parameter
param_setting


%% CPUêî
maxNumCompThreads(core_num);


%% exe

h_wait = waitbar(0,'Please wait...');
sim( 'C_elegans.mdl', [0 End_Time])
close(h_wait)


%% save 

Time_m = (1:length(pD_i))*d_Time;

save ./save/NUM_DATA



%% finish
warndlg( 'Computing finished.')