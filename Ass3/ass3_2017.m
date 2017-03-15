%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Henry He %
% 250869172, hhe65@uwo.ca %
% CS2035, Assignment 3, 2017 %
% March 19, 2017 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ass3_2017

    % close existing figures
    close all

    % set meshgrid parameters
    xmin = -4.0;
    xmax = +4.0;
    ymin = -4.0;
    ymax = +4.0;
    zmin = -8.0;
    zmax = +8.0;
    step = 0.05;
    axis([xmin xmax ymin ymax zmin zmax])

    x = xmin:step:xmax;
    y = ymin:step:ymax;
    
    % create meshgrid 
    [X,Y] = meshgrid(x,y);

    % create two peaks functions
    Z1 = mypeaks(X,Y);

    Z2 = mypeaks2(X,Y);

    % Create unknown functions for numerical integration
    fun1 = @(X,Y) (3*(1-X).^2.*exp(-(X.^2)-(Y+1).^2)-10*(X./5-X.^3-Y.^5).*...
        exp(-X.^2-Y.^2)-1/3*exp(-(X+1).^2-Y.^2));

    num_area1 = integral2(fun1, xmin, xmax, ymin, ymax);

    fun2 = @(X,Y)  (-(3*(1-X).^2.*exp(-(X.^2)-(Y+1).^2)-10*(X./5-X.^3-Y.^5).*...
        exp(-X.^2-Y.^2)-1/3*exp(-(X+1).^2-Y.^2)));

    num_area2 = integral2(fun2, xmin, xmax, ymin, ymax);

    % Symbolic integration of both peaks functions
    syms f1 f2 x y

    f1 = (3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2));
    sym_area1 = eval(int(int(f1,y,ymin,ymax),x,xmin,xmax));

    f2 = -(3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2));
    sym_area2=eval(int(int(f2,y,ymin,ymax),x,xmin,xmax));

    % Text position constants
    xpos1 = -3;
    xpos2 = -3;
    ypos1 = 0;
    ypos2 = 0;
    zpos1 = -7;
    zpos2 = -8;

    % Generate surface mesh plots for both peaks functions, with both
    % numerical and symbolic integrations
    mesh(X,Y,Z1);
    xlabel('X-axis', 'FontSize', 15, 'Color', 'b');
    ylabel('Y axis', 'FontSize', 15, 'Color', 'green');
    zlabel('Z axis', 'FontSize', 15, 'Color', 'red');
    title('Surface plot of f_1(x,y) = (3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2))');
    text(xpos1, ypos1, zpos1, strcat('Numerical integration: ', num2str(num_area1)), 'Color', 'blue');
    text(xpos2, ypos2, zpos2, strcat('Symbolic integration: ', num2str(sym_area1)), 'Color', 'blue');

    figure;

    mesh(X,Y,Z2);
    xlabel('X-axis', 'FontSize', 15, 'Color', 'b');
    ylabel('Y axis', 'FontSize', 15, 'Color', 'green');
    zlabel('Z axis', 'FontSize', 15, 'Color', 'red');
    title('Surface plot of f_2(x,y) = -(3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2))');
    text(xpos1, ypos1, zpos1, strcat('Numerical integration: ', num2str(num_area2)), 'Color', 'red');
    text(xpos2, ypos2, zpos2, strcat('Symbolic integration: ', num2str(sym_area2)), 'Color', 'red');

    % Set animation figure dimensions
    
    set(0,'units','pixels');
    screenSizePixels=get(0,'screensize');
    screenWidth=screenSizePixels(3);
    screenHeight=screenSizePixels(4);
    figureAspectRatio=3/4; % height to width
    figureHeight=screenHeight*0.75;
    figureWidth=screenHeight*1.0/figureAspectRatio;
    % shift left 5% of the screen width
    leftx=screenWidth*0.05;
    % shift up 15% of the screen height
    lefty=screenHeight*0.15;
    ha=figure;
    set(ha,'Position',[leftx lefty figureWidth figureHeight]);

    % Define constants for animation

    delta_t = 0.05;
    display_pause = 0;

    % Animation warping Z1 into Z2, and then Z2 into Z1
    
    for t=0:delta_t:1
        Z=Z1*(1-t)+Z2*(t);
        mesh(X,Y,Z)
        axis([xmin xmax ymin ymax zmin zmax]);
        text(xpos1,ypos1,zpos1,['\fontsize{18} \color{magenta}' ...
        'Numerical Integration: ' ...
        sprintf('%8.3f',num_area1*(1-t)+num_area2*t)]);
        % {1.0 0.6 0.0} is orange
        text(xpos2,ypos2,zpos2,['\fontsize{18} \color{magenta}' ...
            'Symbolic Integration: ' ...
            sprintf('%8.3f',sym_area1*(1-t)+sym_area2*t)]);
        xlabel('\bf \color{blue} \fontsize{20} X axis');
        ylabel('\bf \color{green} \fontsize{20} Y azis');
        zlabel('\bf \color{red} \fontsize{20} Z axis');
        title({'\color{orange} (3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2))'; ...
        '\color{black} warps to'; ...
        '\color{orange} -(3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2))'; ...
        '\color{black} and back again'});
        pause(display_pause);
        drawnow;
    end % for t

    for t=0:delta_t:1
        Z=Z2*(1-t)+Z1*(t);
        mesh(X,Y,Z)
        axis([xmin xmax ymin ymax zmin zmax]);
        text(xpos1,ypos1,zpos1,['\fontsize{18} \color{magenta}' ...
        'Numerical Integration: ' ...
        sprintf('%8.3f',num_area1*(1-t)+num_area2*t)]);
        % {1.0 0.6 0.0} is orange
        text(xpos2,ypos2,zpos2,['\fontsize{18} \color{magenta}' ...
            'Symbolic Integration: ' ...
            sprintf('%8.3f',sym_area1*(1-t)+sym_area2*t)]);
        xlabel('\bf \color{blue} \fontsize{20} X axis');
        ylabel('\bf \color{green} \fontsize{20} Y azis');
        zlabel('\bf \color{red} \fontsize{20} Z axis');
        title({'\color{orange} (3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2))'; ...
        '\color{black} warps to'; ...
        '\color{orange} -(3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2)-1/3*exp(-(x+1)^2 - y^2))'; ...
        '\color{black} and back again'});
        pause(display_pause);
        drawnow;
    end % for t

end


% Returns vectorized peaks function according to given formula 
function Z = mypeaks(X,Y)

    Z = (3*((1-X).^2).*exp(-(X.^2)-(Y+1).^2)-10*(X./5-X.^3-Y.^5).*...
        exp(-X.^2-Y.^2)-1/3*exp(-(X+1).^2-Y.^2));
    
end

% Returns vectorized negative peaks function according to given formula 
function Z = mypeaks2(X,Y)

    Z = -mypeaks(X,Y);
    
end
    



