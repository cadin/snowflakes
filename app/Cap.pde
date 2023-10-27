class Cap {

    int BRANCH = 0;
    int CIRCLE = 1;
    int HEXAGON = 2;

    int type = BRANCH;
    float size = 0;
    float x = 0;

    Branch branch;

    Cap(float _x) {
        type = floor(random(0, 3));
        size = random(2, 10);
        
        if(type != BRANCH){
            x = _x - size;
        } else {
            x = _x;
            branch = new Branch(x - size, x, random(1, 10));
        }

    }

    void draw(boolean debug) {
        pushMatrix();

        if (type == BRANCH) {
            if(debug) stroke(255, 0, 0);
            branch.draw(debug);
        } else if (type == CIRCLE) {
            translate(x, 0);
            if(debug) stroke(0,255, 0);
            ellipse(0, 0, size, size);
        } else if (type == HEXAGON) {
            translate(x, 0);
            if(debug) stroke(0, 0, 255);
            beginShape();
            for (int i = 0; i < 6; i++) {
                float angle = TWO_PI / 6 * i;
                float x = cos(angle) * size;
                float y = sin(angle) * size;
                vertex(x, y);
            }
            endShape(CLOSE);
        }
        popMatrix();
        stroke(0);
    }
}