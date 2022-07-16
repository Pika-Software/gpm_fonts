# gpm_fonts
 More convenient font creation

# Fonts lib
- `number` fonts.Count() - Get count of created fonts
- `table` fonts.GetAll() - Get all created fonts
- `font object` fonts.Add( `string` name, `string` font, `varang` sizes ) - Create font obj
- fonts.Remove( `string` name ) - Remove created font obj
- fonts.RegisterAll() - Force fonts update
 
 # Font object methods
 ```lua
    -- Physical Font
    font:GetFont()
    font:SetFont( font )

    -- Font sizes
    font:GetSizes()
    font:SetSizes( tbl )

    -- Weight
    font:GetWeight()
    font:SetWeight( int )

    -- Extented Font
    font:IsExtended()
    font:SetExtended( bool )

    -- Italic
    font:IsItalic()
    font:SetItalic( bool )
    
    -- Underline
    font:HasUnderline()
    font:SetUnderline( bool )

    -- Shadow
    font:HasShadow()
    font:SetShadow( bool )
```
