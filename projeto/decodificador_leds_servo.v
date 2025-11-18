module decodificador_leds_servo (
    input      [1:0] servo_pos,
    output reg [3:0] leds_servo
);
        
    always @(servo_pos)
    case (servo_pos)
        2'b00:    leds_servo = 4'b0001;
        2'b01:    leds_servo = 4'b0010;
        2'b010:    leds_servo = 4'b0100;
        2'b11:    leds_servo = 4'b1000;
        default: leds_servo = 4'b1111;
    endcase
endmodule
