/*
Authors:
    Paul Gentemann
    Bucky Frost
CS 381 Assignment 7
File: coolstuff.pde
Purpose: Generate web graphics! */

void setup()
{
	size(700,200, P3D);
	directionalLight(51, 102, 126, -5, 2, 0); //r, g, b, x, y, z
	
/*/	background(125);
	background(192, 64, 0);
	noStroke();
	
	translate(20, 50, 0);
	sphere(30);
	fill(255);
	noLoop();
	PFont fontA = loadFont("times new roman");  //Because everything is better with a serif!
	textFont(fontA, 14);
	stroke(255);*/
	stroke(255);
}

// most recent key press is stored in key
void keyboard()
{
	if (keyPressed) {
		if (key == 'b' || key == 'B') {
			background(125);
		}else{
			background(0);
		}
	}
}

void draw()
{       
	keyboard();
	line(150, 25, mouseX, mouseY);
	
	// Drawing the main body
	noStroke();
	lights();
	translate(width/2, height/2, 0.0); //x, y, z
	sphere(50.0);
	
	stroke(255);
/*	text("Hello World!", 20, 2);
	println("Hello ErrorLog!");
	println("More to the error?");
	println("Sweet");*/
}
