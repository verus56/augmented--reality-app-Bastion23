import time

import cv2
import numpy as np
from math import inf

from matplotlib import pyplot as plt

box_coordinates = []
box2_coordinates = []


# mouse callback function
def draw_rect(event, x, y, flags, param):
    global box_coordinates, box2_coordinates
    if event == cv2.EVENT_LBUTTONDOWN:
        box_coordinates = [(x, y)]
        box2_coordinates = [(x - 50, y - 50)]

    elif event == cv2.EVENT_LBUTTONUP:
        box_coordinates.append((x, y))
        box2_coordinates.append((x + 50, y + 50))
        cv2.rectangle(img, (box_coordinates[0][0], box_coordinates[0][1]),
                      (box_coordinates[1][0], box_coordinates[1][1]), (0, 0, 255), 2)
        cv2.rectangle(img, (box2_coordinates[0][0], box2_coordinates[0][1]),
                      (box2_coordinates[1][0], box2_coordinates[1][1]), (255, 0, 0), 2)
        cv2.imshow("image", img)


def MSE(bloc1, bloc2):
    block1, block2 = np.array(bloc1), np.array(bloc2)
    return np.square(np.subtract(block1, block2)).mean()


img = cv2.imread("images/image072.png")
img2 = cv2.imread("images/image092.png")
cv2.namedWindow('image')
cv2.setMouseCallback('image', draw_rect)
cv2.namedWindow('image2')
cv2.setMouseCallback('image2', draw_rect)

while True:
    cv2.imshow('image', img)
    # cv2.imshow('image2', img2)
    k = cv2.waitKey(1) & 0xFF
    if k == 27:
        break

cv2.destroyAllWindows()

img1 = cv2.imread('images/image072.png')
img2 = cv2.imread('images/image092.png')
grayImg1 = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
grayImg2 = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)

# Cropping an image
bloc1 = grayImg1[box_coordinates[0][1]:box_coordinates[1][1], box_coordinates[0][0]:box_coordinates[1][0]]
bloc2 = grayImg2[box_coordinates[0][1] - 100:box_coordinates[1][1] + 100,
        box_coordinates[0][0] - 100:box_coordinates[1][0] + 100]
# researching similarity

start_time = time.time()

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

time = time.time() - start_time
print(f"{time} seconds")

# Display cropped image

plt.figure(figsize=(12, 8))
plt.subplot(1, 4, 1)
plt.title('bloc rogné')
plt.imshow(bloc1, cmap='gray')

plt.subplot(1, 4, 2)
plt.title('bloc de recherche')
plt.imshow(bloc2, cmap='gray')

plt.subplot(1, 4, 3)
plt.title('le bloc le plus similaire dans l''image 2')
plt.imshow(bloc, cmap='gray')

plt.show()

cv2.waitKey(0)
