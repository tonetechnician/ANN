% encode.m
% Author: Sean Devonport
% A script that encodes mushroom data.
%%
function data=encode(file)
    fid = fopen(file);
    tline=fgets(fid);
    data=[];
    i=1;
    while ischar(tline)
        %disp(tline)
        C=char(strsplit(tline,','))';
        C=C(1,:);
        data(i,:)=doEncode(C);
        i=i+1;
        tline=fgets(fid);
    end
    fclose(fid);
end

function y=doEncode(x)
    y=zeros(1,size(x,2));    
    for i=1:size(x,2)
        switch i
            case 1 %encode target. 0 - poisonious, 1 - edible
                switch x(i)
                    case 'p' %poisonious
                        y(i)= 0;
                    case 'e' %edible
                        y(i)= 1;
                end
            case 2 %encode cap shape
                switch x(i)
                    case 'b'
                        y(i)=0;
                    case 'c'
                        y(i)=1;
                    case 'x'
                        y(i)=2;
                    case 'f'
                        y(i)=3;
                    case 'k' 
                        y(i)=4;
                    case 's'
                        y(i)=5;
                end
            case 3 % encode cap-surface
               switch x(i)
                    case 'f'
                        y(i)=0;
                    case 'g'
                        y(i)=1;
                    case 'y'
                        y(i)=2;
                    case 's'
                        y(i)=3;
                end
            case 4 % encode cap-colour
                switch x(i)
                    case 'n' %brown
                        y(i)=0;
                    case 'b' %buff
                        y(i)=1;
                    case 'c' %cinnamon
                        y(i)=2;
                    case 'g' %gray
                        y(i)=3;                    
                    case 'r' %green
                        y(i)=4;
                    case 'p' %pink
                        y(i)=5;
                    case 'u' %purple
                        y(i)=6;                    
                    case 'e' %red
                        y(i)=7;
                    case 'w' %white
                        y(i)=8;                    
                    case 'y' %yellow
                        y(i)=9;
                end
            case 5 % encode bruises
                switch x(i)
                    case 'f' %no bruises
                        y(i)=0;
                    case 't' %bruises
                        y(i)=1;     
                end
            case 6 %encode odor
                switch x(i)
                    case 'a' %almond
                        y(i)=0;
                    case 'l' %anise
                        y(i)=1;
                    case 'c' %creosote
                        y(i)=2;
                    case 'y' %fishy
                        y(i)=3;
                    case 'm' %musty
                        y(i)=4;
                    case 'n' %none
                        y(i)=5;
                    case 'p' %pungent
                        y(i)=6;
                    case 's' %spicy
                        y(i)=7;
                end
            case 7 %gill-attachment
                switch x(i)
                    case 'a' %attached
                        y(i)=0;
                    case 'd' %descending
                        y(i)=1;
                    case 'f' %free
                        y(i)=2;
                    case 'n' %notched
                        y(i)=3;
                end
            case 8 %gill spacing
               switch x(i)
                    case 'c' %close
                        y(i)=0;
                    case 'w' %crowded
                        y(i)=1;
                    case 'd' %distant
                        y(i)=2;
                end
            case 9 %gill size
               switch x(i)
                    case 'b' %broad
                        y(i)=0;
                    case 'n' %narrow
                        y(i)=1;
                end
            case 10 %gill-color
                switch x(i)
                    case 'n' %brown
                        y(i)=0;
                    case 'b' %buff
                        y(i)=1;
                    case 'h' %chocolate
                        y(i)=2;
                    case 'g' %gray
                        y(i)=3;                    
                    case 'r' %green
                        y(i)=4;
                    case 'p' %pink
                        y(i)=5;
                    case 'u' %purple
                        y(i)=6;                    
                    case 'e' %red
                        y(i)=7;
                    case 'w' %white
                        y(i)=8;                    
                    case 'y' %yellow
                        y(i)=9;
                    case 'k' %black
                        y(i)=10;
                    case 'o' %orange
                        y(i)=11;
                end
            case 11 %stalk shape
                switch x(i)
                    case 'e' %enlarging
                        y(i)=0;
                    case 't' %tapering
                        y(i)=1;
                end
            case 12 %stalk root
                switch x(i)
                    case 'b' %bulbous
                        y(i)=0;
                    case 'c' %club
                        y(i)=1;
                    case 'u' %cup
                        y(i)=2;
                    case 'e' %equal
                        y(i)=3;
                    case 'z' %rhizomorphs
                        y(i)=4;
                    case 'r' %rooted
                        y(i)=5;
                    case '?' %missing
                        y(i)=6;
                end
            case 13 %stalk surface above ring
                switch x(i)
                    case 'f' %fibrous
                        y(i)=0;
                    case 'y' %scaly
                        y(i)=1;
                    case 'k' %silky
                        y(i)=2;
                    case 's' %smooth
                        y(i)=3;
                end                
            case 14 %stalk surface below ring
                switch x(i)
                    case 'f' %fibrous
                        y(i)=0;
                    case 'y' %scaly
                        y(i)=1;
                    case 'k' %silky
                        y(i)=2;
                    case 's' %smooth
                        y(i)=3;
                end     
            case 15 %stalk colour above ring
                switch x(i)
                    case 'n' %brown
                        y(i)=0;
                    case 'b' %buff
                        y(i)=1;
                    case 'c' %cinnamon
                        y(i)=2;
                    case 'g' %gray
                        y(i)=3;                    
                    case 'r' %green
                        y(i)=4;
                    case 'p' %pink
                        y(i)=5;                
                    case 'e' %red
                        y(i)=6;
                    case 'w' %white
                        y(i)=7;                    
                    case 'y' %yellow
                        y(i)=8;
                end
            case 16 %stalk colour above ring
                switch x(i)
                    case 'n' %brown
                        y(i)=0;
                    case 'b' %buff
                        y(i)=1;
                    case 'c' %cinnamon
                        y(i)=2;
                    case 'g' %gray
                        y(i)=3;                    
                    case 'r' %green
                        y(i)=4;
                    case 'p' %pink
                        y(i)=5;                
                    case 'e' %red
                        y(i)=6;
                    case 'w' %white
                        y(i)=7;                    
                    case 'y' %yellow
                        y(i)=8;
                end
            case 17 %veil type
               switch x(i)
                    case 'p' %partial
                        y(i)=0;
                    case 'u' %universal
                        y(i)=1;
                end
            case 18 %veil colour
                switch x(i)
                    case 'n' %brown
                        y(i)=0;
                    case 'o' %orange
                        y(i)=1;
                    case 'w' %white
                        y(i)=2;
                    case 'y' %yellow
                        y(i)=3; 
                end
            case 19 %ring number
                switch x(i)
                    case 'n' %none
                        y(i)=0;
                    case 'o' %one
                        y(i)=1;
                    case 't' %two
                        y(i)=2;
                end
            case 20 %ring type
                switch x(i)
                    case 'c' %cobwebby
                        y(i)=0;
                    case 'e' %evanescent
                        y(i)=1;
                    case 'f' %flaring
                        y(i)=2;
                    case 'l' %large
                        y(i)=3;                    
                    case 'n' %none
                        y(i)=4;
                    case 'p' %pendent
                        y(i)=5;                
                    case 's' %sheathing
                        y(i)=6;
                    case 'z' %zone
                        y(i)=7;                    
                end
            case 21%spore print colour
                switch x(i)
                    case 'n' %brown
                        y(i)=0;
                    case 'b' %buff
                        y(i)=1;
                    case 'h' %chocolate
                        y(i)=2;                  
                    case 'r' %green
                        y(i)=4;
                    case 'u' %purple
                        y(i)=5;                    
                    case 'w' %white
                        y(i)=6;                    
                    case 'y' %yellow
                        y(i)=7;
                    case 'k' %black
                        y(i)=8;
                    case 'o' %orange
                        y(i)=9;
                end
            case 22 %population
                switch x(i)
                    case 'a' %abundant
                        y(i)=0;
                    case 'c' %clustered
                        y(i)=1;
                    case 'n' %numerous
                        y(i)=2;
                    case 's' %scattered
                        y(i)=3;                    
                    case 'v' %several
                        y(i)=4;
                    case 'y' %solitary
                        y(i)=5;                                
                end
            case 23 % Habitat
                switch x(i)
                    case 'g' %grasses
                        y(i)=0;
                    case 'l' %leaves
                        y(i)=1;
                    case 'm' %meadows
                        y(i)=2;
                    case 'p' %paths
                        y(i)=3;                    
                    case 'u' %urban
                        y(i)=4;
                    case 'w' %waste
                        y(i)=5;  
                    case 'd' %waste
                        y(i)=6;   
                end
        end
    end
    
end
