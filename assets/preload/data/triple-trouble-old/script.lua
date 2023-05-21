local allowCountdown = false
local xx = 550;
local yy = 700;
local xx2 = 850;
local yy2 = 700;
local ofs = 30;
local followchars = true;

function onCreate()
    addCharacterToList('jr-right', 'dad');
    addCharacterToList('don-ramon-left', 'dad');
    addCharacterToList('don-ramon-right', 'dad');
    addCharacterToList('sr_barriga-down', 'dad');
    addCharacterToList('chavo-scared', 'boyfriend');
    addCharacterToList('el-chavo-red', 'boyfriend');
    addCharacterToList('chavo-perspective', 'boyfriend');
end

function onUpdate()
	if dadName == 'quico' then
		xx = 450
		yy = 650
	end
	if dadName == 'sr_barriga-down' then
		xx = 450
		yy = 500
	end
	if boyfriendName == 'el-chavo-red' then
	                  xx2 = 770
		yy2 = 650
	end
	if dadName == 'jr-right' then
		xx = 830
		yy = 620
	end
	if dadName == 'don-ramon-old' then
		xx = 430
		yy = 230
	end
	if dadName == 'don-ramon-right' then
		xx = 1430
		yy = 480
	end
	if boyfriendName == 'el-chavo' then
		xx2 = 800
		yy2 = 310
	end
	if boyfriendName == 'chavo-yellow' then
		xx2 = 800
		yy2 = 650
	end
	if boyfriendName == 'chavo-perspective' then
		xx2 = 920
		yy2 = 650
	end
	if boyfriendName == 'chavo-perspective-left' then
		xx2 = 980
		yy2 = 650
	end
	if boyfriendName == 'chavo-scared' then
		xx2 = 400
		yy2 = 650
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end