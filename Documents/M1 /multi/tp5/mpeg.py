x1 = y1 = x2 = y2 = 0
longeur = largeur = 0
img = None
padding = 5
areaSelected = False
mse = None


def getFrame2():
    global frame1
    global frame2
    global x1
    global y1
    global padding

    noLoop()
    img = loadImage('frame2.png')
    image(img, 0, 0)
    image(frame1, 0, 0)

    stroke(255)
    fill(255, 255, 255)
    rect(1000, 0, 300, 600)
    instructions()

    frame2 = get(x1-padding, y1-padding, longeur+2*padding, largeur+2*padding)

    # Area to compare on
    noFill()
    stroke(50, 255, 50)
    rect(x1-padding, y1-padding, longeur+2*padding, largeur+2*padding)

    bestMatch()


def bestMatch():
    global frame1
    global frame2
    global padding
    global x1
    global y1
    global longeur
    global largeur
    global mse

    mse = None
    xTemp = -1
    yTemp = -1
    print(padding)
    for i in xrange(2*padding):
        for j in xrange(2*padding):
            bloc = frame2.get(i, j, longeur, largeur)
            newMse = MSE(frame1, bloc)
            if mse == None:
                print(i, j)
                mse = newMse
                xTemp = i
                yTemp = j
            elif mse > newMse:
                print(i, j)
                print("old val "+str(mse))
                mse = newMse
                print("new val "+str(mse))
                xTemp = i
                yTemp = j

    # Best match
    stroke(50, 50, 255)
    rect(x1 + xTemp - padding, y1 + yTemp - padding, longeur, largeur)

    # Print MSE
    instructions()
    mse = None
    # loop()


def MSE(frame, bloc):
    global longeur
    global largeur
    frame.loadPixels()
    bloc.loadPixels()
    mse = 0

    for x in range(longeur * largeur):
        mse += (brightness(bloc.pixels[x]) - brightness(frame.pixels[x]))**2
    mse = mse/(longeur * largeur)
    return mse


def setup():
    global img
    background(255)
    img = loadImage('frame1.png')
    size(1300, 600)
    image(img, 0, 0)


def draw():
    background(0)
    image(img, 0, 0)
    stroke(255)
    fill(255, 255, 255)
    rect(1000, 0, 300, 600)
    instructions()

    # strokeWeight(2)
    noFill()
    stroke(255, 50, 50)
    rect(x1, y1, longeur, largeur)


def mousePressed():
    global x1
    global y1
    global areaSelected
    if not areaSelected:
        x1 = mouseX
        y1 = mouseY


def mouseDragged():
    global x1
    global y1
    global x2
    global y2
    global longeur
    global largeur
    global frame1
    global areaSelected
    if not areaSelected and mouseX < 1000 and mouseY < 600:
        longeur = mouseX-x1
        largeur = mouseY-y1

        stroke(255, 50, 50)
        rect(x1, y1, longeur, largeur)


def mouseReleased():
    global x1
    global y1
    global x2
    global y2
    global longeur
    global largeur
    global frame1
    global areaSelected
    if not areaSelected:
        if longeur < 0:
            x2 = x1
            x1 += longeur
            longeur = -longeur
        else:
            x2 = x1 + longeur

        if largeur < 0:
            y2 = y1
            y1 += largeur
            largeur = -largeur
        else:
            y2 = y1 + largeur
        print("x1: ", x1)
        print("y1: ", y1)
        print("x2: ", x2)
        print("y2: ", y2)
        print("longeur: ", longeur)
        print("largeur: ", largeur)
        frame1 = get(x1, y1, longeur, largeur)
        areaSelected = True
        getFrame2()


def keyPressed():
    global img
    global x1, x2, y1, y2, longeur, largeur, areaSelected, mse
    if key == "r" or key == "R":
        background(255)
        img = loadImage('frame1.png')
        image(img, 0, 0)
        x1 = y1 = x2 = y2 = 0
        longeur = largeur = 0
        mse = None
        areaSelected = False
        loop()


def instructions():
    global mse
    textSize(32)
    fill(0, 102, 153)
    text("Instructions:", 1050, 30)

    textSize(16)
    fill(0, 102, 153)
    text("- to draw the rectangle to study on,", 1005, 70)
    text("  hold mouse button and draw", 1005, 90)
    text("  the rectangle", 1005, 110)

    textSize(16)
    fill(0, 102, 153)
    text("- to reset the images and try again", 1005, 150)
    text("  the process click on the ' r ' or ' R '", 1005, 170)
    text("  key", 1005, 190)

    if not mse == None:
        textSize(20)
        fill(44, 191, 69)
        text("Best MSE: " + str(mse), 1015, 300)

        textSize(16)
        fill(196, 156, 33)
        text("click ' r ' or ' R ' to try again", 1045, 570)