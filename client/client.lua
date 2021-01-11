ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)


---Menu

local coiffeur = {
    'Changer de coupe',
    'Tailler la barbe',
    'Arranger les sourcils',
    '~g~Valider et payer'
}

barbershop = {
	Base = { Header = {"shopui_title_barber2", "shopui_title_barber2"}, Color = {color_black}, Title = "Création Personnage" },
	Data = { currentMenu = "Coiffeur" },
	Events = {

        onSelected = function(self,_, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
                local btn = btn.name 
                local slide = btn.slidenum
                local check = btn.unkCheckbox
            if btn == "Changer de coupe" then
                barbershop.Menu['Cheveux'].b = {}
                TriggerEvent('skinchanger:getData', function(components, maxVals)
                    for i=0 , maxVals.hair_1 do 
                    table.insert(barbershop.Menu["Cheveux"].b, {name = "Coiffure N°"..i,  price = 20 ,  advSlider = {0,63,0} , iterator = i})
                    end
                end)
                OpenMenu('Cheveux')
            elseif btn == "Tailler la barbe" then
                barbershop.Menu['Barbe'].b = {}
                TriggerEvent('skinchanger:getData', function(components, maxVals)
                    for i=0, maxVals.beard_1 do 
                        table.insert(barbershop.Menu['Barbe'].b, {name = "Barbe N°"..i , price = 20  , opacity = 0.5, advSlider = {0,63,0}, iterator = i})
                    end
                end)

                OpenMenu('Barbe')
            elseif btn == "Arranger les sourcils" then 
                barbershop.Menu['Sourcils'].b = {}
                TriggerEvent('skinchanger:getData', function(components, maxVals)
                    for i=0, maxVals.eyebrows_1 do 
                        table.insert(barbershop.Menu['Sourcils'].b, {name = "Sourcil N°"..i , price = 20  ,opacity = 0., advSlider = {0,63,0}, iterator = i})
                    end
                end)
                OpenMenu("Sourcils")
            elseif btn == "~g~Valider et payer" then
                destorycam()
                SetEntityCoords(PlayerPedId(), -821.76, -184.84, 37.56)
                SetEntityHeading(PlayerPedId(), 237.22)
                ClearPedTasks(GetPlayerPed(-1))
                TriggerServerEvent('::{[bngfujqio}}:::pay')
                FreezeEntityPosition(GetPlayerPed(-1), false)
                ESX.ShowNotification("∑ Vous avez payé ~g~ 20$")
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
				end)
                CloseMenu(true)
            end
        end,
        onButtonSelected = function(currentMenu, currentBtn, menuData, newButtons, self)

            if currentMenu == "Cheveux" then 
                for k,v in pairs(barbershop.Menu["Cheveux"].b) do 
                    if currentBtn - 1 == v.iterator then                
                        TriggerEvent('skinchanger:change', 'hair_1' , v.iterator)
                    end
                end
            end

            if currentMenu == 'Barbe' then 
                for k,v in pairs(barbershop.Menu['Barbe'].b) do 
                    if currentBtn - 1 == v.iterator then 
                        TriggerEvent('skinchanger:change', 'beard_1' , v.iterator)
                    end
                end
            end

            if currentMenu == 'Sourcils' then 
                for k,v in pairs(barbershop.Menu['Sourcils'].b) do 
                    if currentBtn - 1 == v.iterator then 
                        TriggerEvent('skinchanger:change', 'eyebrows_1' , v.iterator)
                    end
                end
            end



        end,

        onSlide = function(menuData,btn, currentButton, currentSlt)
            local currentMenu = menuData.currentMenu
            local slide = btn.slidenum
            local opacity = btn.opacity  
            local btn = btn.name
            
            
            if currentMenu == "Barbe" then 
                TriggerEvent('skinchanger:change', 'beard_2' , opacity*10)
                print(opacity)
            end
            if currentMenu == "Sourcils" then 
                TriggerEvent('skinchanger:change', 'eyebrows_2' , opacity*10)
            end
        end,


        onAdvSlide = function(self, btn , currentBtn, currentButtons)

            if self.Data.currentMenu == "Cheveux" then 
                for k,v in pairs(barbershop.Menu['Cheveux'].b) do 
                    if currentBtn.advSlider[3] == v.iterator then
                        TriggerEvent('skinchanger:change', 'hair_color_1', v.iterator) 
                    end
                end
            end
            if self.Data.currentMenu == "Barbe" then 
                
                for k,v in pairs(barbershop.Menu["Barbe"].b) do 
                    if currentBtn.advSlider[3] == v.iterator then 
                        TriggerEvent('skinchanger:change', 'beard_3', v.iterator) 
                    end
                end
            end

            if self.Data.currentMenu == "Sourcils" then 
                
                for k,v in pairs(barbershop.Menu["Sourcils"].b) do 
                    if currentBtn.advSlider[3] == v.iterator then 
                        TriggerEvent('skinchanger:change', 'eyebrows_3', v.iterator) 
                    end
                end
            end

        end,

},

	Menu = {
		["Coiffeur"] = {
			b = {
			}
        },
        ["Cheveux"] = {
            b = {

            }
        },
        ["Barbe"] = {
            b = {

            }
        },
        ["Sourcils"] = {
            b = {

            }
        },
    }
}

RegisterCommand("coiffeur", function()
    barbershop.Menu['Coiffeur'].b = {}
    for k,v in pairs(coiffeur) do
        table.insert(barbershop.Menu["Coiffeur"].b, {name = v  , ask = ">" , askX = true})
    end
    Wait(200)
    CreateMenu(barbershop)
end)


function round(exact, quantum)
    local quant,frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end

