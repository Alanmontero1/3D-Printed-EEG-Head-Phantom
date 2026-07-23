% =========================================================================
% TÍTULO: Comparación Fantoma - Simulación (ANSYS) vs Medición Física
% DESCRIPCIÓN: Script para visualizar y exportar mapas comparativos 
%              de potencial eléctrico (Inyección de voltaje en O2) y su error absoluto.
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

%% 2. DATOS DE VOLTAJE (En el orden exacto de los canales)
% Datos de simulación ANSYS
v_sim = [
    1.755; 1.732; 1.949; 1.970; 2.249; 2.231; 2.241; 2.258; 2.298; ...
    2.476; 2.512; 2.539; 2.557; 2.634; 2.704; 2.762; 2.802; 2.765; ...
    2.846; 2.932; 3.014; 3.033; 2.975; 3.078; 3.213; 3.317; 3.293; ...
    3.247; 3.666; 3.395; 3.704; 4.076
];

% Datos experimentales (Fantoma Físico)
v_real = [
    1.81;  1.84;  1.89;  1.91;  2.17;  2.17;  2.19;  2.17;  2.20; 
    2.39;  2.45;  2.45;  2.45;  2.55;  2.59;  2.64;  2.67;  2.64; 
    2.73;  2.77;  2.81;  2.88;  2.89;  2.94;  2.98;  3.08;  3.13; 
    3.13;  3.36;  3.23;  3.31;  3.45
];

% Cálculo de Error Absoluto
v_error = abs(v_sim - v_real);

%% 3. FUNCIÓN PARA DIBUJAR MAPAS DE CALOR 
function dibujar_cabeza(ax, X, Y, voltajes, channels, titulo, climits, colormap_name)
    axes(ax);
    hold on;
    
    % Malla para interpolación
    XI = linspace(-1.2, 1.2, 400);
    YI = linspace(-1.2, 1.2, 400);
    [XI_grid, YI_grid] = meshgrid(XI, YI);
    mask = (XI_grid.^2 + YI_grid.^2) <= 1.05;
    VI = griddata(X, Y, voltajes, XI_grid, YI_grid, 'cubic');
    VI(~mask) = NaN;
    
    % Mapa de calor
    contourf(XI_grid, YI_grid, VI, 100, 'LineColor', 'none');
    colormap(ax, colormap_name);
    if ~isempty(climits)
        caxis(climits);
    end
    
    % Contorno cabeza, nariz y orejas
    theta = linspace(0, 2*pi, 100);
    plot(cos(theta), sin(theta), 'k', 'LineWidth', 3.0);
    plot([-0.08 0 0.08], [0.99 1.15 0.99], 'k', 'LineWidth', 3.0);
    plot(-1.02 + 0.04*cos(theta), 0.15*sin(theta), 'k', 'LineWidth', 2.5);
    plot( 1.02 + 0.04*cos(theta), 0.15*sin(theta), 'k', 'LineWidth', 2.5);
    
    % Electrodos (círculos blancos grandes con borde negro)
    scatter(X, Y, 90, 'w', 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
    
    % Etiquetas con tamaños grandes
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
            
        elseif ismember(ch_name, {'O1', 'Oz', 'O2'})
            text(X(e), Y(e) - 0.040, ch_name, 'FontSize', fontSize_ch, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
            text(X(e), Y(e) - 0.115, sprintf('%.2f', voltajes(e)), 'FontSize', fontSize_v, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
            
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
    
    % Colorbar equilibrada
    cb = colorbar;
    cb.FontSize = 14;
    cb.FontWeight = 'bold';
    cb.Position = [ax.Position(1) + ax.Position(3) + 0.01, ax.Position(2) + 0.15, 0.022, 0.65]; 
    
    cb.Label.String = 'Voltaje (V)';
    cb.Label.FontSize = 16;
    cb.Label.FontWeight = 'bold';
    
    title(titulo, 'FontSize', 18, 'FontWeight', 'bold', 'Color', 'k');
    axis equal; 
    xlim([-1.2, 1.2]); 
    ylim([-1.2, 1.2]); 
    axis off; 
    hold off;
end

%% 4. FIGURA 1: COMPARACIÓN SIMULACIÓN VS REAL
vmin_comp = min([v_sim; v_real]);
vmax_comp = max([v_sim; v_real]);
climits_comp = [vmin_comp, vmax_comp];

fig1 = figure('Name', 'Comparacion Simulación vs Real', 'Color', 'w', 'Position', [100, 100, 1600, 800]);
ax1 = axes('Position', [0.05, 0.08, 0.38, 0.82]);
dibujar_cabeza(ax1, X, Y, v_sim, channels, 'Simulación ANSYS (Inyección O2)', climits_comp, 'jet');
ax2 = axes('Position', [0.52, 0.08, 0.38, 0.82]);
dibujar_cabeza(ax2, X, Y, v_real, channels, 'Fantoma Físico (Inyección O2)', climits_comp, 'jet');

exportgraphics(fig1, 'comparacion_ansys_real.png', 'Resolution', 300);

%% 5. FIGURA 2: ERROR ABSOLUTO
fig2 = figure('Name', 'Error Absoluto', 'Color', 'w', 'Position', [300, 150, 900, 800]);
ax3 = axes('Position', [0.15, 0.08, 0.55, 0.82]);
climits_err = [0, max(v_error)];
n_colors = 256;
cmap_error = [linspace(1, 1, n_colors)', linspace(1, 0, n_colors)', linspace(1, 0, n_colors)'];

dibujar_cabeza(ax3, X, Y, v_error, channels, 'Error Absoluto (|Simulación - Real|)', climits_err, cmap_error);

exportgraphics(fig2, 'error_absoluto.png', 'Resolution', 300);

disp('Imágenes de simulación y error absoluto generadas y exportadas exitosamente.');