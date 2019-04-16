function data = estimate_pos(data, wind)
    % add new references to ease reading
    x = cumtrapz(data.t, data.u_n);
    y = cumtrapz(data.t, data.v_n);
    z = cumtrapz(data.t, data.w_n); 
    
    data.x = x;
    data.y = y;
    data.z = z;
end