function love.load(args)
    -- control --
    gamestate = require 'libraries.control.gamestate'
    camera = require 'libraries.control.camera'
    timer = require 'libraries.control.timer'
    loveconsole = require 'libraries.control.loveconsole'
    -- filesystem --
    json = require 'libraries.filesystem.json'
    nativefs = require 'libraries.filesystem.nativefs'
    lip = require 'libraries.filesystem.lip'
    xml = require 'libraries.filesystem.xml'
    -- interface --
    suit = require 'libraries.interface.suit'
    gui = require 'libraries.interface.gspot'
    slab = require 'libraries.interface.slab'
    -- post processing --
    moonshine = require 'libraries.post-processing.moonshine'
    -- physics --
    bump = require 'libraries.physics.bump'
    -- utilities --
    collision = require 'libraries.utilities.collision'
    -- Basic 3D engine --
    g3d = require 'libraries.3D.g3d'

    slab.SetINIStatePath(nil)
    slab.Initialize(args)

    currentProject = ""

    -- addons loader --
    Addons = love.filesystem.getDirectoryItems("libraries/addons")
    for addon = 1, #Addons, 1 do
        require("libraries.addons." .. string.gsub(Addons[addon], ".lua", ""))
    end

    -- default filter --
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- state loader--
    States = love.filesystem.getDirectoryItems("src/States")
    for state = 1, #States, 1 do
        require("src.States." .. string.gsub(States[state], ".lua", ""))
    end

    -- every argument passed to the game will direct to console
    if #args > 0 then
        loveconsole:run(table.concat(args, " "))
    end


    --% Create folders %--
    love.filesystem.createDirectory("Projects")

    gamestate.registerEvents()
    gamestate.switch(editorstate)
end