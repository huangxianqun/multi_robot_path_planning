function [ output_args ] = ShowImage( map_plot )
%SHOWIMAGE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    image(1.5, 1.5, map_plot);
    grid on; 
    axis image;
    drawnow;
    %pause(0.1);

end

