% =========================================================================
% TÍTULO: Mapas de Calor - Datos Experimentales y Simulación ANSYS Maxwell
% DESCRIPCIÓN: Script para procesar, visualizar y exportar la distribución 
%              de potencial eléctrico (pares de electrodos y validación FEM).
% =========================================================================

clc;
clear;
close all;

%% ============================================================
%% 1. DATOS EXPERIMENTALES
%% ============================================================
%% P2-P3
A_P23(:,:,1) = [3.12 3.27 3.45; 2.86 3.00 3.13; 2.52 2.72 2.89];
A_P23(:,:,2) = [3.09 3.25 3.45; 2.84 2.98 3.11; 2.48 2.69 2.88];
A_P23(:,:,3) = [3.09 3.25 3.44; 2.84 2.97 3.09; 2.48 2.69 2.88];

B_P23(:,:,1) = [2.72 2.88 3.06; 2.48 2.64 2.75; 2.13 2.36 2.52];
B_P23(:,:,2) = [2.73 2.89 3.06; 2.50 2.66 2.77; 2.14 2.38 2.53];
B_P23(:,:,3) = [2.73 2.89 3.06; 2.48 2.64 2.77; 2.14 2.36 2.53];

C_P23(:,:,1) = [2.98 3.11 3.28; 2.67 2.81 2.91; 2.27 2.45 2.61];
C_P23(:,:,2) = [2.98 3.11 3.28; 2.67 2.80 2.89; 2.27 2.45 2.61];
C_P23(:,:,3) = [2.97 3.11 3.27; 2.66 2.78 2.91; 2.27 2.45 2.61];

%% P1-P3
A_P13(:,:,1) = [3.52 3.36 3.25; 3.06 3.06 3.06; 2.63 2.75 2.89];
A_P13(:,:,2) = [3.53 3.38 3.28; 3.09 3.09 3.06; 2.59 2.77 2.89];
A_P13(:,:,3) = [3.52 3.39 3.27; 3.08 3.08 3.06; 2.61 2.77 2.88];

B_P13(:,:,1) = [3.16 2.97 2.91; 2.75 2.75 2.72; 2.30 2.45 2.56];
B_P13(:,:,2) = [3.17 3.00 2.92; 2.77 2.77 2.75; 2.33 2.47 2.58];
B_P13(:,:,3) = [3.17 2.98 2.91; 2.77 2.77 2.73; 2.30 2.45 2.58];

C_P13(:,:,1) = [3.36 3.22 3.11; 2.89 2.89 2.89; 2.38 2.53 2.63];
C_P13(:,:,2) = [3.34 3.22 3.11; 2.89 2.89 2.89; 2.36 2.52 2.64];
C_P13(:,:,3) = [3.34 3.20 3.11; 2.89 2.89 2.89; 2.38 2.52 2.64];

%% P1-P2
A_P12(:,:,1) = [3.33 2.97 2.63; 3.11 2.95 2.80; 3.02 2.94 2.86];
A_P12(:,:,2) = [3.31 2.94 2.58; 3.09 2.94 2.77; 3.00 2.92 2.84];
A_P12(:,:,3) = [3.30 2.92 2.56; 3.09 2.91 2.77; 3.00 2.91 2.84];

B_P12(:,:,1) = [3.09 2.77 2.52; 2.93 2.77 2.64; 2.84 2.77 2.69];
B_P12(:,:,2) = [3.13 2.80 2.52; 2.95 2.77 2.66; 2.86 2.77 2.70];
B_P12(:,:,3) = [3.09 2.77 2.52; 2.92 2.77 2.64; 2.84 2.77 2.70];

C_P12(:,:,1) = [3.20 2.89 2.56; 3.00 2.89 2.72; 2.91 2.84 2.78];
C_P12(:,:,2) = [3.16 2.84 2.55; 2.97 2.84 2.70; 2.89 2.83 2.77];
C_P12(:,:,3) = [3.14 2.83 2.55; 2.97 2.83 2.70; 2.88 2.83 2.77];

%% PROMEDIOS EXPERIMENTALES
A23 = mean(A_P23,3); B23 = mean(B_P23,3); C23 = mean(C_P23,3);
A13 = mean(A_P13,3); B13 = mean(B_P13,3); C13 = mean(C_P13,3);
A12 = mean(A_P12,3); B12 = mean(B_P12,3); C12 = mean(C_P12,3);

%% ============================================================
%% 2. DATOS SIMULACIÓN ANSYS MAXWELL (P2-P3)
%% ============================================================
SIM_P23 = [2.683  3.063  3.621;
           2.325  2.705  3.087;
           1.788  2.347  2.727];

%% ESCALA COMÚN GLOBAL (Para mapas de voltajes)
vmin = min([A23(:);B23(:);C23(:); A13(:);B13(:);C13(:); A12(:);B12(:);C12(:); SIM_P23(:)]);
vmax = max([A23(:);B23(:);C23(:); A13(:);B13(:);C13(:); A12(:);B12(:);C12(:); SIM_P23(:)]);

%% ============================================================
%% 3. FIGURAS 1-3: MAPAS POR PAR DE ELECTRODOS (ORDEN A -> B -> C)
%% ============================================================
electrodos = {
    'P2-P3', {A23, B23, C23}, 'p2_p3';
    'P1-P3', {A13, B13, C13}, 'p1_p3';
    'P1-P2', {A12, B12, C12}, 'p1_p2'
};
titulos_pieza = {
    'Config. A: 165 \Omega\cdotcm (9 mm)', ...
    'Config. B: 114 \Omega\cdotcm (9 mm)', ...
    'Config. C: 114 \Omega\cdotcm (12 mm)'
};

for e = 1:3
    titulo_elec = electrodos{e,1};
    datos = electrodos{e,2};
    tag = electrodos{e,3};
    
    fig = figure('Name', sprintf('Config %s', titulo_elec), ...
                 'Position', [50 50 1600 650], 'Color', 'w');
    
    for j = 1:3
        subplot(1, 3, j);
        imagesc(datos{j});
        axis image;
        colormap(gca, jet);
        caxis([vmin vmax]);
        
        cb = colorbar;
        cb.FontSize = 18;
        cb.FontWeight = 'bold';
        
        vmax_l = max(datos{j}(:));
        vmin_l = min(datos{j}(:));
        deltaV = vmax_l - vmin_l;
        
        title({titulos_pieza{j}; sprintf('\\DeltaV = %.2f V', deltaV)}, ...
              'FontSize', 22, 'FontWeight', 'bold', 'Color', 'k');
        
        xlabel('Columna', 'FontSize', 18, 'FontWeight', 'bold'); 
        ylabel('Fila', 'FontSize', 18, 'FontWeight', 'bold');
        
        set(gca, 'XTick', [1 2 3], 'YTick', [1 2 3], ...
                 'XTickLabel', {'1','2','3'}, 'YTickLabel', {'1','2','3'}, ...
                 'TickDir', 'out', 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 2.5, 'XColor', 'k', 'YColor', 'k');
        
        for r = 1:3
            for c = 1:3
                text(c, r, sprintf('%.2f', datos{j}(r,c)), ...
                     'HorizontalAlignment', 'center', ...
                     'VerticalAlignment', 'middle', ...
                     'FontSize', 24, 'FontWeight', 'bold', 'Color', 'white');
            end
        end
    end
    
    sgtitle(sprintf('Distribución de Potencial - Par de Electrodos: %s', titulo_elec), ...
            'FontSize', 26, 'FontWeight', 'bold', 'Color', 'k');
        
    exportgraphics(fig, sprintf('mapa_electrodos_%s.png', tag), 'Resolution', 300);
end

%% ============================================================
%% 4. FIGURA 4: COMPARACIÓN EXPERIMENTAL vs SIMULACIÓN (P2-P3) - CONFIG B
%% ============================================================
fig4 = figure('Name', 'Comparación Exp vs Sim (Config B)', 'Position', [70 70 1200 650], 'Color', 'w');
datos_comp = {B23, SIM_P23};
titulos_comp = {'Experimental: Config. B [114 \Omega\cdotcm (9 mm)]', 'Simulación ANSYS Maxwell (P2-P3)'};

for j = 1:2
    subplot(1, 2, j);
    imagesc(datos_comp{j});
    axis image;
    colormap(gca, jet);
    caxis([vmin vmax]);
    
    cb = colorbar;
    cb.FontSize = 18;
    cb.FontWeight = 'bold';
    
    vmax_l = max(datos_comp{j}(:));
    vmin_l = min(datos_comp{j}(:));
    deltaV = vmax_l - vmin_l;
    
    title({titulos_comp{j}; sprintf('\\DeltaV = %.2f V', deltaV)}, ...
          'FontSize', 22, 'FontWeight', 'bold', 'Color', 'k');
    
    xlabel('Columna', 'FontSize', 18, 'FontWeight', 'bold'); 
    ylabel('Fila', 'FontSize', 18, 'FontWeight', 'bold');
    
    set(gca, 'XTick', [1 2 3], 'YTick', [1 2 3], ...
             'XTickLabel', {'1','2','3'}, 'YTickLabel', {'1','2','3'}, ...
             'TickDir', 'out', 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 2.5, 'XColor', 'k', 'YColor', 'k');
    
    for r = 1:3
        for c = 1:3
            text(c, r, sprintf('%.2f', datos_comp{j}(r,c)), ...
                 'HorizontalAlignment', 'center', ...
                 'VerticalAlignment', 'middle', ...
                 'FontSize', 24, 'FontWeight', 'bold', 'Color', 'white');
        end
    end
end
sgtitle('Comparativa: Distribución de Potencial Experimental vs. Simulación (P2-P3)', ...
        'FontSize', 26, 'FontWeight', 'bold', 'Color', 'k');

exportgraphics(fig4, 'comparacion_exp_vs_sim_p2p3.png', 'Resolution', 300);

%% ============================================================
%% 5. FIGURA 5: ERROR ABSOLUTO EXPERIMENTAL - SIMULACIÓN - CONFIG B
%% ============================================================
fig5 = figure('Name', 'Error Absoluto Exp vs Sim (Config B)', 'Position', [90 90 900 800], 'Color', 'w');
ERROR_P23 = abs(B23 - SIM_P23);
vmax_error = max(ERROR_P23(:)); 

imagesc(ERROR_P23);
axis image;
colormap(gca, turbo); 
caxis([0 vmax_error]);

cb = colorbar;
cb.FontSize = 18;
cb.FontWeight = 'bold';

title({'Error Absoluto de Potencial |V_{exp} - V_{sim}|'; 'P2-P3 | Config. B [114 \Omega\cdotcm (9 mm)]'}, ...
      'FontSize', 22, 'FontWeight', 'bold', 'Color', 'k');
xlabel('Columna', 'FontSize', 18, 'FontWeight', 'bold'); 
ylabel('Fila', 'FontSize', 18, 'FontWeight', 'bold');

set(gca, 'XTick', [1 2 3], 'YTick', [1 2 3], ...
         'XTickLabel', {'1','2','3'}, 'YTickLabel', {'1','2','3'}, ...
         'TickDir', 'out', 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 2.5, 'XColor', 'k', 'YColor', 'k');

for r = 1:3
    for c = 1:3
        if ERROR_P23(r,c) > (vmax_error * 0.6)
            txtColor = 'k';
        else
            txtColor = 'w';
        end
        
        text(c, r, sprintf('%.2f', ERROR_P23(r,c)), ...
             'HorizontalAlignment', 'center', ...
             'VerticalAlignment', 'middle', ...
             'FontSize', 24, 'FontWeight', 'bold', 'Color', txtColor);
    end
end

exportgraphics(fig5, 'error_absoluto_exp_vs_sim.png', 'Resolution', 300);

disp('Todos los mapas y comparaciones FEM fueron generados y exportados exitosamente.');