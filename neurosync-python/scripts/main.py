import pygame
import sys

pygame.init()
S_WIDTH = 1280
S_HEIGHT = 720
SCREEN = pygame.display.set_mode((S_WIDTH, S_HEIGHT))
CLOCK = pygame.time.Clock()

TITLE_FONT = pygame.font.SysFont("arial", 64)
text = TITLE_FONT.render("Teste", True, "white", "red")
text_rect = text.get_rect(center=(S_WIDTH/2, 150))

pygame.display.set_caption("NeuroSync")


while True:
    for event in pygame.event.get():
        if (event.type == pygame.QUIT):
                pygame.quit()
                sys.exit()
    SCREEN.blit(text, text_rect)
    pygame.display.update()

    CLOCK.tick(60) #60 fps