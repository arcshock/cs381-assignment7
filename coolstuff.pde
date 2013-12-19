/*
 *Authors:
 *   Paul Gentemann
 *   Bucky Frost
 *CS 381 Assignment 7
 *File: coolstuff.pde
 *Purpose: Generate web graphics! 
 *
 *Sources
 *Cylinder: http://vormplus.be/blog/article/drawing-a-cylinder-with-processing
 *snow flakes: http://www.local-guru.net/blog/pages/advent11#
 *             http://solemone.de/demos/snow-effect-processing/ 
 */

/*Globals*/
int jump; // number of time the jump button has been pressed
float jumpHeight;
bool jumping;
bool handleJump;
final float JUMP_STEP = 5.8; // how much to increment jump
final float JUMP_MAX = 20.0; // max height of jump

bool rotMid; // rotate the middle
final float ROT_ANG_SPD = 30;

bool snow; // Controls snow!
int quantity = 100;
float [] xPosition = new float[quantity];
float [] yPosition = new float[quantity];
int [] flakeSize = new int[quantity];
int [] direction = new int[quantity];
int minFlakeSize = 1;
int maxFlakeSize = 5;

// Init function
void setup()
{
        // init jump related vars
	jump = 0;
        jumpHeight = 0;
        handleJump = false;
        jumping = false;

        // init rotating related vars
        rotMid = false;
        rotMidValue = 0.0;

        // init snow related var(s)
	snow = false;

	size(700, 300, P3D);
	frameRate(30);

        // init for snowing
        for(int i = 0; i < quantity; i++) {
                flakeSize[i] = round(random(minFlakeSize, maxFlakeSize));
                xPosition[i] = random(0, width);
                yPosition[i] = random(0, height);
                direction[i] = round(random(0, 1));
        }
}

// keyPressed
// controls background color,
//          jumping,
//          rotating,
//          snowing
void keyPressed()
{
	switch(key){
	case 'b':	// Changes the background colour.
	case 'B': 
		background(125);
		break;
	case ' ':
		++jump;
                break;
        case 'm':       // silly dance! Just rotate
        case 'M':
                rotMid = !rotMid;
                break;
        case 's':       // To snow, or not to snow!
        case 'S':
                snow = !snow
                break;
	default:
		break;
	}
}

/** Draws a cylinder with the number of sides and 
    radii for top and bottom
    Borrowed from 
    http://vormplus.be/blog/article/drawing-a-cylinder-with-processing */
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

// drawSquare
// Draws a square at the top left of screen
void drawSquare()
{
        rect(0,0,1,1);
}

// drawTophat
// Draws a tophat with a red ribbon
void drawTophat()
{
        rotateY(radians(-15));
        drawCylinder(100, 35, 35, 2); // brim
        translate(0, 0, 20);
	drawCylinder(100, 20, 20, 40); // top
        fill(#FF0000);
	drawCylinder(100, 21, 21, 4); // ribbon
}

// drawHead
// Draws a sphere for the head with two square eyes,
// cone nose, and a tophat.
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
                translate(-18,-10,29);
                scale(13);
                fill(0);
                drawSquare();
        popMatrix();                
       
        // draw the tophat, such a classy gent!
	pushMatrix();
		translate(-5, (-25 - jumpHeight/2), 0);
		rotateX(radians(90));
		drawTophat();
	popMatrix();

        // give that snowman a nose!
        pushMatrix();
                fill(#FF7F00); // make orange
                translate(-0, 4, 29);
                drawCylinder(50, 9, 0, 25);
        popMatrix();
}

// Draws a humerus, forearm, and three 'fingers'
void drawArm()
{
        stroke(126);
        strokeWeight(4);
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
        translate(0, -jumpHeight, 0);
	sphere(50.0);
	
	// Drawing middle
	pushMatrix();
		translate(0, (-60 - jumpHeight), 0);
                rotateY(radians(rotMidValue));
		sphere(39.0);
                
                // Give him arms to organize the universe!
                pushMatrix();
                        scale(15);
                        rotateX(radians(180));
                        drawArm();
                        rotateY(radians(180));
                        drawArm();
                popMatrix();
                fill(255);             
		translate(0, (-55 - jumpHeight), 0);
		drawHead(); // Don't lose it
	popMatrix();
}

// drawSnow()
// Creates a snow like effect
void drawSnow()
{
        background(95);
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
  	lights();
        directionalLight(128, 128, 128, 0, 0, 1);
        ambientLight(58, 58, 58, 0, 0, 1);
        spotLight(1, 102, 126, 80, 20, 40, width/2, 0, 0, radians(60), 100);
        
        if (snow) {
                drawSnow();
        } else {
                background(172);
        }
        
        // See if we are jumping
        if (handleJump) {
                if (jumpHeight > JUMP_MAX) {
                        handleJump = !handleJump;
                } else {
                        jumpHeight += JUMP_STEP;
                }
        } else {        //make sure he lands
                if (jumpHeight > 0)
                        jumpHeight -= JUMP_STEP;
        }

        // get back to the ground
        if (!handleJump && jumpHeight > 0) {
                jumpHeight -= JUMP_STEP;
        } else {               
                if (jump && !handleJump) { // check to jump
                        --jump;
                        handleJump = true;
                        if (jumpHeight < JUMP_MAX)
                                jumpHeight += JUMP_STEP;
                }
        }

        // spinning
        if (rotMid) {
                rotMidValue += ROT_ANG_SPD;
        }


        translate(width/2, (height - 55), 0);
        fill(255);
        drawSnowPerson();
}
