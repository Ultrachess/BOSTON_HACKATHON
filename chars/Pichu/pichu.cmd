[Command]
name = "CPU1"
command = U, D, B, F, a, b, c
time = 1

[Command]
name = "CPU2"
command = D, D, B, F, c, b, c
time = 1

[Command]
name = "CPU3"
command = U, D, F, B, a, b, c
time = 1

[Command]
name = "CPU4"
command = U, F, D, F, a, b, c
time = 1

[Command]
name = "CPU5"
command = F, D, F, U, a, b, c
time = 1

[Command]
name = "CPU6"
command = B, D, U, B, a, b, c
time = 1

[Command]
name = "CPU7"
command = F, D, F, F, a, b, c
time = 1

[Command]
name = "CPU8"
command = B, D, U, F, a, b, c
time = 1

[Command]
name = "CPU9"
command = B, D, B, B, a, b, c
time = 1

[Command]
name = "CPU10"
command = U, U, B, U, a, b, c
time = 1

[Command]
name = "CPU11"
command = D, F, B, D, a, b, c
time = 1

[Command]
name = "CPU12"
command = U, F, U, F, a, b, c
time = 1

[Command]
name = "CPU13"
command = U, B, F, B, a, b, c
time = 1

[Command]
name = "CPU14"
command = D, B, F, F, a, b, c
time = 1

[Command]
name = "CPU15"
command = U, F, U, F, a, b, c
time = 1
;=========================================================================

[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s
;-| Super Motions |--------------------------------------------------------
;The following two have the same name, but different motion.
;Either one will be detected by a "command = TripleKFPalm" trigger.
;Time is set to 20 (instead of default of 15) to make the move
;easier to do.
;
[Command]
name = "Electrobolt"
command = ~D, DF, F, x+y
time = 10

[Command]
name = "Electrobolt_Alt"
command = ~D, DB, B, x+y
time = 10
;-| Special Motions |------------------------------------------------------
;[Command]
;name = "slash"
;command = ~a
;time = 1

;[Command]
;name = "blam"
;command = ~b
;time = 1

;[Command]
;name = "FF_a"
;command = F, F, a

;[Command]
;name = "FF_b"
;command = F, F, b

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery";Required (do not remove)
command = x+y
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd";Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback";Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown";Required (do not remove)
command = /$D
time = 1

;[Command]
;name = "charge";Required (do not remove)
;command = /$a
;time = 1

;[Command]
;name = "charge1";Required (do not remove)
;command = /$b
;time = 1

;---------------------------------------------------------------------------
;STATE -1
;===========================================================================
[Statedef -1]

[State -1, Activate AI]
type = VarSet
trigger1 = command = "CPU1"
trigger2 = command = "CPU2"
trigger3 = command = "CPU3"
trigger4 = command = "CPU4"
trigger5 = command = "CPU5"
trigger6 = command = "CPU6"
trigger7 = command = "CPU7"
trigger8 = command = "CPU8"
trigger9 = command = "CPU9"
trigger10 = command = "CPU10"
trigger11 = command = "CPU11"
trigger12 = command = "CPU12"
trigger13 = command = "CPU13"
trigger14 = command = "CPU14"
trigger15 = command = "CPU15"
v = 59
value = 1

;[State -1,cpu display]
;type = DisplayToClipboard ; Pone el nombre en el debug
;trigger1 = var(59)=1 ; Condici�n para que ponga el texto
;text = "AI's the same, what else do you want?" ; Nombre del texto

;============================================================================
[state -1, cpu 100]
type = changestate
value = 100
triggerall = StateType = S
triggerall = var(59)=1
triggerall = ctrl
triggerall = stateno != [40,115]
triggerall = stateno != [100,50]
trigger1 = random < 30

[state -1, cpu 120]
type = changestate
value = 120
triggerall = StateType = S
triggerall = p2statetype != A
triggerall = var(59)=1
triggerall = ctrl
triggerall = stateno != [40,115]
trigger1 = p2bodydist y>= -5
trigger1 = random <= 30

[state -1, cpu 130]
type = changestate
value = 130
triggerall = StateType = S
triggerall = p2statetype != A
triggerall = var(59)=1
triggerall = ctrl
triggerall = stateno != [40,115]
trigger1 = p2bodydist y<= 5
trigger1 = random <= 30

[state -1, cpu 131]
type = changestate
value = 131
triggerall = StateType = C
triggerall = p2statetype != A
triggerall = p2statetype != S
triggerall = var(59)=1
triggerall = ctrl
triggerall = stateno != [40,115]
trigger1 = p2bodydist y<= 5
trigger1 = random <= 30

[state -1, cpu 132]
type = changestate
value = 132
triggerall = StateType = A
triggerall = p2statetype != A
triggerall = var(59)=1
triggerall = ctrl
triggerall = stateno != [40,115]
trigger1 = p2bodydist y<= 5
trigger1 = random <= 30

[State -1, cpu 200]
type = changestate
value = 200
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist x<= 40
trigger1 = random <= 30


[State -1, cpu 210]
type = changestate
value = 210
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = stateno = 230
trigger1 = movecontact
trigger1 = random <= 30

[State -1, cpu 220]
type = changestate
value = 220
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = statetype = S && p2bodydist y>= 20
trigger1 = ctrl
trigger1 = random <= 30
trigger2 = (stateno = 210) || (stateno = 200) || (stateno = 230)
trigger2 = (time >= 12) || (time >= 10)  || (time >= 5)
trigger2 = random <= 30

[State -1, cpu 230]
type = changestate
value = 230
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
trigger1 = stateno = 200
trigger1 = movecontact  && time >= 6
trigger1 = random <=30

[State -1, cpu 240]
type = changestate
value = 240
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
trigger1 = stateno = 230
trigger1 = movecontact  && time >= 6
trigger1 = random <=30

[State -1, cpu 250]
type = changestate
value = 250
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
trigger1 = stateno = 240
trigger1 = movecontact  && time >= 6
trigger1 = random <=30

[State -1, cpu 400]
type = changestate
value = 400
triggerall = StateType = C ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist x<= 40
trigger1 = random <= 30

[State -1, cpu 410]
type = changestate
value = 410
triggerall = StateType = C ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist x<= 40
trigger1 = random <= 30

[State -1, cpu 420]
type = changestate
value = 420
triggerall = StateType = C ;Si el char esta agachado.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist x<= 40
trigger1 = random <= 100

[State -1, cpu 600]
type = changestate
value = 600
triggerall = StateType = A ;Si el char esta de pie.
triggerall = p2statetype = A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist x<= 40
trigger1 = random <= 400
trigger2 = movecontact
trigger2 = 610
trigger2 = power >=1000
trigger3 = stateno = 600
trigger3 = movecontact && time > 8
value = 200

[State -1, cpu 610]
type = changestate
value = 610
triggerall = StateType = A ;Si el char esta de pie.
triggerall = p2statetype = A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist x<= 40
trigger1 = random <= 200
trigger2 = movecontact
trigger2 = 600
trigger2 = power >=1000
trigger3 = stateno = 600
trigger3 = movecontact

[State -1, cpu 620]
type = changestate
value = 620
triggerall = StateType = A ;Si el char esta de pie.
triggerall = p2statetype = A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist x<= 40
trigger1 = random <= 200
trigger2 = stateno = 600
trigger2 = time > 6
trigger3 = stateno = 610
trigger3 = time > 6

[State -1, cpu 1010]
type = changestate
value = 1010
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist x<= 90
trigger1 = random <= 30

;---------------------------------------------------------------------------
;[State -1, Kung Fu Throw]
;type = ChangeState
;value = 800
;triggerall = command = "z"
;triggerall = statetype = S
;triggerall = ctrl
;triggerall = stateno != 100
;trigger1 = command = "holdfwd"
;trigger1 = p2bodydist X < 3
;trigger1 = (p2statetype = S) || (p2statetype = C)
;trigger1 = p2movetype != H
;trigger2 = command = "holdback"
;trigger2 = p2bodydist X < 5
;trigger2 = (p2statetype = S) || (p2statetype = C)
;trigger2 = p2movetype != H
;---------------------------------------------------------------------------
[State -1, cpu 1000];blam
type = changestate
value = 1000
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist y>= 50
trigger1 = random <=10
trigger2 = p2bodydist x>= 70
trigger2 = random <=10

[State -1, cpu 1010];blam
type = changestate
value = 1010
triggerall = StateType = C ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = p2statetype != S ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist y>= 50
trigger1 = random <=10
trigger2 = p2bodydist x>= 70
trigger2 = random <=10

[State -1, cpu 1020];blam
type = changestate
value = 1020
triggerall = StateType = A ;Si el char esta de pie.
triggerall = p2statetype != S ; Si el oponente NO se encuentra en el aire.
triggerall = var(59)=1
triggerall = ctrl
trigger1 = p2bodydist y>= 50
trigger1 = random <=10
trigger2 = p2bodydist x>= 70
trigger2 = random <=10

[state -1,cpu Electrobolt_Alt]
type = changestate
value = 3000
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = ctrl
triggerall = var(59)=1
triggerall = stateno != [3000,3100]
trigger1= P2BodyDist X >= 50
trigger1 = power >=2000
trigger2 = p2life <= 150
trigger2 = power >=2100
trigger3 = power >=1600
trigger3 = stateno = 220
trigger3 = time = 12
trigger3 = random <= 100
trigger4 = power >=1800
trigger4 = stateno = 210
trigger4 = movecontact
trigger4 = random <= 40


[state -1,cpu Electrobolt]
type = changestate
value = 4000
triggerall = StateType = S ;Si el char esta de pie.
triggerall = p2statetype != A ; Si el oponente NO se encuentra en el aire.
triggerall = ctrl
triggerall = var(59)=1
triggerall = stateno != [3000,3100]
trigger1= P2BodyDist X >= 10
trigger1 = Random <= 100
trigger1 = power >=1600
trigger2 = Random <= 400
trigger2 = power >=3000
trigger3 = random <= 100
trigger3 = p2life <= 130
trigger3 = power >=1000
trigger4 = stateno = 220
trigger4 = time = 12
trigger4 = random <= 100
trigger5 = power >=1200
trigger5 = stateno = 220
trigger5 = time = 12
trigger5 = random <= 100
trigger6 = power >=1500
trigger6 = stateno = 210
trigger6 = movecontact
trigger6 = random <= 100
trigger7 = power >=1800
trigger7 = stateno = 220
trigger7 = movecontact
trigger7 = random <= 40
trigger8 = power >=2000
trigger8 = stateno = 230
trigger8 = movecontact
trigger8 = random <= 40
;===========================================================================
;This is not a move, but it sets up var(1) to be 1 if conditions are right
;for a combo into a special move (used below).
;Since a lot of special moves rely on the same conditions, this reduces
;redundant logic.
[State -1, Combo condition Reset]
type = VarSet
value = 100
trigger1 = 1
var(1) = 0
;Combo condition Check
[State -1, Combo condition Check]
type = VarSet
value = 100
trigger1 = statetype != A
trigger1 = ctrl
trigger2 = (stateno = [200,299]) || (stateno = [400,499])
trigger2 = stateno != 440 ;Except for sweep kick
trigger2 = movecontact
var(1) = 1
;============================================================================
[State -1, Electrobolt_Alt]
type = ChangeState
value = 3000
triggerall = command = "Electrobolt_Alt"
triggerall = power >= 1000
triggerall = statetype != A
trigger1 = ctrl
trigger2 = hitdefattr = SC, NA, SA, HA
trigger2 = stateno != [3000,3100]
trigger2 = movecontact
;---------------------------------------------------------------------------
[State -1, Electrobolt]
type = ChangeState
value = 4000
triggerall = command = "Electrobolt"
triggerall = power >= 1000
triggerall = statetype != A
trigger1 = ctrl
trigger2 = hitdefattr = SC, NA, SA, HA
trigger2 = stateno != [3001,3100]
trigger2 = movecontact
trigger3 = (stateno = 220) || (stateno = 420)
trigger3 = time>=16
;---------------------------------------------------------------------------
;Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 100
trigger1 = command = "FF"
trigger1 = statetype = S
trigger1 = ctrl
;---------------------------------------------------------------------------
;Run Back
;��ރ_�b�V��
[State -1, Run Back]
type = ChangeState
value = 105
trigger1 = command = "BB"
trigger1 = statetype = S
trigger1 = ctrl
;---------------------------------------------------------------------------
;[State -1,Throw]
;type = ChangeState
;value = 800
;triggerall = command = "z"
;triggerall = statetype = S
;triggerall = ctrl
;triggerall = stateno != 100
;trigger1 = command = "holdfwd"
;trigger1 = p2bodydist X < 3
;trigger1 = (p2statetype = S) || (p2statetype = C)
;trigger1 = p2movetype != H
;trigger2 = command = "holdback"
;trigger2 = p2bodydist X < 5
;trigger2 = (p2statetype = S) || (p2statetype = C)
;trigger2 = p2movetype != H
;===========================================================================
;---------------------------------------------------------------------------
;Punch 1
[State -1, Punch 1]
type = ChangeState
value = 200
triggerall = command = "x"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;Punch 2
[State -1, Punch 2]
type = ChangeState
value = 230
triggerall = command = "x"
triggerall = command != "holddown" && p2bodydist x<= 20
trigger1 = stateno = 200
trigger1 = movecontact && time >= 6
trigger1 = statetype = S

;Punch 2
[State -1, Punch 3]
type = ChangeState
value = 240
triggerall = command = "x"
triggerall = command != "holddown" && p2bodydist x<= 20
trigger1 = (stateno = 230)
trigger1 = movecontact  && time >= 6

;Punch 3
[State -1, Punch 3]
type = ChangeState
value = 210
triggerall = command = "y"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) || (stateno = 230) || (stateno = 240)
trigger2 = movecontact

;Punch 2
[State -1, Punch 3]
type = ChangeState
value = 250
triggerall = command = "y"
triggerall = command != "holddown" && p2bodydist x<= 20
trigger1 = stateno = 210
trigger1 = movecontact  && time >= 6
trigger2 = stateno = 240
trigger2 = movecontact  && time >= 6
;---------------------------------------------------------------------------
;Slash
[State -1, Slash]
type = ChangeState
value = 220
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = movecontact
trigger3 = stateno = 230
trigger3 = movecontact
trigger4 = stateno = 240
trigger4 = movecontact
trigger5 = stateno = 210
trigger5 = movecontact
trigger6 = stateno = 220
trigger6 = movecontact && time >= 50
trigger7 = stateno = 250
trigger7 = movecontact
;---------------------------------------------------------------------------
;---------------------------------------------------------------------------
;Taunt
[State -1, Taunt]
type = ChangeState
value = 195
triggerall = command = "start"
triggerall = command != "holddown"
triggerall = statetype != A
triggerall = ctrl
trigger1 = ctrl
trigger2 = var(1)
;--------------------------------------------------------------------------

;[State -1,charge]
;type = ChangeState
;value = 888
;triggerall = ctrl = 1
;trigger1 = command = "charge"
;trigger1 = command = "charge1"
;trigger1 = statetype = S
;---------------------------------------------------------------------------
;Crouching Light Punch
[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = command = "x"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 220) || (stateno = 420)
trigger2 = time >= 20

;---------------------------------------------------------------------------
;Crouching Strong Punch
[State -1, Crouching Strong Punch]
type = ChangeState
value = 410
triggerall = command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 400) || (stateno = 200)
trigger2 = (time > 10) || (time > 8)
;---------------------------------------------------------------------------
;Slide
[State -1, Slide]
type = ChangeState
value = 420
triggerall = command = "a"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Light Punch
[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = command = "x"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = (stateno = 600)
trigger2 = (time >= 16)
trigger3 = stateno = 1350 ;Air blocking
;---------------------------------------------------------------------------
;Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 610
triggerall = command = "y"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = movecontact && time > 8
trigger3 = stateno = 1350 ;Air blocking
trigger4 = stateno = 610
trigger4 = time > 16
;---------------------------------------------------------------------------
;Air Slash
[State -1, Air Slash]
type = ChangeState
value = 620
triggerall = command = "a"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = time > 6
trigger3 = stateno = 610
trigger3 = time > 6
;---------------------------------------------------------------------------
;Buster stand
[State -1, Buster stand]
type = ChangeState
value = 1000
triggerall = command = "b"
triggerall = statetype != A
triggerall = ctrl = 1
trigger1 = statetype = S

;---------------------------------------------------------------------------
;Buster Crouch
[State -1, Buster Crouch]
type = ChangeState
value = 1010
triggerall = command = "b"
triggerall = statetype = C
trigger1 = ctrl
trigger2 = stateno = 1010
trigger2 = statetime >= 12
;---------------------------------------------------------------------------
;Buster Air
[State -1, Buster Air]
type = ChangeState
value = 1020
triggerall = command = "b"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 1020
trigger2 = statetime >= 12

