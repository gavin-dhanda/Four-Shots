--Declares the size of the game window, which will not change.
Window_Width = 1200
Window_Height = 800

--Initializes the gameState so that the game begins with the start screen.
gameState = {start = true, playing = false, dead = false}

--Player Skin
skin = "normal"
skinjump = true
skiny = 638
skinx = 575
skintime = 0.5

lastskin = skin
lasty = skiny
lasttime = skintime
lastjump = true
lastx = skinx

--These x and y variables store the location of the player at any time.
x = 575
y = 638

--These boolean variables will control the player's movement around the screen.
left = false
right = false
jump = false
down = false
crouch = false

--Stores the X value of the previous update cycle; used to determine 
--which direction the player should be facing.
xLast = 0

--Used to manipulate which direction the player is facing, either while 
--moving or standing still, and make player movement smoother.
priority = "right"
facing = "right"

--This bool is true when the sky is getting lighter and false while it is getting darker.
lighter = false

--These variables control the size and transition time of the flashing text on the title screen.
big = false
flash = 0

--Bool to show Game Tips while playing.
info = false

--Shooting is used to detect whether the player is shooting, and spawn 
--creates a ball when shotclock reaches a certain value.
shooting = false
shotclock = 0
spawn = 0

--Spd controls the speed of a jump, and time controls the length of a jump.
spd = 2
time = 1

--These four tables will store information that pertains to both enemies
--and projectiles, as they are spawned in throughout the game.
enemies = {}
giants = {}
balls = {}
bombs = {}

--The initial X values of the four clouds, stored in a table, which will change over time.
clouds = {-165, 280, 590, 950}

--RGB values that control the darkness of the sky.
skyr = 140
skyg = 230
skyb = 255

--These variables as a whole allow the strength of enemies and giants
--to be imcremented between different waves/rounds of the game.
waveSize = 0
enemyHealth = 4
enemyDamage = 0
enemySpeed = 0.6
faster = 0.9
giantHealth = enemyHealth * 3
giantSpeed = enemySpeed / 3
giantDamage = enemyDamage * 2

--These values are 
playerHealth = 200
playerScore = 0

--Used to count the time that a player has been playing each game.
gameSecs = 0
gameMins = 0
playerTime = 0

--Reads from the highscore.txt file in the directory and converts the input, 
--which will be the highscore of your specific device, into an integer.
file = love.filesystem.read("highscore.txt")
highscore = tonumber(file)

--Imports the game soundtrack (an original audio) into the music variable.
music = love.audio.newSource("Soundtrack.mp3", "stream")

function love.load()
	love.window.setMode(Window_Width, Window_Height, {
		fullscreen = false,	--The game cannot be set to fullscreen.
		resizable = false,	--The size of the game window cannot be manipulated.
		vsync = true })		--Ensures visually smoother gameplay.

	--Imports the font from the directory and stores it in certain variables with a specific size.
	font = love.graphics.newFont('font.otf', 75)
	smallf = love.graphics.newFont('font.otf', 25)
	midf = love.graphics.newFont('font.otf', 40)
	startbig = love.graphics.newFont('font.otf', 63)
	startsmall = love.graphics.newFont('font.otf', 57)

	--The code below simply creates variables that store images for each of the 
	--game's elements (The Background, Player, Clouds, Enemies, and Projectiles).
	background = love.graphics.newImage("background.jpeg")

	--Base Skin
	cubel = love.graphics.newImage("cubel.jpeg")
	cuber = love.graphics.newImage("cuber.jpeg")
	smushr = love.graphics.newImage("smushr.jpeg")
	smushl = love.graphics.newImage("smushl.jpeg")

	--Silver Skin
	cubels = love.graphics.newImage("cubels.jpeg")
	cubers = love.graphics.newImage("cubers.jpeg")
	smushrs = love.graphics.newImage("smushrs.jpeg")
	smushls = love.graphics.newImage("smushls.jpeg")

	--Gold Skin
	cubelg = love.graphics.newImage("cubelg.jpeg")
	cuberg = love.graphics.newImage("cuberg.jpeg")
	smushrg = love.graphics.newImage("smushrg.jpeg")
	smushlg = love.graphics.newImage("smushlg.jpeg")

	--Diamond Skin
	cubeld = love.graphics.newImage("cubeld.jpeg")
	cuberd = love.graphics.newImage("cuberd.jpeg")
	smushrd = love.graphics.newImage("smushrd.jpeg")
	smushld = love.graphics.newImage("smushld.jpeg")

	--Obsidian Skin
	cubelo = love.graphics.newImage("cubelo.jpeg")
	cubero = love.graphics.newImage("cubero.jpeg")
	smushro = love.graphics.newImage("smushro.jpeg")
	smushlo = love.graphics.newImage("smushlo.jpeg")

	--Clouds
	cloud9 = love.graphics.newImage("cloud9.png")
	cloud1 = love.graphics.newImage("cloud1.png")
	cloud2 = love.graphics.newImage("cloud2.png")
	cloud3 = love.graphics.newImage("cloud3.png")

	--Enemies
	enemy = love.graphics.newImage("enemy.png")
	enemy2 = love.graphics.newImage("enemy2.png")
	giantr = love.graphics.newImage("giantr.png")
	giantl = love.graphics.newImage("giantl.png")

	--Projectiles
	ball = love.graphics.newImage("ball.png")
	boom = love.graphics.newImage("boom.png")
end

function love.mousepressed(x, y, button, istouch, presses)
	if gameState["start"] == true then
		if button == 1 and presses == 1 then
			if y >= 638 and y <= 688 and lastjump == false then
				if x >= 275 and x <= 325 then
					lastx = skinx
					lasty = skiny
					lasttime = skintime
					lastskin = skin
					lastjump = true
					
					if skin == "diamond" then
						--Nothing
					else
						skintime = 1
					end

					skin = "diamond"
					skinx = 275

				else if 425 <= x and x <= 475 then
					lastx = skinx
					lasty = skiny
					lasttime = skintime
					lastskin = skin
					lastjump = true

					if skin == "silver" then
						--Nothing
					else
						skintime = 1
					end

					skin = "silver"
					skinx = 425

				else if 575 <= x and x <= 625 then
					lastx = skinx
					lasty = skiny
					lasttime = skintime
					lastskin = skin
					lastjump = true

					if skin == "normal" then
						--Nothing
					else
						skintime = 1
					end

					skin = "normal"
					skinx = 575

				else if 725 <= x and x <= 775 then
					lastx = skinx
					lasty = skiny
					lasttime = skintime
					lastskin = skin
					lastjump = true

					if skin == "gold" then
						--Nothing
					else
						skintime = 1
					end

					skin = "gold"
					skinx = 725

				else if 875 <= x and x <= 925 then
					lastx = skinx
					lasty = skiny
					lasttime = skintime
					lastskin = skin
					lastjump = true

					if skin == "obsidian" then
						--Nothing
					else
						skintime = 1
					end

					skin = "obsidian"
					skinx = 875

				end end end end end
			end
		end
	end
end

function love.keypressed(key)
	if key == "escape" then 
			love.event.quit()
	end

--When tab is pressed, it will switch the value of info and either show or hide the Game Tips window.
	if key == "tab" then
		if info == true then
			info = false
		else
			info = true
		end
	end

--While in the start screen, pressing enter/return will start the game.
	if gameState["start"] == true then
		if key == "return" then
			gameState["start"] = false
			gameState["playing"] = true
		end
	end

--This loop allows the player to move using WASD while playing, but not while dead.
	if gameState["playing"] == true then
		if key == "d" then
			right = true
			priority = "right"
		end

		if key == "a" then
			left = true
			priority = "left"
		end

	--This makes it so that you cannot jump while pressing "s", because that means you are already sneaking.
		if key == "w" and love.keyboard.isDown("s") == false then
			jump = true
		end

	--If you press and hold "s" while in a jump, however, it will accelerate your fall.
		if key == "s" and jump == true then
			if jump == true then
				down = true
			else
				crouch = true
			end
		end

	--Begins shooting if space is pressed and you are not sneaking.
		if key == "space" and shooting == false and crouch == false then
			shooting = true
			shotclock = 0
			spawn = 0
		end
	end

	if gameState["dead"] == true then
	
	--While in the end screen, pressing enter/return will send you back to the start screen.
		if key == "return" then
			gameState["dead"] = false
			gameState["start"] = true

		--Resets all necessary variables to Play Again
			left = false
			right = false
			jump = false
			down = false
			crouch = false
			lighter = false
			big = false
			flash = 0

			shooting = false
			shotclock = 0
			spawn = 0

			spd = 2
			time = 1

			xLast = 0

			waveSize = 0
			enemyHealth = 4
			enemyDamage = 0
			enemySpeed = 0.6
			giantHealth = enemyHealth * 3
			giantSpeed = enemySpeed / 3
			giantDamage = enemyDamage * 2

			playerHealth = 200
			playerScore = 0
			playerTime = 0

			gameSecs = 0
			gameMins = 0

			y = 638
			x = 575

			skinjump = true
			skiny = 638
			skintime = 0.5

		--Loops through the tables and deletes any remaining enemies or projectiles.
			enemiesAlive = table.getn(enemies)
			giantsAlive = table.getn(giants)
			ballsAlive = table.getn(balls)
			bombsAlive = table.getn(bombs)
			while enemiesAlive > 0 do
				table.remove(enemies, enemiesAlive)
				enemiesAlive = enemiesAlive - 1
			end
			while giantsAlive > 0 do
				table.remove(giants, giantsAlive)
				giantsAlive = giantsAlive - 1
			end
			while ballsAlive > 0 do
				table.remove(balls, ballsAlive)
				ballsAlive = ballsAlive - 1
			end
			while bombsAlive > 0 do
				table.remove(bombs, bombsAlive)
				bombsAlive = bombsAlive - 1
			end
		end 
	end
end

function love.keyreleased(key)
--While in game or in the start screen, this ensures that releasing a, s, and/or d, will stop their movement.
if gameState["playing"] == true then
	if key == 'd' then
		right = false
		priority = "left"
	end

	if key == 'a' then
		left = false
		priority = "right"
	end

	if key == "s" then
		down = false
		crouch = false
	end
end
end

function love.update(dt)

--Loops through the game soundtrack.
	music:play(music)

--In the start screen, a clock will swap the value of "big", thus changing the font size of the text.
	if gameState["start"] == true then
		flash = flash + 1.5 * dt

		if flash > 1 then
			if big == true then
				big = false
			else
				big = true
			end
			flash = 0
		end
	end

	if skinjump == true and skintime - (2 * dt) > -1 then 
		skintime = skintime - (2 * dt)
		skiny = 580 + (58 * (skintime * skintime))
	else if skintime - (2 * dt) <= -1 then
		skiny = 638
		skintime = 1
	end end

	if lastjump == true and lasttime - (2 * dt) > -1 then 
		lasttime = lasttime - (2 * dt)
		lasty = 580 + (58 * (lasttime * lasttime))
	else if lasttime - (2 * dt) <= -1 then
		lasty = 638
		lasttime = 1
		lastjump = false
	end end


	if gameState["playing"] == true then

--Depending on which key is pressed, the x value of the player will be updated to simulate movement.
--Movement speed is multiplied by 1.5 while sneaking.
	if right == true and priority == "right" and (x + (360 * dt) < 1125) then
		if crouch == true then
			x = x + 1.5 * (360 * dt)
		else 
			x = x + (360 * dt)
		end 
	end
	
	if left == true and priority == "left" and (x - (360 * dt) > 25)then
		if crouch == true then
			x = x - 1.5 * (360 * dt)
		else 
			x = x - (360 * dt)
		end
	end

--If "s" is pressed in the second half of a jump, the speed of that jump will be doubled.
	if down == true and time < 0.25 then
		spd = 4
	else
		spd = 2
	end

--This allows you to hold down the "w" key and jump infinitely.
	if love.keyboard.isDown('w') and jump == false and love.keyboard.isDown("s") == false then
		jump = true
	end

--While jumping, the y value is incremented by using a quadratic equation, where the x value is 
--represented by "time", which is a clock that determines the length of a jump.
	if jump == true and time - (spd * dt) > -1 then 
		time = time - (spd * dt)
		y = 398 + (240 * (time * time))

--When the jump finishes, the timer resets and the player is on ground level.
	else if time - (spd * dt) <= -1 then
		jump = false
		y = 638
		time = 1
	end end

--If the current X value is to the right of the previous value, "facing" is set to "right", and vice versa.
	if xLast - x > 0 then
		facing = "left"
	end
	if xLast - x < 0 then
		facing = "right"
	end
	xLast = x

--Checks if the "s" key is being held, and crouches.
	if love.keyboard.isDown("s") and jump == false then
		crouch = true
	end

--While the player is shooting, the shotclock will reset after a certain number of seconds, as will "spawn".
--Because spawn is only at "1" once, a single ball will be created with every reset of the shotclock.
	if shooting == true then
		shotclock = shotclock + (3.75 * dt)
		spawn = spawn + 1
	end

	if shotclock >= 0.5 and love.keyboard.isDown("space") and crouch == false then
		shooting = true
		shotclock = 0
		spawn = 0
	else if shotclock >= 0.5 then
		shooting = false
	end end

	if spawn == 1 then
		if facing == "right" then
			balls[table.getn(balls) + 1] = {x+18, --The x value.
											y+27, --The y value.
											1600, --The ball speed. (Negative if the ball is going left)
											true, --Is the ball alive?
											x+18} --Initial x value.
		else
			balls[table.getn(balls) + 1] = {x+18 , y+27, -1600, true, x+18}
		end
	end

--If the ball is out of the window, its fifth index will be set to false and it will be deleted from the table.
	for i=1, (table.getn(balls)) do
		balls[i][1] = balls[i][1] + (balls[i][3] * dt)
		if balls[i][1] >= Window_Width + 10 or balls[i][1] <= -10 then
			balls[i][4] = false
		end
	end

	for i=1, (table.getn(balls)) do
		if balls[i][4] == false then
			table.remove(balls, i)
			break
		end
	end
end

if gameState["playing"] == true then
	
--Starts the timer and updates it based on DeltaTime.
	playerTime = playerTime + dt
	gameMins = math.floor(playerTime / 60)
	gameSecs = math.floor(playerTime - (60 * gameMins))

--Iterates through each ball and each enemy, and if they have collided, the ball is deleted and the enemy takes damage.
	for i=1, (table.getn(enemies)) do
		for k=1, (table.getn(balls)) do
			if balls[k][3] > 0 and balls[k][5] < (enemies[i][1] + 25) then
				if balls[k][2] > 630 and balls[k][1] > enemies[i][1] then
					enemies[i][3] = enemies[i][3] - 1
					table.remove(balls, k)
					break
				end
			else  if balls[k][3] < 0 and balls[k][5] > (enemies[i][1] + 25) then
				if balls[k][2] > 630 and balls[k][1] < enemies[i][1] + 78 then
					enemies[i][3] = enemies[i][3] - 1
					table.remove(balls, k)
					break
				end
			end end
		end
	end

--Does the same as the for loop above, this time checking for any collisions between balls and giants.
	for i=1, (table.getn(giants)) do
		for k=1, (table.getn(balls)) do
			if balls[k][3] > 0 and balls[k][5] < (giants[i][1] + 55) then
				if balls[k][1] > giants[i][1] + 60 then
					giants[i][3] = giants[i][3] - 1
					table.remove(balls, k)
					break
				end
			else  if balls[k][3] < 0 and balls[k][5] > (giants[i][1] + 55) then
				if balls[k][1] < giants[i][1] + 55 then
					giants[i][3] = giants[i][3] - 1
					table.remove(balls, k)
					break
				end
			end end
		end
	end

--Iterates through the table of bombs, and checks if the bomb has exploded while colliding with the player. If so, the player takes damage. 
	for i=1, (table.getn(bombs)) do
		if bombs[i][6] == "explode" and bombs[i][1] - 50 < x + 25 and bombs[i][1] + 100 > x + 25 and bombs[i][8] == false and y > 540 then
			playerHealth = playerHealth - giantDamage
			bombs[i][8] = true
		end
	end

--If all enemies and giants have been killed, more are spawned and a new round begins.
	if table.getn(enemies) == 0 and table.getn(giants) == 0 then
		for i=1, math.ceil(waveSize/2) do
		
		--There is a 1 in 6 chance that the enemy will be a giant, and a 50% chance 
		--for each enemy to spawn on either side of the window.
			eType = math.random(6)
			side = math.random(2)

			if eType == 6 then
				if side == 1 then
					giants[table.getn(giants) + 1] =  {(-120 - math.random(waveSize * 50)), --The spawn location (x).
														400, 								--The Y value.
														giantHealth, 						--The Giant's health.
														1, 									--The Direction (either 1 or -1).
														25 + math.random(100), 				--The end location (x).
														0}									--The shot timer.
				else
					giants[table.getn(giants) + 1] =  {(1320 + math.random(waveSize * 50)), 400, giantHealth, -1, 1069 - math.random(100), 0}
				end
			else
				if side == 1 then
					enemies[table.getn(enemies) + 1] =  {(-80 - math.random(waveSize * 100)),	--The spawn location (x).
														630, 									--The Y value.
														enemyHealth, 							--The Enemy's health.
														0, 										--Attack timer.
														0, 										--Animation timer.
														true} 									--Which design is shown.
				else
					enemies[table.getn(enemies) + 1] =  {(1280 + math.random(waveSize * 100)), 630, enemyHealth, 0, 0, true}
				end
			end
		end
	end

--For each giant, when the shot timer reaches a certain value, it creates a bomb that will either go left or right.
	for i=1, table.getn(giants) do
		giants[i][6] = giants[i][6] + (dt / 2.5)

		if giants[i][6] >= 1 and giants[i][5] == giants[i][1] then
			if giants[i][4] > 0 then
				if giants[i][1] + 200 < x then
					bombs[table.getn(bombs) + 1] = {giants[i][1] + 100,	--The bomb's initial x value (Will change.
													532, 				--The bomb's initial y value.
													"right", 			--The direction (Left or Right).
													x + 25, 			--The location of the player when bomb is shot.
													giants[i][1], 		--Initial x value of bomb (Will not change).
													"fly", 				--Is the bomb flying or not.
													0, 					--Explosion timer.
													false}				--Has the bomb hit the Player?
				end
			else
				if giants[i][1] - 200 > x then
					bombs[table.getn(bombs) + 1] = {giants[i][1], 532, "left", x + 25, giants[i][1], "fly", 0, false, false}
				end
			end
			giants[i][6] = 0
		end
	end
 
 --Uses a polynomial equation (this time to the 6th power for visual effect), each 
 --bomb gets the distance to the player and follows a unique path so that is lands at 
 --the original location of the player when the bomb was shot.
	for i=1, table.getn(bombs) do
		if bombs[i][3] == "left" then
			if (bombs[i][1] - bombs[i][4]) > 0 then

				d = (bombs[i][5] - bombs[i][4])/(math.pow(532, 1/4))
				bombs[i][2] = 532 + 0.26 * (math.pow((bombs[i][5] - bombs[i][1])/d, 4))
				bombs[i][1] = bombs[i][1] - (450 * dt)

			else

			--If the bomb has landed, the explosion clock will implement until
			--it reaches a certain value, and the bomb will be deleted.
				bombs[i][2] = 675
				bombs[i][6] = "explode"
				bombs[i][7] = bombs[i][7] + (7 * dt)
			end
			if bombs[i][7] > 1 then
				table.remove(bombs, i)
				break
			end

		else if bombs[i][3] == "right" then
			if (bombs[i][4] - bombs[i][1]) > 0 then

				d = (bombs[i][4] - bombs[i][5])/(math.pow(532, 1/6))
				bombs[i][2] = 532 + 0.26 * (math.pow((bombs[i][1] - bombs[i][5])/d, 6))
				bombs[i][1] = bombs[i][1] + (450 * dt) 

			else
				bombs[i][2] = 675
				bombs[i][6] = "explode"
				bombs[i][7] = bombs[i][7] + (7 * dt)
			end
			if bombs[i][7] > 0.8 then
				table.remove(bombs, i)
				break
			end
		end end 
	end

--The speed of the enemies will be decreased while the player is either jumping or crouching.
	if y <638 or crouch == true then
			mult = 75
		else
			mult = 125
		end

--After spawning, each of the smaller enemies will compare their location 
--to that of the player and move towards the player accordingly.
	for i=1, table.getn(enemies) do -- enemy pathfind
		if enemies[i][1] > x +25 then
			if enemies[i][1] - (enemySpeed * mult * dt) < x +25 then
				enemies[i][1] = x +25
			else
				enemies[i][1] = enemies[i][1] - (enemySpeed * (mult + math.random(50)) * dt) 
			end
		else if enemies[i][1] < x -51 then
			if enemies[i][1] + (enemySpeed * mult * dt) > x -51 then
				enemies[i][1] = x -51
			else
				enemies[i][1] = enemies[i][1] + (enemySpeed * (mult + math.random(50)) * dt) 
			end
		end end

	--If the enemy is within range of the player and they collide, the player 
	--will take damage based on the enemy's attack timer.
		if enemies[i][1] + 39 > x -50 and enemies[i][1] + 39 < x + 100 and y > 600 and enemies[i][4] > 1 then
			playerHealth = playerHealth - enemyDamage
			enemies[i][4] = 0
		else 
			enemies[i][4] = enemies[i][4] + dt
		end

	--In the code below, the animation for the enemies changes based on the clock that is implemented in each enemy.
	--As the rounds progress and enemies move faster, the animation also changes faster.
		enemies[i][5] = enemies[i][5] + (4 * dt)

		if (1.75 - enemySpeed) > 0.4 then
			faster = 1.75 - enemySpeed
		else
			faster = 0.4
		end

		if enemies[i][5] > faster then
			if enemies[i][6] == true then
				enemies[i][6] = false
			else
				enemies[i][6] = true
			end
			enemies[i][5] = 0
		end
	end

--This moves each of the giants from their starting location to their end location at a specific speed.
	for i=1, table.getn(giants) do 
		if giants[i][4] > 0 and (giants[i][1] + (giantSpeed * 125 * dt)) < giants[i][5] then
			giants[i][1] = (giants[i][1] + (giantSpeed * 125 * dt))
		else if giants[i][4] > 0 then
			giants[i][1] = giants[i][5]
		else if giants[i][4] < 0 and (giants[i][1] - (giantSpeed * 125 * dt)) > giants[i][5] then
			giants[i][1] = (giants[i][1] - (giantSpeed * 125 * dt))
		else if giants[i][4] < 0 then
			giants[i][1] = giants[i][5]
		end end end end
	end

--The two for loops below check if the health of each enemy and each 
--giant is less than 1. If so, that enemy/giant is deleted from the table.
--The player recieves some health back when an enemy is killed, but playerHealth cannot exceed 200.
	for i=1, table.getn(enemies) do
		if enemies[i][3] < 1 then
			table.remove(enemies, i)
			if playerHealth < 196 then
				playerHealth = playerHealth + 5
			else
				playerHealth = 200
			end
			playerScore = playerScore + 5
			break
		end
	end

	for i=1, table.getn(giants) do
		if giants[i][3] < 1 then
			table.remove(giants, i)
			if playerHealth < 191 then
				playerHealth = playerHealth + 10
			else
				playerHealth = 200
			end
			playerScore = playerScore + 15
			break
		end
	end

	if playerHealth <= 0 then
		playerHealth = 0
	end

	--This implements a Daylight Cycle, where the shade of blue remains 
	--the same but becomes darker and lighter over time.
	if skyb <= 30 then
		lighter = true
	else if skyb >= 255 then
		lighter = false
		skyr = 140
		skyg = 230
		skyb = 255
	end end
	if lighter == false then
		skyr = skyr - 2 * (140/255 * dt)
		skyb = skyb - 2 * dt
		skyg = skyg - 2 * (230/255 * dt)
	end
	if lighter == true then
		skyr = skyr + 2 * (140/255 * dt)
		skyb = skyb + 2 * dt
		skyg = skyg + 2 * (230/255 * dt)
	end

--After each round, the statistics of the enemies become stronger, allowing for virtually infinite gameplay.
	if table.getn(enemies) == 0 and table.getn(giants) == 0 then
		playerScore = playerScore + (10 * waveSize)
		waveSize = waveSize + 1
		enemyHealth = enemyHealth + 0.25
		enemySpeed = enemySpeed + 0.04
		enemyDamage = enemyDamage + 1
		giantHealth = enemyHealth * 4
		giantSpeed = enemySpeed / 2
		giantDamage = enemyDamage * 2
	end

--All 4 clouds move at a constant rate throughout the game.
	for i = 1, 4 do
		clouds[i] = clouds[i] + (dt * 10)
		if clouds[i] > Window_Width then
		clouds[i] = -500
		end
	end

--When the player dies, the game switches to the end screen.
	if playerHealth <= 0 then
		gameState["dead"] = true
		gameState["playing"] = false
	end
end

if gameState["dead"] == true then
--If the player beat the highscore, their score will be written and saved to the highscore file.
	if playerScore > highscore then
		highscore = playerScore
		love.filesystem.write("highscore.txt", highscore)
	end 
end end

--*In the draw function below, the extraction of certain objects into individual functions allows 
--for much more efficient layering and makes love.draw easier to understand and manipulate.*

function love.draw()
	
	DrawEnvironment()

if gameState["playing"] == true then

	DrawPlayer()

	DrawBalls()

	DrawBombs()

	DrawGiants()

	DrawEnemies()

	DrawTime()

	DrawInfo()

	love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font)
	love.graphics.printf("Round " .. waveSize, 0, 20, Window_Width, 'center')

	love.graphics.setFont(smallf)
	love.graphics.printf("Health = " .. playerHealth, 40, 30, Window_Width, 'left')
	love.graphics.printf("Score = " .. playerScore, 40, 73, Window_Width, 'left')

	love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(midf)
	love.graphics.printf("Press TAB for Game Tips", 0, 735, Window_Width, 'center')

else if gameState["start"] == true then
	
	DrawPlayerInstructions()

	DrawSkins()

    DrawBalls()

    love.graphics.setFont(font)
	love.graphics.setColor(0, 0, 0)
	love.graphics.printf("Four Shots", 0, 20, Window_Width, 'center')

	love.graphics.setFont(startsmall)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("Highscore = " .. highscore, 0, 726, Window_Width, 'center')

else if gameState["dead"] == true then

	DrawPlayer()

    DrawGiants()

    DrawEnemies()

    love.graphics.setFont(font)
	love.graphics.setColor(0, 0, 0)
	love.graphics.printf("Died on Round " .. waveSize, 0, 20, Window_Width, 'center')

	love.graphics.setFont(startsmall)
	love.graphics.setColor(1, 1, 1)
	love.graphics.printf("Press Enter to Return to Menu", 0, 450, Window_Width, 'center')
	love.graphics.printf("Score = " .. playerScore, 0, 520, Window_Width, 'center')
	love.graphics.printf("Highscore = " .. highscore, 0, 726, Window_Width, 'center')
end end end
end

--As explained above, the following functions are intended to simplify the love.draw function and allow 
--the designer to focus on where and when to display certain elements, and not exactly how to display them.

function DrawPlayerInstructions()
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", 300, 185, 600, 250, 20, 20)

	love.graphics.setLineWidth(8)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("line", 300, 185, 600, 250, 20, 20)
	
	love.graphics.setFont(midf)
	love.graphics.printf("Game Controls", 0, 210, Window_Width, 'center')
	love.graphics.setFont(smallf)
	love.graphics.printf("Use WASD to Move, Jump, and Sneak.", 0, 270, Window_Width, 'center')
	love.graphics.printf("Use Space to Shoot and Escape to Exit.", 0, 320, Window_Width, 'center')
	love.graphics.printf("Stay Alive and Kill Enemies for Points!", 0, 370, Window_Width, 'center')

--Uses a clock to switch this text between a small and a large font.
	love.graphics.setColor(1, 1, 1)
	if big == true then
		love.graphics.setFont(startbig)
		love.graphics.printf("Press Enter to Start", 0, 475, Window_Width, 'center')
	else
		love.graphics.setFont(startsmall)
		love.graphics.printf("Press Enter to Start", 0, 479, Window_Width, 'center')
	end
end

function DrawSkins()
	if skinx == 575 then
		if lastx == 575 then
			love.graphics.draw(cuber, 575, skiny, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 275 then
			love.graphics.draw(cuber, 575, skiny, 0, .25, .25)
			love.graphics.draw(cuberd, 275, lasty, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 425 then
			love.graphics.draw(cuber, 575, skiny, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, lasty, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 725 then
			love.graphics.draw(cuber, 575, skiny, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, lasty, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 875 then
			love.graphics.draw(cuber, 575, skiny, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, lasty, 0, .25, .25)
		end end end end end
	else if skinx == 275 then
		if lastx == 575 then
			love.graphics.draw(cuber, 575, lasty, 0, .25, .25)
			love.graphics.draw(cuberd, 275, skiny, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 275 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, skiny, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 425 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, skiny, 0, .25, .25)
			love.graphics.draw(cubers, 425, lasty, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 725 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, skiny, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, lasty, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 875 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, skiny, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, lasty, 0, .25, .25)
		end end end end end
	else if skinx == 425 then
		if lastx == 575 then
			love.graphics.draw(cuber, 575, lasty, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, skiny, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 275 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, lasty, 0, .25, .25)
			love.graphics.draw(cubers, 425, skiny, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 425 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, skiny, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 725 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, skiny, 0, .25, .25)
			love.graphics.draw(cubelg, 725, lasty, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 875 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, skiny, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, lasty, 0, .25, .25)
		end end end end end
	else if skinx == 725 then
		if lastx == 575 then
			love.graphics.draw(cuber, 575, lasty, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, skiny, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 275 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, lasty, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, skiny, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 425 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, lasty, 0, .25, .25)
			love.graphics.draw(cubelg, 725, skiny, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 725 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, skiny, 0, .25, .25)
			love.graphics.draw(cubelo, 875, 638, 0, .25, .25)
		else if lastx == 875 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, skiny, 0, .25, .25)
			love.graphics.draw(cubelo, 875, lasty, 0, .25, .25)
		end end end end end
	else if skinx == 875 then
		if lastx == 575 then
			love.graphics.draw(cuber, 575, lasty, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, skiny, 0, .25, .25)
		else if lastx == 275 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, lasty, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, skiny, 0, .25, .25)
		else if lastx == 425 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, lasty, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, skiny, 0, .25, .25)
		else if lastx == 725 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, lasty, 0, .25, .25)
			love.graphics.draw(cubelo, 875, skiny, 0, .25, .25)
		else if lastx == 875 then
			love.graphics.draw(cuber, 575, 638, 0, .25, .25)
			love.graphics.draw(cuberd, 275, 638, 0, .25, .25)
			love.graphics.draw(cubers, 425, 638, 0, .25, .25)
			love.graphics.draw(cubelg, 725, 638, 0, .25, .25)
			love.graphics.draw(cubelo, 875, skiny, 0, .25, .25)
		end end end end end
	end end end end end 
end

function DrawPlayer()
--Draws the player based on which direction it is facing, and whether or not it is crouched.
	love.graphics.setColor(1, 1, 1)
    
if skin == "normal" then
	if facing == "left" then
    	if crouch == false then
    		love.graphics.draw(cubel, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushl, x - 8.5, y + 33, 0, .225, .225)
    	end

    else
    	if crouch == false then
    		love.graphics.draw(cuber, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushr, x - 8.5, y + 33, 0, .225, .225)
    	end
    end
else if skin == "silver" then
	if facing == "left" then
    	if crouch == false then
    		love.graphics.draw(cubels, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushls, x - 8.5, y + 33, 0, .225, .225)
    	end

    else
    	if crouch == false then
    		love.graphics.draw(cubers, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushrs, x - 8.5, y + 33, 0, .225, .225)
    	end
    end
else if skin == "gold" then
	if facing == "left" then
    	if crouch == false then
    		love.graphics.draw(cubelg, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushlg, x - 8.5, y + 33, 0, .225, .225)
    	end

    else
    	if crouch == false then
    		love.graphics.draw(cuberg, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushrg, x - 8.5, y + 33, 0, .225, .225)
    	end
    end
else if skin == "diamond" then
	if facing == "left" then
    	if crouch == false then
    		love.graphics.draw(cubeld, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushld, x - 8.5, y + 33, 0, .225, .225)
    	end

    else
    	if crouch == false then
    		love.graphics.draw(cuberd, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushrd, x - 8.5, y + 33, 0, .225, .225)
    	end
    end
else
	if facing == "left" then
    	if crouch == false then
    		love.graphics.draw(cubelo, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushlo, x - 8.5, y + 33, 0, .225, .225)
    	end

    else
    	if crouch == false then
    		love.graphics.draw(cubero, x, y, 0, .25, .25)
    	else
    		love.graphics.draw(smushro, x - 8.5, y + 33, 0, .225, .225)
    	end
    end
end end end end

--Draws the player's Health Bar as its health goes Up or Down.
	lower = 0 
	if crouch == true then
		lower = 35
	end

	n = playerHealth / 4
	if playerHealth == 0 then
		n = 1
	end

	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", x, y - 20 + lower, 50, 8, 3, 3)

	love.graphics.setColor(0.05, 0.9, 0.5)
	love.graphics.rectangle("fill", x, y - 20 + lower, n, 8, 3, 3)

	love.graphics.setColor(.1, .1, .1)
	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", x-1, y-21 + lower, 52, 10, 3, 3)
end

function DrawBalls()
	love.graphics.setColor(1, 1, 1)
	if table.getn(balls) > 0 then
		for i=1, (table.getn(balls)) do
			love.graphics.draw(ball , balls[i][1], balls[i][2], 0, 0.035, 0.035)
		end
	end
end

function DrawBombs()
	if table.getn(bombs) > 0 then
		for i=1, table.getn(bombs) do
			if bombs[i][6] == "fly" then
				love.graphics.setColor(0, 0, 0)
				love.graphics.rectangle("fill", bombs[i][1], bombs[i][2], 20, 20, 8, 8)
			else
				love.graphics.setColor(0.95, 0.8, 0.8)
				if bombs[i][7] < 0.1 then
					love.graphics.draw(boom, bombs[i][1] - 10, bombs[i][2] - 7, 0, 0.06, 0.06)
				else if bombs [i][7] < 0.25 then
					love.graphics.draw(boom, bombs[i][1] - 18, bombs[i][2] - 17, 0, 0.09, 0.09)
				else
					love.graphics.draw(boom, bombs[i][1] - 29, bombs[i][2] - 29, 0, 0.125, 0.125)
				end end
			end
		end
	end
end

function DrawEnemies()
	love.graphics.setColor(1, 1, 1)
	if table.getn(enemies) > 0 then
		for i=1, (table.getn(enemies)) do
			love.graphics.setColor(1, 1, 1)
			if enemies[i][6] == false then
				love.graphics.draw(enemy, enemies[i][1], enemies[i][2], 0, 0.25, 0.25)
			else
				love.graphics.draw(enemy2, enemies[i][1], enemies[i][2], 0, 0.25, 0.25)
			end

		--This code implements a health bar that displays the enemy's current health as a fraction of its original health.
			h = enemies[i][3] / enemyHealth * 50

			love.graphics.rectangle("fill", enemies[i][1] + 13, enemies[i][2] - 20, 50, 8, 3, 3)
			love.graphics.setColor(70/255, 150/255, 200/255)
			love.graphics.rectangle("fill", enemies[i][1] + 13, enemies[i][2] - 20, h, 8, 3, 3)

			love.graphics.setColor(.1, .1, .1)
			love.graphics.setLineWidth(2)
			love.graphics.rectangle("line", enemies[i][1] + 12, enemies[i][2] - 21, 52, 10, 3, 3)
		end
	end
end

function DrawGiants()
	love.graphics.setColor(1, 1, 1)
	if table.getn(giants) > 0 then
		for i=1, (table.getn(giants)) do
			love.graphics.setColor(1, 1, 1)
			if giants[i][4] > 0 then
				love.graphics.draw(giantr, giants[i][1], giants[i][2], 0, 0.411, 0.411)
			else
				love.graphics.draw(giantl, giants[i][1], giants[i][2], 0, 0.411, 0.411)
			end

		--This code implements a health bar that displays the giant's current health as a fraction of its original health.
			h = giants[i][3] / giantHealth * 50

			love.graphics.rectangle("fill", giants[i][1] + 32, giants[i][2] - 20, 50, 8, 3, 3)
			love.graphics.setColor(255/255, 80/255, 90/255)
			love.graphics.rectangle("fill", giants[i][1] + 32, giants[i][2] - 20, h, 8, 3, 3)

			love.graphics.setColor(.1, .1, .1)
			love.graphics.setLineWidth(2)
			love.graphics.rectangle("line", giants[i][1] + 31, giants[i][2] - 21, 52, 10, 3, 3)
		end
	end
end

function DrawInfo()
	if info == true then
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("fill", 275, 185, 650, 250, 20, 20)

		love.graphics.setLineWidth(8)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("line", 275, 185, 650, 250, 20, 20)
	
		love.graphics.setFont(midf)
		love.graphics.printf("Game Tips", 0, 210, Window_Width, 'center')

		love.graphics.setFont(smallf)
		love.graphics.printf("Sneaking Speeds You Up and Slows Enemies", 0, 270, Window_Width, 'center')
		love.graphics.printf("Jumping Slows Down Enemies", 0, 320, Window_Width, 'center')
		love.graphics.printf("Killing Enemies Increases Your Health!", 0, 370, Window_Width, 'center')
	end
end

function DrawTime()
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(midf)
--Converts the time variable into the standard presentation of minutes and seconds (0:00).
	if gameSecs < 10 then
		love.graphics.printf("Time " .. gameMins .. ":0" .. gameSecs, 880, 43, Window_Width, 'left')
	else
		love.graphics.printf("Time " .. gameMins .. ":" .. gameSecs, 880, 43, Window_Width, 'left')
	end
end

function DrawEnvironment()
	--Controls the  background and sky during every state of the game.
	love.graphics.setColor((skyb + 125)/255, (skyb + 125)/255, (skyb + 125)/255)
	love.graphics.draw(background, 0, 0)

	love.graphics.setColor(skyr/255, skyg/255, skyb/255)
	love.graphics.rectangle('fill', 0, 0, Window_Width, Window_Height - 112)

	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle('fill', 0, 0, Window_Width, 130, 10, 10)

	love.graphics.setColor(0, 0, 0)
	love.graphics.setLineWidth(8)
	love.graphics.rectangle('line', 0, 0, Window_Width, 130, 10, 10)

	love.graphics.setColor((skyb + 100)/255, (skyb + 100)/255, (skyb + 125)/255)
	love.graphics.draw(cloud9, clouds[3], 210, 0, .5, .5)
	love.graphics.draw(cloud1, clouds[2], 95, 0, .5, .5)
	love.graphics.draw(cloud2, clouds[1], 170, 0, .5, .5)
	love.graphics.draw(cloud3, clouds[4], 120, 0, .5, .5)
end