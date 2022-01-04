module tracker_sensor(clk, reset, left_track, right_track, mid_track, state);
    input clk;
    input reset;
    input left_track, right_track, mid_track;
    output reg [1:0] state;

    always@(posedge clk, posedge reset) begin // 1 = white, 0 = black
        if(reset) begin
            state <= 2'b00; // stop
        end else begin
            if(left_track == 1 && mid_track == 0 && right_track == 1) begin
                state <= 2'b11; // forward
            end else if(left_track == 1 && mid_track == 1 && right_track == 0) begin
                state <= 2'b01; // left
            end else if(left_track == 1 && mid_track == 0 && right_track == 0) begin
                state <= 2'b01; // left
            end else if(left_track == 0 && mid_track == 1 && right_track == 1) begin
                state <= 2'b10; // right
            end else if(left_track == 0 && mid_track == 0 && right_track == 1) begin
                state <= 2'b10; // right
            end else if(left_track == 0 && mid_track == 0 && right_track == 0) begin
                state <= 2'b10; // right
            end else if(left_track == 1 && mid_track == 1 && right_track == 1) begin
                state <= 2'b11; // forward
            end else begin
                state <= 2'b00;  // stop
            end
        end
    end


endmodule
