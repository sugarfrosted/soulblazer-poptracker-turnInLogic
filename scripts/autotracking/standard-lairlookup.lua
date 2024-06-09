local LAIR_ROM_OFFSET = 0xba0d
local LAIR_ROM_DATA_SIZE = 0x20
local LAIR_COORDINATE_OFFSET = 0x0b

-- [lair_id] = map x y (each is one byte)
local VANILLA_LAIR_LOCATIONS = {
  [0x002] = 0x051937,
  [0x006] = 0x05140b,
  [0x007] = 0x051f06,
  [0x008] = 0x054205,
  [0x009] = 0x0c0203,
  [0x00d] = 0x054221,
  [0x00e] = 0x05403b,
  [0x00f] = 0x060827,
  [0x010] = 0x060812,
  [0x011] = 0x06080a,
  [0x012] = 0x06181c,
  [0x013] = 0x080503,
  [0x015] = 0x063409,
  [0x016] = 0x06351b,
  [0x018] = 0x062d2e,
  [0x01a] = 0x062234,
  [0x01d] = 0x070404,
  [0x022] = 0x091a08,
  [0x023] = 0x091919,
  [0x025] = 0x0b051f,
  [0x028] = 0x06193e,
  [0x029] = 0x054b2c,
  [0x02a] = 0x062e1b,
  [0x02b] = 0x090203,
  [0x02c] = 0x0b0a0a,
  [0x02e] = 0x070334,
  [0x02f] = 0x09071a,
  [0x037] = 0x210203,
  [0x038] = 0x191456,
  [0x03c] = 0x190334,
  [0x03d] = 0x19102d,
  [0x03f] = 0x191c20,
  [0x040] = 0x190319,
  [0x041] = 0x200f05,
  [0x043] = 0x1a0f10,
  [0x046] = 0x1b170d,
  [0x049] = 0x1b0d24,
  [0x04a] = 0x1b171a,
  [0x04e] = 0x1c0f24,
  [0x04f] = 0x1c2d07,
  [0x050] = 0x220202,
  [0x051] = 0x1c3d22,
  [0x056] = 0x1d1b0f,
  [0x058] = 0x1e0c09,
  [0x059] = 0x1e270e,
  [0x05a] = 0x1e2225,
  [0x05b] = 0x1e152d,
  [0x05c] = 0x1f041f,
  [0x05d] = 0x1f0430,
  [0x061] = 0x1f2f04,
  [0x062] = 0x1f1c0a,
  [0x063] = 0x1f140a,
  [0x064] = 0x1f0a08,
  [0x06f] = 0x213816,
  [0x072] = 0x211d39,
  [0x07c] = 0x342726,
  [0x083] = 0x34561d,
  [0x084] = 0x345533,
  [0x086] = 0x346f2f,
  [0x08a] = 0x300424,
  [0x08b] = 0x301606,
  [0x08c] = 0x30170d,
  [0x08d] = 0x301611,
  [0x08e] = 0x30122e,
  [0x08f] = 0x301637,
  [0x092] = 0x30240d,
  [0x095] = 0x303805,
  [0x099] = 0x2e0f0e,
  [0x09b] = 0x2e0829,
  [0x09d] = 0x2e1926,
  [0x0a1] = 0x2e360c,
  [0x0a4] = 0x2e2321,
  [0x0a5] = 0x2e232a,
  [0x0a7] = 0x2f0918,
  [0x0ab] = 0x2f1913,
  [0x0ad] = 0x340e39,
  [0x0b1] = 0x2f151b,
  [0x0b5] = 0x2f0a23,
  [0x0b6] = 0x320e15,
  [0x0b9] = 0x310a07,
  [0x0bb] = 0x310620,
  [0x0bd] = 0x311931,
  [0x0be] = 0x312a31,
  [0x0c0] = 0x313b1a,
  [0x0c1] = 0x2a1328,
  [0x0c2] = 0x2a7926,
  [0x0c9] = 0x3e212a,
  [0x0ca] = 0x3e1739,
  [0x0cb] = 0x3e0a22,
  [0x0cc] = 0x3f1c09,
  [0x0d3] = 0x3f2c1e,
  [0x0d4] = 0x3f281e,
  [0x0d6] = 0x412320,
  [0x0d7] = 0x411811,
  [0x0dd] = 0x42283a,
  [0x0e1] = 0x421d24,
  [0x0e6] = 0x421624,
  [0x0e8] = 0x421131,
  [0x0e9] = 0x450f10,
  [0x0ea] = 0x452909,
  [0x0eb] = 0x450c26,
  [0x0ee] = 0x461b05,
  [0x0ef] = 0x460b19,
  [0x0f0] = 0x461419,
  [0x0f2] = 0x461038,
  [0x0f6] = 0x461c4c,
  [0x0f7] = 0x46085a,
  [0x0f8] = 0x47080d,
  [0x0fa] = 0x471213,
  [0x0fc] = 0x471a19,
  [0x0fe] = 0x470a37,
  [0x0ff] = 0x47183c,
  [0x103] = 0x44060b,
  [0x109] = 0x56080b,
  [0x10b] = 0x56022e,
  [0x10c] = 0x561407,
  [0x10d] = 0x561d11,
  [0x112] = 0x562b23,
  [0x114] = 0x562636,
  [0x11a] = 0x563921,
  [0x11b] = 0x563925,
  [0x11e] = 0x57080d,
  [0x120] = 0x570914,
  [0x122] = 0x570d2d,
  [0x126] = 0x57162e,
  [0x129] = 0x571c48,
  [0x12f] = 0x591617,
  [0x136] = 0x583734,
  [0x137] = 0x5b030e,
  [0x139] = 0x5b0d14,
  [0x13b] = 0x5b121d,
  [0x13c] = 0x5b0b1d,
  [0x13e] = 0x5b0c2e,
  [0x142] = 0x5b2a1b,
  [0x145] = 0x5b3130,
  [0x14a] = 0x5b3219,
  [0x14b] = 0x5b3a20,
  [0x14c] = 0x5c171a,
  [0x14d] = 0x5c0604,
  [0x152] = 0x5c143a,
  [0x153] = 0x5c2206,
  [0x155] = 0x5c3935,
  [0x159] = 0x660c07,
  [0x15a] = 0x661913,
  [0x15f] = 0x670a0f,
  [0x161] = 0x67041d,
  [0x162] = 0x670f1d,
  [0x166] = 0x67230b,
  [0x167] = 0x672319,
  [0x168] = 0x672b0f,
  [0x16b] = 0x680f1e,
  [0x16d] = 0x682217,
  [0x16e] = 0x682026,
  [0x170] = 0x68301d,
  [0x172] = 0x68392f,
  [0x179] = 0x6a1a07,
  [0x17e] = 0x6b090b,
  [0x17f] = 0x6b1615,
  [0x181] = 0x6c0309,
  [0x182] = 0x6c0d09,
  [0x183] = 0x6c0314,
  [0x185] = 0x6c1919,
  [0x186] = 0x6d0409,
  [0x187] = 0x6d161b,
  [0x18c] = 0x6d0f10,
  [0x18d] = 0x6e0e13,
  [0x18f] = 0x6e1a17,
  [0x192] = 0x6f170a,
  [0x195] = 0x721722
}

local function convertAddressToAbus( address )
  return ( ( address & 0xff8000 ) << 1 ) | 0x8000 | ( address & 0x7fff )
end


lairs = {}

function locateRomLairsFromMemorySegment( segment )

  if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    return
  end

  for lair_id, _ in pairs(VANILLA_LAIR_LOCATIONS) do
    local address = convertAddressToAbus(LAIR_ROM_OFFSET + (lair_id * LAIR_ROM_DATA_SIZE) + LAIR_COORDINATE_OFFSET)
    local map = segment:ReadUInt8(address)
    local coordX = segment:ReadUInt8(address + 1)
    local coordY = segment:ReadUInt8(address + 2)

    if map ~= nil and map > 0 and coordX ~= nil and coordX > 0 and coordY ~= nil and coordY > 0 then
      -- local coordinates = tonumber( string.format( "%02x%02x%02x", map, coordX, coordY ), 16 )
      local coordinates = (map << 16) + (coordX << 8) + coordY

      for other_lair_id, other_coordinates in pairs(VANILLA_LAIR_LOCATIONS) do
        if coordinates == other_coordinates then
          lairs[other_lair_id] = lair_id
        end
      end
    end

  end

end

function LairAddressLookup(lair_id)
  if not lairs[lair_id] then
    return 0
  else
    return LAIR_WRAM_OFFSET + lairs[lair_id]
  end
end

ScriptHost:AddMemoryWatch( "ROM Lair Data", convertAddressToAbus( LAIR_ROM_OFFSET ), 0x3480, locateRomLairsFromMemorySegment )