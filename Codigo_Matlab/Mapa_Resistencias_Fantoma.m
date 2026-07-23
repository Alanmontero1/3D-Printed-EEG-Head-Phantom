% =========================================================================
% TÍTULO: Topoplot de Resistencias 
% DESCRIPCIÓN: Script para generar el mapa espacial de las 
%           resistencias medidas en los electrodos del fantoma.
% =========================================================================

clear; clc; close all;

%% 1. DATOS DE ELECTRODOS Y RESISTENCIAS
electrodos = {'Fp1', 'Fp2', 'AF3', 'AF4', 'F7', 'F3', 'Fz', 'F4', 'F8', ...
              'FC5', 'FC1', 'FC2', 'FC6', 'T7', 'C3', 'Cz', 'C4', 'T8', ...
              'CP5', 'CP1', 'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', ...
              'PO3', 'PO4', 'O1', 'Oz', 'O2'};
              
resistencias = [2.9, 2.83, 2.71, 2.76, 2.5, 2.79, 3.11, 3.74, 2.61, ...
                2.64, 3.65, 3.37, 2.82, 2.67, 3.51, 0, 3.85, 3.21, ...
                3.0, 4.82, 4.20, 2.98, 2.7, 2.94, 3.18, 3.01, 3.03, ...
                2.83, 2.74, 3.92, 2.83, 2.86];

%% 2. COORDENADAS (Aproximación proyectada en un círculo de radio 1)
X = [-0.3, 0.3, -0.25, 0.25, -0.8, -0.4, 0, 0.4, 0.8, ...
     -0.6, -0.2, 0.2, 0.6, -0.95, -0.4, 0, 0.4, 0.95, ...
     -0.6, -0.2, 0.2, 0.6, -0.8, -0.4, 0, 0.4, 0.8, ...
     -0.25, 0.25, -0.3, 0, 0.3];

Y = [ 0.85, 0.85, 0.65, 0.65, 0.5, 0.5, 0.5, 0.5, 0.5, ...
      0.25, 0.25, 0.25, 0.25, 0, 0, 0, 0, 0, ...
     -0.25,-0.25,-0.25,-0.25,-0.5,-0.5,-0.5,-0.5,-0.5, ...
     -0.65,-0.65,-0.85,-0.85,-0.85];

%% 3. CREAR MALLA PARA LA INTERPOLACIÓN
[Xq, Yq] = meshgrid(linspace(-1.1, 1.1, 400), linspace(-1.1, 1.1, 400));
Vq = griddata(X, Y, resistencias, Xq, Yq, 'v4');
mascara = (Xq.^2 + Yq.^2) > 1;
Vq(mascara) = NaN; 

%% 4. CREACIÓN Y CONFIGURACIÓN DE LA FIGURA
fig = figure('Name', 'Topoplot de Resistencias', 'Color', 'w', 'Position', [100, 100, 900, 850]);
hold on;

h = pcolor(Xq, Yq, Vq);
set(h, 'EdgeColor', 'none'); 
shading interp; 

theta = linspace(0, 2*pi, 200);
plot(cos(theta), sin(theta), 'k', 'LineWidth', 3.0);
plot([-0.08, 0, 0.08], [0.99, 1.15, 0.99], 'k', 'LineWidth', 3.0);

ear_theta = linspace(-pi/2, pi/2, 50);
ear_X = 0.04 * cos(ear_theta);
ear_Y = 0.15 * sin(ear_theta);
plot( 1.02 + ear_X, ear_Y, 'k', 'LineWidth', 2.5); 
plot(-1.02 - ear_X, ear_Y, 'k', 'LineWidth', 2.5); 

scatter(X, Y, 90, 'w', 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);

for i = 1:length(electrodos)
    ch_name = electrodos{i};
    fontSize_ch = 17.0; 
    fontSize_v  = 16.0; 
    
    if strcmp(ch_name, 'Fp1')
        text(X(i), Y(i) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        text(X(i) + 0.12, Y(i), sprintf('%.2f', resistencias(i)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
        
    elseif strcmp(ch_name, 'Fp2')
        text(X(i), Y(i) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        text(X(i) - 0.12, Y(i), sprintf('%.2f', resistencias(i)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
        
    elseif strcmp(ch_name, 'P3')
        text(X(i), Y(i) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        text(X(i) - 0.12, Y(i), sprintf('%.2f', resistencias(i)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
        
    elseif strcmp(ch_name, 'P4')
        text(X(i), Y(i) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        text(X(i) + 0.12, Y(i), sprintf('%.2f', resistencias(i)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
        
    elseif strcmp(ch_name, 'T7')
        text(X(i), Y(i) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        text(X(i) + 0.12, Y(i), sprintf('%.2f', resistencias(i)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
        
    elseif strcmp(ch_name, 'T8')
        text(X(i), Y(i) + 0.065, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        text(X(i) - 0.12, Y(i), sprintf('%.2f', resistencias(i)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
        
    elseif ismember(ch_name, {'O1', 'Oz', 'O2'})
        text(X(i), Y(i) - 0.035, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
        text(X(i), Y(i) - 0.135, sprintf('%.2f', resistencias(i)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
        
    else
        if abs(Y(i)) > 0.85 || abs(X(i)) > 0.85
            fontSize_ch = 15.0;
            fontSize_v  = 14.0;
            offset_y    = 0.07;
        else
            fontSize_ch = 17.0;
            fontSize_v  = 16.0;
            offset_y    = 0.075;
        end
        
        text(X(i), Y(i) + offset_y, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        text(X(i), Y(i) - offset_y, sprintf('%.2f', resistencias(i)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    end
end

%% 5. CONFIGURACIÓN DE COLORES, BARRA Y ESTILO FINAL
colormap('jet'); 
cb = colorbar;
cb.FontSize = 14;
cb.FontWeight = 'bold';
cb.Position = [0.73, 0.15, 0.022, 0.70]; 
cb.Label.String = 'Resistencia (k\Omega)';
cb.Label.FontSize = 16;
cb.Label.FontWeight = 'bold';
caxis([0 5]); 

axis equal off;
title('Distribución de Resistencia en Electrodos', 'FontSize', 22, 'FontWeight', 'bold');

%% 6. EXPORTACIÓN AUTOMÁTICA EN ALTA CALIDAD (300 DPI)
exportgraphics(fig, 'topoplot_resistencias_eeg.png', 'Resolution', 300);
disp('Topoplot de resistencias generado y exportado exitosamente.');

hold off;