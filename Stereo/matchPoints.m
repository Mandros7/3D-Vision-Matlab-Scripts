function [ mPoints ] = matchPoints(data,column1,column2)
    data = [data(:,column1) data(:,column2)];
    mPoints = [];
    for i = 1:length(data)
        if((data(i,1)>-1)&&(data(i,2)>-1))
            mPoints = [mPoints;data(i,:)];
        end
    end
end

