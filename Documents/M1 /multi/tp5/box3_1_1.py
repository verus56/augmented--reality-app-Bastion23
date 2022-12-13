import cv2
import numpy as np
from math import inf

box_coordinates = []


# mouse callback function
def draw_rect(event, x, y, flags, param):
    global box_coordinates, box2_coordinates
    if event == cv2.EVENT_LBUTTONDOWN:
        box_coordinates = [(x, y)]

    elif event == cv2.EVENT_LBUTTONUP:
        box_coordinates.append((x, y))
        cv2.rectangle(img, (box_coordinates[0][0], box_coordinates[0][1]),
                      (box_coordinates[1][0], box_coordinates[1][1]), (0, 0, 255), 2)
        cv2.rectangle(img, (box2_coordinates[0][0], box2_coordinates[0][1]),
                      (box2_coordinates[1][0], box2_coordinates[1][1]), (255, 0, 0), 2)
        cv2.imshow("image", img)


def MSE(bloc1, bloc2):
    block1, block2 = np.array(bloc1), np.array(bloc2)
    sim = np.square(np.subtract(block1, block2)).mean()
    return sim


img = cv2.imread("image072.png")
img2 = cv2.imread("image092.png")
cv2.namedWindow('image')
cv2.setMouseCallback('image', draw_rect)
cv2.namedWindow('image2')
cv2.setMouseCallback('image2', draw_rect)

while True:
    cv2.imshow('image', img)
    cv2.imshow('image2', img2)
    cv2.waitKey(0)
    break



cv2.destroyAllWindows()

img1 = cv2.imread('image072.png')
img2 = cv2.imread('image092.png')
grayImg1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
grayImg2 = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

# Cropping an image
bloc1 = grayImg1[box_coordinates[0][1]:box_coordinates[1][1], box_coordinates[0][0]:box_coordinates[1][0]]

# researching similarity
min = inf
for i in range(box_coordinates[0][1] - 100,
               box_coordinates[1][1] + 100 - (box_coordinates[1][1] - box_coordinates[0][1])):
    for j in range(box_coordinates[0][0] - 100,
                   box_coordinates[1][0] + 100 - (box_coordinates[1][0] - box_coordinates[0][0])):
        block2 = grayImg2[i:i + (box_coordinates[1][1] - box_coordinates[0][1]),
                j:j + (box_coordinates[1][0] - box_coordinates[0][0])]
        loss = MSE(bloc1, block2)
        if loss < min:
            min = loss
            bloc = block2

# Display cropped image
cv2.imshow("cropped", bloc1)  # first bloc
cv2.imshow("resultat trouvé", bloc)  # bloc similaire in 2nd image
cv2.waitKey(0)
