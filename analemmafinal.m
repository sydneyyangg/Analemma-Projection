% Constants
latitude = 43.5; % Latitude of Waterloo in degrees
longitude = -80.5; % Longitude of Waterloo in degrees
height = 9.27; % Height of the glass pane in meters above the ground
time_of_day = 13; % Local solar time (adjusted by EoT)
days = 1:365; % Days of the year

% Pre-allocate arrays
altitudes = zeros(size(days));
azimuths = zeros(size(days));
x_proj = zeros(size(days));
y_proj = zeros(size(days));

% Loop through each day of the year
for n = days
    % Step 1: Calculate Solar Declination (in degrees)
    declination = -23.44 * cosd(360 / 365 * (n + 10)); % Earth's axial tilt

    % Step 2: Calculate the Equation of Time (EoT) in minutes
    B = (360 / 365) * (n - 81); % Day of the year offset by vernal equinox
    EoT = 9.87 * sind(2 * B) - 7.53 * cosd(B) - 1.5 * sind(B);
    
    % Step 3: Correct Local Solar Time (in hours)
    solar_time = time_of_day + EoT / 60; % EoT adjusts clock time to solar time
    
    % Step 4: Calculate Solar Hour Angle (in degrees)
    hour_angle = 15 * (solar_time - 12); % 15 degrees per hour from solar noon

    % Step 5: Calculate Solar Altitude (in degrees)
    altitude = asind(sind(latitude) * sind(declination) + ...
                     cosd(latitude) * cosd(declination) * cosd(hour_angle));
    altitudes(n) = altitude;
    
    % Step 6: Calculate Solar Azimuth (in degrees)
    azimuth = acosd((sind(altitude) * sind(latitude) - sind(declination)) / ...
                    (cosd(altitude) * cosd(latitude)));
    if hour_angle > 0
        azimuth = 360 - azimuth; % Adjust azimuth for afternoon positions
    end
    azimuths(n) = azimuth;
    
    % Step 7: Project Solar Position onto Ground
    shadow_length = height * cotd(altitude); % Length of the shadow
    x_proj(n) = shadow_length * sind(azimuth); % X-coordinate of projection
    y_proj(n) = shadow_length * cosd(azimuth); % Y-coordinate of projection
end

% Plot the Analemma Path
figure;
plot(x_proj, y_proj, 'b-', 'LineWidth', 2);
hold on;
scatter(x_proj(80), y_proj(80), 'r', 'filled'); % Spring Equinox
scatter(x_proj(172), y_proj(172), 'g', 'filled'); % Summer Solstice
scatter(x_proj(266), y_proj(266), 'r', 'filled'); % Autumn Equinox
scatter(x_proj(355), y_proj(355), 'g', 'filled'); % Winter Solstice
title('Analemma Projection on the Ground');
xlabel('X Projection (m)');
ylabel('Y Projection (m)');
legend('Analemma Path', 'Equinoxes', 'Solstices');
grid on;
axis equal;
