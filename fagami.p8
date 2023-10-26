pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
function _init()
	create_perso1()
end

function _update()
	move_p1()
	update_cam()
end

function _draw()
	cls()
	draw_map()
	draw_perso1()
end
-->8
--map
function draw_map()
	map(0,0,0,0,128,64)
end

function update_cam()
	local camx=p1.x-64
	local camy=p1.y-32
	camera(camx,camy)
end

-->8
--perso
function create_perso1()
p1={
x=12,
y=20,
h=8,
w=8,
speed =1,
sprite=1}
end

function draw_perso1()
spr(1,p1.x,p1.y)
end

function move_p1()
	newx = p1.x
	newy = p1.y
	dir = ""
	if (btn(➡️))then
				newx=newx+1
				dir = "right"
	end
	
	if (btn(⬅️))then
				newx=newx-1
				dir = "left"
	end
	
	if (btn(⬆️))then
				newy=newy-1
				dir = "up"
	end
	
	if (btn(⬇️))then
				newy=newy+1
				dir = "down"
	end
	
	if not (check_flag(p1,dir,0)) then
		p1.x =mid(0,newx,127*8)
		p1.y =mid(0,newy,63*8)
	end
	
end
-->8
--collision

function check_flag(perso,aim,flag)
	local x=perso.x local h=perso.h
	local y=perso.y	local w=perso.w
	
	local x1=0  local x2=0
	local y1=0  local y2=0
	
	if aim=="left" then
				x1=x-1  y1=y
				x2=x    y2=y+h-1
				
	elseif aim=="right" then
				x1=x+w  		y1=y
				x2=x+1+w  y2=y+h-1
				
	elseif aim=="up" then
				x1=x+1    y1=y-1
				x2=x-1+w    y2=y
	
	elseif aim=="down" then
   	x1=x    y1=y+h
				x2=x+w    y2=y+h
	end
	
	x1/=8			y1/=8
	x2/=8			y2/=8
	
	if fget(mget(x1,y1),flag)
	or fget(mget(x1,y2),flag)
	or fget(mget(x2,y1),flag)
	or fget(mget(x2,y2),flag) then
			return true
	else
			return false
	end
end
__gfx__
0000000000444400004444007777766677777666aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa33c333330333330003333300600000066886686666664466
0000000004ffff0004ffff007d8d86667d8d8666aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa3aaa3aacccc3ccc3333f3303333f330049999406688866666664666
0070070004fcfc0004fcfc007777766677777666aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa3a3aaacccccccc3f0ff0303f0ff030044994406689886666664466
000770000fffff000fffff007777777777777777aaaaaaaaaaaaaaaaaaaaaaaaaaaa9aaaa33333aa3ccccccc33ffff3033ffff30000440006899986666664666
0007700009fff90009fff9f0dddd6667dddd6676aaaaaaaaaaaaaaaaaaaaaaaaaaa99aaaa3a3a3aacccccccc337777300337770304499440889a988666644466
00700700f09990f00f9990007777666677776666aaaaaaaaaaa4aaaaaaaaaaaaaa9999aa3aa4aa3accccc3c307dddd0007dddd000499994089aaa98666466646
000000000011100000111000d66d6666d66d6666aaaaaaaaaaaaaaaaaaaaaaaaa999999aaaa4aaaa3c3c3cc307bbbb0007bbbb000444444088aa7a8666466646
0000000000d0d000000d0d007667666667667666aaaaaaaaaaaaaaaaaaaaaaaa99999999aaa4aaaa33333cc307d00d00007d00d0000000006887786666644466
66666666aaaaaaaa44444444444aaaaaaaaaa404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa56666666600000000
66666666aaaaaaaa40404040404aaaaaaaaaa444a99999aaaaaaaaaaaaaaaaaaaaaaaaaaa99999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa556666666600000000
66666666aaaaaaaa44444444444aaaaaaaaaa40499aaa99aaaaaaaaaaaaaaaaaaaaaaaaa99aaa99aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa5556666666600000000
66666666aaaaaaaaaaaaaaaa404aaaaaaaaaa444aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9aa9aaaaaaaaaaaaaaaaaaaaaa556666666600000000
66666666aaaaaaaaaaaaaaaa444aaaaaaaaaa404aaa9999aaaaaaaaaaaaaaaaaaaaaaaaaaaa9999aaaa99a999aaaaaaaaaaaaaaaaaaaaaa56666666600000000
6666666644444444aaaaaaaa404aaaaaaaaaa444aa9aaaa9aaaaaaaaaaaaaaaaaaaaaaaaaa9aaaa9aa9999a999aaaaaaaaaaaaaaaaaaaaa56666666600000000
6666666604040404aaaaaaaa444aaaaaaaaaa404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999a999aaaaaaaaaaaaaaaaaaaa56666666600000000
6666666644444444aaaaaaaa404aaaaaaaaaa444999aaaaaaaaaaaaaaaaaaaaaaaaaaaaa999aaaaa99999999a999aaaaaaaaaaaaaaaaaaa56666666600000000
404aaaaaaaaaaaaaaaaaa404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa50000000000000000
044aaaaaaaaaaaaaaaaaa440aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa50000000000000000
444aaaaaaaaaaaaaaaaaa444aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa50000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa110000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa11810000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa444444aaaaaaaaaaaaaaaaaaaaaaaa4aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa4aaaaaaaaaaaaaaaa11110000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa440044aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1110000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa404404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa111110000000000000000
aaaaa404404aaaaa444444444444444469999996aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
aaaaa444444aaaaa040404044040404099999797aaaaaaaaaaaaaaaaaaaaaaaaa99999aaaaaaaaaaaaaaaaaaaaaaaaaaa99999aaaaaaaaaa0000000000000000
aaaaa404404aaaaa44444444444444449999979aaaaaaaaaaaaaaaaaaaaaaaaa99aaa99aaaaaaaaaaaaaaaaaaaaaaaaa99aaa99aaaaaaaaa0000000000000000
aaaaa444444aaaaaaaaaa404404aaaaa99999a99aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
aaaaa404404aaaaaaaaaa444444aaaaa699aaa96aaaaaaaaaaaaaaaaaaaaaaaaaaa9999aaaaaaaaaaaaaaaaaaaaaaaaaaaa9999aaaaaaaaa0000000000000000
4444444444444444aaaaa404404aaaaa66999966aaaaaaaaaaaaaaaaaaaaaaaaaa9aaaa9aaaaaaaaaaaaaaaaaaaaaaaaaa9aaaaaaaaaaaaa0000000000000000
0404040440404040aaaaa444444aaaaa66699666aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
4444444444444444aaaaa404404aaaaa99999a79aaaaaaaaaaaaaaaaaaaaaaaa999aaaaaaaaaaaaaaaaaaaaaaaaaaaaa999aaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505050505050505050505050505050505050505050505050505050505051617181516171815050925161718192a2b2c25093
a3b3c350505050607080505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
5050505050505050505050505050505050505050505050505050505050505050505050505050505050505052627282526272825050935262728293a3b3c35094
a4b4c450505051617181505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
5050505050505050505050505050505050505050505050505050505050505050505050505050505050505053637383536373835050945363738394a4b4c45050
50505050505052627282505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505053637383505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050705050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050507050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505070505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050507050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050705050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
50505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050
__gff__
0000000000000001000100000002000000010101010000000000000000000000010001010100000000000000000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1a151617180523111111112416171817182311111111111124051c051a1b1516171805050515161718050505151617180515161718051516171805151617180505050505050515161718050505151617180505050505151617180515161718050505050505051516171805050505050515161718051617181516171815161718
2a2526272815141010101031111111111130101010101010132b0909092b2526272805050525262728050505252627280525262728052526272805252627280505050505050525262728050505252627280505050505252627280525262728050505050505052526272805050505050525262728052627282526272825262728
3a15161723113010101010101010101010101010101010101307090a09073536373805050535363738050505353637380535363738053536373805353637380505050505050535363738050505353637380505050505353637380535363738050505050505053536373805051516171835363738053637383536373835363738
4a2505211d1010101010101010101010101010101010101013070909094b4546474805050545464748050505454647480545464748054546474805454647480505050505050545464748050505454647480505050505454647480545464748050805151617184546474808082526272845464748051617181516171815161718
1a3505212d10101010101033121212121232101010100d101305090905050505050505050505050505050505050505050505050505051516171805050505050505051516171805050505050505050505050505051516171805050505050505050505252627280505050505053536373815161718051617181516171815161718
2a45464722123210101010134546474805141010101010101305050905050505050515161718050505050515161718050505050505052526272817180505050505052526272805050505050515161718050505052526272805050515161718050505351516171805051516171846474825262728052627282526272825262728
3a2526272825141010101013191a1b1c05141010101010101305050523111111111111111111111124050525262728171805050505053536373827280505050505053536373805050505050525262728151617183536373805050525262728050505452526272805052526272805050535363738053637383536373835363738
4a3536373835141010101013292a2b2c05221212121212122005050514101010101010101010101013050535363738272805050505054546474837380505151617184546474805050505050535363738252627284546474805050535363738050505053536373805053536373805050545464748054647484546474845464748
054546474845141010331220393a3b3c05050535363738050505050514101010101010101010101013050545464748373805050505050505454647480505252627280505050505050505050545464748353637380505050505050545464748050505054546474805054546474805050505080505050505050505050505050505
050505050535141010134b4c494a4b4c05050505050505050505050514100e1010101010100310101305050607080505050505050505050505050505050505191a1b1c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
151617180545141010130505050505210505050505050505050505051410101010101010101010101305151617180523111111111111111111111111112405292a2b2c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
252627280505141010311111111111111111111111111111111111113010101010101010101010101305252627280514101010101010101010101010101305393a3b3c05050505191a1b1c0505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
353637380505141010101010101010101010101010101010101010101010101010101010101010101305353637380514101010101010101010101010101305494a4b4c05050505292a2b2c0505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
0505050505051410101010101010101010101010101010101010101010101010101010101010101013050506070805141010101010101010101010101013050505050505050505393a3b3c0505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
0505060708051410103312121212121212121212121212121212121232101010101010101010101013051516171805141010101010101010101010101013050505050505050505494a4b4c0505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
0515161718051410101315050505050515050505050515050505051514101010101010101010101013052526272805141010101010101010101010101013050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
052526272805141010130505050505050505050505050505050521152212121212121212121212122005353637380514101010101010101010101010101305050505191a1b1c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
053536373805141010311111111111111111111111111111111111111111111111111111111111111111111111111130101010101010101010101010101305050505292a2b2c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
050505050505141010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101305050505393a3b3c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
050505050505141010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010103410101305050505494a4b4c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
0505060708052212121212121212121212121212121212121212121212121212121212121212121212121212121212321010101010101010101010101013050505050505050505050505191a1b050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
0515161718050505050506070805050505060708050505050506070805050521212105050505060708050505050505141010101010101010101010101013050505050505050505050505292a2b050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
052526272805050505151617180505051516171805050505151617180505050505050607081516171805050505050514101010101010101010101010101305191a1b1c05050505050505393a3b050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
050505050505050505252627280505052526272805050505252627280505050505151617182526272805050607080514101010101010101010101010101305292a2b2c05050505050505494a4b050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
050505050505050505353637380505053536373805050505353637380505050505252627283536373805151617180514101010101010101010101010101305393a3b3c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
050505050505050505050505050505060708050505050607080505050505050505353637380505060708252627280514101010101010101010101010101305494a4b4c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
05050505050506070805050505051516171805050515161718050505050506070805050505051516171835363738051410101010101010101010101010130505191a1b1c050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
05050505051516171805050505052526272805050525262728050505051516171805050505052526272805050505051410101010101010101010101010130505292a2b2c05050505191a1b1c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
05050505052526272805050505053536373805050535363738050505052526272805050505053536373805050505051410101010101010101010101010130505393a3b3c05050505292a2b2c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
05050505053536373805050505050505050505050505050505050505050505050505050505050505050505050505052212121212121212121212121212200505494a4b4c05050505393a3b3c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505191a1b1c0505050505494a4b4c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050607080506070805051905060708191a1b1c05292a2b2c05050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505
