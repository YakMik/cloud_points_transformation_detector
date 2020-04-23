alpha = 18;
x_offset = 10;
y_offset = 20;

plot_offset = 5;
step = 0.1;

% Draw a rectangle
% line1_x = -10:step:10;
% line1_y = 5*ones(1,length(line1_x));
% 
% line2_y = 5:-step:-5;
% line2_x = 10*ones(1,length(line2_y));
% 
% line3_x = 10:-step:-10;
% line3_y = -5*ones(1,length(line3_x));
% 
% line4_y = -5:step:5;
% line4_x = -10*ones(1,length(line4_y));

line1_x = 0:step:5;
line1_y = 5*ones(1,length(line1_x));

line2_y = 5:-step:3;
line2_x = 5*ones(1,length(line2_y));

line3_x = 2:step:10;
line3_y = -5*ones(1,length(line3_x));

line4_y = 1:-step:-5;
line4_x = 2*ones(1,length(line4_y));

x = [line1_x(2:end) line2_x(2:end) line3_x(2:end) line4_x(2:end)];
y = [line1_y(2:end) line2_y(2:end) line3_y(2:end) line4_y(2:end)];

% Adding noise
x_noise = x + (rand(1,length(x)) - 0.5)/5;
y_noise = y + (rand(1,length(y)) - 0.5)/5;

% Point cloud rotation
alpha = alpha * pi / 180;
[x_noise_cen y_noise_cen] = getCenter(x_noise, y_noise);
x_noise = x_noise - x_noise_cen;
y_noise = y_noise - y_noise_cen;
x_noise_r = x_noise * cos(alpha) + y_noise * sin(alpha);
y_noise_r = -x_noise * sin(alpha) + y_noise * cos(alpha);
x_noise_r = x_noise_r + x_noise_cen;
y_noise_r = y_noise_r + y_noise_cen;

% Adding point cloud offset
x_noise_r_o = x_noise_r + x_offset;
y_noise_r_o = y_noise_r + y_offset;

% Plot transformation steps
subplot(2,2,1)
plot(x, y, 'r.'); grid on; hold on;
title('Исходная фигура');
axis([min(x)-plot_offset max(x)+plot_offset min(y)-plot_offset max(y)+plot_offset]);
subplot(2,2,2)
plot(x_noise, y_noise, 'b.'); grid on; hold on;
title('Оцифрованная фигура');
axis([min(x_noise)-plot_offset max(x_noise)+plot_offset min(y_noise)-plot_offset max(y_noise)+plot_offset]);
subplot(2,2,3)
plot(x_noise_r, y_noise_r, 'g.'); grid on; hold on;
title('Оцифрованная повернутая фигура');
axis([min(x_noise_r)-plot_offset max(x_noise_r)+plot_offset min(y_noise_r)-plot_offset max(y_noise_r)+plot_offset]);
subplot(2,2,4)
plot(x_noise_r_o, y_noise_r_o, 'k.'); grid on; hold on;
title('Оцифрованная повернутая фигура со смещением');
axis([min(x_noise_r_o)-plot_offset max(x_noise_r_o)+plot_offset min(y_noise_r_o)-plot_offset max(y_noise_r_o)+plot_offset]);

% Search and display of transformation parameters
[ x_offs y_offs angl ] = getTransform( x, y, x_noise_r_o, y_noise_r_o );
fprintf('X offset: %f\nY offset: %f\nAngle: %f\n', x_offs, y_offs, 180*angl/pi);