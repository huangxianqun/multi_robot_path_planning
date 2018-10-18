function [map_color, route_multi, dest_node] = multi_path_generation( start_coords_array,dest_coords_mark_array,map,weight)

map_color=zeros(size(map,1),size(map,2));
map_color(~map)=1;
map_color(map)=2;

for i=1:10
    start_coords(1)=start_coords_array(i,1);
    start_coords(2)=start_coords_array(i,2);
    dest_coords_mark=dest_coords_mark_array(i);
    [dest_node_1,route, numExpanded] = DijkstraGrid (map, start_coords, dest_coords_mark,weight);
    route_multi(i,1:length(route))=route;
    start_node = sub2ind(size(map), start_coords(1), start_coords(2));
%     dest_coords_array=dest_mark_2_dest_coords(dest_coords_mark);
%     for j=1:size(dest_coords_array,1)
%         dest_node(j)=sub2ind(size(map), dest_coords_array(j,1), dest_coords_array(j,2));
%     end
% map_color(start_node) = 5;
% map_color(dest_node_1)  = 6;
%¼ÇÂ¼ÖÕµã
dest_node(i)=dest_node_1;
% for k = 2:length(route) - 1
%     if (map_color(route(k))==1)
%         map_color(route(k)) =7+(i-1);
%     else
%         continue;
%     end
% end
end 
image(1.5, 1.5, map_color);
grid on;
axis image;
end