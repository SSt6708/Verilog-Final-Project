module display(clk, jump, down, left, right, resetn, x, y, color, score);

input clk, resetn, jump, down, left, right;

output reg [7:0] x;
output reg [6:0] y;
output reg [11:0] color; 
output reg [3:0] score;



reg[6:0] VGAscore;

reg gameEnd; //check if game end

always@(posedge clk)begin
if(!resetn)begin
gameEnd = 1'b0;
end
else if(count625 || count1250) begin 

if((spaceship_x +19 >= comet_x && spaceship_x + 19 <= comet_x +4 ) && (spaceship_y <= comet_y && spaceship_y + 9 >= comet_y +4)||
	(spaceship_x +19 >= comet_x2 && spaceship_x + 19 <= comet_x2 +4 ) && (spaceship_y <= comet_y2 && spaceship_y + 9 >= comet_y2 +4)||
	(spaceship_x +19 >= comet_x3 && spaceship_x + 19 <= comet_x3 +4 ) && (spaceship_y <= comet_y3 && spaceship_y + 9 >= comet_y3 +4)||
	(spaceship_x +19 >= comet_x4 && spaceship_x + 19 <= comet_x4 +4 ) && (spaceship_y <= comet_y4 && spaceship_y + 9 >= comet_y4 +4)||
	
	(spaceship_x +19 >= comet_x+4 && spaceship_x<= comet_x) && (spaceship_y <= comet_y+4 && spaceship_y >= comet_y)||
	(spaceship_x +19 >= comet_x2+4 && spaceship_x<= comet_x2) && (spaceship_y <= comet_y2+4 && spaceship_y >= comet_y2)||
	(spaceship_x +19 >= comet_x3+4 && spaceship_x<= comet_x3) && (spaceship_y <= comet_y3+4 && spaceship_y >= comet_y3)||
	(spaceship_x +19 >= comet_x4+4 && spaceship_x<= comet_x4 ) && (spaceship_y <= comet_y4+4 && spaceship_y >= comet_y4)||
	
	(spaceship_x +19 >= comet_x+4 && spaceship_x<= comet_x) && (spaceship_y +9 <= comet_y+4 && spaceship_y+9 >= comet_y)||
	(spaceship_x +19 >= comet_x2+4 && spaceship_x<= comet_x2 ) && (spaceship_y +9 <= comet_y2+4 && spaceship_y+9 >= comet_y2)||
	(spaceship_x +19 >= comet_x3+4 && spaceship_x<= comet_x3 ) && (spaceship_y +9 <= comet_y3+4 && spaceship_y+9 >= comet_y3)||
	(spaceship_x +19 >= comet_x4+4 && spaceship_x<= comet_x4 ) && (spaceship_y +9 <= comet_y4+4 && spaceship_y+9 >= comet_y4))
	
	gameEnd = 1'b1; 
end
end
	


//background 
wire [14:0] address_background;
wire [11:0] color_background; 
assign address_background = 160*y + x;

background b1(
	address_background,
	clk,
	color_background);


always@(posedge clk)begin
if(!resetn)begin
offScreenComet1=1'b0;
offScreenComet2=1'b0;
offScreenComet3=1'b0; 
offScreenComet4=1'b0; 
offStar1=1'b0; 
offStar2=1'b0; 
offStar3=1'b0; 
offStar4=1'b0;

end
		if(comet_x == 160)
			offScreenComet1=1'b1;
		else
			offScreenComet1=1'b0;
			
		if(comet_x2 == 160)
			offScreenComet2=1'b1;
		else
			offScreenComet2=1'b0;

		if(comet_x3 == 160)
			offScreenComet3=1'b1;
		else
			offScreenComet3=1'b0;
			
		if(comet_x4 == 160)
			offScreenComet4=1'b1;
		else
			offScreenComet4=1'b0;
			
		if(star1_x == 160)
			offStar1=1'b1;
		else
			offStar1=1'b0;
		
		if(star2_x == 160)
			offStar2=1'b1;
		else
			offStar2=1'b0;
			
		if(star3_x == 160)
			offStar3=1'b1;
		else
			offStar3=1'b0;
		
		if(star4_x == 160)
			offStar4=1'b1;
		else
			offStar4=1'b0;
			
end
//this regulates the clock for the random generator 



// first comet
wire [4:0] address_comet;
wire [11:0] color_comet;
reg [7:0] comet_x;
wire [6:0] comet_y;

//make a clock for the y address

assign address_comet = ( x >= comet_x &&  x <= (comet_x + 4) && y >= comet_y && y <= (comet_y + 4) )? (5 * (y-comet_y) + (x - comet_x) ): 8'b0;

random1 stary1 (offStar1, star1_y);
random2 stary2 (offStar2, star2_y);
random3 stary3 (offStar3, star3_y);
random4 stary4 (offStar4, star4_y);

random3 comety1 (offScreenComet1, comet_y);
random2 comety2 (offScreenComet2, comet_y2);
random4 comety3 (offScreenComet3, comet_y3);
random1 comety4 (offScreenComet4, comet_y4);

comet U1(
	address_comet,
	clk,
	color_comet); 

//second comet
wire [4:0] address_comet2;
wire [11:0] color_comet2;
reg [7:0] comet_x2;
wire [6:0] comet_y2;
//assign comet_y2 = 7'b0110010; 
assign address_comet2 = ( x >= comet_x2 &&  x <= (comet_x2 + 4) && y >= comet_y2 && y <= (comet_y2 + 4) )? (5 * (y-comet_y2) + (x - comet_x2) ): 8'b0;


comet U2(
	address_comet2,
	clk,
	color_comet2); 
	
	

	//third comet
wire [4:0] address_comet3;
wire [11:0] color_comet3;
reg [7:0] comet_x3;
wire [6:0] comet_y3;
//assign comet_y3 = 7'b0001010; 
assign address_comet3 = ( x >= comet_x3 &&  x <= (comet_x3 + 4) && y >= comet_y3 && y <= (comet_y3 + 4) )? (5 * (y-comet_y3) + (x - comet_x3) ): 8'b0;


comet U3(
	address_comet3,
	clk,
	color_comet3); 
	
		//fourth comet
wire [4:0] address_comet4;
wire [11:0] color_comet4;
reg [7:0] comet_x4;
wire [6:0] comet_y4;
//assign comet_y4 = 7'b0010010; 
assign address_comet4 = ( x >= comet_x4 &&  x <= (comet_x4 + 4) && y >= comet_y4 && y <= (comet_y4 + 4) )? (5 * (y-comet_y4) + (x - comet_x4) ): 8'b0;


comet U4(
	address_comet4,
	clk,
	color_comet4); 
	
	

//make star 1 
wire [4:0] address_star;
wire [11:0] color_star1;
reg[7:0] star1_x;
wire[6:0] star1_y;

//assign star1_y = 7'b0111100;
assign address_star = ( x >= star1_x &&  x <= (star1_x + 4) && y >= star1_y && y <= (star1_y + 4) )? (5 * (y-star1_y) + (x - star1_x) ): 8'b0;


star1 S1(
address_star,
clk,
color_star1);



//make star 2
wire [4:0] address_star2;
wire [11:0] color_star2;
reg[7:0] star2_x;
wire[6:0] star2_y;

//assign star2_y = 7'b1001100;
assign address_star2 = ( x >= star2_x &&  x <= (star2_x + 4) && y >= star2_y && y <= (star2_y + 4) )? (5 * (y-star2_y) + (x - star2_x) ): 8'b0;


star1 S2(
address_star2,
clk,
color_star2);



//make star 3
wire [4:0] address_star3;
wire [11:0] color_star3;
reg[7:0] star3_x;
wire[6:0] star3_y;

//assign star3_y = 7'b0001100;
assign address_star3 = ( x >= star3_x &&  x <= (star3_x + 4) && y >= star3_y && y <= (star3_y + 4) )? (5 * (y-star3_y) + (x - star3_x) ): 8'b0;

star1 S3(
address_star3,
clk,
color_star3);




//make star 4
wire [4:0] address_star4;
wire [11:0] color_star4;
reg[7:0] star4_x;
wire[6:0] star4_y;

//assign star4_y = 7'b1111101;
assign address_star4 = ( x >= star4_x &&  x <= (star4_x + 4) && y >= star4_y && y <= (star4_y + 4) )? (5 * (y-star4_y) + (x - star4_x) ): 8'b0;


star1 S4(
address_star4,
clk,
color_star4);

//make a space ship!!!  

//wire [4:0] address_star;
//wire [8:0] color_star1;
wire [7:0] address_spaceship;
reg[7:0] spaceship_x;
reg[6:0] spaceship_y; 
reg eat1;
reg eat2;
reg eat3;
reg eat4;
wire [11:0] color_spaceship;


spaceship S5(
	address_spaceship,
	clk,
	color_spaceship);

assign address_spaceship = (  x >= spaceship_x &&  x <= (spaceship_x + 19) && y >= spaceship_y && y <= (spaceship_y + 9) )? (20 * (y-spaceship_y) + (x - spaceship_x) ): 8'b0;




	 



always@(posedge clk) begin 
	if(!resetn) begin
	x <= 8'b0;
	y <= 7'b0;
	
	end else begin
	if(x == 8'b10011111) begin
		x <= 8'b0;
		if(y == 7'b1110111)
			y <= 7'b0;
		else
			y <= y + 1;
		end
		else x <= x + 1; 
	end 
end 


always@(posedge clk)begin
if(!resetn)begin
spaceship_y = 7'b0111100;
spaceship_x = 8'b00001010; 
score = 4'b0;
eat1 = 1'b0;
VGAscore = 7'b0;
end

else if((count625) && !gameEnd) begin

if(star1_x <= 0)
eat1 = 1'b0;
if(((spaceship_x +19 >= star1_x && spaceship_x + 19 <= star1_x +4 ) && (spaceship_y <= star1_y && spaceship_y + 9 >= star1_y +4) ||
	 (spaceship_x <= star1_x && spaceship_x + 19 >= star1_x +4 ) && (spaceship_y >= star1_y && spaceship_y  <= star1_y +4) ||
	 (spaceship_x <= star1_x && spaceship_x + 19 >= star1_x +4  ) && (spaceship_y +9 >= star1_y && spaceship_y+9  <= star1_y +4))
	  && eat1 != 1'b1)begin
	score = score + 1;
	VGAscore = VGAscore +1;
	eat1 = 1'b1;
	end
	
if(star2_x <= 0)
eat2 = 1'b0;
if(((spaceship_x +19 >= star2_x && spaceship_x + 19 <= star2_x +4 ) && (spaceship_y <= star2_y && spaceship_y + 9 >= star2_y +4) ||
	 (spaceship_x <= star2_x && spaceship_x + 19 >= star2_x +4 ) && (spaceship_y >= star2_y && spaceship_y  <= star2_y +4) ||
	 (spaceship_x <= star2_x && spaceship_x + 19 >= star2_x +4  ) && (spaceship_y +9 >= star2_y && spaceship_y+9  <= star2_y +4))
	  && eat2 != 1'b1)begin
	score = score + 1;
	VGAscore = VGAscore +1;
	eat2 = 1'b1;
	end
	
if(star3_x <= 0)
eat3 = 1'b0;
if(((spaceship_x +19 >= star3_x && spaceship_x + 19 <= star3_x +4 ) && (spaceship_y <= star3_y && spaceship_y + 9 >= star3_y +4) ||
	 (spaceship_x <= star3_x && spaceship_x + 19 >= star3_x +4 ) && (spaceship_y >= star3_y && spaceship_y  <= star3_y +4) ||
	 (spaceship_x <= star3_x && spaceship_x + 19 >= star3_x +4  ) && (spaceship_y +9 >= star3_y && spaceship_y+9  <= star3_y +4))
	  && eat3 != 1'b1)begin
	score = score + 1;
	VGAscore = VGAscore +1;
	eat3 = 1'b1;
	end
	
if(star4_x <= 0)
eat4 = 1'b0;
if(((spaceship_x +19 >= star4_x && spaceship_x + 19 <= star4_x +4 ) && (spaceship_y <= star4_y && spaceship_y + 9 >= star4_y +4) ||
	 (spaceship_x <= star4_x && spaceship_x + 19 >= star4_x +4 ) && (spaceship_y >= star4_y && spaceship_y  <= star4_y +4) ||
	 (spaceship_x <= star4_x && spaceship_x + 19 >= star4_x +4  ) && (spaceship_y +9 >= star4_y && spaceship_y+9  <= star4_y +4))
	  && eat4 != 1'b1)begin
	score = score + 1;
	VGAscore = VGAscore +1;
	eat4 = 1'b1;
	end
	
	else begin
	VGAscore = VGAscore;
	score = score;
	end



if(jump)begin
spaceship_y = spaceship_y - 2;
spaceship_x = spaceship_x; 

//if((spaceship_x +19 >= star1_x && spaceship_x + 19 <= star1_x +4 ) && (spaceship_y <= star1_y && spaceship_y + 14 >= star1_y +4))
//	score = score + 1;
//	else
//	score = score;

end
else if(down)begin
spaceship_y = spaceship_y + 2;
spaceship_x = spaceship_x;

//if((spaceship_x +19 >= star1_x && spaceship_x + 19 <= star1_x +4 ) && (spaceship_y <= star1_y && spaceship_y + 14 >= star1_y +4))
//	score = score + 1;
//	else
//	score = score;
end

else if(left)begin
spaceship_y = spaceship_y;
spaceship_x = spaceship_x-2;

//if((spaceship_x +19 >= star1_x && spaceship_x + 19 <= star1_x +4 ) && (spaceship_y <= star1_y && spaceship_y + 14 >= star1_y +4))
//	score = score + 1;
//	else
//	score = score;
end

else if(right)begin
spaceship_y = spaceship_y;
spaceship_x = spaceship_x+2;

//if((spaceship_x +19 >= star1_x && spaceship_x + 19 <= star1_x +4 ) && (spaceship_y <= star1_y && spaceship_y + 14 >= star1_y +4))
//	score = score + 1;
//	else
//	score = score;
end


else begin
spaceship_y = spaceship_y;
spaceship_x = spaceship_x;

//if((spaceship_x +19 >= star1_x && spaceship_x + 19 <= star1_x +4 ) && (spaceship_y <= star1_y && spaceship_y + 14 >= star1_y +4))
//	score = score + 1;
//	else
//	score = score;
end
end

end

reg offScreenComet1, offScreenComet2, offScreenComet3, offScreenComet4, offStar1, offStar2, offStar3, offStar4; 

always@(posedge clk) begin 
if(!resetn)begin
comet_x = 8'b10000000;//128
comet_x2 = 8'b10001100;//140
comet_x3= 8'b11011101;//221
comet_x4= 8'b11110011;//243
star1_x = 8'b10101010;//170
star2_x= 8'b10100010;//162
star3_x= 8'b10010110;//150
star4_x= 8'b10001110; //142

end
else if ((count625 || count312 ) && !gameEnd)begin

if(count312) begin
comet_x = comet_x -2;
comet_x2 = comet_x2 -2;
comet_x3 = comet_x3 -2;
comet_x4 = comet_x4-2;

end

if(count625)begin
star3_x = star3_x - 1;
star4_x = star4_x - 2;

star1_x = star1_x - 2;
star2_x = star2_x - 2;
end


end
end





//always@(*)begin
//assign color = ( x >= comet_x &&  x <= (comet_x + 4) && y >= comet_y && y <= (comet_y + 4) )? color_comet : 9'b101001101;
//end 

reg[6:0] minus;

always@(*) begin

if(VGAscore < 10)
	minus = 0;
else if(VGAscore <20)
	minus = 10;
else if(VGAscore <30)
	minus = 20;
else if(VGAscore < 40)
	minus = 30;
	
end
	
	
	
	

	



always@(*) begin 

if(!gameEnd) begin

if( x>= 130 && x <= 159 && y >= 0 && y <= 14 )begin 

if( x >= 130 && x <= 144)begin // evaluate the left digit

if( x >= 130 && x <= 144 && y >= 0 && y <= 14 && VGAscore < 10)begin
color = color_0;
end 
else if(x >= 130 && x <= 144 && y >= 0 && y <= 14 && VGAscore < 20)begin
color = color_1;
end 
else
color = color_2;
end

if( x >= 145 && x <= 159)begin

if( x >= 145 && x <= 159 && y >= 0 && y <= 14 )begin // evaluate the right digit
if(VGAscore - minus == 0)
color = color_0;
else if(VGAscore - minus == 1)
color = color_1;
else if(VGAscore - minus == 2)
color = color_2;
else if(VGAscore -minus == 3)
color = color_3;
else if(VGAscore -minus == 4)
color = color_4;
else if(VGAscore -minus == 5)
color = color_5;
else if(VGAscore -minus == 6)
color = color_6;
else if(VGAscore -minus == 7)
color = color_7;
else if(VGAscore -minus == 8)
color = color_8;
else if(VGAscore -minus == 9)
color = color_9;
end 

end

end


// new VGA score stuff ends here!

else if( x >= comet_x2 &&  x <= (comet_x2 + 4) && y >= comet_y2 && y <= (comet_y2 + 4) )begin 

color = color_comet2;//comet 2
end
else if( x >= comet_x3 &&  x <= (comet_x3 + 4) && y >= comet_y3 && y <= (comet_y3 + 4) )begin 

color = color_comet3; //comet3
end
else if( x >= comet_x4 &&  x <= (comet_x4 + 4) && y >= comet_y4 && y <= (comet_y4 + 4) )begin 

color = color_comet4; //comet 4
end

else if( x >= comet_x &&  x <= (comet_x + 4) && y >= comet_y && y <= (comet_y + 4) ) begin

color = color_comet; //comet
end

else if( x >= spaceship_x &&  x <= (spaceship_x + 19) && y >= spaceship_y && y <= (spaceship_y + 9) )begin
if(color_spaceship != 12'b0) // erase the black part of the sprite
color = color_spaceship;
else
color = color_background; //spaceship
end

else if ( x >= star1_x &&  x <= (star1_x + 4) && y >= star1_y && y <= (star1_y + 4))begin
	if(eat1 == 1'b0)
	color = color_star1;// star1
	else 
	color = color_background;
end

else if ( x >= star2_x &&  x <= (star2_x + 4) && y >= star2_y && y <= (star2_y + 4))begin
	if(eat2 == 1'b0)
	color = color_star2;// star2
	else 
	color = color_background;
end

else if ( x >= star3_x &&  x <= (star3_x + 4) && y >= star3_y && y <= (star3_y + 4))begin
	if(eat3 == 1'b0)
	color = color_star3;// star3
	else 
	color = color_background;
end

else if ( x >= star4_x &&  x <= (star4_x + 4) && y >= star4_y && y <= (star4_y + 4))begin
	if(eat4 == 1'b0)
	color = color_star4;// star3
	else 
	color = color_background;
end


else begin

color = color_background; // background

end
end 


else begin

if ( (x >= 69 && x<= 89 && y >= 20 && y <= 100) || (x>=49 && x <= 109 && y >= 40 && y<= 60))
	color = 12'b111111111111;
	else
	color = 12'b000000000000;
 end
end


wire count1250;
wire count625;
wire count312;

rateDivider r1( clk, resetn, 24'b101111101011110000011111, count1250);
rateDivider r2( clk, resetn, 24'b010111110101111000001111, count625);
rateDivider r3( clk, resetn, 24'b001011111010111100000111, count312);

	
	 
	 
	 
	  
	 
// trying to make VGA score keeper here // 
//making numbers 0 -9 from the mifs	 
	 
//making number 0
reg [7:0] address_0;
wire [11:0] color_0;

always@(posedge clk)begin
if ( x>= 130 && x <= 144 && y >= 0 && y <= 14)
address_0 = (15 * (y) + (x-130));
else if(x>= 145 && x <= 159 && y >= 0 && y <= 14)
address_0 = (15 * (y) + (x-145));
else
address_0 = 8'b0;
end

number0 n0(
	address_0,
	clk,
	color_0);



//making number 1
reg [7:0] address_1;
wire [11:0] color_1;

always@(posedge clk)begin
if ( x>= 130 && x <= 144 && y >= 0 && y <= 14)
address_1 = (15 * (y) + (x-130));
else if(x>= 145 && x <= 159 && y >= 0 && y <= 14)
address_1 = (15 * (y) + (x-145));
else
address_1 = 8'b0;
end

number1 n1(
	address_1,
	clk,
	color_1);



//making number 2
reg [7:0] address_2;
wire [11:0] color_2;

always@(posedge clk)begin
if ( x>= 130 && x <= 144 && y >= 0 && y <= 14)
address_2 = (15 * (y) + (x-130));
else if(x>= 145 && x <= 159 && y >= 0 && y <= 14)
address_2 = (15 * (y) + (x-145));
else
address_2 = 8'b0;
end

number2 n2(
	address_2,
	clk,
	color_2);



//making number 3
reg [7:0] address_3;
wire [11:0] color_3;

always@(posedge clk)begin
if ( x>= 130 && x <= 144 && y >= 0 && y <= 14)
address_3 = (15 * (y) + (x-130));
else if(x>= 145 && x <= 159 && y >= 0 && y <= 14)
address_3 = (15 * (y) + (x-145));
else
address_3 = 8'b0;
end
number3 n3(
	address_3,
	clk,
	color_3);



//making number 4
wire [7:0] address_4;
wire [11:0] color_4;
assign address_4 = ( x>= 145 && x <= 159 && y >= 0 && y <= 14)? (15 * (y) + (x-145)): 8'b0;
number4 n4(
	address_4,
	clk,
	color_4);


//making number 5
wire [7:0] address_5;
wire [11:0] color_5;

assign address_5 = ( x>= 145 && x <= 159 && y >= 0 && y <= 14)? (15 * (y) + (x-145)): 8'b0;

number5 n5(
	address_5,
	clk,
	color_5);



//making number 6
wire [7:0] address_6;
wire [11:0] color_6;

assign address_6 = ( x>= 145 && x <= 159 && y >= 0 && y <= 14)? (15 * (y) + (x-145)): 8'b0;
number6 n6(
	address_6,
	clk,
	color_6);

//making number 7
wire [7:0] address_7;
wire [11:0] color_7;

assign address_7 = ( x>= 145 && x <= 159 && y >= 0 && y <= 14)? (15 * (y) + (x-145)): 8'b0;

number7 n7(
	address_7,
	clk,
	color_7);

//making number 8
wire [7:0] address_8;
wire [11:0] color_8;

assign address_8 = ( x>= 145 && x <= 159 && y >= 0 && y <= 14)? (15 * (y) + (x-145)): 8'b0;

number8 n8(
	address_8,
	clk,
	color_8);

//making number 9
wire [7:0] address_9;
wire [11:0] color_9;
	 
assign address_9 = ( x>= 145 && x <= 159 && y >= 0 && y <= 14)? (15 * (y) + (x-145)): 8'b0;

number9 n9(
	address_9,
	clk,
	color_9);
	 
	 
endmodule

module random1(clk, y); 
    input clk; 
    output reg [6:0] y; 
     
  
 
    reg [0:3] foo = 4'b1111; 
  
 
   always @ ( posedge clk ) 
      foo <= {foo[3]^foo[2], foo[0:2]}; 
 
    always begin 
      case (foo) 
        9 : y<= 7'b1100100; //100
        10 : y<= 7'b1101110; //110
        11 : y<= 7'b1110000; 
        12 : y<= 7'b1100010; //98
        14 : y<= 7'b1010111; //87
        15 : y<= 7'b0110111; //55
        13 : y<= 7'b0001100; //12
        0 : y<= 7'b0100000; //32
        1 : y<= 7'b1100001; //97
        2 : y<= 7'b0011110; 
        3 : y<= 7'b1100100; //100
        4 : y<= 7'b1101110; //110
        5 : y<= 7'b1110011; //115
        6 : y<= 7'b0011001; //25
        7 : y<= 7'b0001111; //15
        8 : y<= 7'b1000001; //65
      endcase 
    end 
  endmodule 
  
 
module random2(clk, y); 
    input clk; 
    output reg [6:0] y;
     
  
 
    reg [0:3] foo = 4'b1111; 
  
 
   always @ ( posedge clk ) 
      foo <= {foo[3]^foo[2], foo[0:2]}; 
 
    always begin 
      case (foo) 
        0 : y<= 7'b0001110; 
        1 : y<= 7'b0010100; 
        2 : y<= 7'b0011110; 
        3 : y<= 7'b0101010; 
        4 : y<= 7'b0111100; 
        5 : y<= 7'b1000110; 
        6 : y<= 7'b1001000; 
        7 : y<= 7'b1010000; 
        8 : y<= 7'b1011010; 
        9 : y<= 7'b0000100; 
        10 : y<= 7'b1100100; 
        11 : y<= 7'b1101110; 
        12 : y<= 7'b1100011; 
        13 : y<= 7'b0011001; 
        14 : y<= 7'b0001111; 
        15 : y<= 7'b1001001; 
      endcase 
    end 
  endmodule 
  
 

module random3(clk, y); 
    input clk; 
    output reg [6:0] y;
     
  
 
    reg [0:3] foo = 4'b1111; 
  
 
   always @ ( posedge clk ) 
      foo <= {foo[3]^foo[2], foo[0:2]}; 
 
    always begin 
      case (foo) 
        3 : y<= 7'b0001111; 
        4 : y<= 7'b0010100; 
        5 : y<= 7'b0011110; 
        6 : y<= 7'b0101001; 
        7 : y<= 7'b0111100; 
        8 : y<= 7'b1000110; 
        9 : y<= 7'b1001000; 
        10 : y<= 7'b1010010; 
        11 : y<= 7'b1011010; 
        12 : y<= 7'b0000110; 
        13 : y<= 7'b1101100; 
        14 : y<= 7'b1101110; 
        15 : y<= 7'b1010011; 
        0 : y<= 7'b0011001; 
        1 : y<= 7'b0001111; 
        2 : y<= 7'b1000001; 
      endcase 
    end 
 
  endmodule 
  
 



module random4(clk, y);
    input clk; 
    output reg [6:0] y;
     
  
 
    reg [0:3] foo = 4'b1111; 
  
 
   always @ ( posedge clk ) 
      foo <= {foo[3]^foo[2], foo[0:2]}; 
 
    always begin 
      case (foo) 
        7 : y<= 7'b0001011; 
        8 : y<= 7'b0101100; 
        9 : y<= 7'b0011110; 
        10 : y<= 7'b0101000; 
        11: y<= 7'b0111100; 
        12: y<= 7'b1000110; 
        13 : y<= 7'b1001000; 
        14 : y<= 7'b1011000; 
        15 : y<= 7'b1011010; 
        0 : y<= 7'b0010111; 
        1 : y<= 7'b1100100; 
        2 : y<= 7'b1101100; 
        3 : y<= 7'b1010111; 
        4 : y<= 7'b0011001; 
        5 : y<= 7'b0001111; 
        6 : y<= 7'b1001001; 
      endcase 
    end 
  endmodule 
  
  
  module rateDivider( clk, resetn, rate, counter);
 
	output reg counter;
	input clk;
	input [23:0] rate;
	input resetn;
	
	reg [23:0]count;
	
	always @(posedge clk)
	 begin : Rate_Divider
			if (!resetn)begin
				count = rate; //12.5Mhz
				counter = 1'b0;
			end
			else begin
				if (count == 24'd0)begin
					count = rate;
					counter = 1'b1;
				end
				else if (count)begin
					count = count - 24'b1;
					counter = 1'b0;
				end
			end
	 end

	 endmodule
 
  
  

