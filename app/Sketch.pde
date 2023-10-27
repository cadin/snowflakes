class Sketch {
    int sketchW; // width in pixels
    int sketchH; // height in pixels
    float ppi; // pixels per inch of printed doc

    int numRows = 5;
    int numCols = 8;

    int spacing = 100;

    int maxFlakeSize = 40; // 20;
    int minFlakeSize = 10; // 3;
    int numFlakesPerFrame = 1;
    int maxTries = 5000;
    int flakePadding = 14;

    ArrayList<Snowflake> flakes;

    boolean isPacking = true;
    boolean debug = false;

    int sketchX = 0;
    int sketchY = 0;

    Snowflake selectedFlake = null;

    float mx, my = 0;

    ImageMask mask;
    boolean useMask = true;

    int activeAreaX;
    int activeAreaY;
    int activeAreaW;
    int activeAreaH;


    Sketch(int _w, int _h, float _ppi) {
        sketchW = _w;
        sketchH = _h;
        ppi = _ppi;

        flakes = new ArrayList<Snowflake>();
        
        // for(int y = 0; y < numRows; y += 1) {
        //     for(int x = 0; x < numCols; x += 1) {
        //         flakes.add(new Snowflake(100 + x * spacing, 100 + y * spacing, int(random(5, 50))));
        //     }
        // }
        if(useMask){
            PImage img = loadImage("mask-snowfall.png");
            mask = new ImageMask(img, sketchW, sketchH);
        }

        setActiveArea();

    }

    void setDimensions(int _x, int _y, int _w, int _h, float _ppi) {
        sketchW = _w;
        sketchH = _h;
        ppi = _ppi;
        sketchX = _x;
        sketchY = _y;

        setActiveArea();
    }

    void setActiveArea() {
        activeAreaX = 80;
        activeAreaY = 200;
        activeAreaW = sketchW - 160;
        activeAreaH = sketchH - 280;
    }

    void draw(float penSize) {
        // replace this with custom sketch drawing code
        strokeWeight(penSize);

        if(isPacking){
            packCircles();
        }

        for(Snowflake flake : flakes){
            if(flake.isGrowing){
                flake.grow(maxFlakeSize);

                if(flakeIsAgainstOtherFlake(flake, flakes, true)) {
                    flake.isGrowing = false;
                    flake.reset();
                }
            } else {
                flake.draw(debug || selectedFlake == flake);
            }
        
            
        }

        if(useMask && debug){
            if(mask.graphics != null) {
                image(mask.graphics, 0, 0, sketchW, sketchH);
            }
        }

        // if(debug){
        //     fill(255, 0, 0);
        //     noStroke();
        //     circle(mx, my, 10);
        // }

    }

    boolean flakeIsAgainstOtherFlake(Snowflake flake, ArrayList<Snowflake> arr, boolean adjustRadius) {
        boolean result = false;
        for(Snowflake otherFlake : arr) {
            if(flake == otherFlake) continue;
            if(dist(flake.x, flake.y, otherFlake.x, otherFlake.y) <= flake.radius + otherFlake.radius + flakePadding){
                if(adjustRadius){
                    flake.radius = dist(flake.x, flake.y, otherFlake.x, otherFlake.y) - otherFlake.radius - flakePadding;
                }
                result = true;
            }
        }
        return result;
    }

    Snowflake createFlake() {
        float x = useMask ? random(sketchW) : random(activeAreaX, activeAreaX + activeAreaW);
        float y = useMask ? random(sketchH) : random(activeAreaY, activeAreaY + activeAreaH);
        boolean valid = true;

        for(Snowflake flake : flakes){
            if(dist(x, y, flake.x, flake.y) < flake.radius + minFlakeSize + flakePadding){
                valid = false;
                break;
            }
        }

        if(useMask && !mask.getPixel(int(x), int(y))){
            valid = false;
        }

        if(valid){
            return new Snowflake(x, y, minFlakeSize, random(0, PI / 3));
        } else {
            return null;
        }
    }

    void packCircles() {
        int numTries = 0;
        int count = 0;
        while(count < numFlakesPerFrame){
            Snowflake flake = createFlake();
            if(flake != null){
                flakes.add(flake);
                numTries = 0;
                count++;
            } else {
                numTries++;
            }

            if(numTries > maxTries){
                isPacking = false;
                println("Packed " + flakes.size() + " flakes");
                break;
            }
        }

        
    }

    Snowflake getFlakeUnderMouse() {
        for(Snowflake flake : flakes){
            if(dist(mouseX, mouseY, flake.x + sketchX, flake.y + sketchY) < flake.radius){
                return flake;
            }
        }
        println("No flake under mouse");
        return null;
    }

    void mousePressed() {
        // mousePressed events get forwarded from main applet
        Snowflake flake = getFlakeUnderMouse();
        if(flake != null){
            flake.reset();
        }
    }

    void highlightFlake() {
        Snowflake flake = getFlakeUnderMouse();
        if(flake != null){
            selectedFlake = flake;
            printInfo(flake);
        } else {
            selectedFlake = null;
        }       
    }

    void printInfo(Snowflake flake) {
        println("x: " + flake.x + ", y: " + flake.y + ", radius: " + flake.radius);
    }

    void keyPressed() {
        // keyPressed events get forwarded from main applet
        switch(key) {
            case 'r': 
                for(Snowflake flake : flakes){
                    flake.reset();
                }
                break;
            case 'd':
                debug = !debug;
                break;
            case 'i':
                highlightFlake();
                break;

        }
    }
    
}