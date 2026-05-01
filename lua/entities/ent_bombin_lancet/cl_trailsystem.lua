-- ============================================================
-- CONTRAIL SYSTEM  --  ent_bombin_lancet
-- Single persistent beam trail from the rear of the drone.
-- Unique hook names to avoid collision with other entities.
-- ============================================================

local TRAIL_MATERIAL = Material( "trails/smoke" )
local SAMPLE_RATE    = 0.025   -- 40 fps sampling

-- One emission point: rear of the drone.
-- Lancet is ~40 units long; -30 Y puts the point near the tail.
-- Tune if the trail appears mid-body rather than at the rear.
local TRAIL_OFFSET = Vector( 0, -30, 0 )

-- Contrail config: thin near drone, widens behind it.
local CONTRAIL_CFG = {
    r         = 255,
    g         = 255,
    b         = 255,
    a         = 130,
    startSize = 3,
    endSize   = 18,
    lifetime  = 6,
}

local LancetTrails = {}

local function EnsureRegistered( entIndex )
    if LancetTrails[entIndex] then return end
    LancetTrails[entIndex] = {
        nextSample = 0,
        positions  = {},
    }
end

local function DrawBeam( positions, cfg )
    local n = #positions
    if n < 2 then return end

    local Time = CurTime()
    local lt   = cfg.lifetime

    for i = n, 1, -1 do
        if Time - positions[i].time > lt then
            table.remove( positions, i )
        end
    end

    n = #positions
    if n < 2 then return end

    render.SetMaterial( TRAIL_MATERIAL )
    render.StartBeam( n )
    for _, pd in ipairs( positions ) do
        local Scale = math.Clamp( (pd.time + lt - Time) / lt, 0, 1 )
        local size  = cfg.startSize * Scale + cfg.endSize * (1 - Scale)
        render.AddBeam( pd.pos, size, pd.time * 50,
            Color( cfg.r, cfg.g, cfg.b, cfg.a * Scale * Scale ) )
    end
    render.EndBeam()
end

hook.Add( "Think", "bombin_lancet_contrail_update", function()
    local Time = CurTime()

    for _, ent in ipairs( ents.FindByClass( "ent_bombin_lancet" ) ) do
        EnsureRegistered( ent:EntIndex() )
    end

    for entIndex, state in pairs( LancetTrails ) do
        local ent = Entity( entIndex )
        if not IsValid( ent ) then
            LancetTrails[entIndex] = nil
            continue
        end

        if Time < state.nextSample then continue end
        state.nextSample = Time + SAMPLE_RATE

        local wpos = LocalToWorld( TRAIL_OFFSET, Angle(0,0,0), ent:GetPos(), ent:GetAngles() )
        table.insert( state.positions, { time = Time, pos = wpos } )
        table.sort( state.positions, function( a, b ) return a.time > b.time end )
    end
end )

hook.Add( "PostDrawTranslucentRenderables", "bombin_lancet_contrail_draw", function( bDepth, bSkybox )
    if bSkybox then return end
    for _, state in pairs( LancetTrails ) do
        DrawBeam( state.positions, CONTRAIL_CFG )
    end
end )
