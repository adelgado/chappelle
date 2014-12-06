function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

function table.isarray(tbl)
  local numKeys = 0
  for _, _ in pairs(tbl) do
      numKeys = numKeys+1
  end

  local numIndices = 0
  for _, _ in ipairs(tbl) do
      numIndices = numIndices+1
  end

  return numKeys == numIndices
end
  -- body

function table.concatenate(t1, t2)
  local t3 = {}

  if (table.isarray(t1) and table.isarray(t2)) then
    for i,v in ipairs(t1) do
      t3[#t3 + 1] = t1[i]
    end

    for i,v in ipairs(t2) do
      t3[#t3 + 1] = t2[i]
    end
  end

  return t3
end


transofrm = function (rota)
  match = string.match(rota, ':')
  if not match then
    return rota -- route has no variables
  end

  local amountOfVariables
  for a in string.gmatch(rota, ':') do
    amountOfVariables = amountOfVariables + 1
  end

  local route = '' for i in 1,amountOfVariables do recursviveluy split a
  variavel no : e vai epgando cada string posterios, aí para a string em si a
  getne adiciona na strin gque vai ser retornaada comosendo a regex, e para o
  lucar aonde foi encontrado essa tr9ng a getne coloca um códigoq eua gente já
  sabe que é uma captua desse tipo (no caso, seri alago como'(%a-)'). aí a
  gente teria que aamrzenar tmambém a quantidade de variáveos juntoq cpm a
  rota, porque caso contrário a geente não saberia exatamente quantos
  argumetnos experar que uma rotas especícfica produza



  return pattern
end

local request
local match

for i from 0 to #rotas do
  match = matchRoute(rotas[i])
  if match then
    break
  end
end

function rota(rota)

  params = {}
  for param in string.gmatch(rota, ':(%a-)') do
    params[#params + 1] = param
  end

  return params
end
