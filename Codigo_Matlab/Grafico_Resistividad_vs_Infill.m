% =========================================================================
% TÍTULO: Gráfica de Resistividad vs Porcentaje de Relleno (Infill)
% DESCRIPCIÓN: Script para procesamiento de datos de resistencia en función 
%              del porcentaje de relleno y cálculo de resistividad.
% =========================================================================

clear; clc; close all;

%% 1. ENTRADA DE DATOS EXPERIMENTALES
infill = [25, 50, 75, 100];          % Porcentaje de relleno (%)
R_mean = [455.2, 457.2, 302.2, 102.2]; % Resistencia promedio (Ohmios) calculada
R_std  = [13.6, 6.8, 31.0, 10.1];    % Desviación estándar

%% 2. PROCESAMIENTO Y CÁLCULO DE PARÁMETROS
% Factor Geométrico (A = 0.5 cm^2, L = 2 cm)
K = 0.25;

% Cálculo de Resistividad (Ohm*cm)
rho_mean = R_mean * K;
rho_std  = R_std * K;

%% 3. CREACIÓN Y CONFIGURACIÓN DE LA FIGURA
fig = figure('Color', 'w', 'Position', [100, 100, 1000, 800]);

errorbar(infill, rho_mean, rho_std, '-o', ...
    'LineWidth', 2, ...
    'MarkerSize', 10, ...
    'MarkerFaceColor', [0.85 0.33 0.10], ...
    'Color', 'k', ...
    'CapSize', 12);

%% 4. FORMATO
grid on;
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
ax.Position = [0.18, 0.19, 0.76, 0.75];

set(gcf, 'Color', 'w');
set(ax, 'Color', 'w', 'XColor', 'k', 'YColor', 'k');

% Etiquetas de los ejes
xlabel('Porcentaje de Relleno (%)', ...
    'FontSize', 34, 'FontWeight', 'bold', 'Color', 'k');
ylabel('Resistividad Promedio (\Omega\cdot cm)', ...
    'FontSize', 34, 'FontWeight', 'bold', 'Color', 'k');

% Límites y marcas
xlim([15 110]);
xticks([25, 50, 75, 100]);
set(ax, ...
    'FontSize', 28, ...
    'FontWeight', 'bold', ...
    'TickDir', 'out', ...
    'LineWidth', 2);

%% 5. EXPORTACIÓN DE IMAGEN 
exportgraphics(fig, 'resistividad_vs_infill.png', 'Resolution', 300);
disp('Gráfica de infill generada y exportada exitosamente.');