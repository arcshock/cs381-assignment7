void setup()
{
	size(200,200, P3D);
//	background(125);
	background(0);
	noStroke();
	directionalLight(51, 102, 126, -5, 2, 0); //r, g, b, x, y, z
	translate(20, 50, 0);
	sphere(30);
	fill(255);
	noLoop();
	PFont fontA = loadFont("times new roman");  //Because everything is better with a serif!
	textFont(fontA, 14);  
}

void draw(){  
	text("Hello World!", 20, 2);
	println("Hello ErrorLog!");
	println("More to the error?");
	println("Sweet");
}