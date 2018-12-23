
img = None
sorted = None
index = 0

def setup():
    global img
    global sorted
    
    size(960, 720)
    
    img = loadImage("MLH3.jpg")
    sorted = createImage(img.width, img.height, RGB)
    sorted.loadPixels()
    img.loadPixels()
    
    sorted = img.get()
    

    
def draw():
    global img
    global sorted
    global index
    
    background(0)
    
    print(frameRate)
    
        # Selection Sort
    for x in range(10):
        record = -1
        selected_pixel = index
        for j in range(index, len(sorted.pixels)):
            pix = sorted.pixels[j]
            b = hue(pix)
            
            if b > record:
                record = b
                selected_pixel = j
            
        sorted.pixels[selected_pixel], sorted.pixels[index] = sorted.pixels[index], sorted.pixels[selected_pixel]        
        
        if index <= len(sorted.pixels):
            index += 1
        

    sorted.updatePixels()
    
    image(img, 0, 0)
    image(sorted, 480, 0)
    
