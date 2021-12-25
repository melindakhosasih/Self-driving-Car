// This module take "mode" input and control two motors accordingly.
// clk should be 100MHz for PWM_gen module to work correctly.
// You can modify / add more inputs and outputs by yourself.
module motor(
    input clk,
    input rst,
    input [1:0]mode,
    output  [1:0]pwm,
    output [1:0]r_IN,
    output [1:0]l_IN
);

    reg [9:0]next_left_motor, next_right_motor;
    reg [9:0]left_motor, right_motor;
    reg [1:0] r_temp, l_temp;   ////////////////
    wire left_pwm, right_pwm;

    motor_pwm m0(clk, rst, left_motor, left_pwm);
    motor_pwm m1(clk, rst, right_motor, right_pwm);

    assign pwm = {left_pwm,right_pwm};
    assign r_IN = r_temp;
    assign l_IN = l_temp;

    // TODO: trace the rest of motor.v and control the speed and direction of the two motors
    /////////////////////////////////////////////////////////////////////////////////
    always@(posedge clk, posedge rst)begin
      if(rst)begin
        left_motor <= 9d'0;
        right_motor <= 9d'0;
      end else begin
        left_motor <= next_left_motor
        right_motor <= next_right_motor
      end
    end

    always@(*)begin
      case(mode)
        2'b00 : begin
          next_left_motor = 9'd0;
          next_right_motor = 9'd0;
          l_temp = 2'b00;
          r_temp = 2'b00;
        end
        2'b01 : begin
          next_left_motor = 9'd600;          //
          next_right_motor = 9'd300;
          l_temp = 2'b10;                  // 
          r_temp = 2'b10;
        end
        2'b10 : begin
          next_left_motor = 9'd300;
          next_right_motor = 9'd600;       //
          l_temp = 2'b10;
          r_temp = 2'b10;                //
        end
        2'b11 : begin
          next_left_motor = 9'd750;
          next_right_motor = 9'd750;
          l_temp = 2'b10;
          r_temp = 2'b10;
        end
      endcase
    end
    /////////////////////////////////////////////////////////////////////////////////
    
endmodule

module motor_pwm (
    input clk,
    input reset,
    input [9:0]duty,
	output pmod_1 //PWM
);
        
    PWM_gen pwm_0 ( 
        .clk(clk), 
        .reset(reset), 
        .freq(32'd25000),
        .duty(duty), 
        .PWM(pmod_1)
    );

endmodule

//generte PWM by input frequency & duty cycle
module PWM_gen (
    input wire clk,
    input wire reset,
	input [31:0] freq,
    input [9:0] duty,
    output reg PWM
);
    wire [31:0] count_max = 100_000_000 / freq;
    wire [31:0] count_duty = (duty > 0 ? count_max * duty / 1024 : 0);
    reg [31:0] count;
        
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 0;
            PWM <= 0;
        end else if (count < count_max) begin
            count <= count + 1;
            if(count < count_duty)
                PWM <= 1;
            else
                PWM <= 0;
        end else begin
            count <= 0;
            PWM <= 0;
        end
    end
endmodule

