clc
clear all
close all hidden

%% delete
delete( '*.asv')

%% path
add_pathes

%% parameter
param_setting

%% load
load ./save/NUM_DATA


%% plot data

i_ax = 1;

%%-------------------------------------------------------------------------
%%[0] plot swim path [m]
%%-------------------------------------------------------------------------
h_fig(1) = figure(1);
set( h_fig(1), 'Position', [ 100 100 1300 600], 'Renderer', 'painters')
h_ax(i_ax) = axes( 'Parent', h_fig(1), 'FontSize', 15);

xCOM_x = xCOM(:,1:2:end-1).';
xCOM_y = xCOM(:,2:2:end).';
ind_time = 1:20:length( Time_m);
T_mat = ones(M_num+1,1)*Time_m(ind_time);
xCOM_x(end,:) = nan;%% 各時刻での形状の表示の独立
xCOM_y(end,:) = nan;

color_line( h_ax(i_ax), xCOM_x(:,ind_time), xCOM_y(:,ind_time), T_mat, 'LineWidth', 2);
xlabel( '{\itX} position [m]', 'FontSize', 25, 'FontName', 'Times New Roman')
ylabel( '{\itY} position [m]', 'FontSize', 25, 'FontName', 'Times New Roman')
axis equal
axis( h_ax(i_ax), [ min( xCOM_x(:)) max( xCOM_x(:)) ...
    min( min( xCOM_y(:)), -0.5*Length) max( max( xCOM_y(:)), 0.5*Length)])
grid( h_ax(i_ax), 'on')
hold( h_ax(i_ax), 'on')
h_cbar(1) = colorbar( 'peer', h_ax(i_ax), 'FontSize', 15, 'FontName', 'Times New Roman');
ylabel( h_cbar(1), 'Time [s]', 'FontSize', 25, 'FontName', 'Times New Roman')


set( h_ax(i_ax), 'FontName', 'Times New Roman')




i_ax = i_ax + 1;



%%-------------------------------------------------------------------------
%%[1] plot body forces [N]
%%-------------------------------------------------------------------------
h_fig(2) = figure(2);
set( h_fig(2), 'Position', [ 100 100 1300 800], 'Renderer', 'painters')
h_ax(i_ax) = subplot( 3, 1, 1, 'Parent', h_fig(2), 'FontSize', 15);

F_MD = F_M(:,1:M_num);
F_MV = F_M(:,M_num+1:end);
F_LD = F_L(:,1:M_num);
F_LV = F_L(:,M_num+1:end);
F_DD = F_D(:,1:M_num);
F_DV = F_D(:,M_num+1:end);



h_plot_f(1,:) = plot( h_ax(i_ax), Time_m, F_MD, 'b', Time_m, F_MV, 'r');
xlabel( h_ax(i_ax), 'Time [s]', 'FontSize', 25, 'FontName', 'Times New Roman')
ylabel( h_ax(i_ax), 'Muscle force [N]', 'FontSize', 25, 'FontName', 'Times New Roman')
grid( h_ax(i_ax), 'on')
hold( h_ax(i_ax), 'on')
xlim( h_ax(i_ax), [ 0 Time_m(end)])
% ylim( h_ax(i_ax), [ -15e-7 5e-7])

h_lg(1) = legend( h_plot_f(1,[ 1 M_num+1]), 'Dorsal', 'Ventral');


set( h_lg(1), 'FontSize', 20)
set( h_ax(i_ax), 'FontName', 'Times New Roman')




i_ax = i_ax + 1;

h_ax(i_ax) = subplot( 3, 1, 2, 'Parent', h_fig(2), 'FontSize', 15);
h_plot_f(2,:) = plot( h_ax(i_ax), Time_m, F_LD, 'b', Time_m, F_LV, 'r');
xlabel( h_ax(i_ax), 'Time [s]', 'FontSize', 25, 'FontName', 'Times New Roman')
ylabel( h_ax(i_ax), [ 'Lateral visco-', sprintf( '\r\n'), 'elastic force [N]'], 'FontSize', 25, 'FontName', 'Times New Roman')
grid( h_ax(i_ax), 'on')
hold( h_ax(i_ax), 'on')
xlim( h_ax(i_ax), [ 0 Time_m(end)])
% ylim( h_ax(i_ax), [ -20e-7 5e-7])

h_lg(2) = legend( h_plot_f(2,[ 1 M_num+1]), 'Dorsal', 'Ventral');


set( h_lg(2), 'FontSize', 20)
set( h_ax(i_ax), 'FontName', 'Times New Roman')




i_ax = i_ax + 1;

h_ax(i_ax) = subplot( 3, 1, 3, 'Parent', h_fig(2), 'FontSize', 15);
h_plot_f(3,:) = plot( h_ax(i_ax), Time_m, F_DD, 'b', Time_m, F_DV, 'r');
xlabel( h_ax(i_ax), 'Time [s]', 'FontSize', 25, 'FontName', 'Times New Roman')
ylabel( h_ax(i_ax), [ 'Diagonal visco-', sprintf( '\r\n'), 'elastic force [N]'], 'FontSize', 25, 'FontName', 'Times New Roman')
grid( h_ax(i_ax), 'on')
hold( h_ax(i_ax), 'on')
xlim( h_ax(i_ax), [ 0 Time_m(end)])
% ylim( h_ax(i_ax), [ -20e-7 5e-7])

h_lg(3) = legend( h_plot_f(3,[ 1 M_num+1]), 'Dorsal', 'Ventral');


set( h_lg(3), 'FontSize', 20)
set( h_ax(i_ax), 'FontName', 'Times New Roman')




i_ax = i_ax + 1;


%% animation



h_fig(3) = figure(3);
set( h_fig(3), 'Position', [ 100 100 1700 800])
h_ax(i_ax) = axes( 'Parent', h_fig(3), 'FontSize', 25);

pD_x = squeeze( pD_i(:,1,:));
pD_y = squeeze( pD_i(:,2,:));
pV_x = squeeze( pV_i(:,1,:));
pV_y = squeeze( pV_i(:,2,:));
X_data = [ pD_x; flipud( pV_x); pD_x(1,:)];
Y_data = [ pD_y; flipud( pV_y); pD_y(1,:)];

%%[0] 輪郭plot [m]
h_plot(1) = plot( h_ax(i_ax), X_data(:,1), Y_data(:,1), 'r', 'LineWidth', 3);
xlabel( '{\itX} position [m]', 'FontSize', 40, 'FontName', 'Times New Roman')
ylabel( '{\itY} position [m]', 'FontSize', 40, 'FontName', 'Times New Roman')
grid( h_ax(i_ax), 'on')
hold( h_ax(i_ax), 'on')
axis image
axis( h_ax(i_ax), [ min( X_data(:)) max( X_data(:)) min( Y_data(:)) max( max( Y_data(:)), 0.5*Length)])
%%[1] 接続点plot [m]
h_plot(2) = quiver( h_ax(i_ax), [ pD_x(1:end-1,1); pV_x(1:end-1,1)], [ pD_y(1:end-1,1); pV_y(1:end-1,1)],...
                        -[ LL_D(1,:).'.*nL_D(:,1,1); LL_V(1,:).'.*nL_V(:,1,1)], -[ LL_D(1,:).'.*nL_D(:,2,1); LL_V(1,:).'.*nL_V(:,2,1)], 'AutoScale', 'off', 'LineWidth', 1);
h_plot(3) = quiver( h_ax(i_ax), [ pD_x(1:end-1,1); pV_x(1:end-1,1)], [ pD_y(1:end-1,1); pV_y(1:end-1,1)],...
                        -[ LD_D(1,:).'.*nD_D(:,1,1); LD_V(1,:).'.*nD_V(:,1,1)], -[ LD_D(1,:).'.*nD_D(:,2,1); LD_V(1,:).'.*nD_V(:,2,1)], ...
                        'b', 'AutoScale', 'off', 'LineWidth', 3, 'ShowArrowHead', 'off');
h_txt(1) = text( 0.5*Length, 0.5*Length, [ 'Time = ', num2str( Time_m(1), '%0.2f'), ' [s]'], ...
              'FontName', 'Times New Roman', 'FontSize',45, 'BackgroundColor', 'g');
                    
                    
set( h_ax(i_ax), 'FontName', 'Times New Roman')

i_ax = i_ax + 1;


%% plot更新

D_ii = 4;
i_cnt = 1;

ii_mat = 1:D_ii:length(Time_m);
for ii = ii_mat
   
    %%[0] 輪郭plot [m]
    set( h_plot(1), 'XData', X_data(:,ii), 'YData', Y_data(:,ii))
    %%[1] 接続点plot [m]
    set( h_plot(2), 'XData', [ pD_x(1:end-1,ii); pV_x(1:end-1,ii)], 'YData', [ pD_y(1:end-1,ii); pV_y(1:end-1,ii)], ...
                    'UData', -[ LL_D(ii,:).'.*nL_D(:,1,ii); LL_V(ii,:).'.*nL_V(:,1,ii)], 'VData', -[ LL_D(ii,:).'.*nL_D(:,2,ii); LL_V(ii,:).'.*nL_V(:,2,ii)])
    set( h_plot(3), 'XData', [ pD_x(1:end-1,ii); pV_x(1:end-1,ii)], 'YData', [ pD_y(1:end-1,ii); pV_y(1:end-1,ii)], ...
                    'UData', -[ LD_D(ii,:).'.*nD_D(:,1,ii); LD_V(ii,:).'.*nD_V(:,1,ii)], 'VData', -[ LD_D(ii,:).'.*nD_D(:,2,ii); LD_V(ii,:).'.*nD_V(:,2,ii)])
    set( h_txt(1), 'String', [ 'Time = ', num2str( Time_m(ii), '%0.2f'), ' [s]'])
    drawnow
    pause(0.01)
    
    movie_data(i_cnt) = getframe( h_fig(3)); %#ok<AGROW>
    i_cnt = i_cnt + 1;
end



%% plot path of posterior edge

pos_path = [ pD_x(end,1:ii_mat(end)) + pV_x(end,1:ii_mat(end));
             pD_y(end,1:ii_mat(end)) + pV_y(end,1:ii_mat(end))]/2;
plot( h_ax(i_ax-1), pos_path(1,:), pos_path(2,:), 'g', 'LineWidth', 3);

drawnow


%% save

dT = mean( diff( Time_m));
% movie2avi( movie_data, 'data.avi', 'fps', 1/(dT*D_ii))


fig_name = { 'swim_path', 'body_forces', 'behavior'};
for ii=1:length(h_fig)
   saveas( h_fig(ii), [ './save/fig/', fig_name{ii}, '.fig']) 
end

