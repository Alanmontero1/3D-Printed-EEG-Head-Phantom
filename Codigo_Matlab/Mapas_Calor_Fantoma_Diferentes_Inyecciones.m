% =========================================================================
% TÍTULO: Script para Mapas de Calor Fantoma
% DESCRIPCIÓN: Script para visualización y exportación 
%              automática de mapas de calor para múltiples casos de inyección.
% =========================================================================

clear; clc; close all;

%% 1. DEFINICIÓN DE CANALES Y COORDENADAS TOPOGRÁFICAS APROXIMADAS
channels = {'Fp1','Fp2','AF3','AF4','F7','F3','Fz','F4','F8',...
            'FC5','FC1','FC2','FC6','T7','C3','Cz','C4','T8',...
            'CP5','CP1','CP2','CP6','P7','P3','Pz','P4','P8',...
            'PO3','PO4','O1','Oz','O2'};
X = [-0.3,  0.3, -0.3,  0.3, -0.8, -0.5,  0.0,  0.5,  0.8, ...
     -0.7, -0.3,  0.3,  0.7, -0.95,-0.5,  0.0,  0.5,  0.95,...
     -0.7, -0.3,  0.3,  0.7, -0.8, -0.5,  0.0,  0.5,  0.8, ...
     -0.3,  0.3, -0.3,  0.0,  0.3];
Y = [ 0.95, 0.95, 0.8,  0.8,  0.6,  0.6,  0.6,  0.6,  0.6, ...
      0.3,  0.3,  0.3,  0.3,  0.0,  0.0,  0.0,  0.0,  0.0, ...
     -0.3, -0.3, -0.3, -0.3, -0.6, -0.6, -0.6, -0.6, -0.6, ...
     -0.8, -0.8, -0.95,-0.95,-0.95];

%% 2. INGRESO DE DATOS EXPERIMENTALES
data = [
    1.81, 1.75, 2.47, 2.72, 1.92, 1.76, 1.73, 1.92, 3.55; % Fp1
    1.84, 1.72, 2.64, 2.56, 1.88, 1.78, 1.79, 1.92, 3.53; % Fp2
    1.89, 1.86, 2.48, 2.95, 2.03, 1.83, 1.78, 2.03, 3.71; % AF3
    1.91, 1.78, 2.84, 2.55, 1.91, 1.86, 1.88, 2.00, 3.68; % AF4
    2.17, 2.17, 2.58, 3.14, 2.50, 2.02, 1.95, 2.31, 4.25; % F7
    2.17, 2.17, 2.64, 3.09, 2.36, 2.05, 1.98, 2.30, 4.21; % F3
    2.19, 2.11, 2.78, 2.89, 2.23, 2.14, 2.06, 2.28, 4.20; % Fz
    2.17, 2.02, 2.97, 2.72, 2.14, 2.17, 2.14, 2.23, 4.18; % F4
    2.20, 2.00, 3.05, 2.67, 2.11, 2.22, 2.29, 2.25, 4.23; % F8
    2.39, 2.45, 2.67, 3.07, 2.78, 2.19, 2.10, 2.56, 4.71; % FC5
    2.45, 2.45, 2.77, 2.96, 2.53, 2.32, 2.21, 2.58, 4.71; % FC1
    2.45, 2.30, 2.85, 2.86, 2.40, 2.47, 2.30, 2.53, 4.64; % FC2
    2.45, 2.16, 2.98, 2.67, 2.28, 2.49, 2.53, 2.45, 4.53; % FC6
    2.55, 2.56, 2.70, 3.03, 3.45, 2.28, 2.18, 2.79, 5.09; % T7
    2.59, 2.86, 2.75, 2.98, 2.75, 2.36, 2.24, 2.78, 5.12; % C3
    2.64, 2.52, 2.83, 2.92, 2.57, 2.55, 2.36, 2.73, 5.04; % Cz
    2.67, 2.33, 2.90, 2.86, 2.44, 2.85, 2.53, 2.68, 4.90; % C4
    2.64, 2.23, 2.97, 2.83, 2.38, 2.59, 3.19, 2.63, 4.85; % T8
    2.73, 2.69, 2.77, 2.99, 2.97, 2.39, 2.28, 3.00, 5.52; % CP5
    2.77, 2.63, 2.81, 2.93, 2.69, 2.51, 2.36, 2.95, 5.33; % CP1
    2.81, 2.50, 2.84, 2.90, 2.59, 2.63, 2.45, 2.87, 5.23; % CP2
    2.88, 2.36, 2.89, 2.86, 2.48, 2.72, 2.72, 2.82, 5.17; % CP6
    2.89, 2.64, 2.79, 2.97, 2.97, 2.45, 2.33, 3.28, 5.99; % P7
    2.94, 2.63, 2.80, 2.95, 2.81, 2.51, 2.38, 3.22, 5.88; % P3
    2.98, 2.56, 2.84, 2.92, 2.92, 2.59, 2.47, 3.15, 5.73; % Pz
    3.08, 2.47, 2.86, 2.89, 2.59, 2.66, 2.57, 3.05, 5.63; % P4
    3.13, 2.41, 2.89, 2.87, 2.54, 2.67, 2.72, 2.97, 5.40; % P8
    3.13, 2.59, 2.81, 2.94, 2.78, 2.55, 2.43, 3.52, 6.46; % PO3
    3.36, 2.50, 2.85, 2.92, 2.66, 2.63, 2.54, 3.25, 6.10; % PO4
    3.23, 2.56, 2.82, 2.93, 2.78, 2.55, 2.45, 3.52, 6.44; % O1
    3.31, 2.55, 2.84, 2.92, 2.72, 2.56, 2.47, 3.45, 6.31; % Oz
    3.45, 2.53, 2.84, 2.92, 2.69, 2.59, 2.52, 3.38, 6.18  % O2
];

nombres_casos = {
    '1. Positivo en O2 (5.41V)', 
    '2. Alimentación en C3 (5.41V)',
    '3. Inyección tierra en AF4', 
    '4. Inyección tierra en AF3', 
    '5. Inyección lateral en T7',
    '6. Inyección lateral en C4', 
    '7. Inyección lateral en T8', 
    '8. Inyección lateral en O1', 
    '9. Mili voltio (Res 100k)'
};

tags_casos = {
    'caso_1_positivo_o2',
    'caso_2_alimentacion_c3',
    'caso_3_tierra_af4',
    'caso_4_tierra_af3',
    'caso_5_lateral_t7',
    'caso_6_lateral_c4',
    'caso_7_lateral_t8',
    'caso_8_lateral_o1',
    'caso_9_milivoltio_res100k'
};

%% 3. CREACIÓN DE MALLA 
xi = linspace(-1.2, 1.2, 400);
yi = linspace(-1.2, 1.2, 400);
[XI, YI] = meshgrid(xi, yi);
mask = (XI.^2 + YI.^2) <= 1;

%% 4. GENERACIÓN, FORMATO Y EXPORTACIÓN AUTOMÁTICA DE FIGURAS
for i = 1:size(data, 2)
    voltajes = data(:, i);
    
    % Interpolación
    VI = griddata(X, Y, voltajes, XI, YI, 'cubic');
    VI(~mask) = NaN; 
    
    fig = figure('Name', nombres_casos{i}, 'Color', 'w', 'Position', [100, 100, 850, 850]);
    hold on;
    
    % Dibujar mapa de calor suavizado
    contourf(XI, YI, VI, 100, 'LineColor', 'none');
    colormap('jet'); 
    
    % Contorno de la cabeza, nariz y orejas
    theta = linspace(0, 2*pi, 100);
    plot(cos(theta), sin(theta), 'k', 'LineWidth', 3.0);
    plot([-0.08 0 0.08], [0.99 1.15 0.99], 'k', 'LineWidth', 3.0); 
    plot(-1.02 + 0.04*cos(theta), 0.15*sin(theta), 'k', 'LineWidth', 2.5); 
    plot( 1.02 + 0.04*cos(theta), 0.15*sin(theta), 'k', 'LineWidth', 2.5); 
    
    % Graficar los electrodos
    scatter(X, Y, 90, 'w', 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
    
    % --- Textos y etiquetas de los electrodos ---
    for e = 1:length(channels)
        ch_name = channels{e};
        fontSize_ch = 17.0; 
        fontSize_v  = 16.0; 
        
        if strcmp(ch_name, 'Fp1')
            text(X(e), Y(e) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) - 0.12, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'Fp2')
            text(X(e), Y(e) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) + 0.12, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'PO3')
            text(X(e), Y(e) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) - 0.12, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'PO4')
            text(X(e), Y(e) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) + 0.12, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'T7')
            text(X(e), Y(e) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) + 0.12, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
            
        elseif strcmp(ch_name, 'T8')
            text(X(e), Y(e) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e) - 0.12, Y(e), sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
            
        else
            if abs(Y(e)) > 0.85 || abs(X(e)) > 0.85
                fontSize_ch = 15.0;
                fontSize_v  = 14.0;
                offset_y    = 0.07;
            else
                fontSize_ch = 17.0;
                fontSize_v  = 16.0;
                offset_y    = 0.075;
            end
            
            text(X(e), Y(e) + offset_y, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            text(X(e), Y(e) - offset_y, sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        end
    end
    
    % Configurar la barra de color
    cb = colorbar;
    cb.FontSize = 16;
    cb.FontWeight = 'bold';
    cb.Position = [0.73, 0.15, 0.025, 0.70]; 
    
    if i == 9
        unidad = 'mV';
    else
        unidad = 'V';
    end
    cb.Label.String = sprintf('Potencial (%s)', unidad);
    cb.Label.FontSize = 18;
    cb.Label.FontWeight = 'bold';
    
    % Título grande estilo tesis
    title(nombres_casos{i}, 'FontSize', 22, 'FontWeight', 'bold', 'Color', 'k');
    
    axis equal;
    xlim([-1.2, 1.2]); 
    ylim([-1.2, 1.2]);
    axis off; 
    
    % Exportación automática en alta resolución (300 DPI)
    nombre_archivo = sprintf('mapa_eeg_%s.png', tags_casos{i});
    exportgraphics(fig, nombre_archivo, 'Resolution', 300);
    
    hold off;
end

disp('Todos los mapas de calor EEG fueron generados y exportados exitosamente.');