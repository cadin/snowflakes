class ImageMask {

    PImage maskImage = null;
    PGraphics graphics = null;

    int sketchW, sketchH = 0;

    ImageMask(PImage img, int _sketchW, int _sketchH) {
        sketchW = _sketchW;
        sketchH = _sketchH;

        maskImage = img;
        processMaskData();
    }

    void importImage() {
        selectInput("Load image mask", "onImageMaskSelected");
    }
    
    void onImageMaskSelected(File img) {
        if(img == null) return;
        
        String filePath = img.getAbsolutePath();
        
        maskImage = loadImage(filePath);
        processMaskData();
    }

    boolean getPixel(int x, int y) {
        graphics.loadPixels();            
        // fucking retina displays make this complicated
        // why can't I create a PGraphics at an exact size?
        int xVal = x * graphics.pixelDensity;
        int yVal = y * graphics.pixelDensity;
        int index =( xVal + yVal * sketchW * graphics.pixelDensity) ;
        color c = graphics.pixels[ index ];
        return (brightness(c) >= 50);
    }

    void processMaskData() {
        graphics = createGraphics(sketchW, sketchH);
        graphics.beginDraw();
        graphics.background(0);

        // scale and center
        float scale = float(sketchW) / float(maskImage.width);
        if(scale * maskImage.height > sketchH) {
            scale = float(sketchH) / float(maskImage.height);
        }
        float w = maskImage.width * scale;
        float h = maskImage.height * scale;
        float xPos = (sketchW- w) / 2;
        float yPos = (sketchH - h) / 2;

        graphics.image(maskImage, xPos, yPos, w, h);
        graphics.endDraw();
    }

}

