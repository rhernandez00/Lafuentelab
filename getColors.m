function colors = getColors(colorScheme)
if nargin < 1
    colorScheme = 1;
end

switch colorScheme
    case 1
        colors = {...
            [76,195,217],... %blue 1
            [240,0,105],... %magenta9 %[207,0,91],... %magenta9
            [169,222,3],... %green 3
            [199,13,255],... %purple 4
            [75,172,198],...%cyan 5
            [255,88,1],... %orange 6
            [255,240,0],... %yellow 7
            [232,16,12],... %red 8
            [207,0,91],... %magenta9
            [0,51,153],...%blue 10
            [0,0,0],... %black 11
            [0,0,0]... %black 12
            [255,255,255]... %white 13
            };
    case 2
        colors = {...
            [0,51,153],...%blue 1
            [207,0,91],... %magenta9
            [169,222,3],... %green 3
            [76,195,217],... %blue 4
            [75,172,198],...%cyan 5
            [255,88,1],... %orange 6
            [255,240,0],... %yellow 7
            [232,16,12],... %red 8
            [207,0,91],... %magenta9
            [0,0,0]... %black 10
            };
     case 3
        colors = {...
            
            [254,39,149],...%pink 2 
            [76,195,217],...%cyan 5
            [241,103,69],... %orangeINB  3 
            [194,103,255],... %light purple  3 
            [68,141,135],... %dark green 1
            [217,4,43],...%bloody red 4
            [107,12,34],...%bloody red 5
            [0,0,0]... %black 
            };
    case 4
        colors = {...  
            [255,0,0],...%red 1 
            [0,255,0],...%green 2
            [0,0,255],... %blue  3 
            [0,0,0],... %black 4  
            [255,255,255],... %white 5 
            [255,255,0],...%
            [255,0,255],...%
            [0,255,255]... %
            };
    case 5 %for colorblind 1 
        colors = {...  
            [230,159,0],...% 1 
            [86,180,233],...% 2
            [0,158,115],... %3 
            [240,228,66],... %4  
            [0,114,178],... %5
            [213,94,0],...
            [204,121,167],...
            [0,0,0]...
            };
    case 6 %for colorblind 1 
        colors = {...  
            [146,0,0],...%red 1 
            [31,217,118],...%green 2
            [0,109,219],... %blue  3 
            [0,73,73],... %dark blue 4  
            [219,109,0],... %orange 5 
            };
    case 7
        colors = {...
            [75,172,198],...%cyan 5
            [240,0,105],... %magenta9 %[207,0,91],... %magenta9
            [169,222,3],... %green 3
            [199,13,255],... %purple 4
            [255,88,1],... %orange 6
            [76,195,217],... %blue 1
            [255,240,0],... %yellow 7
            [232,16,12],... %red 8
            [207,0,91],... %magenta9
            [0,51,153],...%blue 10
            [0,0,0],... %black 11
            [0,0,0]... %black 12
            [255,255,255]... %white 13
            };
end
for i = 1:length(colors)
    colors{i} = colors{i}./255;
end

