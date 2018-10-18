function [ output_args ] = ShowImage( map_plot )
%SHOWIMAGE 此处显示有关此函数的摘要
%   此处显示详细说明
    image(1.5, 1.5, map_plot);
    grid on; 
    axis image;
    drawnow;
    %pause(0.1);

end

