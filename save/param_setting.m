%% parameter
%%%
%%% J. Boyle et al., Gait modulation in C.elegans: an integrated
%%% neuromechanical model, Frontiers in Computational Neuroscience, 2012.
%%%


%% ��̓p�����[�^
End_Time = 15; %% ��͏I�[���� [s]
d_Time = 2e-2; %% ��͍��ݎ��� [s]
core_num = 2; %% CPU�� [-]

%% �`��p�����[�^
M_num = 48; %% Segment number [-]
Length = 1e-3; %% Total length [m]
R_minor = 40e-6; %% Minor radius [m]

i_vec = (1:M_num+1).'; %% Nodes number [-] 
R_i = R_minor*abs( sin( acos( ( i_vec - (M_num/2 + 1) )/( M_num/2 + 0.2 ) )) ); %% the radii along the body [m] 
L_seg = Length/M_num; %% Length per an unit segment [m]
L_0L_i = sqrt( L_seg^2 + (R_i(1:end-1) - R_i(2:end)).^2 ); %% rest length of lateral spring [m]
L_0D_i = sqrt( L_seg^2 + (R_i(1:end-1) + R_i(2:end)).^2 ); %% rest length of diagnal spring [m]

X_com0 = [ (i_vec-1)*L_seg zeros(M_num+1,1)]; %% �e�����N�d�S�̏����ʒu [m]
% X_com0 = [ (i_vec-1)*L_seg ((1:M_num+1)/M_num - 0.5).^2.'*M_num/4*L_seg]; %% �e�����N�d�S�̏����ʒu [m]
X_com0 = reshape( X_com0.', [], 1);
phi0_vec = ones(M_num+1,1)*pi/2;


%% �\���p�����[�^
kappa_L = M_num/24*0.01; %% Lateral spring constant [kg/s^2]
kappa_D = kappa_L*350; %% Diagonal spring constant [kg/s^2]
beta_L = kappa_L*0.025; %% Lateral damping constant [kg/s]
beta_D = kappa_D*0.01; %% Diagonaldamping constant [kg/s]


%% �ؓ��p�����[�^
Delta_M = 0.65; %% [-]
L_min_i = L_0L_i.*( 1 - Delta_M*(R_i(1:end-1) + R_i(2:end))/(2*R_minor) ); %% Minimum muscle length [m]
F_max_i = [ 0.70*2/3 0.70-0.42*(1:M_num-1)/M_num].'; %% Maximum muscle efficacies [-]
kappa_0M = kappa_L*20; %% Muscle spring constant [kg/s^2]
beta_0M = beta_L*100; %% Muscle damping constant [kg/s]


%% �^���j���[����
N_num = 12; %% �^���j���[������ [-]
eps_hys = 0.5; %% �q�X�e���V�X�p�����[�^ [-]
I_AVB_D = 0.675; %% Input current from forward locomotion command interneurons AVB [-]
I_AVB_V = 1.175; %% Input current from forward locomotion command interneurons AVB [-]
w_D = 0; %% Inhibitory (GABAergic) synaptic weight [-]
w_V = -1; %% Inhibitory (GABAergic) synaptic weight [-]

S0_nk = [ ones(N_num,1); zeros(N_num,1)]; %% Initializing all neuron [-]


%% Stretch receptor parameter
N_out = M_num/N_num; %% �̐�/�_�o�߂̔� [-]
N_SR = M_num/2; %% �̐ߐ��̔��� [-]
n_num = (1:N_num).'; %% Nervous number [-]
A_n = 1.*( (n_num - 1)*N_out <= M_num - N_SR ) ...
            + sqrt( N_SR./( M_num - (n_num - 1)*N_out ) ).*( (n_num - 1)*N_out > M_num - N_SR ); %% Prefactor for sensory feedback [-]
%%%------------------------------------------------------------------------
%%% �_���ł� G_SR_n�̒�`��,
%%%     G_SR_n = (0.224 + 0.056*n_num)/N_out; 
%%% �ƂȂ��Ă��邪�C�T���v���v���O�����ƈقȂ�(���)�D
%%%------------------------------------------------------------------------
G_SR_n = Delta_M*(0.4 + 0.08*n_num)*2/N_out; %% The conductance parameter[-]
lambda_i = 2*R_minor./( R_i(1:end-1) + R_i(2:end) ); %% Sensory feedback gain [-]
gamma_iD = [0.8 1.2]; %% Sensory feedback gain on dorsal [-]
gamma_iV = 1; %% Sensory feedback gain on ventral [-]


%% Muscle electrophysiology parameter
w_NMJ = ones(M_num,1); %% The excitatory neuromuscular junction (NMJ) weights [-]
not_w_NMJ = -w_NMJ; %% The strength of GABAergic muscle inhibition by D-class neurons [-] 
tau_M = 100e-3; %% Muscles respond as leaky integrators [s]


%% ���̃��f��

%%[0] ��
% C_par = 5.2e-6; %% �������R�� [kg/s]
% C_per = 3.3e-6; %% ���i�����R�� [kg/s]
%%[1] ���V
C_par = 128e-3; %% �������R�� [kg/s]
C_per = 3.2e-3; %% ���i�����R�� [kg/s]


%%%
%%% �̂�1�Z�O�����g�ɍ�p����R�͂ɂ��čl����D
%%%
c_par = C_par/(M_num+1); %% �������R�� [kg/s]
c_per = C_per/(M_num+1); %% ���i�����R�� [kg/s]
Ri_c_per = R_i.*c_per/2; %% ��]���� [kgm/s]: �~���f�ʂ̉�]���ɂ��Čv�Z�D


