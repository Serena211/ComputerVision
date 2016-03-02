function res = reader(path, output_file_name)
    % Input:
    %       (1) the absolute path of the input video
    %       (2) the file name of the output video
    % Output: the path of the video detected by the face detector
    obj = VideoReader(path);
    width = obj.Width;
    height = obj.Height;
    mov = struct('cdata',zeros(height,width,3,'uint8'), 'colormap', []);
    k = 1;
    while hasFrame(obj)
        mov(k).cdata = readFrame(obj);
        k = k + 1;
    end
    k = k - 1; % Number of frames

    out = struct('cdata',zeros(height,width,3,'uint8'), 'colormap', []);
    for i = 1:k
        tmpImg = mov(i).cdata;
        [x, y, h, w] = ycrcb(tmpImg); % to be determined
        x = round(x);
        y = round(y);
        h = round(h);
        w = round(w);
        for a = 1:size(x,2)
            if (h(a) ~= 0) && (w(a) ~= 0)
                for col = x(a):x(a)+w(a)
                    tmpImg = drawYellow(tmpImg, col, y(a));
                    tmpImg = drawYellow(tmpImg, col, y(a)+h(a));
                end
                for row = y(a):y(a)+h(a)
                    tmpImg = drawYellow(tmpImg, x(a), row);
                    tmpImg = drawYellow(tmpImg, x(a)+w(a), row);
                end
            end
        end
        out(i).cdata = tmpImg;
    end
    
    writer = VideoWriter(output_file_name, 'MPEG-4');
    writer.FrameRate = obj.FrameRate;
    open(writer);
    for i = 1:k
        writeVideo(writer, out(i).cdata);
    end
    close(writer);
    res = output_file_name;
end