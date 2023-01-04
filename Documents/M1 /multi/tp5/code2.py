import cv2
import numpy as np
import math
"""
La fonction MSE (Mean Squared Error) calcule l'erreur quadratique moyenne entre deux blocs d'images. 
Elle est utilisée ici pour mesurer la similitude entre deux blocs en comparant les valeurs de pixel de chaque bloc. 
Plus l'erreur quadratique moyenne est faible, plus les deux blocs sont similaires.
"""
def MSE(block1, block2):
    return np.sum((block1.astype("float") - block2.astype("float")) ** 2) / float(block1.shape[0] * block1.shape[1])

def search(bloc1,searchBox,searchImg,bloc_width,bloc_height):
    mse = +math.inf
    maxX = (searchBox[1][0] - bloc_width) + 1
    maxY = (searchBox[1][1] - bloc_height)+ 1
    box2_coordinates = None

    for y in range(searchBox[0][1],maxY):
        for x in range(searchBox[0][0],maxX):
                bloc2 = searchImg[y:y+bloc_height,x:x+bloc_width]
                temp = MSE(bloc1,bloc2)
                if temp < mse:
                    mse = temp
                    box2_coordinates=[(x,y),(x+bloc_width,y+bloc_height)]
    return box2_coordinates

def SearchBox(coordinates,width,height,span):

    if coordinates[0][0] < span : topLeftX = 0
    elif coordinates[0][0] > width - span : topLeftX = width - span
    else : topLeftX = coordinates[0][0] - span

    if coordinates[0][1] < span : topLeftY = 0
    elif coordinates[0][1] > height - span : topLeftY = height - span
    else : topLeftY = coordinates[0][1] - span

    if coordinates[1][0] > width - span : bottomRightX = width
    else : bottomRightX = coordinates[1][0] + span

    if coordinates[1][1] > height - span : bottomRightY = height
    else : bottomRightY = coordinates[1][1] + span

    return [(topLeftX,topLeftY),(bottomRightX,bottomRightY)]
    

def draw_greenBox(img,coordinates):
    if coordinates is not None:
        cv2.rectangle(img, 
        (coordinates[0][0], coordinates[0][1]), 
        (coordinates[1][0], coordinates[1][1]), 
        (0 , 255, 0), 2)

def draw_redBox(img,coordinates):
    if coordinates is not None:
        cv2.rectangle(img, 
        (coordinates[0][0], coordinates[0][1]), 
        (coordinates[1][0], coordinates[1][1]), 
        (0, 0, 255), 2)


bloc_width,bloc_height = 32,32
bloc_width,bloc_height = 32,32
seuil = 50
span = 100

image1 = "images/image092.png"
image2 = "images/image072.png"


img1 = cv2.imread(image1)
img2 = cv2.imread(image2)


a = cv2.cvtColor(img1, cv2.COLOR_BGR2XYZ)
#this notation will give you all values in column 0 (from all rows)
a = a[:,:,0]

b = cv2.cvtColor(img2, cv2.COLOR_BGR2XYZ)
b = b[:,:,0]


width = a.shape[1]
height = a.shape[0]
print(a.shape[1]) 
print(b.shape[1]) 
print(a.shape[0]) 
print(b.shape[0]) 

# Deviser l’image 1 en bloc de 32x32 px:
maxX = width - (width % bloc_height)
maxY = height- (height % bloc_height)

for y in range (0,maxY,bloc_height):
    for x in range(0,maxX,bloc_width):
        topLeftX = x
        topLeftY = y
        bottomRightX = x+bloc_width
        bottomRightY = y+bloc_height
        bloc1 = a[topLeftY:bottomRightY,topLeftX:bottomRightX]
        bloc2 = b[topLeftY:bottomRightY,topLeftX:bottomRightX]
        # Si l'MSE entre un bloc de la première image et un bloc de la deuxième image est inférieur à un seuil spécifié (50 ici),
        # le code dessine une boîte verte autour du bloc similaire dans la deuxième image 
        # et une boîte rouge autour du bloc de la première image.
        if seuil < MSE(bloc1,bloc2):
            coordinates = [(topLeftX,topLeftY),(bottomRightX,bottomRightY)]
            draw_redBox(img1,coordinates)
            searchBox = SearchBox(coordinates,width,height,span)
            greenBox = search(bloc1,searchBox,b,bloc_width,bloc_height)
            draw_greenBox(img2,greenBox)
cv2.imshow("Affichager les Blocks similaire dans l'image 1", img1) 
cv2.imshow("Affichager les Blocks similaire dans l'image 2", img2) 
cv2.waitKey(0)
print("Test")