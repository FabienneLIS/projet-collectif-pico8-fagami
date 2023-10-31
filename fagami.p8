pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
function _init()
	create_perso1()
	init_msg()
	init_msg_win()
	create_mummy()
	--mset(8,3,3)
	printh(m1.x)
	printh(m1.y)
end

function _update()
	if #messages==0 and 
				p1.win==0 then
		move_p1()
	end
		update_cam()
	 update_msg()
		update_msg_win()
		move_mummy(m1)	
		--move_mummy(m2)
		--move_mummy(m3)
end

function _draw()
	cls()
	draw_map()
	draw_msg()
	draw_mummy(m1)
	draw_perso1()
	draw_msg_win()
	--draw_mummy(m2)
	--draw_mummy(m3)
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
	h=8, --hauteur du perso
	w=8,	--largeur du perso
	speed=1,
	keys=0,
	dir = "",
	win=0 
	--sprite=1
	}
end
--animation du  perso en fonction
--des mouvements
function draw_perso1()
	if (btn(➡️))then
		spr(2,p1.x,p1.y)
	elseif (btn(⬅️))then
		spr(26,p1.x,p1.y)
					
	elseif (btn(⬆️))then
		spr(27,p1.x,p1.y)
		
	elseif (btn(⬇️))then
		spr(28,p1.x,p1.y)
	else
		spr(1,p1.x,p1.y)
	end
end

function move_p1()
	newx = p1.x
	newy = p1.y
	local test=0
	
	if (btn(➡️))then
				newx=newx+1
			p1.dir = "right"
	
	elseif (btn(⬅️))then
				newx=newx-1
				p1.dir = "left"
	
	elseif (btn(⬆️))then
				newy=newy-1
				p1.dir = "up"
	
	elseif (btn(⬇️))then
				newy=newy+1
				p1.dir = "down"
	end
		
	
	--verifie si on touche le flag collision
	if not (check_flag(p1,p1.dir,0)) then
		p1.x =mid(0,newx,127*8)
		p1.y =mid(0,newy,63*8)
	end
	
	--quand on touche la momie, on repart a 0
	if check_flag(p1,p1.dir,2) then
		p1.x=12
		p1.y=20
	end	

	--ramasser objet
	if check_flag(p1,p1.dir,1) then
		p1.keys+=1
		mset(22,4,30)
	end	
	if check_flag(p1,p1.dir,1) then
		p1.keys+=1
		mset(60,8,30)
	end
	
	-- creation du message de fin
	if (check_flag(p1,p1.dir,3))then	
		create_msg_win("victoire !\nvous avez survecu...\n[x]","...et vous avez vaincu\nla malediction!")
		p1.win=1
		update_msg_win()
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
				x2=x+w-1  		y2=y+h-1
				
	elseif aim=="up" then
				x1=x    		y1=y-1
				--x2=x-1+w    y2=y
				x2=x+w-1    		y2=y
	elseif aim=="down" then
   	x1=x   		 y1=y+h-1
				x2=x+w-1    y2=y+h
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
-->8
--messages
-- declare le tableau une fois termine
function init_msg()
		messages={}
		create_msg("nouvelle mission!","(appuyez sur [x]\npour continuer)","bonjour.","vous etes devant\nle tombeau maudit\ndu pharaon fagami.","ramassez\ntoutes les cles.","trouvez\nla coupe magique...","...pour briser\nla malediction.","ne vous laissez\npas attraper par\nvos ennemis...","sinon ce tombeau\nsera le votre!!!")
end

--affiche le nveau msg
function create_msg(name,...)
	msg_title=name --titre
	messages={...}
end


--affiche les msgs a la suite
function update_msg()
	if btnp(❎) then
		deli(messages,1)
	end
end

function draw_msg()
	if messages[1] then
	local y=32
		--titre
		rectfill(2,y,11+#msg_title*4,y+7,4)
		print(msg_title,6,y+2,7)
		--message
		rectfill(2,y+8,11+#msg_title*4,y+32,15)
		print(messages[1],6,y+11,4)
	end
end



-->8
--ennemy
function create_mummy()
	m1={
		x=144,y=24, 
		h=8, 	w=8,	
		speed =1,dir=true,--si true alors doit aller a droite si false a gauche
		maxx=184,minx=144,
		maxy=0,miny=0 
		}
	m2={
		x=166,y=48,
		h=8, 	w=8,	
		speed =2,dir=false,--si true alors doit aller a droite si false a gauche
		maxx=184,minx=144,
		maxy=0,miny=0 
		}
	m3={
		x=144,y=12,
		h=8, 	w=8,	
		speed =1,dir=false,--si true alors doit aller a droite si false a gauche
		maxx=0,minx=0,
		maxy=48,miny=8 
		}	
	
end

function draw_mummy(mummy)
	if mummy.dir then
		spr(3,mummy.x,mummy.y,1,1,false,false)
		mset(mummy.x/8,mummy.y/8,3)
	else
		spr(3,mummy.x,mummy.y,1,1,true,false)
		mset(mummy.x/8,mummy.y/8,3)
	end
end

function move_mummy(mummy)
		mset(mummy.x/8,mummy.y/8,16)
		--verifie si mvt en y=0
		if mummy.maxy==0 
		and mummy.miny==0 then	
			if mummy.dir==true then
				mummy.x+=mummy.speed
			else 
				mummy.x-=mummy.speed
			end
			if mummy.x==mummy.maxx then
				mummy.dir=false
			elseif mummy.x==mummy.minx then
				mummy.dir=true
			end
		
		--verifie si mvt en x=0	 
		elseif mummy.maxx==0 
		and mummy.minx==0 then	
		
			if mummy.dir==true then
				mummy.y+=mummy.speed
			else 
				mummy.y-=mummy.speed
			end
			
			if mummy.y==mummy.maxy then
				mummy.dir=false
			elseif mummy.y==mummy.miny then
				mummy.dir=true
			end
		end  
		

end
-->8
--message de fin
--dclare le msg de fin
function init_msg_win()
	msg_win={}
end

--cree le message de fin
function create_msg_win(...)
	msg_win = {...}
end

function draw_msg_win()
	if msg_win[1] then
		--local x=53		local y=17
		--local x1=61 local y1=19
		--titre
		--rectfill(x,y,x1+#msg_title*4,y1+7,4)
		--print(msg_title,x+4,y+2,7)
		--messagewin
	--	rectfill(422,132,500,172,15)
		print(msg_win[1],248,80,8)
	end
end
	
function update_msg_win()
	if btnp(❎) then
		deli(msg_win,1)
	end
end	
	



__gfx__
0000000000333300003333007777700000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa33c333330333330003333300600000060449944066664466
0000000003ffff0003ffff007d8d800000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa3aaa3aacccc3ccc3333f3303333f330049999400004400066664666
0070070003fefe0003fefe007777700000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa3a3aaacccccccc3f0ff0303f0ff030044994400000000066664466
000770000fffff000fffff007777777700000000aaaa9aa9aaaaaaaaaaaaaaaaaaaa9aaaa33333aa3ccccccc33ffff3033ffff30000440000000000066664666
00077000f8fff88f08fff88fdddd000700000000aaa99a999aaaaaaaaaaaaaaaaaa99aaaa3a3a3aacccccccc3377773003377703044994400449944066644466
00700700008880000f8880007777000000000000aa9999a999aaaaaaaaaaaaaaaa9999aa3aa4aa3accccc3c307dddd0007dddd00049999400499994066466646
000000000011100000111000d00d000000000000a999999a999aaaaaaaaaaaaaa999999aaaa4aaaa3c3c3cc307bbbb0007bbbb00044444400444444066466646
0000000000d0d000000d0d00700700000000000099999999a999aaaaaaaaaaaa99999999aaa4aaaa33333cc307d00d00007d00d0000000000000000066644466
66666666aaaaaaaa44444444444aaaaaaaaaa404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa003333000033330000333300aaaaaaa56666666600000000
66666666aaaaaaaa40404040404aaaaaaaaaa444aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa4444444400ffff3003ffff0003ffff00aaaaaa556666666600000000
66666666aaaaaaaa44444444444aaaaaaaaaa404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa4400004400efef3003fefe0003fefe00aaaaa5556666666600000000
66666666aaaaaaaaaaaaaaaa404aaaaaaaaaa444aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa4444444400fffff0fffffff00fffff00aaaaaa556666666600000000
66666666aaaaaaaaaaaaaaaa444aaaaaaaaaa404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa40000004f88fff8008fff80008fff800aaaaaaa56666666600000000
6666666644444444aaaaaaaa404aaaaaaaaaa444aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa44444444000888f000888000f08880f0aaaaaaa56666666600000000
6666666604040404aaaaaaaa444aaaaaaaaaa404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa44aaa000111000011100000111000aaaaaaa56666666600000000
6666666644444444aaaaaaaa404aaaaaaaaaa444aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa44aaa00d0d00000d0d00000d0d000aaaaaaa56666666600000000
404aaaaaaaaaaaaaaaaaa404aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa68866866040404048888888800000000aaaaaaa50000000000000000
044aaaaaaaaaaaaaaaaaa440aaaaaaaaaaaaaaaaa99999aaaaaaaaaaaaaaaaaaaaaaaaaa66888666404040408888888800000000aaaaaaa50000000000000000
444aaaaaaaaaaaaaaaaaa444aaaaaaaaaaaaaaaa99aaa99aaaaaaaaaaaaaaaaaaaaaaaaa66898866040404048888888800000000aaaaaaa50000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa68999866404040408888888800000000aaaaaa110000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999aaaaaaaaaaaaaaaaaaaaaaaaa889a9886040404048888888800000000aaaa11810000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa444444aaaaaaa9aaaa9aaaaaaaaaaaaaaaaaaaaaaaa89aaa986404040408888888800000000aaaa11110000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa440044aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa88aa7a86040404048888888800000000aaaaa1110000000000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa404404aaaaa999aaaaaaaaaaaaaaaaaaaaaaaaaaaaa68877866404040408888888800000000aaa111110000000000000000
aaaaa404404aaaaa444444444444444469999996aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
aaaaa444444aaaaa040404044040404099999797aaaaaaaaaaaaaaaaaaaaa4aaa99999aa00000000000000000000000000000000000000000000000000000000
aaaaa404404aaaaa44444444444444449999979aaaaaaaaaaaaaaaaaaaaaaaaa99aaa99a00000000000000000000000000000000000000000000000000000000
aaaaa444444aaaaaaaaaa404404aaaaa99999a99aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
aaaaa404404aaaaaaaaaa444444aaaaa699aaa96aaaaaaaaaaaaaaaaaaaaaaaaaaa9999a00000000000000000000000000000000000000000000000000000000
4444444444444444aaaaa404404aaaaa66999966aaaaaaaaaaaaaaaaaaaaaaaaaa9aaaa900000000000000000000000000000000000000000000000000000000
0404040440404040aaaaa444444aaaaa66699666aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000
4444444444444444aaaaa404404aaaaa99999a79aaaaaaaaaaaaaaaaaaaaaaaa999aaaaa00000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000aaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000aaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000aaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000aaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000aaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000aaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000aaaaaaaaaaaaaaaa0000000000000000
0000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0000000000000000aaaaaaaaaaaaaaaa0000000000000000
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
51515151515151515151506070805171817181716162506070618151515151515150607080516151615161516171516161715161516151617181516151615262
52625262526262625262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262
51515151515151515151516171815172827282725363516171818251515151515151617181526252625262526272526262725262526252627282526252626262
62705161516162627162626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262
51515151718151515151526272825171817181718171526272828171817181718152627282718151615171817181516151615161516151615161516151616262
62626262526252626262526262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262
51515151728251515151536373835172827282728272536373838272827282728253637383728252625272827282526252515262516252625151526252626262
62626262626262627362626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262
71817181718171817181718171817171817181718171817181718171817181718171817171817181718171817181718171815151515151515151516251615060
70806262626250607080626262506070806262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262
72827282728272827282728272827272827282728272827282728272827282728272718171817282728272827282728272825151515151515151516252625161
71816262626251617181626262516171816262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262
71817181718171817181718171817171817181718171817181718181718171817181728272827181718171817181718151515151515151515151516262625262
72826262626252627282626262526272826262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262
72827282728272827282728272827272827282728272827282728282728272827282718171817181728272827282718171815151515151515151516262625363
73836262626253637383626262536373836262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262
71817181718171817181718171817171817181718171817181718181718171817181728272827282718171817181728272825151515151515151516262625151
62515162516251515151515151516262516251626262515162626262515151626262626262626262626262626262626262626262626262626262626262626262
72827282728272827282728272827272827282728272827282728282728272827282718171817181728272827282718171817181718171815151515151515151
51515151515151515151515151515151515151515151515151515151515151516262626262626262626262626262626262626262626262626262626262626262
71817181718171817181718171817171817181718171817181718181718171817181718172827282718171817181728272827282728272825151515151515151
51515151515151515151515151515151515151515151515151515151515151516262626262626262626262626262626262626262626262626262626262626262
72827282728272827282728272827272827282728272827282728282728272827282728271817181728272827282718171817181718171815151515151515151
51515151515151515151515151515151515151515151515151515151515151515151626262626262626262626262626262626271816262626262626262626262
71817181718171817181718171817181817181718171817181718171817181817181728272827282718171817181728272827282728272825151515151515151
51515151515151515151515151515151515151515151515151515151515151515151515151625171817181718171817181718172826262626262626271817181
72827282728272827282728272827282827282728272827282728272827282827282718171817181728272827282718171817181718171817181515151515151
51515151515151515151515151515151515151515151515151515151515151515151515151515172827282728272827282728271817181718171817181827282
71817181718171817181718171817181817181718171817181718171817181718171817181718171817181718171817181718171818272827282515151515151
51515151515151515151718171817181718171817181515151515151515151515151515151517181817181718171817181718172827282728272827282817181
72827282728272827282728272827271817181718171817181728272827282728272827282728272827282728272827282728272828171817181718171817181
71817181718151515151728272827282728272827282718171817181718171817181718171817282827282728272827282728271817181718171817181827282
71817181718171817181718171817172827282728272827282718171817181718171817181718171817181718171817181718171818272827282728272827282
72827282728271817181718171817181718171817181728272827282728272827282728272827181817181718171817181728271817181728272827282817181
72827282728272827282728272827271817181718171817181728272827282728272827282728272827282728272827282728272828171817181718171817181
71817181718172827282728272827282728272827282718171817181718171817181718171817282827282728272827282718172827282718171817181827282
71817181718171817181718171817172827282728272827282718171817181718171817181718171817181718171817181718171818272827282728272827282
72827282728271817181718171817181718171817181728272827181728272827282728271817181817181717181817171818272828171728272827282817181
72827282728272827282728272718171817181718171817181728272827282728272827282728272827282728272827282728272828171817181718171817181
71817181718171817181718171817282728272827282718171817282718171817181718172827282827282727282827272827282728272827282728272827282
71817181718171817181718171728272827282728272827282718171817181718171817181718171817181718171817181718171818272827282728272827282
72827282728272827282728272827181718171817181718171817181728272827282728271817181718171817181718171817181718171817181718171817181
72827282728272827282728272718171817181718171817181728272827282728272827271817181718171817181718171817181828171817181718171817181
71817181718171817181718171817282728272827282728272827282718171817181718172827282728272827282728272827282728272827282728272827282
71817181718171817181718171728272827282728272827282718171817181718171815072827282728272827282728272827282728272827282728272827282
72827282728272827282728272827181718171817181718171817181728272827282728271817181718171817181718171817181718171817181718171817181
72827282728272827282728272718171817181718171817181728272827282728272825071817181718171817181718171817181718171817181718171817181
71817181718171817181718171817282728272827282728272827282718171817181718172827282728272827282728272827282728272827282728272827282
71817181718171817181718171728272827282728272827282505050505050507181718172827282728272827282728272827282728272827282728272827282
72827282728272827282728272827181718171817181718171817181728272827282728271817181718171817181718171817181718171817181718171817181
72827282728272827282728272827282728272827282718171817181718171817282728272827181718171718181718171817181718171817181718171817181
71817181718171817181718171817282728272827282728272827282728272827181718172827282728272827282728272827282728272827282728272827282
71817181718171817181718171817181718171817181728272827282728272827181718171817282728272728282728272827282728272827282728272827282
72827282728272827282728272827282728272827282728271817181718171817282728272827282728272827282728271817181718172827282728272827282
72827282728272827282728272827282728272827282718171817181718171817282728272827181718171817181718171817181718171817181718171817181
71817181718171817181718171817181718171817181718172827282728272827181718171817181718171817181718172827282718171817181718171817181
71817181718171817181718171817181718171817181728272827282728272827181718171817282728272827282728272827282728272827282728272827282
72827282728272827282728272827282728272827282728271817181718171817282728272827282728272827282728271817181728272827282728272827282
72827282728272827282728272827282728272827282718171817181718171817282728272827181718171817181718171817181718171817181718171817181
71817181718171817181718171817181718171817181718172827282728272827181718171817181718171817181718172827282718171817181718171817181
71817181718171817181718171817181718171817181728272827282728271817181718171817282728272827282728272827282728272827282728272827282
72827282728272827282728272827282728272827282728271817181718171817282728272827282728272827282728271817181728272827282728272827282
72827282728272827282728272827282728272827282718171817181718172827282728272827181718171817181718171817181718171817181718171817181
71817181718171817181718171817181718171817181718172827282728272827181718171817181718171817181718172827282718171817181718171817181
__gff__
0000000400000000000100000002000200010101010000000003000000000000010001010100000000010100000000000101010108000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0715161718072311111111241617181718231111111111112428272827281516171805060708272827282728272827282728272827282728272827282728272827282728272827282728272827282728272827282728272817180515171817182728272827282728272827282728272808161705272827282728272827282728
0725261928161429101029311111111111301010101010101316090909162526272815161718262715161715161718281516171828050607082805060705060708050607050607080705060708252627050605060708252605060708272827281617181516171815161718161715161718262715161718282526272825262728
0715161617113010101010101010101010101010101010101307090a09073536373805060705060725262725262728382526272838151617183815161715161718151617151617181715161718353637151615161718353615161718362728252627282526272825262728262725262728363725262728383536373835363738
072607211d101010101010101010101010101010101010101307090909164546474815161715161735363735363738483536373848252627284825262725262728252627252627282725262728050607252625262728454625262728463738353637383536373835363738363735363738464735363738181516171815161718
073507212d10101010101033121212121232101010100f101316090916161616161625262725262728050607171717070506070506353637381835363735363738353637353637383735363738151617353635363738171835363738050607353637383536373805060708050636373815161718050607081516171815161718
0745264717123229101029134516472626141010101010101316160916161616161635363735363717151617181516171516171516050607082835360506070506070826272805060705060726252627280506070826272805060708151617050607081516171815161718151626260708262728151617182526272825262728
0726231111113010101010130716162626141010101010101316161623111111111111111111111124252627281726271726272526151617183827281516171516171836373815161715161718353637381516171836373815161718252627151617182526272825262728252626161718363738252627283536373835363738
0735141010101010101010132516161626221212121212122016161614101010101010101010101013353637383536231111111111111111111111111111111111111111111111111111112428363738252526272846474825262728353637252627283536373835363738353626262728464726353637384526262645464748
26451410101010101033122023111111111111112437381616161616141010101010101034101010131516151615161410102a10101010101010102a0f101010101010101010101010102a1326262626263536372626260726263738464748353637384546474826262646474826363726262626072637262626072626260708
26261410103312121220254c14101010101010101326261616161616141010101010101010101010132526172617261410102a10101010101010102a10101010101010101010101010102a1326262626262626262626262626262626262626262607262626072626262626262626262626262616172626262626262626261718
26261410101321212121262614101010101010101326261616161616141010101010101010101010131516161715161410101010102a2a2a2a10102a2a2a2a2a2a2a2a2a2a10102a2a2a2a1326050607082626262626262626262626261718152626262616171815261718262618151617262526272626262626272826262728
25261410103111111111111130101033123210101321212121212121141010101010101010101010131726262717261410101010102a10102a10102a10101010102a10102a10102a10102a1326151617182626262626262626262626262728252627282526272826262626262728252627263536372626272836373835263738
2636141010101010101010101010101321141010132121212121212114101010101010101010101013151636371716142a2a2a2a2a2a10101010102a10101010102a10102a10101010102a1326252627282626262626262626262635363738353637383536372626263738363738353637262626072626262626262626260708
26261410101010101010101010101013211410103111111111111111301010101010101010101010132526170717261410101010102a10101010102a10102a2a2a2a10102a10101010102a1326353637382626262626262626262626262728252627282505060708050607080506070805062608050626081516171815161718
26262212121232101033121212121220211410101010101010101010101010101010101010101010131516161715161410101010102a2a2a2a10102a10102a10102a10102a2a2a2a10102a1326262626262626262626262626262635363717353637173515161718151617181516171815161718151617182526272825262728
26262623111130101013152626262626261410101010101010101010101010101010101010101010132526262725261410102a10101010101010101010102a10102a10102a10102a10102a1326262626262626262626262626262626260708050607080517262728252627282526272825262728252627262626262626262626
26262614101010101013262626262626262212121212121212121212121212121212121212121212201516363715161410102a10101010101010101010102a10102a10102a10102a10102a1326262626262626262626262626262626161718151617181707083738353637263536373835363738353637261516171815161718
2626261410101010103111111111111111112421212121212121212311111111111111112421212121212311111111302a2a2a10102a2a2a1010102a2a2a2a10102a10102a10102a1010101326050607082626262626262626262625262728252627281617180506070826262626262626262626261707262626272825262728
262626141010331232101010101010101010132121212121212121141010101010101010132121212121141010101010101010101010102a1010101010101010102a10101010102a2a10101326151617182626262626262626262635363717353637382627281516171826262626262626262626261617182626373835363738
262626141010132114101010101010101010132121212121212121141010101010101010132121212121141010101010101010101010102a1010101010101010102a1010101010102a10101326252627282626262626262626262626262626262626353637382526272826262626262626262626262627282626262626262626
16151614101013211410103312121232101013212121212121212114101033121232101013212121212114101033123210102a2a2a10102a2a2a2a2a2a2a1010102a2a2a2a2a10102a10101326353637382626262626262626262626262626262626262626262626262626262626262626262626263637382626261815162626
26252614101031113010101316151614101013231111111111112414101013231130101013211516231130101013161410102a101010102a10101010102a101010101010101010101010101326262626262626262626262626262626262626262626262626262626262626262626262626262626262728052526272626262726
16150514101010101010101307082614101013141010101010101314101013141010101013212517141010101013261410102a101010102a10101010102a101010101010101010101010101316262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
26251514101010101010101317181614101031301010101010101314101013141010101013231111301010101013261410102a10102a2a2a10102a10102a2a2a2a10102a10102a2a2a10101316262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
16151622121212121212122027282614101010101010333210101314101013141010331220141010101010331220161410102a101010101010102a10101010102a10102a10102a101010101326262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
26163536372121252615353637381614101010101010131410103130101013141010311111301010101010133717261410102a101010101010102a10101010102a10102a10102a101010101326262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
16151615161516072625262526162622121212121212201410101010101013141010101010101010331212203715161410102a2a2a2a2a1010102a2a2a2a10102a10102a10102a2a2a10101326050607082626262626262626262626262626262626262626262626262626262626262626262626262626262626262626052626
2625261626162617161516151615162625261516171825141010101010101314101010101010101013050607082526141010101010102a1010101010102a10102a10102a101010102a10101326151617182626262626262626262626262626262626262626262626262626262626262626262626262626262626262626050505
1505060708162627261526252625263615162526272815221212121212122022121212121212121220151617181516141010101010102a1010101010102a10102a10102a101010102a10101326252627282626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
1515161718353637151515151515152728273536373816262526162616262526151515151525261726252627281726221212121212121212121212121212121212121212121212121212122026353637382626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
1525262728151515151515151515151718171817050607161516151615161516151515151515161717171717171716161516151615161516151615161516252625262526252626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
1535363738151515151515151515152728272827151617181626162625262526151515151525262517172625262526262526252625262526252625262526151615161516151626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
__sfx__
01011500000001f000256002000028000240002b000250002f0002b00027000015000050000500005000050000500005000000000000000000000000000000000000000000000000000000000000000000000000
