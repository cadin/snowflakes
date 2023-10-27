class Snowflake {
    boolean isGrowing = true;

    float x;
    float y;
    float radius;
    boolean hasDot;
    float dotSize = 0;
    float dotX = 0;

    boolean hasDash;
    float dashSize = 0;
    float dashX = 0;

    int maxBranches;
    float rotation;

    Branch mainBranch;

    Snowflake(float _x, float _y, float _radius, float _rotation) {
        x = _x;
        y = _y;
        radius = _radius;
        rotation = _rotation;

    }

    void grow(int maxSize) {
        radius += 2;
        if(radius >= maxSize) {
            isGrowing = false;
            radius = maxSize;
            reset();
        }
    }

    void draw(boolean debug) {
        pushMatrix();
        

        stroke(0);
        noFill();
        translate(x, y);
        rotate(rotation);
        if(debug) {
            stroke(0, 255, 255);
            circle(0, 0, radius * 2);
            stroke(0);
        }
        for(int i = 0; i < 6; i++) {
            drawLeg(debug);
            rotate(PI/3);
        }
        popMatrix();
    }

    void drawLeg(boolean debug) {
       
        if(mainBranch == null) {
            return;
        }
        pushMatrix();
        mainBranch.draw(debug);
        if(hasDot || hasDash) {
            pushMatrix();
            rotate(PI/6);
            if(hasDot){
                circle(dotX, 0, dotSize);
            } else {
                line(dashX, 0, dashX + dashSize, 0);
            }
            popMatrix();
        }
        popMatrix();
    }

    void reset() {
        float startX = random(0, radius * 0.25);
        float capVal = random(0, 1);

        boolean capped = radius > 15 || (radius > 8 && capVal > 0.5) ;
        mainBranch = new Branch(radius, startX, capped);

        float rand = random(1);
        hasDot = rand > 0.8;
        if(hasDot) {
            dotSize = random(0.1, 10);
            dotX = random(radius);
        } 

        hasDash = !hasDot && rand > 0.7;
        if(hasDash) {
            dashSize = random(0.1, 10);
            dashX = random(radius);
        }
    }
}