module neurosync_controller_single_fd (
    input  clock,
    input  reset,
    input  zera,
    input  jogar,
    input  confirma,
    input  direita,
    input  esquerda,
    input  [3:0] botoes,
    input  echo,
    input  conta_pergunta,
    input  registra_modo,
    input  zera_prep_jogo,
    input  set_pos,
    input  jogando,
    input  medir,
    input  enable_mov,
    input  show_leds_servo,
    
    output pronto_play,
    output acertou_play,
    output acertou_faixa,
    output [1:0] opcode,
    output is_ultima_pergunta,

    output [3:0] leds,
    output [3:0] leds_servo,
    output trigger,
    output pwm,
    output db_pwm,
    output wire [6:0] hex0,
    output wire [6:0] hex1,
    output wire [6:0] hex2,
    output pronto_tx,
    output serial
);

    wire [11:0] s_medida;

    wire jogar_det, 
         confirma_det, 
         reset_det, 
         direita_det, 
         esquerda_det;
    wire [3:0] botoes_det;

    wire [2:0] w_memory_addr;
    wire [59:0] w_mem0_out, w_mem1_out, w_mem2_out, w_mem3_out, w_resposta;
    wire [59:0] w_memory_out;
    wire [1:0] w_pos, w_modo;

    wire [1:0]  opcode_mem;
    wire [3:0]  leds_mem;
    wire [3:0]  leds_servo_decod;
    wire [1:0]  pos_inicial_mem;
    wire [11:0] lim_inf_mem;
    wire [11:0] lim_sup_mem;
    wire [27:0] expected_mem;
    wire w_zera_pwm;

    wire w_serial_faixa, w_serial_play;

    assign serial = (medir == 1'b1) ? w_serial_faixa : w_serial_play;

    assign w_zera_pwm = zera || zera_prep_jogo || reset;
    assign opcode_mem      = w_memory_out[59:58];
    assign leds_mem        = w_memory_out[57:54];
    assign pos_inicial_mem = w_memory_out[53:52];
    assign lim_inf_mem     = w_memory_out[51:40];
    assign lim_sup_mem     = w_memory_out[39:28];
    assign expected_mem    = w_memory_out[27:0];

    assign opcode = opcode_mem;
    assign leds       = (jogando == 1'b1) ? leds_mem : 4'b1111;
    assign leds_servo = (show_leds_servo == 1'b1) ? leds_servo_decod : 4'b1111;



    decodificador_leds_servo decodificador_leds_servo (
        .servo_pos(w_pos),
        .leds_servo(leds_servo_decod)
    );

    //Registradores
    registrador_n #(.N(2)) registrador_modo (
        .clock(clock),
        .clear(zera),
        .enable(registra_modo),
        .D(w_pos),
        .Q(w_modo)
    );

    //MUX
    mux_4x1 #(.BITS(60)) muxMemorias (
        .D3(w_mem3_out),
        .D2(w_mem2_out),
        .D1(w_mem1_out),
        .D0(w_mem0_out),
        .SEL(w_modo),
        .MUX_OUT(w_memory_out)
    );

    //Contadores
    contador_m #(.M(8), .N(3)) contador_memoria (
        .clock(clock),
        .zera_as(),
        .zera_s(zera),
        .conta(conta_pergunta),
        .Q(w_memory_addr),
        .fim(is_ultima_pergunta),
        .meio()
    );

    //Memorias
    mem0 mem0 (
        // .clock(clock),
        .address(w_memory_addr),
        .data_out(w_mem0_out)  
    );

    mem1 mem1 (
        // .clock(clock),
        .address(w_memory_addr),
        .data_out(w_mem1_out)  
    );

    mem2 mem2 (
        // .clock(clock),
        .address(w_memory_addr),
        .data_out(w_mem2_out)  
    );

    mem3 mem3 (
        // .clock(clock),
        .address(w_memory_addr),
        .data_out(w_mem3_out)  
    );

    //Componentes
    medidor_faixa medidor_faixa(
        .clock(clock),
        .reset(reset),
        .medir(medir),
        .upperL(lim_sup_mem),
        .lowerL(lim_inf_mem),
        .echo(echo),

        .trigger(trigger),
        .acertou(acertou_faixa),
        .saida_serial(w_serial_faixa),
        .db_medida(s_medida),
        .db_estado(),
        .dentro()
    );

    circuito_pwm circuito_pwm (
        .clock(clock),
        .zera(w_zera_pwm),
        .set_pos(set_pos),
        .direita(direita),
        .esquerda(esquerda),
        .enable_mov(enable_mov),
        .pos_inicial(pos_inicial_mem),
        .pwm(pwm),
        .pos(w_pos),
        .db_pwm(db_pwm)
    );

    play_analyser play_analyser (
        .clock(clock),
        .jogar(jogar),
        .reset(reset),
        .botoes(botoes),
        .pos(w_pos),
        .confirma(confirma),
        .direita(direita),
        .esquerda(esquerda),
        .expected(expected_mem),
        .serial(w_serial_play),
        .pronto(pronto_play),
        .acertou(acertou_play),
        .resposta(w_resposta),
        .pronto_comparacao()
    );


    //Edge detectors
    edge_detector jogar_detector (
        .clock(clock),
        .reset(),
        .sinal(jogar),
        .pulso(jogar_det)
    );
    edge_detector confirma_detector (
        .clock(clock),
        .reset(),
        .sinal(confirma),
        .pulso(confirma_det)
    );
    edge_detector reset_detector (
        .clock(clock),
        .reset(),
        .sinal(reset),
        .pulso(reset_det)
    );
    edge_detector direita_detector (
        .clock(clock),
        .reset(),
        .sinal(direita),
        .pulso(direita_det)
    );
    edge_detector esquerda_detector (
        .clock(clock),
        .reset(),
        .sinal(esquerda),
        .pulso(esquerda_det)
    );
    edge_detector botao0_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes[0]),
        .pulso(botoes_det[0])
    );
    edge_detector botao1_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes[1]),
        .pulso(botoes_det[1])
    );
    edge_detector botao2_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes[2]),
        .pulso(botoes_det[2])
    );
    edge_detector botao3_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes[3]),
        .pulso(botoes_det[3])
    );

    //Displays de 7seg
    hexa7seg H0 (
        .hexa   (s_medida[3:0]), 
        .display(hex0         )
    );
    hexa7seg H1 (
        .hexa   (s_medida[7:4]), 
        .display(hex1         )
    );
    hexa7seg H2 (
        .hexa   (s_medida[11:8]), 
        .display(hex2          )
    );

endmodule