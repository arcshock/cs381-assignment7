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

int jump; // number of time the jump button has been pressed

void setup()
{
	xPos = 0;
	yPos = 0;
	jump = 0;
	
	size(700, 700, P3D);
	frameRate(30);
	flakes = new PVector[c];
	/*for (int i = 0; i < height; ++i) {
		flakes[i] = new PVector(random(width), 0);
	}*/

	/*PFont fontA = loadFont("times new roman");  //Because everything is better with a serif!
	textFont(fontA, 14);*/
	stroke(255);
	println("Hello ErrorLog!");
}

// Most recent key press is stored in key
void keyPressed()
{
	switch(key){
	case 'b':	//changes the background colour
	case 'B': 
		background(125);
		break;
	case ' ':
		++jump;
	default:
		break;
	}
}

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
        pushMatrix();
                rotateX(radians(-15));
        	drawCylinder(100, 30, 30, 2); //brim
                rotateX(radians(0));
	popMatrix();
        translate(0, 40, 0);
	drawCylinder(100, 10, 10, 20); //top
        fill(153);
	drawCylinder(100, 10, 10, 4); //top
        
}

void drawHead()
{
	sphere(29.0);
	pushMatrix();
		translate(0, -30, 0);
		rotateX(radians(90));
                fill(0);
		drawTophat();
	popMatrix();
}

void drawArm()
{
        stroke(126);
        line(0,0,0, 4,2,0);
        stroke(126);
        line(4,2,0, 4,4,0);
        stroke(126);
        line(4,4,0, 5,5,0);
        stroke(126);
        line(4,4,0, 4,5,0);
        stroke(126);
        line(4,4,0, 3,5,0);
        stroke(126);

}
// Draws a snowperson based on hierarchical objects
void drawSnowPerson()
{
	// Drawing bottom
	noStroke();
	lights();
	sphere(50.0);
	
	// Drawing middle
	pushMatrix();
		translate(0, -60, 0); //HATE THIS!
		sphere(39.0);
                pushMatrix();
                        scale(25);
                        rotateX(radians(180));
                        drawArm();
                popMatrix();
                noStroke();
                fill(255);             
		translate(0, -55, 0);
                //rotateX(radians(90));
		drawHead();
	popMatrix();
}

void draw()
{       
	if (jump) {
	//	--jump;
	// make that silly, obese snowman jump!
	}
        pushMatrix();
                scale(30);
	        drawArm();
        popMatrix();
	translate(width/2, height/2, 0);
        fill(255);
	drawSnowPerson();
	
	
	stroke(255);
	//text("Hello World!", 20, 2);
	//println(jump);

}
