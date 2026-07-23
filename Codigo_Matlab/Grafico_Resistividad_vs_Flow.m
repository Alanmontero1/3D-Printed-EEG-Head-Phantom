% =========================================================================
% TÍTULO: Gráfica de Resistividad vs Porcentaje de Flujo (Flow)
% DESCRIPCIÓN: Script para procesamiento de datos experimentales de PLA
%              conductor y cálculo de resistividad.
% =========================================================================

clear; clc; close all;

%% 1. ENTRADA DE DATOS EXPERIMENTALES
flow = [100, 90, 80, 70];          % Porcentaje de flujo (%)
R_mean = [455.2, 526.5, 597.8, 771.3]; % Resistencia promedio (Ohmios)
R_std  = [13.6, 4.5, 3.75, 2.17];    % Desviación estándar de la resistencia

%% 2. PROCESAMIENTO Y CÁLCULO DE PARÁMETROS ELÉCTRICOS
% Factor Geométrico (A = 0.5 cm^2, L = 2 cm)
K = 0.25; 

% Cálculo de Resistividad (Ohm*cm) y propagación de error estándar
rho_mean = R_mean * K;
rho_std  = R_std * K;

%% 3. CONFIGURACIÓN Y GENERACIÓN DE LA FIGURA
fig = figure('Color', 'w', 'Position', [100, 100, 1000, 800]);

errorbar(flow, rho_mean, rho_std, '-o', ...
    'LineWidth', 2, ...
    'MarkerSize', 10, ...
    'MarkerFaceColor', [0.85 0.33 0.10], ...
    'Color', 'k', ...
    'CapSize', 12);

%% 4. ESTILO Y FORMATO 
grid on;
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
ax.Position = [0.18, 0.19, 0.76, 0.75];

set(gcf, 'Color', 'w');
set(ax, 'Color', 'w', 'XColor', 'k', 'YColor', 'k');

% Etiquetas de los ejes
xlabel('Porcentaje de Flujo (%)', ...
    'FontSize', 34, 'FontWeight', 'bold', 'Color', 'k');
ylabel('Resistividad Promedio (\Omega\cdot cm)', ...
    'FontSize', 34, 'FontWeight', 'bold', 'Color', 'k');

% Límites y marcas (Ticks)
xlim([65 105]);
xticks([70, 80, 90, 100]);
set(ax, ...
    'FontSize', 28, ...
    'FontWeight', 'bold', ...
    'TickDir', 'out', ...
    'LineWidth', 2);

%% 5. EXPORTACIÓN DE RESULTADOS
% Guarda la gráfica automáticamente en alta resolución (300 DPI) 
exportgraphics(fig, 'flow_vs_resistividad.png', 'Resolution', 300);
disp('Gráfica generada y exportada exitosamente.');