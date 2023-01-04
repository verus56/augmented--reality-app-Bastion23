import cv2
import numpy as np
from math import inf

box_coordinates = []

# mouse callback function
def draw_rect(event, x, y, flags, param):
    global box_coordinates 
    if event == cv2.EVENT_LBUTTONDOWN:
        box_coordinates=[(x, y)] 
      
    elif event == cv2.EVENT_LBUTTONUP:
        box_coordinates.append((x, y)) 
        cv2.rectangle(img, (box_coordinates[0][0], box_coordinates[0][1]), 
        (box_coordinates[1][0], box_coordinates[1][1]), (0, 0, 255), 2)
        cv2.imshow("image", img) 
            
def MSE(block1, block2):
    return np.sum((block1.astype("float") - block2.astype("float")) ** 2) / float(block1.shape[0] * block1.shape[1])


image1 = "images/image072.png"
image2 = "images/image092.png"


img = cv2.imread(image1)
cv2.namedWindow('image')
cv2.setMouseCallback('image', draw_rect)



cv2.imshow('image', img)
cv2.waitKey(0) 

print(box_coordinates)

cv2.destroyAllWindows()

#img1 = cv2.imread('image072.png')
#grayImg1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)

grayImg1 = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)


# Cropping an image
bloc1 = grayImg1[box_coordinates[0][1]:box_coordinates[1][1], box_coordinates[0][0]:box_coordinates[1][0]] 

bloc1_width = box_coordinates[1][0] - box_coordinates[0][0]
bloc1_height = box_coordinates[1][1] - box_coordinates[0][1]


# Display cropped image
cv2.imshow("cropped", bloc1)


img2 = cv2.imread(image2)

green_box = [
(box_coordinates[0][0]-100,box_coordinates[0][1]-100),
(box_coordinates[1][0]+100,box_coordinates[1][1]+100)]


box2_coordinates = []

grayImg2 = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

mse = +inf

for i in range(green_box[0][0],green_box[1][0]-bloc1_width+1):
    for j in range(green_box[0][1],green_box[1][1]-bloc1_height+1):
            bloc2 = grayImg2[j:j+bloc1_height,i:i+bloc1_width]
            temp = MSE(bloc1,bloc2)
            if temp < mse:
                mse = temp
                box2_coordinates=[(i,j),(i+bloc1_width,j+bloc1_height)]


cv2.rectangle(img2, 
(green_box[0][0], green_box[0][1]), 
(green_box[1][0], green_box[1][1]), 
(0, 255, 0), 2)

cv2.rectangle(img2, 
(box2_coordinates[0][0], box2_coordinates[0][1]), 
(box2_coordinates[1][0], box2_coordinates[1][1]), 
(0 , 0, 255), 2)

cv2.imshow("Result", img2) 
cv2.waitKey(0)
