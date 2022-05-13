if (SERVER) then
    return
end

local logger = GPM.Logger( "Fonts" )

module( "fonts", package.seeall )

local list = {}
local count = 0

function Count()
    return count
end

do
    local table_Copy = table.Copy
    function GetAll()
        return table_Copy( list )
    end
end

do
    local Font = {}
    Font.__index = Font

    -- Name of font .ttf file
    function Font:GetFont()
        return self.__font
    end

    function Font:SetFont( font )
        assert( type( font ) == "string", "bad argument #1 (string expected, got " .. type( font ) .. ")" )
        self.__font = font
    end

    -- Font sizes
    function Font:GetSizes()
        return self.__sizes
    end

    function Font:SetSizes( tbl )
        assert( type( tbl ) == "table", "bad argument #1 (table expected, got " .. type( tbl ) .. ")" )
        self.__sizes = tbl
    end

    -- Weight
    function Font:GetWeight()
        return self.__weight or 500
    end

    function Font:SetWeight( int )
        assert( type( int ) == "number", "bad argument #1 (number expected, got " .. type( int ) .. ")" )
        self.__weight = int
    end

    -- Extented Font
    function Font:IsExtended()
        return self.__extended or false
    end

    function Font:SetExtended( bool )
        self.__extended = bool == true
    end

    -- Italic
    function Font:IsItalic()
        return self.__italic or false
    end

    function Font:SetItalic( bool )
        self.__italic = bool == true
    end

    -- Underline
    function Font:HasUnderline()
        return self.__underline or false
    end

    function Font:SetUnderline( bool )
        self.__underline = bool == true
    end

    -- Shadow
    function Font:HasShadow()
        return self.__shadow or false
    end

    function Font:SetShadow( bool )
        self.__shadow = bool == true
    end

    do

        local surface_CreateFont = surface.CreateFont
        local ScreenProcent = ScreenProcent
        local ipairs = ipairs

        function Font:Register()
            local underline = self:HasUnderline()
            local extended = self:IsExtended()
            local shadow = self:HasShadow()
            local weight = self:GetWeight()
            local italic = self:IsItalic()
            local font = self:GetFont()

            for num, size in ipairs( self:GetSizes() ) do
                local registerName = self.__name .. "_" .. size
                surface_CreateFont(registerName, {
                    ["size"] = ScreenProcent( size ),
                    ["underline"] = underline,
                    ["extended"] = extended,
                    ["shadow"] = shadow,
                    ["italic"] = italic,
                    ["weight"] = weight,
                    ["font"] = font
                })

                logger:debug( "Registed: {1}", registerName )
            end
        end

    end

    do
        local setmetatable = setmetatable
        function Add( name, font, ... )
            local new = setmetatable( { ["__name"] = name }, Font )
            new:SetFont( font )
            new:SetSizes( {...} )

            list[ name ] = new
            count = count + 1

            return new
        end
    end

end

function RegisterAll()
    if (table.Count( list ) > 0) then
        logger:debug( "Registration ~ Started" )

        for name, font in pairs( list ) do
            font:Register()
        end

        logger:debug( "Registration ~ Finished" )
    else
        logger:debug( "Registration ~ No Fonts" )
    end
end

function Remove( name )
    if (list[ name ] ~= nil) then
        count = count - 1
        list[ name ] = nil
    end
end

hook.Add( "OnScreenSizeChanged", "GPM.Fonts", RegisterAll )
hook.Add( "InitPostEntity", "GPM.Fonts", RegisterAll )
hook.Add( "OnGameReady", "GPM.Fonts", RegisterAll )