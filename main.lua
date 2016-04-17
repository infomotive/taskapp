local widget = require("widget")

local top = display.statusBarHeight


local lists = {} -- source data
local listData = {}-- variable that holds the lists data, load from lists{}
local tableList = nil -- the tableView widget instance

local bgBorderCol = {0, 155, 200}
local bgCol = {0, 125, 170}
local textCol = {0, 0, 0}

lists = 
{
		{
			id = 1,
			title = 'Today',
			desc = 'what i must do today'
		}, 
		{
			id = 2, 
			title = 'queued',
			desc = 'Queued todo items, do sometime in the future'
		}, 
		{
			id = 3, 
			title = 'Presentation Preparation',
			desc = 'Tasks to do in preparation of the presentation'
		}
}

local function onRowRender(event)
		
		local row = event.row
		--local rowGroup = event.view
		local idx = row.index-- or 0
		local color = {1,0,0,0.5}

		--row:setFillColor(.5,.5,.5, 0)

		textTitle = display.newText( listData[idx].title, 0, 0, "Verdana", 14) 
		textTitle:setFillColor(unpack(textCol))
		textTitle:setReferencePoint(display.CenterLeftReferencePoint)
		textTitle.x = 20
		textTitle.y = row.contentHeight * 0.33 --20 --rowGroup.contentHeight * 0.33
		row:insert(textTitle)

		textDesc = display.newText(row, listData[idx].desc, 0, 0, "Verdana", 12) 
		textDesc:setFillColor(unpack(textCol))
		textDesc:setReferencePoint(display.CenterLeftReferencePoint)
		textDesc.x = 20
		textDesc.y = row.contentHeight * 0.66 --20 --rowGroup.contentHeight * 0.33

	

		lineSep = display.newLine( 0, row.contentHeight - 1, row.contentWidth, row.contentHeight - 1) --row.contentHeight, 0, row.contentWidth)
		--lineSep:setReferencePoint(display.CenterLeftReferencePoint)
		lineSep:setStrokeColor(unpack(bgBorderCol))
		lineSep.strokeWidth = 2
		row:insert(lineSep)

		print("called render ".. idx)

end -- onRowRender

local function rowListener(event)
	
	local row = event.row
	--local background = row.background
	local phase = event.phase

	if phase == "press" then
		print("pressed")
	elseif phase == "release" or phase == "tap" then
		print("release or tap")
	elseif phase == "swipeLeft" then
		print ("swipe left")
	elseif phase == "swipeRight" then
		print("swipeRight")
	end

end -- rowListener

local function setup()
	local bg = display.newRect(0, top, display.contentWidth, display.contentHeight - top)
	bg:setFillColor(unpack(bgBorderCol))

	tableList = widget.newTableView{
		onRowRender = onRowRender,
		--listener = rowListener,
		onRowTouch = rowListener,
		top = top + 10,
		left = 10, 
		height = display.contentHeight - top - 20, 
		width = display.contentWidth - 20,
		backgroundColor = {unpack(bgCol)},
		noLines = true
	}

end

local function loadData()
	for x = 1, #lists do
		listData[x] = {}
		listData[x].id = lists[x].id
		listData[x].title = lists[x].title
		listData[x].desc = lists[x].desc
		listData[x].due = math.random(1, 31) --..'/07/2016',
		listData[x].showDel = false
	end
end

local function showRecords()

	
	

	for x = 1, #listData do
		tableList:insertRow{
			--onRowRender = onRowRender,
			--listener = rowListener}
			rowHeight = 50,
			rowColor = {1, 0, 1},
			lineColor = {0,0,0}
		}
	end

end -- showRecords()


setup()

loadData()

showRecords()



function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

	print_r(listData)