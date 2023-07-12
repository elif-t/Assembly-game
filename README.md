# Assembly-game
A game written in ARM Cortex M0 assembly.

## Space shooter

In the process of developing our game, as the name suggests, we drew inspiration from the classic 'Space Shooter' game. Our player character is a spaceship, facing enemies in the form of meteors and rival spacecraft. The player navigates up and down to avoid these threats, endeavoring to prevent any collisions. Should a collision occur, the game concludes, with a 'Game Over' message appearing on the screen. Our character is equipped with the capability to fire projectiles, a feature that, unfortunately, wasn't fully integrated into our project. As long as the character survives, the thrilling game continues unabated.


![flowchart_of_main](https://github.com/elif-t/Assembly-game/blob/main/flowchart.png)

Game graphics

![game_img1](https://github.com/elif-t/Assembly-game/blob/main/assembly_game_img1.jpeg)
![game_img3](https://github.com/elif-t/Assembly-game/blob/main/assembly_game_img4.jpeg)
![game_img2](https://github.com/elif-t/Assembly-game/blob/main/assembly_game_img2.jpeg)


The missing parts are as follows:

• We are performing the fireball shooting process, but we are unable to keep it fixed on the
screen. We needed to keep it fixed and make it move forward.

• When we shoot a fireball, if it collides with an enemy, both the enemy and the fireball will
disappear.
