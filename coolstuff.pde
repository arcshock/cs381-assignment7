/*
Authors:
    Paul Gentemann
    Bucky Frost
CS 381 Assignment 7
File: coolstuff.pde
Purpose: Generate web graphics! 

Sources:
Cylinder: http://vormplus.be/blog/article/drawing-a-cylinder-with-processing
snow flakes: http://www.local-guru.net/blog/pages/advent11#
             http://solemone.de/demos/snow-effect-processing/ */
/*Globals*/
int jump; // number of time the jump button has been pressed
int jumpHeight;
bool snow; // Controls snow!
int quantity = 100;
float [] xPosition = new float[quantity];
float [] yPosition = new float[quantity];
int [] flakeSize = new int[quantity];
int [] direction = new int[quantity];
int minFlakeSize = 1;
int maxFlakeSize = 5;

void setup()
{
	jump = 0;
        jumpHeight = 0;
	snow = false;
	size(700, 300, P3D);

	frameRate(30);

        for(int i = 0; i < quantity; i++) {
                flakeSize[i] = round(random(minFlakeSize, maxFlakeSize));
                xPosition[i] = random(0, width);
                yPosition[i] = random(0, height);
                direction[i] = round(random(0, 1));
        }

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
        case 's':       //to snow, or not to snow!
        case 'S':
                snow = !snow               
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

void drawSquare()
{
        rect(0,0,1,1);
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
        translate(0, 0, -1);
	drawCylinder(100, 10, 10, 4); //top
        
}

void drawHead()
{
        // head
	sphere(29.0);

        // draw the snowman's left eye
        pushMatrix();
                translate(5,-10,29);
                scale(13);
                fill(0);
                drawSquare();               
        popMatrix();

        // draw the snowman's right eye
        pushMatrix();
                translate(-16,-10,29);
                scale(13);
                fill(0);
                drawSquare();
        popMatrix();                
       
        // draw the tophat, such a classy gent!
	pushMatrix();
		translate(0, -30, 0);
		rotateX(radians(90));
//              fill(0);
        //        lights();
		drawTophat();
	popMatrix();

        // give that snowman a nose!
                fill(0xFF7F00); //make orange
        pushMatrix();
                translate(0,10,29);
                drawCylinder(50, 0, 4, 7);
        popMatrix();
}

void drawArm()
{
        stroke(126);
        line(0,0,0, 4,2,0);
        line(4,2,0, 4,4,0);
        line(4,4,0, 5,5,0);
        line(4,4,0, 4,5,0);
        line(4,4,0, 3,5,0);
        noStroke();
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
                        scale(15);
                        rotateX(radians(180));
                        drawArm();
                        rotateY(radians(180));
                        drawArm();
                popMatrix();
                noStroke();
                fill(255);             
		translate(0, -55, 0);
                //rotateX(radians(90));
		drawHead();
	popMatrix();
}

// Snow
void drawSnow()
{
        background(17);
        noStroke();
        smooth();
        fill(255);

        for(int i = 0; i < xPosition.length; i++) {
                ellipse(xPosition[i], yPosition[i], flakeSize[i], flakeSize[i]);
    
                if(direction[i] == 0) {
                        xPosition[i] += map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
                } else {
                        xPosition[i] -= map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
                }
    
                yPosition[i] += flakeSize[i] + direction[i]; 
    
                if(xPosition[i] > width + flakeSize[i] || 
                   xPosition[i] < -flakeSize[i] || 
                   yPosition[i] > height + flakeSize[i]) {
                        xPosition[i] = random(0, width);
                        yPosition[i] = -flakeSize[i];
                }
    
        }
}
void draw()
{      
        if (snow) {
                drawSnow();
        } else {
                background(17);
        }

	if (jump) {
	//	--jump;
	// make that silly, obese snowman jump!
	}

        pushMatrix();
        popMatrix();
	
        translate(width/2, (height - 55), 0);
        fill(255);
	drawSnowPerson();
	
	//text("Hello World!", 20, 2);
	//println(jump);
}
