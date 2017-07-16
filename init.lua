local gbpinvisiable_trans={user={},en={}}
local gbpinvisiable_tool_hidden=1
minetest.register_alias("in", "gbpinvisiable:apple")

minetest.register_tool("gbpinvisiable:apple", {
	description = "gpi",
	range = 7,
	groups = {not_in_creative_inventory=gbpinvisiable_tool_hidden},
	inventory_image = "bubble.png^default_apple.png",
		on_use = function(itemstack, user, pointed_thing)
		local pos=user:getpos()
		if minetest.check_player_privs(user:get_player_name(), {kick=true})==false then
			minetest.chat_send_player(user:get_player_name(), "You need kick to use this")
			return itemstack
		end

		local en=minetest.add_entity(pos, "gbpinvisiable:en")
		user:set_attach(en, "",pos, pos)
		gbpinvisiable_trans.user=user
		gbpinvisiable_trans.en=en
		minetest.after(0.5,function()
		gbpinvisiable_trans.en:set_hp(0)
		gbpinvisiable_trans.en:punch(gbpinvisiable_trans.user, 1, "default:diamond_pick")
		gbpinvisiable_trans.user={}
		gbpinvisiable_trans.en={}
		end)
		return itemstack
		end,
})

minetest.register_entity("gbpinvisiable:en",{
	gbpinvisiabler=1,
	hp_max = 1,
	physical = true,
	weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"bubble.png"}, 
	colors = {}, 
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
})