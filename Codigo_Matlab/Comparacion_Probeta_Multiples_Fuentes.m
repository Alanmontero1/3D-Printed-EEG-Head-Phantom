% =========================================================================
% TÍTULO: Mapas de Calor - Comparación Peak-to-Peak vs RMS por Mediciones
% DESCRIPCIÓN: Script automatizado para generar mapas de calor
%              comparativos (PTP y RMS) para diferentes fuentes.
% =========================================================================

clear; clc; close all;

%% 1. ENTRADA DE DATOS EXPERIMENTALES
%% ------------------ MEDICIÓN 1 ------------------
% Peak-to-Peak
F1_ptp = [2.90 2.95 2.85;
          2.96 2.94 2.91;
          2.87 2.85 2.76];
F2_ptp = [4.49 4.64 4.75;
          4.54 4.65 4.56;
          4.78 4.50 4.73];
FC_ptp = [4.92 5.04 5.13;
          4.88 5.04 4.98;
          4.88 4.95 5.08];
% RMS
F1_rms = [1.063 1.082 1.046;
          1.080 1.070 1.064;
          1.047 1.052 1.020];
F2_rms = [1.621 1.670 1.703;
          1.632 1.671 1.643;
          1.701 1.617 1.692];
FC_rms = [1.369 1.412 1.457;
          1.367 1.402 1.407;
          1.367 1.392 1.439];

%% ------------------ MEDICIÓN 2 ------------------
% Peak-to-Peak
F1_ptp2 = [3.03 2.92 3.02;
           2.85 2.92 2.97;
           2.82 2.73 2.90];
F2_ptp2 = [4.84 4.95 4.97;
           4.78 4.86 4.91;
           4.70 4.80 4.84];
FC_ptp2 = [5.18 5.25 5.32;
           5.09 5.17 5.18;
           5.08 5.11 5.13];
% RMS
F1_rms2 = [1.104 1.074 1.109;
           1.042 1.077 1.103;
           1.034 0.996 1.070];
F2_rms2 = [1.730 1.764 1.770;
           1.710 1.736 1.751;
           1.677 1.712 1.730];
FC_rms2 = [1.441 1.489 1.518;
           1.444 1.465 1.490;
           1.446 1.463 1.461];

%% 2. ORGANIZACIÓN DE CASOS
casos = {
    F1_ptp,  F1_rms,  'Medicion_1_Fuente_1',         'Medición 1 - Fuente 1';
    F2_ptp,  F2_rms,  'Medicion_1_Fuente_2',         'Medición 1 - Fuente 2';
    FC_ptp,  FC_rms,  'Medicion_1_Fuentes_Comb',     'Medición 1 - Fuentes combinadas';
    F1_ptp2, F1_rms2, 'Medicion_2_Fuente_1',         'Medición 2 - Fuente 1';
    F2_ptp2, F2_rms2, 'Medicion_2_Fuente_2',         'Medición 2 - Fuente 2';
    FC_ptp2, FC_rms2, 'Medicion_2_Fuentes_Comb',     'Medición 2 - Fuentes combinadas';
};

%% 3. GENERACIÓN, FORMATO Y EXPORTACIÓN AUTOMÁTICA DE FIGURAS
for k = 1:size(casos,1)
    PTP    = casos{k,1};
    RMS    = casos{k,2};
    tag    = casos{k,3};
    nombre = casos{k,4};
    
    fig = figure('Color','w','Position',[100 100 1400 650]);
    
    %% --- Subplot 1: Peak-to-Peak ---
    subplot(1,2,1)
    imagesc(PTP)
    axis square
    axis ij                     
    colormap(gca,turbo)
    
    cb1 = colorbar;
    cb1.FontSize = 18;
    cb1.FontWeight = 'bold';
    
    title('Peak-to-Peak', 'FontSize', 22, 'FontWeight', 'bold', 'Color', 'k')
    
    xticks(1:3)
    yticks(1:3)
    xlabel('Columna', 'FontSize', 18, 'FontWeight', 'bold')
    ylabel('Fila', 'FontSize', 18, 'FontWeight', 'bold')
    
    set(gca, 'XTick', [1 2 3], 'YTick', [1 2 3], ...
             'XTickLabel', {'1','2','3'}, 'YTickLabel', {'1','2','3'}, ...
             'TickDir', 'out', 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 2.5, 'XColor', 'k', 'YColor', 'k');
         
    for i=1:3
        for j=1:3
            text(j,i,sprintf('%.2f',PTP(i,j)),...
                'HorizontalAlignment','center',...
                'VerticalAlignment','middle',...
                'Color','w',...
                'FontWeight','bold',...
                'FontSize',24);
        end
    end
    
    %% --- Subplot 2: RMS ---
    subplot(1,2,2)
    imagesc(RMS)
    axis square
    axis ij                     
    colormap(gca,turbo)
    
    cb2 = colorbar;
    cb2.FontSize = 18;
    cb2.FontWeight = 'bold';
    
    title('RMS', 'FontSize', 22, 'FontWeight', 'bold', 'Color', 'k')
    
    xticks(1:3)
    yticks(1:3)
    xlabel('Columna', 'FontSize', 18, 'FontWeight', 'bold')
    ylabel('Fila', 'FontSize', 18, 'FontWeight', 'bold')
    
    set(gca, 'XTick', [1 2 3], 'YTick', [1 2 3], ...
             'XTickLabel', {'1','2','3'}, 'YTickLabel', {'1','2','3'}, ...
             'TickDir', 'out', 'FontSize', 18, 'FontWeight', 'bold', 'LineWidth', 2.5, 'XColor', 'k', 'YColor', 'k');
         
    for i=1:3
        for j=1:3
            text(j,i,sprintf('%.3f',RMS(i,j)),...
                'HorizontalAlignment','center',...
                'VerticalAlignment','middle',...
                'Color','w',...
                'FontWeight','bold',...
                'FontSize',24);
        end
    end
    
    sgtitle(nombre, 'FontSize', 26, 'FontWeight', 'bold', 'Color', 'k')
    
    % Exportar cada imagen 
    nombre_archivo = sprintf('mapa_%s.png', tag);
    exportgraphics(fig, nombre_archivo, 'Resolution', 300);
end

disp('Todas las figuras de PTP y RMS fueron generadas y exportadas exitosamente.');