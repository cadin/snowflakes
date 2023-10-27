class Branch {

    float length;
    float x, y = 0;
    boolean capEnd = false;
    Cap cap;
    ArrayList<Branch> branches = new ArrayList<Branch>();

    Branch(float _length, float _x, float _y) {
        length = _length;
        x = _x;
        y = _y;
        reset();
    }

    Branch(float _length, float _x, boolean _capEnd) {
       length = _length;
        x = _x;
        capEnd = _capEnd;
        reset();
    }


    void reset() {
        int maxBranches = floor(length / 20);
        if(maxBranches > 0){
            int numBranches = floor(random(1, maxBranches));
            for(int i = 0; i < numBranches; i++) {
                float branchLength = random(0, length);
                float branchX = random(0, length / numBranches);
                float branchY = random(2, 20);
                branches.add(new Branch(branchLength, branchX, branchY));
            }
        }

        if(capEnd) {
            cap = new Cap(length);
        }
    }

    void draw(boolean debug) {
        float lineLen = capEnd && cap.type != 0 ? length - cap.size*2 : length;
        line(x, 0, lineLen, y);
        drawSide(debug);
        scale(-1, 1);
        drawSide(debug);

        if(capEnd && cap.type == 2){
            cap.draw(debug);
        }
    }

    void drawSide(boolean debug) {
        
        for(Branch b : branches) {
            pushMatrix();
            if(debug) stroke(128, 128, 128);
            b.draw(debug);
            stroke(0);
            popMatrix();
        }

        if(capEnd && cap.type != 2) {
            cap.draw(debug);
        }
    }

}