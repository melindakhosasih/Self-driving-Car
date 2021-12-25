module tracker_sensor(clk, reset, left_track, right_track, mid_track, state);
    input clk;
    input reset;
    input left_track, right_track, mid_track;
    output reg [1:0] state;

    always@(posedge clk, posedge reset)begin
      if(reset)begin
        state <= 2'b00;
      end else begin
        if(left_track == 0 && mid_track == 1 && right_track == 0)begin
          state <= 2'b11;
        end else if(left_track == 1 && mid_track == 1 && right_track == 0)begin
          state <= 2'b10;
        end else if(left_track == 1 && mid_track == 0 && right_track == 0)begin
          state <= 2'b10;
        end else if(left_track == 0 && mid_track == 1 && right_track == 1)begin
          state <= 2'b01;
        end else if(left_track == 0 && mid_track == 0 && right_track == 1)begin
          state <= 2'b01;
        end else begin
          state <= 2'b00;
        end
      end
    end
    // TODO: Receive three tracks and make your own policy.
    // Hint: You can use output state to change your action.

endmodule
