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
            
#def MSE(box1,box2,N,M):
#    somme=0
#    for x in range(N):
#        for y in range(M):
#            somme+=(box1[x][y]-box2[x][y])**2
#    return ((1/N*M)*somme)        
# qui permet de retrouver dans la zone encadrée en vert la zone rectangulaire la plus similaire à la zone encadrée en rouge 
def MSE(block1, block2):
    block1, block2 = np.array(block1), np.array(block2)
    sim = np.square(np.subtract(block1, block2)).mean()
    return sim

img = cv2.imread("image072.png")
cv2.namedWindow('image')
cv2.setMouseCallback('image', draw_rect)


cv2.imshow('image', img)
	# waiting using waitKey method
cv2.waitKey(0)

print(box_coordinates)
cv2.destroyAllWindows()

img1 = cv2.imread('image072.png')
grayImg1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
# Cropping an image
block1 = grayImg1[box_coordinates[0][1]:box_coordinates[1][1], box_coordinates[0][0]:box_coordinates[1][0]] 
# Display cropped image
cv2.imshow("cropped", block1)
cv2.waitKey(0)

img1 = cv2.imread('image092.png')
grayImg1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
# Cropping an image
block1 = grayImg1[box_coordinates[0][1]:box_coordinates[1][1], box_coordinates[0][0]:box_coordinates[1][0]] 
# Display cropped image
cv2.imshow("cropped", block1)
cv2.waitKey(0)
cv2.destroyAllWindows()
img1 = cv2.imread('image072.png')
img2 = cv2.imread('image092.png')
grayImg1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
grayImg2 = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

# Cropping an image
block1 = grayImg1[box_coordinates[0][1]:box_coordinates[1][1], box_coordinates[0][0]:box_coordinates[1][0]]

box2 =[(box_coordinates[0][0] - 100,box_coordinates[0][1] - 100),(box_coordinates[1][0] + 100,box_coordinates[1][1] + 100)]
cv2.rectangle(img2, (box2 [0][0], box2[0][1]), 
(box2 [1][0], box2 [1][1]), (0, 255, 0), 2)
# researching similarity
min = +inf
for i in range(box_coordinates[0][1] - 100,box_coordinates[1][1] + 100 - (box_coordinates[1][1] - box_coordinates[0][1])):
    for j in range(box_coordinates[0][0] - 100,box_coordinates[1][0] + 100 - (box_coordinates[1][0] - box_coordinates[0][0])):
        block2 = grayImg2[i:i + (box_coordinates[1][1] - box_coordinates[0][1]),
                j:j + (box_coordinates[1][0] - box_coordinates[0][0])]
        loss = MSE(block1,block2)
        if loss < min:
            min = loss
            h=(box_coordinates[1][1] - box_coordinates[0][1])
            w=(box_coordinates[1][0] - box_coordinates[0][0])
            bloc = block2


cv2.rectangle(img2, (block1 [0][0], block1 [0][1]), 
(block1 [1][0], block1 [1][1]), (0, 0, 255), 2)
cv2.rectangle(img2, (bloc [0][0], bloc [0][1]), 
(bloc [1][0], bloc [1][1]), (255, 0, 0), 2)
cv2.imshow("Result", img2) 
cv2.waitKey(0)



