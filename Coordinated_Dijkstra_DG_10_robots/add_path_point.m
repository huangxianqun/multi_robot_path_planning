function [route_add]=add_path_point(route,number,position)
route_add=zeros(1,length(route)+1);
if position ==1
    route_add(1)=number;
    route_add(2:length(route_add))=route;
elseif position==length(route)
    route_add(1:length(route_add)-1)=route;
    route_add(length(route_add))=number;
else 
    route_add(1:position-1)=route(1:position-1);
    route_add(position)=number;
    route_add(position+1:length(route_add))=route(position:length(route));
end
    