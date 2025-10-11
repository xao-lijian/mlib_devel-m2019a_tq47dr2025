function pfb_data_transform_mask(gcb)
% find all the gateway in/out blocks
gateway_outs = find_system(gcb, ...
        'searchdepth', 1, ...
        'FollowLinks', 'on', ...
        'lookundermasks', 'all', ...
        'masktype','Xilinx Gateway Out Block'); 

gateway_ins = find_system(gcb, ...
        'searchdepth', 1, ...
        'FollowLinks', 'on', ...
        'lookundermasks', 'all', ...
        'masktype','Xilinx Gateway In Block');
% set number of bits for the Convert block    
convert_blkHandle = getSimulinkBlockHandle([gcb, '/Convert']);


%rename the gateway outs
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    gw_name = get_param(gw, 'Name');
    if regexp(gw_name, 'clk_in$')
        set_param(gw, 'Name', clear_name([gcb, '_clk_in']));
    elseif regexp(gw_name, 'data_valid_in$')
        set_param(gw, 'Name', clear_name([gcb, '_data_valid_in']));
    elseif regexp(gw_name, 'data_in_real$')
        set_param(gw, 'Name', clear_name([gcb, '_data_in_real']));     
    elseif regexp(gw_name, 'data_in_imag$')
        set_param(gw, 'Name', clear_name([gcb, '_data_in_imag']));           
    else 
        parent_name = get_param(gw, 'Parent');
        errordlg(['Unknown gateway: ', parent_name, '/', gw_name]);
    end
end 

%rename the gateway ins
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    gw_name = get_param(gw, 'Name');
    % Set number of bits for gateway in block
    if regexp(gw_name, 'data_valid_out$')
        set_param(gw, 'Name', clear_name([gcb, '_data_valid_out']));
    elseif regexp(gw_name, 'data_out$')
        set_param(gw, 'Name', clear_name([gcb, '_data_out']));         
    else 
        parent_name = get_param(gw, 'Parent');
        errordlg(['Unknown gateway: ', parent_name, '/', gw_name]);
    end
end