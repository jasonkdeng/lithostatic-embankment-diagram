% Atterberg Liquid Limit Script
% ----------------------------- start of script

% --- Experimental Data
num_blows = [41, 27, 21, 20];
p_moisture = [25.24, 26.32, 26.29, 28.80];

% --- Plot of Experimental Data
semilogy(p_moisture, num_blows, 'ks', 'markerfacecolor', 'b', 'markersize', 5)
xlabel('\bfMoisture Content (%)')
ylabel('\bfNumber of Blows')
grid on
xs_label = get(gca, 'xtick');
set(gca, 'xticklabel', xs_label)
ylim([10, 60])

% --- Plot of Line of Best Fit
hold on
pm_points = linspace(min(p_moisture), max(p_moisture));
c = polyfit(p_moisture, log(num_blows), 1);
nb_points = exp(polyval(c, pm_points));
plot(pm_points, nb_points, '--k')
hold off

% --- Find Liquid Limit
hold on
LL_b = 25;
LL_m = (log(LL_b) - c(2)) / c(1);
plot(LL_m, LL_b, 'ko', 'markerfacecolor', 'r')
hold off
legend('Experimental Points','Line of Best Fit','Interpolated Point at 25 Blows');
% ----------------------------- end of script