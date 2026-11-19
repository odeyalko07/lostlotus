import pygame
import sys

pygame.init()

screen = pygame.display.set_mode((640, 480), pygame.HWSURFACE | pygame.FULLSCREEN)

icon = pygame.image.load("icon.ico").convert_alpha()

pygame.display.set_caption("Lost Lotus")
pygame.display.set_icon(icon)

while True:
	screen.fill((0, 0, 0))
	pygame.display.flip()
	for event in pygame.event.get():
		if event.type == pygame.QUIT:
			sys.exit()