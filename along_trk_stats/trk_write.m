function trk_write(header,tracks,savePath)
%TRK_WRITE - Write TrackVis .trk files
%
% Syntax: read_trk(header,tracks,savePath)
%
% Inputs:
%    header   - Header information for .trk file [struc]
%    tracks   - Track data struc array [1 x nTracks]
%      nPoints  - # of points in each track
%      matrix   - XYZ coordinates and associated scalars [nPoints x 3+nScalars]
%      props    - Properties of the whole tract
%    savePath - Path where .trk file will be saved [char]
%
% Output files:
%    Saves .trk file to disk at location given by 'savePath'.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: TRK_READ

% Author: John Colby (johncolby@ucla.edu)
% UCLA Developmental Cognitive Neuroimaging Group (Sowell Lab)
% Apr 2010 $Rev$ $Date$

fid = fopen(savePath, 'w');

%% Write header
fwrite(fid, header.id_string, '*char');
fwrite(fid, header.dim, 'short');
fwrite(fid, header.voxel_size, 'float');
fwrite(fid, header.origin, 'float');
fwrite(fid, header.n_scalars , 'short');
fwrite(fid, header.scalar_name', '*char');
fwrite(fid, header.n_properties, 'short');
fwrite(fid, header.property_name', '*char');
fwrite(fid, header.reserved, '*char');
fwrite(fid, header.voxel_order, '*char');
fwrite(fid, header.pad2, '*char');
fwrite(fid, header.image_orientation_patient, 'float');
fwrite(fid, header.pad1, '*char');
fwrite(fid, header.invert_x, 'uchar');
fwrite(fid, header.invert_y, 'uchar');
fwrite(fid, header.invert_z, 'uchar');
fwrite(fid, header.swap_xy, 'uchar');
fwrite(fid, header.swap_yz, 'uchar');
fwrite(fid, header.swap_zx, 'uchar');
fwrite(fid, header.n_count, 'int');
fwrite(fid, header.version, 'int');
fwrite(fid, header.hdr_size, 'int');

%% Write body
for iTrk = 1:header.n_count
    % Modify orientation
    %if header.invert_x==1, tracks(iTrk).matrix(:,1) = header.dim(1)*header.voxel_size(1) - tracks(iTrk).matrix(:,1); end
    %if header.invert_y==1, tracks(iTrk).matrix(:,2) = header.dim(2)*header.voxel_size(2) - tracks(iTrk).matrix(:,2); end
    %if header.invert_z==1, tracks(iTrk).matrix(:,3) = header.dim(3)*header.voxel_size(3) - tracks(iTrk).matrix(:,3); end
    
    tracks(iTrk).matrix(:,2) = header.dim(2)*header.voxel_size(2) - tracks(iTrk).matrix(:,2);
    
    fwrite(fid, tracks(iTrk).nPoints, 'int');
    fwrite(fid, tracks(iTrk).matrix', 'float');
    if header.n_properties
        fwrite(fid, tracks(iTrk).props, 'float');
    end
end

fclose(fid);