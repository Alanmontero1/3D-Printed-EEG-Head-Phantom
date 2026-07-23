% =========================================================================
% TÍTULO: Mapas de Calor de Potencial (Frecuencias y Configuraciones)
% DESCRIPCIÓN: Script para la generación y exportación de mapas de calor 
%              experimentales del fantoma en régimen AC.
% =========================================================================

clear; clc; close all;

%% 1. ENTRADA DE DATOS EXPERIMENTALES
% --- P1-P4, 8mm abajo, varias frecuencias ---
P1P4_4Hz   = [3.72 3.54 3.40; 3.42 3.30 3.16; 3.24 3.08 2.90];
P1P4_6Hz   = [3.72 3.56 3.44; 3.44 3.32 3.20; 3.20 3.12 2.88];
P1P4_10Hz  = [3.80 3.60 3.48; 3.48 3.36 3.20; 3.28 3.12 2.96];
P1P4_25Hz  = [3.76 3.58 3.44; 3.46 3.34 3.20; 3.28 3.12 2.90];
P1P4_80Hz  = [3.74 3.54 3.41; 3.45 3.33 3.20; 3.26 3.11 2.91];

% --- P1-P4, 60 Hz, diferentes configuraciones ---
P1P4_60Hz_ab = [2.39 2.26 2.17; 2.23 2.11 2.03; 2.07 1.95 1.83]; % Inferior 8mm (B)
P1P4_60Hz_ar = [3.45 3.36 3.25; 3.19 3.11 3.03; 3.10 3.02 2.90]; % Superior 8mm (A)
P1P4_60Hz_3m = [2.65 2.49 2.38; 2.42 2.33 2.23; 2.26 2.16 2.02]; % Inferior 3mm (C)

% --- P1-P3, 60 Hz, diferentes configuraciones ---
P1P3_60Hz_ab = [2.11 1.99 1.93; 1.85 1.85 1.85; 1.57 1.66 1.74]; % Inferior 8mm (B)
P1P3_60Hz_ar = [2.72 2.64 2.55; 2.40 2.39 2.40; 2.12 2.19 2.27]; % Superior 8mm (A)
P1P3_60Hz_3m = [2.28 2.23 2.21; 2.11 2.11 2.11; 1.91 1.98 2.01]; % Inferior 3mm (C)

%% 2. FIGURA 1: EFECTO DE LA FRECUENCIA (P1-P4, 8mm abajo)
fig1 = figure('Name','Frecuencias P1-P4','Position',[30 30 1600 1000], 'Color', 'w');
freq_data = {P1P4_4Hz, P1P4_6Hz, P1P4_10Hz, P1P4_25Hz, P1P4_80Hz};
freq_names = {'4 Hz', '6.4 Hz', '10.7 Hz', '25.4 Hz', '80.2 Hz'};
freq_P1 = [5.88, 5.80, 5.80, 5.72, 5.68];

for i = 1:5
    subplot(2, 3, i);
    imagesc(freq_data{i});
    axis image;
    colormap(gca, jet);
    caxis([2.8 3.9]);
    
    cb = colorbar;
    cb.FontSize = 18;
    cb.FontWeight = 'bold';
    
    title({freq_names{i}; sprintf('V_{in} = %.2f V', freq_P1(i))}, ...
          'FontSize', 22, 'FontWeight', 'bold');
    xlabel('Columna', 'FontSize', 18, 'FontWeight', 'bold'); 
    ylabel('Fila', 'FontSize', 18, 'FontWeight', 'bold');
    
    set(gca, 'XTick', [1 2 3], 'YTick', [1 2 3], ...
             'XTickLabel', {'1','2','3'}, 'YTickLabel', {'1','2','3'}, ...
             'TickDir', 'out', 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 2.5);
    
    for r = 1:3
        for c = 1:3
            text(c, r, sprintf('%.2f', freq_data{i}(r,c)), ...
                 'HorizontalAlignment', 'center', ...
                 'VerticalAlignment', 'middle', ...
                 'FontSize', 24, 'FontWeight', 'bold', 'Color', 'white');
        end
    end
end
sgtitle('Distribución de Potencial: Efecto de la Frecuencia (P1-P4, Config. B)', ...
        'FontSize', 26, 'FontWeight', 'bold');

exportgraphics(fig1, 'mapa_frecuencias_p1p4.png', 'Resolution', 300);

%% 3. FIGURA 2: COMPARACIÓN P1-P4, 60 Hz (ORDEN: A -> B -> C)
fig2 = figure('Name','Comparacion P1-P4 60Hz','Position',[50 50 1600 650], 'Color', 'w');
configs_P1P4 = {P1P4_60Hz_ar, P1P4_60Hz_ab, P1P4_60Hz_3m};
names_P1P4 = {'Config. A (Sup. 8mm)', 'Config. B (Inf. 8mm)', 'Config. C (Inf. 3mm)'};
P1_P1P4 = [6.32, 6.20, 6.16]; 

for i = 1:3
    subplot(1, 3, i);
    imagesc(configs_P1P4{i});
    axis image;
    colormap(gca, jet);
    caxis([1.5 3.6]);
    
    cb = colorbar;
    cb.FontSize = 18;
    cb.FontWeight = 'bold';
    
    title({names_P1P4{i}; sprintf('V_{in} = %.2f V', P1_P1P4(i))}, ...
          'FontSize', 22, 'FontWeight', 'bold');
    xlabel('Columna', 'FontSize', 18, 'FontWeight', 'bold'); 
    ylabel('Fila', 'FontSize', 18, 'FontWeight', 'bold');
    
    set(gca, 'XTick', [1 2 3], 'YTick', [1 2 3], ...
             'XTickLabel', {'1','2','3'}, 'YTickLabel', {'1','2','3'}, ...
             'TickDir', 'out', 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 2.5);
    
    for r = 1:3
        for c = 1:3
            text(c, r, sprintf('%.2f', configs_P1P4{i}(r,c)), ...
                 'HorizontalAlignment', 'center', ...
                 'VerticalAlignment', 'middle', ...
                 'FontSize', 24, 'FontWeight', 'bold', 'Color', 'white');
        end
    end
end
sgtitle('Mapas de Potencial (P1-P4, 60 Hz) por Configuración de Inyección', ...
        'FontSize', 26, 'FontWeight', 'bold');

exportgraphics(fig2, 'mapa_config_p1p4.png', 'Resolution', 300);

%% 4. FIGURA 3: COMPARACIÓN P1-P3, 60 Hz (ORDEN: A -> B -> C)
fig3 = figure('Name','Comparacion P1-P3 60Hz','Position',[70 70 1600 650], 'Color', 'w');
configs_P1P3 = {P1P3_60Hz_ar, P1P3_60Hz_ab, P1P3_60Hz_3m};
names_P1P3 = {'Config. A (Sup. 8mm)', 'Config. B (Inf. 8mm)', 'Config. C (Inf. 3mm)'};
P1_P1P3 = [6.04, 6.16, 6.28]; 

for i = 1:3
    subplot(1, 3, i);
    imagesc(configs_P1P3{i});
    axis image;
    colormap(gca, jet);
    caxis([1.4 2.8]);
    
    cb = colorbar;
    cb.FontSize = 18;
    cb.FontWeight = 'bold';
    
    title({names_P1P3{i}; sprintf('V_{in} = %.2f V', P1_P1P3(i))}, ...
          'FontSize', 22, 'FontWeight', 'bold');
    xlabel('Columna', 'FontSize', 18, 'FontWeight', 'bold'); 
    ylabel('Fila', 'FontSize', 18, 'FontWeight', 'bold');
    
    set(gca, 'XTick', [1 2 3], 'YTick', [1 2 3], ...
             'XTickLabel', {'1','2','3'}, 'YTickLabel', {'1','2','3'}, ...
             'TickDir', 'out', 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 2.5);
    
    for r = 1:3
        for c = 1:3
            text(c, r, sprintf('%.2f', configs_P1P3{i}(r,c)), ...
                 'HorizontalAlignment', 'center', ...
                 'VerticalAlignment', 'middle', ...
                 'FontSize', 24, 'FontWeight', 'bold', 'Color', 'white');
        end
    end
end
sgtitle('Mapas de Potencial (P1-P3, 60 Hz) por Configuración de Inyección', ...
        'FontSize', 26, 'FontWeight', 'bold');

exportgraphics(fig3, 'mapa_config_p1p3.png', 'Resolution', 300);
disp('Todos los mapas de calor fueron generados y exportados exitosamente.');