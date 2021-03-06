function mrac_output = mrac_model_e2y_2delay(params)
    k_x0 = params(1:2);
    P = params(3:4);
    P = [1.5, 3; 1.5, 3];
    omega_c = params(5);
    delay = params(6);
    gamma_x = params(7:8);
    omega_filter = 15;
    tau_0 = params(9);
    gamma_tau = 0.00;
    s = tf('s');
    low_pass_filter = omega_filter/(omega_filter + s);
%     sys_ol = omega_c/(s) * exp(-delay * s);
%     tf_ol_pade = pade(sys_ol, 2);
    tf_ol_pade = omega_c/s;
    tf_cl_pade = tf_ol_pade;
    
    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'P', P);
    assignin('base', 'tau_p', tau_0);
    assignin('base', 'tau_d', tau_0+0.1);
    assignin('base', 'gamma_tau', gamma_tau);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'ref_x0', [0]);
    assignin('base', 'gamma_x', gamma_x);
    assignin('base', 'k_x0', k_x0);
    out = sim('adaptive_mrac_e2y_double_delay');
    mrac_output = out.y;

end