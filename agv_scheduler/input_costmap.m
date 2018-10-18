function  res = input_costmap( )
%INPUT_COSTMAP 此处显示有关此函数的摘要
%   此处显示详细说明

%Node Template
empty_node.index = 0;                %当前节点编号
empty_node.adj_node = [];            %当前节点的相邻节点
empty_node.adj_weight = [];          %当前节点到相邻节点边的权值
empty_node.parent_node = 0;          %当前节点的父节点

node = repmat(empty_node, 69, 1);

%输入地图的信息（目前是手动）
node(1).index = 1;  node(1).adj_node = [2];     node(1).adj_weight = [3]; 
node(2).index = 2;  node(2).adj_node = [1, 3];  node(2).adj_weight = [3, 3]; 
node(3).index = 3;  node(3).adj_node = [2, 6];  node(3).adj_weight = [3, 3]; 

node(4).index = 4;  node(4).adj_node = [5];     node(4).adj_weight = [3]; 
node(5).index = 5;  node(5).adj_node = [4, 6];  node(5).adj_weight = [3, 3];
node(6).index = 6;  node(6).adj_node = [3, 5, 9];  node(6).adj_weight = [3, 3, 3]; 

node(7).index = 7;  node(7).adj_node = [8];     node(7).adj_weight = [3]; 
node(8).index = 8;  node(8).adj_node = [7, 9];  node(8).adj_weight = [3, 3];
node(9).index = 9;  node(9).adj_node = [6, 8, 12];  node(9).adj_weight = [3, 3, 3]; 

node(10).index = 10;  node(10).adj_node = [11];     node(10).adj_weight = [3]; 
node(11).index = 11;  node(11).adj_node = [10, 12];  node(11).adj_weight = [3, 3];
node(12).index = 12;  node(12).adj_node = [9, 11, 15];  node(12).adj_weight = [3, 3, 3];

node(13).index = 13;  node(13).adj_node = [14];     node(13).adj_weight = [3];
node(14).index = 14;  node(14).adj_node = [13, 15];  node(14).adj_weight = [3, 3];
node(15).index = 15;  node(15).adj_node = [12, 14 16, 20];  node(15).adj_weight = [3, 3, 3, 3];
node(16).index = 16;  node(16).adj_node = [15, 17];  node(16).adj_weight = [3, 3];
node(17).index = 17;  node(17).adj_node = [16];  node(17).adj_weight = [3];

node(18).index = 18;  node(18).adj_node = [19];  node(18).adj_weight = [3];
node(19).index = 19;  node(19).adj_node = [18, 20];  node(19).adj_weight = [3, 3];
node(20).index = 20;  node(20).adj_node = [15, 19 ,21, 25];  node(20).adj_weight = [3, 3, 3, 3];
node(21).index = 21;  node(21).adj_node = [20, 22];  node(21).adj_weight = [3, 3];
node(22).index = 22;  node(22).adj_node = [21];  node(22).adj_weight = [3];

node(23).index = 23;  node(23).adj_node = [24];  node(23).adj_weight = [3];
node(24).index = 24;  node(24).adj_node = [23, 25];  node(24).adj_weight = [3, 3];
node(25).index = 25;  node(25).adj_node = [20, 24 ,26, 30];  node(25).adj_weight = [3, 3, 3, 3];
node(26).index = 26;  node(26).adj_node = [25, 27];  node(26).adj_weight = [3, 3];
node(27).index = 27;  node(27).adj_node = [26];  node(27).adj_weight = [3];

node(28).index = 28;  node(28).adj_node = [29];  node(28).adj_weight = [3];
node(29).index = 29;  node(29).adj_node = [28, 30];  node(29).adj_weight = [3, 3];
node(30).index = 30;  node(30).adj_node = [25, 29 ,31, 35];  node(30).adj_weight = [3, 3, 3, 3];
node(31).index = 31;  node(31).adj_node = [30, 32];  node(31).adj_weight = [3, 3];
node(32).index = 32;  node(32).adj_node = [31];  node(32).adj_weight = [3];

node(33).index = 33;  node(33).adj_node = [34];  node(33).adj_weight = [3];
node(34).index = 34;  node(34).adj_node = [33, 35];  node(34).adj_weight = [3, 3];
node(35).index = 35;  node(35).adj_node = [30, 34 ,36, 40];  node(35).adj_weight = [3, 3, 3, 3];
node(36).index = 36;  node(36).adj_node = [35, 37];  node(36).adj_weight = [3, 3];
node(37).index = 37;  node(37).adj_node = [36];  node(37).adj_weight = [3];

node(38).index = 38;  node(38).adj_node = [39];  node(38).adj_weight = [3];
node(39).index = 39;  node(39).adj_node = [38, 40];  node(39).adj_weight = [3, 3];
node(40).index = 40;  node(40).adj_node = [35, 39 ,41, 45];  node(40).adj_weight = [3, 3, 3, 3];
node(41).index = 41;  node(41).adj_node = [40, 42];  node(41).adj_weight = [3, 3];
node(42).index = 42;  node(42).adj_node = [41];  node(42).adj_weight = [3];

node(43).index = 43;  node(43).adj_node = [44];  node(43).adj_weight = [3];
node(44).index = 44;  node(44).adj_node = [43, 45];  node(44).adj_weight = [3, 3];
node(45).index = 45;  node(45).adj_node = [40, 44 ,46, 50];  node(45).adj_weight = [3, 3, 3, 3];
node(46).index = 46;  node(46).adj_node = [45, 47];  node(46).adj_weight = [3, 3];
node(47).index = 47;  node(47).adj_node = [46];  node(47).adj_weight = [3];

node(48).index = 48;  node(48).adj_node = [49];  node(48).adj_weight = [3];
node(49).index = 49;  node(49).adj_node = [48, 50];  node(49).adj_weight = [3, 3];
node(50).index = 50;  node(50).adj_node = [45, 49 ,51, 55];  node(50).adj_weight = [3, 3, 3, 3];
node(51).index = 51;  node(51).adj_node = [50, 52];  node(51).adj_weight = [3, 3];
node(52).index = 52;  node(52).adj_node = [51];  node(52).adj_weight = [3];

node(53).index = 53;  node(53).adj_node = [54];  node(53).adj_weight = [3];
node(54).index = 54;  node(54).adj_node = [53, 55];  node(54).adj_weight = [3, 3];
node(55).index = 55;  node(55).adj_node = [50, 54 ,56, 60];  node(55).adj_weight = [3, 3, 3, 3];
node(56).index = 56;  node(56).adj_node = [55, 57];  node(56).adj_weight = [3, 3];
node(57).index = 57;  node(57).adj_node = [56];  node(57).adj_weight = [3];

node(58).index = 58;  node(58).adj_node = [59];     node(58).adj_weight = [3]; 
node(59).index = 59;  node(59).adj_node = [58, 60];  node(59).adj_weight = [3, 3];
node(60).index = 60;  node(60).adj_node = [55, 59, 63];  node(60).adj_weight = [2, 3, 3];

node(61).index = 61;  node(61).adj_node = [62];     node(61).adj_weight = [3]; 
node(62).index = 62;  node(62).adj_node = [61, 63];  node(62).adj_weight = [3, 3];
node(63).index = 63;  node(63).adj_node = [60, 62, 66];  node(63).adj_weight = [3, 3, 3];

node(64).index = 64;  node(64).adj_node = [65];     node(64).adj_weight = [3]; 
node(65).index = 65;  node(65).adj_node = [64, 66];  node(65).adj_weight = [3, 3];
node(66).index = 66;  node(66).adj_node = [63, 65, 69];  node(66).adj_weight = [3, 3, 3];

node(67).index = 67;  node(67).adj_node = [68];     node(67).adj_weight = [3]; 
node(68).index = 68;  node(68).adj_node = [67, 69];  node(68).adj_weight = [3, 3];
node(69).index = 69;  node(69).adj_node = [66, 68];  node(69).adj_weight = [3, 3];


res = node;%输出规划图
end

