/*
Authors:
    Paul Gentemann
    Bucky Frost
CS 381 Assignment 7
File: coolstuff.pde
Purpose: Generate web graphics! 

Sources:
Cylinder: http://vormplus.be/blog/article/drawing-a-cylinder-with-processing
snow flakes: http://www.local-guru.net/blog/pages/advent11# */

/*Globals*/
PVector[] flakes;
int c = 40;

int xPos;
int yPos;

void setup()
{
	size(700,200, P3D);
	frameRate(30);
	flakes = new PVector[c];
	/*for (int i = 0; i < height; ++i) {
		flakes[i] = new PVector(random(width), 0);
	}*/
//	directionalLight(51, 102, 126, -5, 2, 0); //r, g, b, x, y, z
	
/*	background(125);
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
		switch(key){
		case 'b':		//changes the background colour
		case 'B': 
			background(125);
			break;
		default:
			background(0);
			break;
		}
	}

/*	if (keyPressed) {
		if (key == 'b' || key == 'B') {
			background(125);
		}else{
			background(0);
		}
	}*/
}

/*
mouseDragged()
{
	xPos = mouseX;
	yPos = mouseY;
}
*/


/** Draws a cylinder with the number of sides and 
    radii for top and bottom
    Borrowed some from http://vormplus.be/blog/article/drawing-a-cylinder-with-processing */
void drawCylinder(int sides, float top, float bottom, float h)
{
	float angle = 360 / sides;
	float halfHeight = h / 2;
	
	// top
	beginShape();
	for (int i = 0; i < sides; ++i) {
		float x = cos( radians( i * angle ) ) * top;
		float y = sin( radians( i * angle ) ) * top;
		vertex( x, y, -halfHeight);
	}
	endShape(CLOSE);
	
	// bottom
	beginShape();
	for (int i = 0; i < sides; ++i) {
		float x = cos( radians( i * angle ) ) * bottom;
		float y = sin( radians( i * angle ) ) * bottom;
		vertex( x, y, halfHeight);
	}
	endShape(CLOSE);
	
	// draw body
	beginShape(TRIANGLE_STRIP);
	for (int i = 0; i < sides + 1; ++i) {
		float x1 = cos( radians( i * angle ) ) * top;
		float y1 = sin( radians( i * angle ) ) * top;
		float x2 = cos( radians( i * angle ) ) * bottom;
		float y2 = sin( radians( i * angle ) ) * bottom;
		vertex( x1, y1, -halfHeight);
		vertex( x2, y2, halfHeight);
	}
	endShape(CLOSE);
}

void drawTophat()
{
	drawCylinder(100, 25, 25, 20);
	drawCylinder(100, 50, 50, 5);
}

// Draws a snowperson based on hierarchical objects
void drawSnowPerson()
{
	// Drawing bottom
	noStroke();
	lights();
	pushMatrix();
	translate(width/2, height/2, 0.0);
	sphere(50.0);
	popMatrix();
	
	// Drawing middle
	pushMatrix();
	translate(width/2, (height/2-50), 0.0);
	sphere(39.0);
	popMatrix();
	
	// Drawing head
	pushMatrix();
	translate(width/2, (height/2-90), 0.0);
	sphere(29.0);
	rotateX(radians(90));
	translate(0.0,20, 0);
	drawTophat();
	popMatrix();
}

void draw()
{       
	/*pushMatrix();
		resetMatrix();
		rotateX(radians(90));
		translate(width/4, -100,0);
		drawTophat();
	popMatrix();*/

	// Handle any key presses
	keyboard();
	
	//draws a line from a fixed point to the mouse pos
	//line(150, 25, mouseX, mouseY);
	
	/*lights();
	noStroke();
	drawCylinder(8, 20, 20, 80);*/
	
	translate(0,40,0);
	drawSnowPerson();
	
	
	stroke(255);
	//text("Hello World!", 20, 2);
	//rprintln("Hello ErrorLog!");	
}
