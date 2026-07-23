% =========================================================================
% TÍTULO: Mapas de Calor EEG - Peak-to-Peak y RMS 
% DESCRIPCIÓN: Script para generar y exportar comparativas  
%              bajo distintas condiciones de inyección (Ambas fuentes, Fuente 1, Fuente 2).
% =========================================================================

clear; clc; close all;

%% 1. DEFINICIÓN DE CANALES Y COORDENADAS (Sistema 10-20)
channels = {'Fp1','Fp2','AF3','AF4','F7','F3','Fz','F4','F8',...
            'FC5','FC1','FC2','FC6','T7','C3','Cz','C4','T8',...
            'CP5','CP1','CP2','CP6','P7','P3','Pz','P4','P8',...
            'PO3','PO4','O1','Oz','O2'};

% Coordenadas normalizadas (vista superior cabeza)
X = [-0.30,  0.30, -0.30,  0.30, -0.80, -0.50,  0.00,  0.50,  0.80, ...
     -0.70, -0.30,  0.30,  0.70, -0.95,-0.50,  0.00,  0.50,  0.95,...
     -0.70, -0.30,  0.30,  0.70, -0.80, -0.50,  0.00,  0.50,  0.80, ...
     -0.30,  0.30, -0.30,  0.00,  0.30];

Y = [ 0.95,  0.95,  0.80,  0.80,  0.60,  0.60,  0.60,  0.60,  0.60, ...
      0.30,  0.30,  0.30,  0.30,  0.00,  0.00,  0.00,  0.00,  0.00, ...
     -0.30, -0.30, -0.30, -0.30, -0.60, -0.60, -0.60, -0.60, -0.60, ...
     -0.80, -0.80, -0.95, -0.95, -0.95];

%% 2. DATOS DE MEDICIONES
% Formato: [Peak-to-Peak (mV), RMS (mV)] para cada canal
% --- CONDICIÓN 1: AMBAS FUENTES ACTIVAS ---
data_ambas = [
    3100, 826;    % Fp1
    3000, 794.1;  % Fp2
    3280, 880;    % AF3
    3030, 795.5;  % AF4
    3540, 932;    % F7
    3500, 921;    % F3
    3390, 887;    % Fz
    3290, 862;    % F4
    3250, 849;    % F8
    3610, 945;    % FC5
    3560, 924;    % FC1
    3520, 909;    % FC2
    3430, 889;    % FC6
    3670, 948;    % T7
    3660, 945;    % C3
    3650, 939;    % Cz
    3610, 932;    % C4
    3570, 923;    % T8
    3740, 964;    % CP5
    3680, 958;    % CP1
    3720, 957;    % CP2
    3740, 966;    % CP6
    3800, 982;    % P7
    3830, 989;    % P3
    3830, 995;    % Pz
    3790, 1000;   % P4
    3820, 1012;   % P8
    3880, 1019;   % PO3
    3950, 1061;   % PO4
    3940, 1036;   % O1
    3960, 1052;   % Oz
    3960, 1079;   % O2
];

% --- CONDICIÓN 2: SOLO FUENTE 1 (50 Hz en AF3) ---
data_f1 = [
    1730, 625.4;  % Fp1
    1750, 630.2;  % Fp2
    1780, 643.3;  % AF3
    1790, 646.1;  % AF4
    1980, 713;    % F7
    1990, 715.4;  % F3
    2480, 879;    % Fz
    2000, 719.8;  % F4
    2040, 729.9;  % F8
    2160, 773.7;  % FC5
    2210, 790.6;  % FC1
    2220, 794.5;  % FC2
    2220, 793.2;  % FC6
    2280, 814.6;  % T7
    2320, 829.3;  % C3
    2370, 943.9;  % Cz
    2390, 852.4;  % C4
    2380, 845.8;  % T8
    2440, 870.3;  % CP5
    2450, 875;    % CP1
    2590, 885.7;  % CP2
    2550, 911.1;  % CP6
    2560, 912.8;  % P7
    2610, 930.8;  % P3
    2650, 944.7;  % Pz
    2710, 965;    % P4
    2760, 983;    % P8
    2760, 980;    % PO3
    2950, 1048;   % PO4
    2830, 1007;   % O1
    2900, 1033;   % Oz
    3020, 1073;   % O2
];

% --- CONDICIÓN 3: SOLO FUENTE 2 (10 Hz en O2) ---
data_f2 = [
    2390, 850;    % Fp1
    2270, 807;    % Fp2
    2560, 907;    % AF3
    2250, 800;    % AF4
    2680, 949;    % F7
    2640, 936;    % F3
    2010, 723;    % Fz
    2360, 839;    % F4
    2300, 817;    % F8
    2600, 922;    % FC5
    2510, 891;    % FC1
    2400, 873;    % FC2
    2360, 841;    % FC6
    2570, 912;    % T7
    2520, 891;    % C3
    2460, 874;    % Cz
    2410, 854;    % C4
    2370, 843;    % T8
    2510, 891;    % CP5
    2450, 860;    % CP1
    2440, 865;    % CP2
    2400, 853;    % CP6
    2510, 895;    % P7
    2470, 879;    % P3
    2440, 868;    % Pz
    2430, 865;    % P4
    2410, 857;    % P8
    2450, 870;    % PO3
    2420, 865;    % PO4
    2450, 876;    % O1
    2450, 873;    % Oz
    2430, 867;    % O2
];

% Conversiones de unidades
data_ambas(:,1) = data_ambas(:,1) / 1000;
data_f1(:,1)    = data_f1(:,1)    / 1000;
data_f2(:,1)    = data_f2(:,1)    / 1000;

data_ambas(:,2) = data_ambas(:,2) / 1000;
data_f1(:,2)    = data_f1(:,2)    / 1000;
data_f2(:,2)    = data_f2(:,2)    / 1000;

%% 3. CONFIGURACIÓN DE DATOS
condiciones = {'Ambas fuentes activas', 'Fuente 1: 50 Hz en AF3', 'Fuente 2: 10 Hz en O2'};
datasets = {data_ambas, data_f1, data_f2};

%% 4. FUNCIÓN PARA DIBUJAR CABEZA CON MAPA DE CALOR
function dibujar_cabeza(ax, X, Y, voltajes, channels, titulo, unidad)
    axes(ax);
    hold on;
    
    % Interpolación
    XI = linspace(-1.2, 1.2, 400);
    YI = linspace(-1.2, 1.2, 400);
    [XI_grid, YI_grid] = meshgrid(XI, YI);
    mask = (XI_grid.^2 + YI_grid.^2) <= 1.05;
    VI = griddata(X, Y, voltajes, XI_grid, YI_grid, 'cubic');
    VI(~mask) = NaN;
    
    % Mapa de calor
    contourf(XI_grid, YI_grid, VI, 100, 'LineColor', 'none');
    colormap(jet);
    
    % Contorno cabeza, nariz y orejas
    theta = linspace(0, 2*pi, 100);
    plot(cos(theta), sin(theta), 'k', 'LineWidth', 2.5);
    plot([-0.08 0 0.08], [0.99 1.12 0.99], 'k', 'LineWidth', 2.5);
    plot(-1.02 + 0.04*cos(theta), 0.15*sin(theta), 'k', 'LineWidth', 2.0);
    plot( 1.02 + 0.04*cos(theta), 0.15*sin(theta), 'k', 'LineWidth', 2.0);
    
    % Electrodos
    scatter(X, Y, 70, 'w', 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1.2);
    
    % Etiquetas
    for e = 1:length(channels)
        ch_name = channels{e};
        fontSize_ch = 12.0; 
        fontSize_v  = 11.0; 
        
        if strcmp(ch_name, 'Fp1')
            text(X(e), Y(e) + 0.055, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) - 0.10, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'Fp2')
            text(X(e), Y(e) + 0.055, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) + 0.10, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'PO3')
            text(X(e), Y(e) + 0.055, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) - 0.10, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'PO4')
            text(X(e), Y(e) + 0.055, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) + 0.10, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'T7')
            text(X(e), Y(e) + 0.055, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) + 0.10, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'T8')
            text(X(e), Y(e) + 0.055, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) - 0.10, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
            
        else
            if abs(Y(e)) > 0.85 || abs(X(e)) > 0.85
                fontSize_ch = 10.5;
                fontSize_v  = 9.5;
                offset_y    = 0.06;
            else
                fontSize_ch = 12.0;
                fontSize_v  = 11.0;
                offset_y    = 0.065;
            end
            
            text(X(e), Y(e) + offset_y, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e), Y(e) - offset_y, sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        end
    end
    
    % Colorbar
    cb = colorbar;
    cb.FontSize = 12;
    cb.FontWeight = 'bold';
    cb.Position = [ax.Position(1) + ax.Position(3) + 0.008, ax.Position(2) + 0.15, 0.018, 0.60]; 
    
    cb.Label.String = sprintf('Potencial (%s)', unidad);
    cb.Label.FontSize = 13;
    cb.Label.FontWeight = 'bold';
    
    title(titulo, 'FontSize', 15, 'FontWeight', 'bold', 'Color', 'k');
    
    axis equal;
    xlim([-1.2, 1.2]); 
    ylim([-1.2, 1.2]);
    axis off;
    hold off;
end

%% 5. FIGURA 1: COMPARACIÓN DE LAS 3 CONDICIONES (PEAK-TO-PEAK)
fig_ptp = figure('Name', 'Comparacion Peak-to-Peak', 'Color', 'w', 'Position', [50, 50, 1800, 750]);
for i = 1:3
    pos_x = 0.03 + (i-1)*0.32; 
    ax = axes('Position', [pos_x, 0.08, 0.26, 0.82]);
    
    voltajes_ptp = datasets{i}(:, 1);
    dibujar_cabeza(ax, X, Y, voltajes_ptp, channels, ...
        sprintf('%s\nPeak-to-Peak', condiciones{i}), 'V');
end

exportgraphics(fig_ptp, 'comparacion_ptp.png', 'Resolution', 300);

%% 6. FIGURA 2: COMPARACIÓN DE LAS 3 CONDICIONES (RMS)
fig_rms = figure('Name', 'Comparacion RMS', 'Color', 'w', 'Position', [50, 50, 1800, 750]);
for i = 1:3
    pos_x = 0.03 + (i-1)*0.32; 
    ax = axes('Position', [pos_x, 0.08, 0.26, 0.82]);
    
    voltajes_rms = datasets{i}(:, 2);
    dibujar_cabeza(ax, X, Y, voltajes_rms, channels, ...
        sprintf('%s\nRMS', condiciones{i}), 'V');
end

exportgraphics(fig_rms, 'comparacion_rms.png', 'Resolution', 300);

disp('Mapas de calor Peak-to-Peak y RMS generados y exportados exitosamente en alta resolución.');