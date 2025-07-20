groundELEV = 259.5;
x_Of_Col = [0, 8.13, 16.26, 19.92, 26.38];

% Read and adjust elevation
ELEV_raw = readmatrix("Stress Spreadsheets(Peak Flood).csv", ...
    "Range", "A2:A32");
% If ELEV is 2D, take only the first column
if size(ELEV_raw, 2) > 1
    ELEV = ELEV_raw(:, 1);
else
    ELEV = ELEV_raw;
end
%ELEV = ELEV + groundELEV;

% Read stress data and convert to kPa - adjust range to match x_Of_Col
data_Before_raw = readmatrix("Stress Spreadsheets(Peak Flood).csv", ...
    "Range", "C2:G32") / 1000;
% If data has more columns than expected, take only the first 5
if size(data_Before_raw, 2) > length(x_Of_Col)
    data_Before = data_Before_raw(:, 1:length(x_Of_Col));
    fprintf('Warning: Data had %d columns, using only first %d\n', ...
        size(data_Before_raw, 2), length(x_Of_Col));
else
    data_Before = data_Before_raw;
end

% Clean NaNs
data_Before(~isfinite(data_Before)) = NaN;
ELEV(~isfinite(ELEV)) = NaN;

% Check dimensions and adjust if necessary
fprintf('ELEV size: %d x %d\n', size(ELEV));
fprintf('data_Before size: %d x %d\n', size(data_Before));
fprintf('x_Of_Col size: %d x %d\n', size(x_Of_Col));

% Ensure data dimensions match
if size(data_Before, 2) ~= length(x_Of_Col)
    error('Number of columns in data_Before (%d) must match length of x_Of_Col (%d)', ...
        size(data_Before, 2), length(x_Of_Col));
end

if size(data_Before, 1) ~= length(ELEV)
    error('Number of rows in data_Before (%d) must match length of ELEV (%d)', ...
        size(data_Before, 1), length(ELEV));
end

% Create meshgrid with correct dimensions
[x, y] = meshgrid(x_Of_Col, ELEV);


% Plot
contour_Vec = [0, 20:20:220];  % Explicitly include 0 as first contour
[c, h] = contourf(x, y, data_Before, contour_Vec);
clabel(c, h, 'FontSize', 10, 'FontWeight', 'normal', ...
    'Color', 'black', 'FontName', 'Times New Roman');

% Add explicit zero contour line
hold on;
[c0, h0] = contour(x, y, data_Before, [0, 0], 'k-', 'LineWidth', 2);
clabel(c0, h0, 'FontSize', 10, 'FontWeight', 'bold', ...
    'Color', 'black', 'FontName', 'Times New Roman');

% Create custom colormap with white for zero values
cmap = flipud(autumn);
% Insert white at the beginning for zero values
cmap_custom = [1 1 1; cmap];  % White followed by autumn colormap
colormap(cmap_custom);

% Set color limits to ensure zero maps to white
caxis([0, max(contour_Vec)]);

cb = colorbar('Direction', 'reverse');
cb.Label.String = '\bfLithostatic Stress (kPa)';
cb.Label.FontSize = 10;

xlabel('Horizontal Distance (m)');
ylabel('Elevation (masl)');
title('Plot of Lithostatic Stresses (Peak Flood)');

% Safe ylim
ylim([min(ELEV, [], 'omitnan'), max(ELEV, [], 'omitnan')]);