---@diagnostic disable: undefined-doc-name, lowercase-global

------------------------------------------------------------
-- Version: Stand 110.12 14/12/2023 00:04
------------------------------------------------------------

--- [[ Globals ]] ---

--- A string containing the name of your script (this excludes .lua).
SCRIPT_NAME = "<string>"

--- A string containing the name of your script file.
SCRIPT_FILENAME = "<string>"

--- A string containing the path to your script file from the Lua Scripts folder.
SCRIPT_RELPATH = "<string>"

--- A bool indicating if your script was started in direct response to a user action.
SCRIPT_MANUAL_START = "<boolean>"

--- A bool indicating if a silent start of your script is desired.
SCRIPT_SILENT_START = "<boolean>"


--- Click Type ---

CLICK_WEB = 16
CLICK_FLAG_CHAT = 8
CLICK_WEB_COMMAND = 17
CLICK_AUTO = 5
CLICK_CHAT_ALL = 8
CLICK_HOTKEY = 2
CLICK_FLAG_WEB = 16
CLICK_SCRIPTED = 7
CLICK_BULK = 4
CLICK_COMMAND = 1
CLICK_MENU = 0
CLICK_FLAG_AUTO = 4
CLICK_CHAT_TEAM = 9

INVALID_GUID = -1


--- [[ Menu Functions ]] ---

--- Menu functions for the Stand API.
--- [Click to view the official documentation](https://stand.gg/help/lua-api-documentation#menu-functions)
menu = {}

--- Returns a reference to the list that your script gets when it is started.
--- @return CommandRef
function menu.my_root() end

--- Returns a reference to the list that the given player owns. Note that the returned reference may be invalid even if called in an on_join handler.
--- @param player_id int
--- @return CommandRef
function menu.player_root(player_id) end

--- Using return value of this function to create a command produces a detached commmand (CommandUniqPtr) instead of a CommandRef.
--- @return CommandRef
function menu.shadow_root() end

--- Returns a reference to any command in Stand using a path such as Self>Immortality.
--- Note that the path has to be in English (UK) and using the no-space greater-than separator.
--- Providing a tree version is optional but highly recommended for future-proofing.
--- You can find this in any tree config file, such as your profile.
--- @param path string
--- @param tree_version int?
--- @return CommandRef
function menu.ref_by_path(path, tree_version) end

--- Returns a reference to any command in Stand using a path such as Self>Immortality.
--- However, this takes a base like `Self` so `path` can (i.e) be `Immortality`.
--- @param base int
--- @param path string
--- @return CommandRef
function menu.ref_by_rel_path(base, path) end

--- @param command_name string
--- @return CommandRef
function menu.ref_by_command_name(command_name) end

--- Creates a list inside of the menu with `parent` numeric ID.
--- @param parent CommandRef
--- @param menu_name string
--- @param command_names table<any, string>
--- @param help_text Label
--- @param on_click function?
--- @param on_back function?
--- @param on_active_list_update function?
--- @return CommandRef|CommandUniqPtr
function menu.list(parent, menu_name, command_names, help_text, on_click, on_back, on_active_list_update) end

--- Create a very basic clickable button inside menu `parent`.
---
--- `perm` may be any of:
--- - COMMANDPERM_FRIENDLY
--- - COMMANDPERM_NEUTRAL
--- - COMMANDPERM_SPAWN
--- - COMMANDPERM_RUDE
--- - COMMANDPERM_AGGRESSIVE
--- - COMMANDPERM_TOXIC
--- - COMMANDPERM_USERONLY
---
--- Your on_click function will be called with click_type and effective_issuer. The click type could be any of:
--- - CLICK_MENU
--- - CLICK_COMMAND
--- - CLICK_HOTKEY
--- - CLICK_BULK
--- - CLICK_AUTO
--- - CLICK_SCRIPTED
--- - CLICK_WEB
--- - CLICK_WEB_COMMAND
--- - CLICK_CHAT_ALL
--- - CLICK_CHAT_TEAM
---
--- And could match any or neither of these bitflags:
--- - CLICK_FLAG_AUTO
--- - CLICK_FLAG_CHAT
--- - CLICK_FLAG_WEB
---
--- Your `on_command` function will be called with the provided arguments, click_type, and effective_issuer.
--- If `on_command` is not provided, commands will be redirected to on_click.
--- @param parent CommandRef
--- @param menu_name string
--- @param command_names table<any, string>
--- @param help_text Label
--- @param on_click function?
--- @param on_command function?
--- @param syntax string?
--- @param perm int?
--- @return CommandRef|CommandUniqPtr
function menu.action(parent, menu_name, command_names, help_text, on_click, on_command, syntax, perm) end

--- Your `on_change` function will be called with on and click_type.
--- @param parent CommandRef
--- @param menu_name string
--- @param command_names table<any, string>
--- @param help_text Label
--- @param on_change function
--- @param default_on boolean?
--- @return CommandRef|CommandUniqPtr
function menu.toggle(parent, menu_name, command_names, help_text, on_change, default_on) end

--- Your `on_tick` function will be called every tick that the toggle is checked.
--- You should not call util.yield in this context.
--- @param parent CommandRef
--- @param menu_name string
--- @param command_names table<any, string>
--- @param help_text Label
--- @param on_tick function
--- @param on_stop function?
--- @return CommandRef|CommandUniqPtr
function menu.toggle_loop(parent, menu_name, command_names, help_text, on_tick, on_stop) end

--- Your `on_change` function will be called with value, prev_value and click_type.
--- @param parent CommandRef
--- @param menu_name string
--- @param command_names table<any, string>
--- @param help_text Label
--- @param min_value int
--- @param max_value int
--- @param default_value int
--- @param step_size int
--- @param on_change function
--- @return CommandRef|CommandUniqPtr
function menu.slider(parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_change) end

--- Your `on_change` function will be called with value, prev_value and click_type.
---
--- Note that the float variant is practically identical except the last 2 digits are indicated to be numbers after the decimal point.
--- The precision can be changed with menu.set_precision.
--- @param parent CommandRef
--- @param menu_name string
--- @param command_names table<any, string>
--- @param help_text Label
--- @param min_value int
--- @param max_value int
--- @param default_value int
--- @param step_size int
--- @param on_change function
--- @return CommandRef|CommandUniqPtr
function menu.slider_float(parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_change) end

--- Your `on_click` function will be called with value and click_type.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param min_value int
--- @param max_value int
--- @param default_value int
--- @param step_size int
--- @param on_click function
--- @return CommandRef|CommandUniqPtr
function menu.click_slider(parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_click) end

--- Your `on_click` function will be called with value and click_type.
---
--- Note that the float variant is practically identical except the last 2 digits are indicated to be numbers after the decimal point.
--- The precision can be changed with menu.set_precision.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param min_value int
--- @param max_value int
--- @param default_value int
--- @param step_size int
--- @param on_click function
--- @return CommandRef|CommandUniqPtr
function menu.click_slider_float(parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_click) end

--- `options` must be table of list action item data.
--- List action item data is an index-based table that contains value, menu_name, command_names, help_text, and category.
--- Value and menu_name are mandatory.
---
--- Your `on_change` function will be called with the option's value, the option's menu_name, the previous option's value, and click_type as parameters.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param options table<int, table>
--- @param default_value int
--- @param on_change function
--- @return CommandRef|CommandUniqPtr
function menu.list_select(parent, menu_name, command_names, help_text, options, default_value, on_change) end

--- `options` must be table of list action item data.
--- List action item data is an index-based table that contains value, menu_name, command_names, help_text, and category.
--- Value and menu_name are mandatory.
---
--- Your `on_item_click` function will be called with the option's value, the option's menu_name, and click_type as parameters.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param options table<int, table>
--- @param on_item_click function
--- @return CommandRef|CommandUniqPtr
function menu.list_action(parent, menu_name, command_names, help_text, options, on_item_click) end

--- Your `on_change` function will be called with the string and click type.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param on_change function
--- @param default_value string?
--- @return CommandRef|CommandUniqPtr
function menu.text_input(parent, menu_name, command_names, help_text, on_change, default_value) end

--- Your `on_change` function will be called with Colour and click type.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param default Colour
--- @param transparency boolean
--- @param on_change function
--- @return CommandRef|CommandUniqPtr
function menu.colour(parent, menu_name, command_names, help_text, default, transparency, on_change) end

--- Your `on_change` function will be called with Colour and click type.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param default_r number
--- @param default_g number
--- @param default_b number
--- @param default_a number
--- @param transparency boolean
--- @param on_change function
--- @return CommandRef|CommandUniqPtr
function menu.colour(parent, menu_name, command_names, help_text, default_r, default_g, default_b, default_a, transparency, on_change) end

--- Creates a rainbow slider for the given colour command.
--- This should be called right after creating the colour command.
--- @param colour_command CommandRef
--- @return CommandRef|CommandUniqPtr
function menu.rainbow(colour_command) end

--- Creates a rainbow slider inside of the given colour command.
--- This should be called right after creating the colour command.
--- @param colour_command CommandRef
--- @return CommandRef|CommandUniqPtr
function menu.inline_rainbow(colour_command) end

--- @param parent CommandRef
--- @param menu_name Label
--- @return CommandRef|CommandUniqPtr
function menu.divider(parent, menu_name) end

--- Pairs well with menu.on_tick_in_viewport and menu.set_value.
--- @param parent CommandRef
--- @param menu_name Label
--- @param value string?
--- @return CommandRef|CommandUniqPtr
function menu.readonly(parent, menu_name, value) end

--- @param parent CommandRef
--- @param menu_name Label
--- @param link string
--- @param help_text Label?
--- @return CommandRef|CommandUniqPtr
function menu.hyperlink(parent, menu_name, link, help_text) end

--- Your `on_click` function will be called with the option's index, the option's value, and click_type as parameters.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param options table<int, Label>
--- @param on_click function
--- @return CommandRef|CommandUniqPtr
function menu.textslider(parent, menu_name, command_names, help_text, options, on_click) end

--- Your `on_click` function will be called with the option's index, the option's value, and click_type as parameters.
--- @param parent CommandRef
--- @param menu_name Label
--- @param command_names table<any, string>
--- @param help_text Label
--- @param options table<int, Label>
--- @param on_click function
--- @return CommandRef|CommandUniqPtr
function menu.textslider_stateful(parent, menu_name, command_names, help_text, options, on_click) end

--- @param parent CommandRef
--- @param menu_name Label
--- @param command_name string
--- @param single_only boolean? [default = false] 
--- @return CommandRef|CommandUniqPtr
function menu.player_list_players_shortcut(parent, menu_name, command_name, single_only) end

--- @param parent CommandRef
--- @param target CommandRef
--- @param show_address_in_corner boolean? [default = false]
--- @return CommandRef|CommandUniqPtr
function menu.link(parent, target, show_address_in_corner) end

--- Loads state & hotkeys for commands you've created without needing to yield,
--- although note that your script is always expected to create all (stateful) commands in the first tick.
function menu.apply_command_states() end

--- Delete a command or menu.
--- @param command CommandRef
function menu.delete(command) end

--- @param old CommandRef
--- @param new CommandUniqPtr
--- @return CommandRef
function menu.replace(old, new) end

--- @param command CommandRef
--- @return CommandUniqPtr
function menu.detach(command) end

--- @param parent CommandRef
--- @param command CommandUniqPtr
--- @return CommandRef
function menu.attach(parent, command) end

--- @param anchor CommandRef|CommandUniqPtr
--- @param command CommandUniqPtr
--- @return CommandRef
function menu.attach_after(anchor, command) end

--- @param anchor CommandRef|CommandUniqPtr
--- @param command CommandUniqPtr
--- @return CommandRef
function menu.attach_before(anchor, command) end

--- Returns if the referenced command still exists.
--- @param ref CommandRef
--- @return boolean
function menu.is_ref_valid(ref) end

--- Focus a command or menu.
--- @param command CommandRef
function menu.focus(command) end

--- @param command CommandRef
--- @return boolean
function menu.is_focused(command) end

--- @param command CommandRef
--- @param include_user boolean?
--- @return table<int, int>
function menu.get_applicable_players(command, include_user) end

--- @param command CommandRef
--- @return CommandRef
function menu.get_parent(command) end

--- The type may equal one of these values:
---
--- - COMMAND_LINK
--- - COMMAND_ACTION
--- - COMMAND_ACTION_ITEM
--- - COMMAND_INPUT
--- - COMMAND_TEXTSLIDER
--- - COMMAND_TEXTSLIDER_STATEFUL
--- - COMMAND_READONLY_NAME
--- - COMMAND_READONLY_VALUE
--- - COMMAND_READONLY_LINK
--- - COMMAND_DIVIDER
--- - COMMAND_LIST
--- - COMMAND_LIST_CUSTOM_SPECIAL_MEANING
--- - COMMAND_LIST_PLAYER
--- - COMMAND_LIST_COLOUR
--- - COMMAND_LIST_HISTORICPLAYER
--- - COMMAND_LIST_READONLY
--- - COMMAND_LIST_REFRESHABLE
--- - COMMAND_LIST_CONCEALER
--- - COMMAND_LIST_SEARCH
--- - COMMAND_LIST_NAMESHARE
--- - COMMAND_LIST_ACTION
--- - COMMAND_LIST_SELECT
--- - COMMAND_TOGGLE_NO_CORRELATION
--- - COMMAND_TOGGLE
--- - COMMAND_TOGGLE_CUSTOM
--- - COMMAND_SLIDER
--- - COMMAND_SLIDER_FLOAT
--- - COMMAND_SLIDER_RAINBOW
---
--- List types will return a non-zero value if ANDed with COMMAND_FLAG_LIST.
---
--- Additionally, if you AND the type with COMMAND_FULLTYPEFLAG, you may find the result to equal one of the following:
---
--- - COMMAND_FLAG_LIST
--- - COMMAND_FLAG_LIST_ACTION
--- - COMMAND_FLAG_TOGGLE
--- - COMMAND_FLAG_SLIDER
---
--- Note that not all commands in Stand are physical, e.g. COMMAND_LINK can only take on the appearance of another command.
--- You can use type >= COMMAND_FIRST_PHYSICAL to check if a command type is physical.
--- @param command CommandRef
--- @return int
function menu.get_type(command) end

--- @param list CommandRef
--- @return table<int, CommandRef>
function menu.get_children(list) end

--- @param list CommandRef
--- @return CommandRef
function menu.list_get_focus(list) end

--- Removes invalidated weakrefs from an internal vector.
--- Stand does this automatically, but if you bulk-delete-or-replace commands, you might want to call this right after.
--- @return int
function menu.collect_garbage() end

--- Is Stand open?
--- @return boolean
function menu.is_open() end

--- Returns the menu grid origin x & y.
--- @return number, number
function menu.get_position() end

--- Returns x, y, width, & height for the current main view (active list, warning, etc.).
--- @return number, number, number, number
function menu.get_main_view_position_and_size() end

--- Returns a reference to the current menu list, which ignores the context menu.
--- @return CommandRef
function menu.get_current_menu_list() end

--- Returns a reference to the current UI list, which can include the context menu.
--- @return CommandRef
function menu.get_current_ui_list() end

--- Returns the cursor text of the current UI list.
--- @param even_when_disabled boolean? [default = false]
--- @param even_when_inappropriate boolean? [default = false]
--- @return string
function menu.get_active_list_cursor_text(even_when_disabled, even_when_inappropriate) end

--- @return boolean
function menu.are_tabs_visible() end

--- @param prefill string
function menu.show_command_box(prefill) end

--- @param click_type int
--- @param prefill string
function menu.show_command_box_click_based(click_type, prefill) end

--- @param input string
function menu.trigger_commands(input) end

--- @param command CommandRef
--- @param arg string
function menu.trigger_command(command, arg) end

--- @return boolean
function menu.command_box_is_open() end

--- Returns x, y, width, & height.
--- @return number, number, number
function menu.command_box_get_dimensions() end

--- @return boolean
function menu.is_in_screenshot_mode() end

--- @param command CommandRef
--- @param callback function
--- @return int
function menu.on_tick_in_viewport(command, callback) end

--- @param command CommandRef
--- @param callback function
--- @return int
function menu.on_focus(command, callback) end

--- @param command CommandRef
--- @param callback function
--- @return int
function menu.on_blur(command, callback) end

--- @param command CommandRef
--- @param handler_id int
--- @return boolean
function menu.remove_handler(command, handler_id) end

--- If command points to a link, its target is returned. Otherwise, command is returned.
--- @param command CommandRef|CommandUniqPtr
--- @return Label
function menu.get_physical(command) end

--- You might want to use lang.get_string on the return value.
--- @param command CommandRef|CommandUniqPtr
--- @return Label
function menu.get_menu_name(command) end

--- @param command CommandRef|CommandUniqPtr
--- @return table<int, string>
function menu.get_command_names(command) end

--- You might want to use lang.get_string on the return value.
--- @param command CommandRef|CommandUniqPtr
--- @return Label
function menu.get_help_text(command) end

--- @param command CommandRef|CommandUniqPtr
--- @return string
function menu.get_name_for_config(command) end

--- @param command CommandRef
--- @return boolean
function menu.get_visible(command) end

--- @param command CommandRef
--- @return int|bool|string
function menu.get_value(command) end

--- @param command CommandRef
--- @return int
function menu.get_min_value(command) end

--- @param command CommandRef
--- @return int
function menu.get_max_value(command) end

--- @param command CommandRef
--- @return int
function menu.get_step_size(command) end

--- For float sliders.
--- @param command CommandRef
--- @return int
function menu.get_precision(command) end

--- For lists. See menu.set_indicator_type for possible values.
--- @param command CommandRef
--- @return int
function menu.get_indicator_type(command) end

--- For links.
--- @param command CommandRef
--- @return CommandRef
function menu.get_target(command) end

--- @param command CommandRef
--- @return string
function menu.get_state(command) end

--- @param command CommandRef
--- @return string
function menu.get_default_state(command) end

--- @param command CommandRef
--- @return string
function menu.apply_default_state(command) end

--- @param command CommandRef|CommandUniqPtr
--- @param menu_name Label
function menu.set_menu_name(command, menu_name) end

--- @param command CommandRef|CommandUniqPtr
--- @param command_names table<any, string>
function menu.set_command_names(command, command_names) end

--- @param command CommandRef|CommandUniqPtr
--- @param help_text Label
function menu.set_help_text(command, help_text) end

--- If empty (which is the default), the name for config is the English (UK) translation of the menu_name,
--- but if you change the menu_name of a command or have multiple commands in the same list with the same name,
--- this will help the state and hotkeys system to keep the association.
--- @param command CommandRef|CommandUniqPtr
--- @param name_for_config string
function menu.set_name_for_config(command, name_for_config) end

--- @param command CommandRef
--- @param visible boolean
function menu.set_visible(command, visible) end

--- @param command CommandRef
--- @param value int|bool|string
function menu.set_value(command, value) end

--- @param command CommandRef
--- @param min_value int
function menu.set_min_value(command, min_value) end

--- @param command CommandRef
--- @param max_value int
function menu.set_max_value(command, max_value) end

--- @param command CommandRef
--- @param step_size int
function menu.set_step_size(command, step_size) end

--- For float sliders.
--- @param command CommandRef
--- @param precision int
function menu.set_precision(command, precision) end

--- For lists. Possible values for indicator_type:
--- - LISTINDICATOR_ARROW
--- - LISTINDICATOR_ARROW_IF_CHILDREN
--- - LISTINDICATOR_OFF
--- - LISTINDICATOR_ON
--- @param command CommandRef
--- @param indicator_type int
function menu.set_indicator_type(command, indicator_type) end

--- For links.
--- @param command CommandRef
--- @param target CommandRef
function menu.set_target(command, target) end

--- Also works for list_select.
--- @param command CommandRef
--- @param options table<int, table>
function menu.set_list_action_options(command, options) end

--- @param command CommandRef
--- @param options table<int, Label>
function menu.set_textslider_options(command, options) end

--- For number sliders.
--- @param command CommandRef
--- @param value int
--- @param replacement string
function menu.add_value_replacement(command, value, replacement) end

--- Commands marked as "temporary" will not have state or hotkey options and can't be added to "Saved Commands."
--- However, they will still have their state set to default in the script stop process.
--- @param command CommandRef
function menu.set_temporary(command) end

--- `skippable` will not have an effect when "Force Me To Read Warnings" is disabled.
--- @param command CommandRef
--- @param click_type int
--- @param message string
--- @param proceed_callback function
--- @param cancel_callback function?
--- @param skippable boolean? [default = false]
function menu.show_warning(command, click_type, message, proceed_callback, cancel_callback, skippable) end

--- Returns a 32-bit int derived from the user's activation key. 0 if no activation key.
--- Don't try to attain people's activation keys with this, there may be consequences.
--- @return int
function menu.get_activation_key_hash() end

--- Returns a value between 0 and 3 depending on the user's edition.
--- @return int
function menu.get_edition() end

--- full -- "Stand 0.93.1" -- "Stand 0.93.1-preview1"
---
--- version -- "0.93.1" -- "0.93.1-preview1"
---
--- version_target -- "0.93.1" -- "0.93.1"
---
--- branch -- nil -- "preview1"
---
--- brand -- "Stand" -- "Stand"
---
--- game -- "1.67-3028" -- "1.67-3028"
--- @return table<string, string>
function menu.get_version() end

--- [[ End of 'menu' functions. ]] ---
--- [[ Start of 'players' functions. ]] ---

--- Player functions for the Stand API.
--- [Click to view the official documentation.](https://stand.gg/help/lua-api-documentation#players-functions)
players = {}

--- Registers a function to be called when a player should have script features added.
--- Your callback will be called with the player id and player root as arguments.
---
--- Note that although your callback may yield, it should create all player commands in the same tick as it is called.
--- @param callback function
--- @return int
function players.add_command_hook(callback) end

--- Registers a function to be called when a player joins the session.
--- Your callback will be called with the player id as argument.
---
--- Note that although your callback may yield, you should create all player commands in the same tick as you receive the event.
--- @param callback function
--- @return int
function players.on_join(callback) end

--- Registers a function to be called when a player leaves the session.
--- Your callback will be called with the player id and name as arguments.
--- @param callback  function
--- @return int
function players.on_leave(callback) end

--- Calls your join handler(s) for every player that is already in the session.
function players.dispatch_on_join() end

--- Checks if a player with the given id is in session.
--- @param player_id int
--- @return boolean
function players.exists(player_id) end

--- Alternative to the PLAYER.PLAYER_ID native.
--- @return int
function players.user() end

--- Alternative to the PLAYER.PLAYER_PED_ID native.
--- @return int
function players.user_ped() end

--- Returns an index-based table with all matching player ids.
--- @param include_user boolean? [default = true]
--- @param include_friends boolean? [default = true]
--- @param include_strangers boolean? [default = true]
--- @return table<int, int>
function players.list(include_user, include_friends, include_strangers) end

--- Returns an index-based table with all matching player ids.
--- @param include_user boolean? [default = false]
--- @param include_friends boolean? [default = false]
--- @param include_crew_members boolean? [default = false]
--- @param include_org_members boolean? [default = false]
--- @return table<int, int>
function players.list_only(include_user, include_friends, include_crew_members, include_org_members) end

--- Returns an index-based table with all matching player ids.
--- @param include_user boolean? [default = false]
--- @param include_friends boolean? [default = false]
--- @param include_crew_members boolean? [default = false]
--- @param include_org_members boolean? [default = false]
--- @return table<int, int>
function players.list_except(include_user, include_friends, include_crew_members, include_org_members) end

--- Like players.list but using Players > All Players > Excludes.
--- @param include_user boolean? [default = false]
--- @return table<int, int>
function players.list_all_with_excludes(include_user) end

--- @return int
function players.get_host() end

--- @return int
function players.get_script_host() end

--- Returns an index-based table containing the ids of all players focused in the menu.
--- @return table<int, int>
function players.get_focused() end

--- @param player_id int
--- @return string
function players.get_name(player_id) end

--- @param player_id int
--- @return int
function players.get_rockstar_id(player_id) end

--- Returns 4294967295 if unknown.
--- @param player_id int
--- @return int
function players.get_ip(player_id) end

--- Returns 0 if unknown.
--- @param player_id int
--- @return int
function players.get_port(player_id) end

--- Returns 4294967295 if the player is not connected via P2P.
--- @param player_id int
--- @return int
function players.get_connect_ip(player_id) end

--- Returns 0 if the player is not connected via P2P.
--- @param player_id int
--- @return int
function players.get_connect_port(player_id) end

--- Returns 4294967295 if unknown.
--- @param player_id int
--- @return int
function players.get_lan_ip(player_id) end

--- Returns 0 if unknown.
--- @param player_id int
--- @return int
function players.get_lan_port(player_id) end

--- @param player_id int
--- @return boolean
function players.are_stats_ready(player_id) end

--- @param player_id int
--- @return int
function players.get_rank(player_id) end

--- @param player_id int
--- @return int
function players.get_rp(player_id) end

--- @param player_id int
--- @return int
function players.get_money(player_id) end

--- @param player_id int
--- @return int
function players.get_wallet(player_id) end

--- @param player_id int
--- @return int
function players.get_bank(player_id) end

--- @param player_id int
--- @return number
function players.get_kd(player_id) end

--- @param player_id int
--- @return int
function players.get_kills(player_id) end

--- @param player_id int
--- @return int
function players.get_deaths(player_id) end

--- Returns the same as the LOCALIZATION.GET_CURRENT_LANGUAGE native.
--- @param player_id int
--- @return int
function players.get_language(player_id) end

--- @param player_id int
--- @return boolean
function players.is_using_controller(player_id) end

--- @param player_id int
--- @return string
function players.get_name_with_tags(player_id) end

--- @param player_id int
--- @return string
function players.get_tags_string(player_id) end

--- @param player_id int
--- @return boolean
function players.is_godmode(player_id) end

-- Returns true if the player has the "Modder" tag.
--- @param player_id int
--- @return boolean
function players.is_marked_as_modder(player_id) end

-- Returns true if the player has the "Modder or Admin" tag.
--- @param player_id int
--- @return boolean
function players.is_marked_as_modder_or_admin(player_id) end

-- Returns true if the player has the "Admin" tag.
--- @param player_id int
--- @return boolean
function players.is_marked_as_admin(player_id) end

--- @param player_id int
--- @return boolean
function players.is_marked_as_attacker(player_id) end

--- @param player_id int
--- @return boolean
function players.is_otr(player_id) end

--- @param player_id int
--- @return boolean
function players.is_out_of_sight(player_id) end

--- @param player_id int
--- @return boolean
function players.is_in_interior(player_id) end

--- @param player_id int
--- @return boolean
function players.is_typing(player_id) end

--- @param player_id int
--- @return boolean
function players.is_using_vpn(player_id) end

--- @param player_id int
--- @return boolean
function players.is_visible(player_id) end

--- Returns the player's host token as a decimal string.
--- @param player_id int
--- @return string
function players.get_host_token(player_id) end

--- Returns the player's host token as a 16-character padded hex string.
--- @param player_id int
--- @return string
function players.get_host_token_hex(player_id) end

--- Returns the position or 0 if not applicable.
--- @param player_id int
--- @return string
function players.get_host_queue_position(player_id) end

--- Returns an index-based table with all matching player ids, sorted in ascending host queue order.
--- @param include_user boolean? [default = true]
--- @param include_friends boolean? [default = true]
--- @param include_strangers boolean? [default = true]
--- @return table<int, int>
function players.get_host_queue(include_user, include_friends, include_strangers) end

--- Returns -1 if not applicable.
--- @param player_id int
--- @return int
function players.get_boss(player_id) end

--- Returns -1 for none, 0 for CEO, or 1 for Motorcycle Club.
--- @param player_id int
--- @return int
function players.get_org_type(player_id) end

--- Returns -1 if not applicable. If you want the HUD colour, add 192 to the return value.
--- @param player_id int
--- @return int
function players.get_org_colour(player_id) end

--- @param player_id int
--- @return string
function players.clan_get_motto(player_id) end

--- Works correctly at all distances.
--- @param player_id int
--- @return userdata
function players.get_position(player_id) end

--- Works at all distances, but best when the user is close to them.
--- @param player_id int
--- @return int
function players.get_vehicle_model(player_id) end

--- @param player_id int
--- @return boolean
function players.is_using_rc_vehicle(player_id) end

--- Returns the value of the player's bounty or nil.
--- @param player_id int
--- @return int?
function players.get_bounty(player_id) end

--- Receipient must be a friend or member of the same non-Rockstar crew; doesn't work on self. 
--- Message must be 1-255 characters.
--- @param recipient int
--- @param text string
function players.send_sms(recipient, text) end

--- @param player_id int
--- @return Vector3
function players.get_cam_pos(player_id) end

--- @param player_id int
--- @return Vector3
function players.get_cam_rot(player_id) end

--- Returns a player id or -1 if not applicable.
--- @param player_id int
--- @return int
function players.get_spectate_target(player_id) end

--- Returns X, Y, Z, and a bool to indicate if the Z is guessed. Z will always be guessed for remote players.
--- @param player_id int
--- @return number, number, number, bool
function players.get_waypoint(player_id) end

--- The address of the player's CNetGamePlayer/rage::netPlayer instance or 0.
--- @param player_id int
--- @return int
function players.get_net_player(player_id) end

--- @param player_id int
--- @param wanted_level int
--- @return int
function players.set_wanted_level(player_id, wanted_level) end

--- Valid rewards can be found in pickups.meta <Rewards> blocks.
--- Some examples are REWARD_HEALTH, REWARD_ARMOUR, REWARD_WEAPON_PISTOL, and REWARD_AMMO_PISTOL.
--- Only works on remote players.
--- @param player_id int
--- @param reward string|int
--- @return int
function players.give_pickup_reward(player_id, reward) end

--- @param player_id int
--- @return number
function players.get_weapon_damage_modifier(player_id) end

--- @param player_id int
--- @return number
function players.get_melee_weapon_damage_modifier(player_id) end

--- @param player_id int
--- @param name Label
--- @param toast_flags int? [default = TOAST_DEFAULT]
--- @param severity int? [default = 100]
function players.add_detection(player_id, name, toast_flags, severity) end

--- Example:
--- ```lua
--- players.on_flow_event_done(function(p, name, extra)
---     name = lang.get_localised(name)
---     if extra then
---         name ..= " ("
---         name ..= extra
---         name ..= ")"
---     end
---     util.toast(players.get_name(p)..": "..name)
--- end)
--- ```
--- @param callback function
--- @return int
function players.on_flow_event_done(callback) end

--- @param player_id int
--- @param x number
--- @param y number
--- @return int
function players.teleport_2d(player_id, x, y) end

--- @param player_id int
--- @param x number
--- @param y number
--- @param z number
--- @return int
function players.teleport_2d(player_id, x, y, z) end

--- [[ End of 'players' functions. ]] ---
--- [[ Start of 'entities' functions. ]]

--- Entities Functions for the Stand API.
--- [Click here to view the offical documentation.](https://stand.gg/help/lua-api-documentation#entities-functions)
entities = {}

--- A wrapper for the PED.CREATE_PED native. Returns INVALID_GUID on failure.
--- @param type int
--- @param hash int
--- @param pos Vector3
--- @param heading number
--- @return int
function entities.create_ped(type, hash, pos, heading) end

--- A wrapper for the VEHICLE.CREATE_VEHICLE native. Returns INVALID_GUID on failure.
--- @param hash int
--- @param pos Vector3
--- @param heading number
--- @return int
function entities.create_vehicle(hash, pos, heading) end

--- A wrapper for the OBJECT.CREATE_OBJECT_NO_OFFSET native. Returns INVALID_GUID on failure.
--- @param hash int
--- @param pos Vector3
--- @return int
function entities.create_object(hash, pos) end

--- Returns INVALID_GUID if vehicle not found.
--- @param include_last_vehicle boolean? [default = true]
--- @return int
function entities.get_user_vehicle_as_handle(include_last_vehicle) end

--- Returns 0 if vehicle not found.
--- @param include_last_vehicle boolean? [default = true]
--- @return int
function entities.get_user_vehicle_as_pointer(include_last_vehicle) end

--- @return int
function entities.get_user_personal_vehicle_as_handle() end

--- Returns the address of the entity with the given script handle.
--- @param handle int
--- @return int
function entities.handle_to_pointer(handle) end

--- Returns the entity with the given address has a script handle.
--- @param addr int
--- @return boolean
function entities.has_handle(addr) end

--- Returns a script handle for the entity with the given address.
--- If the entity does not have a script handle, one will be assigned to it.
--- Note that script handles are a limited resource and allocating too many of them can cause the game to become unstable or even crash.
--- @param addr int
--- @return int
function entities.pointer_to_handle(addr) end

--- This will force a script handle to be allocated for all vehicles.
--- Note that script handles are a limited resource and allocating too many of them can cause the game to become unstable or even crash.
--- @return table<int, int>
function entities.get_all_vehicles_as_handles() end

--- @return table<int, int>
function entities.get_all_vehicles_as_pointers() end

--- This will force a script handle to be allocated for all peds.
--- Note that script handles are a limited resource and allocating too many of them can cause the game to become unstable or even crash.
--- @return table<int, int>
function entities.get_all_peds_as_handles() end

--- @return table<int, int>
function entities.get_all_peds_as_pointers() end

--- This will force a script handle to be allocated for all objects.
--- Note that script handles are a limited resource and allocating too many of them can cause the game to become unstable or even crash.
--- @return table<int, int>
function entities.get_all_objects_as_handles() end

--- @return table<int, int>
function entities.get_all_objects_as_pointers() end

--- This will force a script handle to be allocated for all pickups.
--- Note that script handles are a limited resource and allocating too many of them can cause the game to become unstable or even crash.
--- @return table<int, int>
function entities.get_all_pickups_as_handles() end

--- @return table<int, int>
function entities.get_all_pickups_as_pointers() end

--- This will handle control requests on its own, and force deletion locally if control cannot be obtained.
---
--- Note that deleting some entities causes other entities to get deleted as well (e.g. deleting weapons deletes their attachments) which can be problematic if you're iterating over entity pointers to delete them as some of the subsequent pointers can go stale.
--- Handles don't have this issue because they get invalidated when the respective entity is deleted.
--- @param handle_or_ptr int
function entities.delete(handle_or_ptr) end

--- @param handle_or_ptr int
--- @return int
function entities.get_model_hash(handle_or_ptr) end

--- The result might be less precise than the native counterpart.
--- @param addr int
--- @return Vector3
function entities.get_position(addr) end

--- The result might be less precise than the native counterpart.
--- @param addr int
--- @return Vector3
function entities.get_rotation(addr) end

--- @param handle_or_ptr int
--- @return number
function entities.get_health(handle_or_ptr) end

--- @param handle_or_ptr int
--- @param modType int
--- @return number
function entities.get_upgrade_value(handle_or_ptr, modType) end

--- @param handle_or_ptr int
--- @param modType int
--- @return number
function entities.get_upgrade_max_value(handle_or_ptr, modType) end

--- @param handle_or_ptr int
--- @param modType int
--- @param value int
--- @return number
function entities.set_upgrade_value(handle_or_ptr, modType, value) end

--- Only applicable to vehicles.
--- @param addr int
--- @return int
function entities.get_current_gear(addr) end

--- Only applicable to vehicles.
--- @param addr int
--- @param current_gear int
function entities.set_current_gear(addr, current_gear) end

--- Only applicable to vehicles.
--- @param addr int
--- @return int
function entities.get_next_gear(addr) end

--- Only applicable to vehicles.
--- @param addr int
--- @param next_gear int
function entities.set_next_gear(addr, next_gear) end

--- Only applicable to vehicles.
--- @param addr int
--- @return number
function entities.get_rpm(addr) end

--- Only applicable to vehicles.
--- @param addr int
--- @param rpm float
function entities.set_rpm(addr, rpm) end

--- Only applicable to vehicles.
--- @param addr int
--- @return number
function entities.get_gravity(addr) end

--- Only applicable to vehicles.
--- @param addr int
--- @param gravity number
--- @return number
function entities.set_gravity(addr, gravity) end

--- Only applicable to vehicles.
--- @param addr int
--- @param gravity_multiplier number
--- @return number
function entities.set_gravity_multiplier(addr, gravity_multiplier) end

--- Only applicable to vehicles. Returns a value between 0.0 and 1.25.
--- @param addr int
--- @return number
function entities.get_boost_charge(addr) end

--- Returns a pointer or 0.
--- @param addr int
--- @return int
function entities.get_draw_handler(addr) end

--- @param addr int
--- @return int
function entities.vehicle_draw_handler_get_pearlecent_colour(addr) end

--- @param addr int
--- @return int
function entities.vehicle_draw_handler_get_wheel_colour(addr) end

--- @param addr int
--- @return boolean
function entities.get_vehicle_has_been_owned_by_player(addr) end

--- Only applicable to peds.
--- @param addr int
--- @return int
function entities.get_player_info(addr) end

--- @param addr int
--- @return int
function entities.player_info_get_game_state(addr) end

--- Only applicable to peds.
--- @param addr int
--- @return int
function entities.get_weapon_manager(addr) end

--- @param handle_or_ptr int
--- @return int
function entities.get_head_blend_data(handle_or_ptr) end

--- Returns the ID of the player that owns this entity.
--- @param handle_or_ptr int
--- @return int
function entities.get_owner(handle_or_ptr) end

--- Prevents ambient ownership changes so that only explicit requests will be processed.
--- @param handle_or_ptr int
--- @param can_migrate boolean
function entities.set_can_migrate(handle_or_ptr, can_migrate) end

--- @param handle_or_ptr int
--- @return boolean
function entities.get_can_migrate(handle_or_ptr) end

--- @param handle_or_ptr int
--- @param player int
function entities.give_control(handle_or_ptr, player) end

--- @param addr int
--- @return int
function entities.vehicle_get_handling(addr) end

--- Type:
---
--- - 0 = HANDLING_TYPE_BIKE
--- - 1 = HANDLING_TYPE_FLYING
--- - 2 = HANDLING_TYPE_VERTICAL_FLYING
--- - 3 = HANDLING_TYPE_BOAT
--- - 4 = HANDLING_TYPE_SEAPLANE
--- - 5 = HANDLING_TYPE_SUBMARINE
--- - 6 = HANDLING_TYPE_TRAIN
--- - 7 = HANDLING_TYPE_TRAILER
--- - 8 = HANDLING_TYPE_CAR
--- - 9 = HANDLING_TYPE_WEAPON
---
--- You can view the relevant handling types for your current vehicle by opening with the Handling Editor: Vehicle > Movement > Handling Editor.
--- @param handle_or_ptr int
--- @param type int
--- @return int
function entities.handling_get_subhandling(handle_or_ptr, type) end

--- @param handle_or_ptr int
--- @param wheel_index int
--- @return nil
function entities.detach_wheel(handle_or_ptr, wheel_index) end

--- @param handle_or_ptr int
--- @return boolean
function entities.is_player_ped(handle_or_ptr) end

--- @param handle_or_ptr int
--- @return boolean
function entities.is_invulnerable(handle_or_ptr) end

--- This internally calls util.yield. Returns false if control could not be attained within timeout.
--- @param handle_or_ptr int
--- @param timeout int? [default = 2000]
--- @return boolean
function entities.request_control(handle_or_ptr, timeout) end

--- [[ End of 'entities' functions. ]] ---
--- [[ Start of 'chat' functions.   ]] ---

--- Chat functions for the Stand API.
--- [Click to view the official documentation.](https://stand.gg/help/lua-api-documentation#chat-functions)
chat = {}

--- Registers a function to be called when a chat message is sent:
--- ```lua
--- chat.on_message(function(packet_sender, message_sender, text, team_chat)
---     Do stuff...
--- end)
--- ```
--- @param callback function
--- @return int
function chat.on_message(callback) end

--- As you might be aware, messages have a limit of 140 UTF-16 characters.
--- However, that is only true for the normal input, as you can use up to 254 UTF-8 characters over the network, and many more for the local history.
--- @param text string
--- @param team_chat boolean
--- @param add_to_local_history boolean
--- @param networked boolean
function chat.send_message(text, team_chat, add_to_local_history, networked) end

--- sender will only be respected when recipient == players.user(), otherwise sender will be forced to players.user().
--- @param recipient int
--- @param sender int
--- @param text string
--- @param team_chat boolean
function chat.send_targeted_message(recipient, sender, text, team_chat) end

--- Possible return values:
--- - 0 = Closed.
--- - 1 = Writing in team chat.
--- - 2 = Writing in all chat.
--- @return int
function chat.get_state() end

--- @return boolean
function chat.is_open() end

function chat.open() end

function chat.close() end

--- Returns the message that the user is currently drafting or an empty string if not applicable.
--- @return string
function chat.get_draft() end

--- @param team_chat boolean
function chat.ensure_open_with_empty_draft(team_chat) end

--- @param appendix string
function chat.add_to_draft(appendix) end

--- @param characters string
function chat.remove_from_draft(characters) end

--- ```lua
--- util.create_tick_handler(function()
---     for chat.get_history() as msg do
---         local str = msg.sender_name.." ["..(msg.team_chat ? "TEAM" : "ALL")..(msg.is_auto ? ", AUTO" : "").."] "..msg.contents
---         if msg.time ~= 0 then
---             str = "["..os.date('%H:%M:%S', msg.time).."] "..str
---         end
---         util.draw_debug_text(str)
---     end
--- end)
--- ```
--- @return table<int, table<string, any>>
function chat.get_history() end

--- [[ End of 'chat' functions. ]] ---
--- [[ Start of 'directx' functions. ]] ---

--- Any X and Y value must be between 0.0 to 1.0.
---
--- The draw functions are in the HUD coordinate space, which is superimposed 1920x1080.
--- You can also append _client to any draw function, e.g.
--- draw_line_client to draw in client coordinate space, which is based on the game window size.
---
--- [Click to view the official documentation.](https://stand.gg/help/lua-api-documentation#directx-functions)
directx = {}

--- An absolute path is recommended, e.g. by using filesystem.resources_dir().
--- @param path string
--- @return int
function directx.create_texture(path) end

--- @param id int
--- @param sizeX number
--- @param sizeY number
--- @param centerX number
--- @param centerY number
--- @param posX number
--- @param posY number
--- @param rotation number
--- @param colour Colour
function directx.draw_texture(id, sizeX, sizeY, centerX, centerY, posX, posY, rotation, colour) end

--- @param id int
--- @param sizeX number
--- @param sizeY number
--- @param centerX number
--- @param centerY number
--- @param posX number
--- @param posY number
--- @param rotation number
--- @param r number
--- @param g number
--- @param b number
--- @param a number
function directx.draw_texture(id, sizeX, sizeY, centerX, centerY, posX, posY, rotation, r, g, b, a) end

--- @param path string
--- @return userdata
function directx.create_font(path) end

--- `alignment` can be any of:
--- - `ALIGN_TOP_LEFT`
--- - `ALIGN_TOP_CENTRE`
--- - `ALIGN_TOP_RIGHT`
--- - `ALIGN_CENTRE_LEFT`
--- - `ALIGN_CENTRE`
--- - `ALIGN_CENTRE_RIGHT`
--- - `ALIGN_BOTTOM_LEFT`
--- - `ALIGN_BOTTOM_CENTRE`
--- - `ALIGN_BOTTOM_RIGHT`
--- @param x number
--- @param y number
--- @param text string
--- @param alignment int
--- @param scale number
--- @param colour Colour
--- @param force_in_bounds boolean? [default = false]
--- @param font userdata? [default = nil]
function directx.draw_text(x, y, text, alignment, scale, colour, force_in_bounds, font) end

--- @param x number
--- @param y number
--- @param width number
--- @param height number
--- @param colour Colour
function directx.draw_rect(x, y, width, height, colour) end

--- @param x1 number
--- @param y1 number
--- @param x2 number
--- @param y2 number
--- @param colour Colour
function directx.draw_line(x1, y1, x2, y2, colour) end

--- @param x1 number
--- @param y1 number
--- @param x2 number
--- @param y2 number
--- @param colour1 Colour
--- @param colour2 Colour
function directx.draw_line(x1, y1, x2, y2, colour1, colour2) end

--- @param x1 number
--- @param y1 number
--- @param x2 number
--- @param y2 number
--- @param x3 number
--- @param y3 number
--- @param colour Colour
function directx.draw_triangle(x1, y1, x2, y2, x3, y3, colour) end

--- @return number, number
function directx.get_client_size() end

--- Returns width and height.
--- @param text string
--- @param scale number? [default = 1.0]
--- @param font userdata? [default = nil]
--- @return number, number
function directx.get_text_size(text, scale, font) end

--- @param x number
--- @param y number
--- @return number, number
function directx.pos_hud_to_client(x, y) end

--- @param x number
--- @param y number
--- @return number, number
function directx.size_hud_to_client(x, y) end

--- @param x number
--- @param y number
--- @return number, number
function directx.pos_client_to_hud(x, y) end

--- @param x number
--- @param y number
--- @return number, number
function directx.size_client_to_hud(x, y) end

--- @return int
function directx.blurrect_new() end

--- Frees an instance.
--- This is automatically done for all instances your script has allocated but not freed once it finishes.
--- @param instance int
function directx.blurrect_free(instance) end

--- Prefer to use 1 instance per region, as any draw with a different size requires the buffers to be reallocated.
--- `strength` should be around 4 and can't exceed 255.
--- @param instance int
--- @param x number
--- @param y number
--- @param width number
--- @param height number
--- @param strength int
function directx.blurrect_draw(instance, x, y, width, height, strength) end

--- [[ End of 'directx' functions. ]] ---
--- [[ Start of 'util' functions. ]] ---

--- Utility functions for the Stand API.
--- [Click here to view the official documentation.](https://stand.gg/help/lua-api-documentation#util-functions)
util = {}

--- Loads the natives lib with the provided version, installing it from the repository if needed.
--- @param version int|string
--- @param flavour string?
function util.require_natives(version, flavour) end

--- Executes the given function in an OS thread to avoid holding up the game for expensive tasks like using require
--- on a big file, creating lots of commands, or performing expensive calculations.
--- Note that this will hold up your entire script, and calling natives or certain api functions in this context
--- may lead to instabilities.
--- @param func function
function util.execute_in_os_thread(func) end

--- Like require, but in an OS thread, to avoid holding up the game. Might not work for every library.
--- @param file string
function util.require_no_lag(file) end

--- Registers the parameter-function to be called every tick until it returns false.
--- @param func function
function util.create_tick_handler(func) end

--- @param func function
function util.try_run(func) end

--- Prevents Stand cleaning up your script for being idle.
--- This is implicit when you create commands, register event handlers, or use the async_http API.
function util.keep_running() end

--- Pauses the execution of the calling thread until the next tick or in wake_in_ms milliseconds.
--- If you're gonna create a "neverending" loop, don't forget to yield:
--- ```lua
--- while true do
---    -- Code that runs every tick...
---    util.yield()
--- end
--- ```
--- For simple loops, you should prefer util.create_tick_handler.
--- @param wake_in_ms number?
function util.yield(wake_in_ms) end

function util.yield_once() end

--- The first bool remains true until your script is being stopped. You generally won't need to check against this as the runtime will handle the stop process,
--- but in special situations like execute_in_os_thread, you might like to check against this to see if you want to continue with an expensive operation.
---
--- The second bool indicates if a silent stop of your script has been requested.
--- @return boolean, boolean
function util.can_continue() end

--- @param busy boolean
function util.set_busy(busy) end

--- Creates the kind of thread that your script gets when it is created, or one of your callbacks is invoked,
--- which is just another coroutine that gets resumed every tick and is expected to yield or return.
--- @param thread_func function
function util.create_thread(thread_func, ...) end

--- Stops the calling thread.
function util.stop_thread() end

--- Goes through the script stop process, freshly loads the contents of the script file, and starts the main thread again.
--- Note that the thread scheduler stays as-is, so this restart is different from a stop-and-start.
function util.restart_script() end

function util.stop_script() end

--- @param func function
function util.on_pre_stop(func) end

--- Script stop process:
---
--- - on_pre_stop handlers are called.
--- - Default state is applied to all commands (Change callbacks may be called at this point with CLICK_BULK).
--- - on_stop handlers are called.
---
--- Note that yielding and creating threads are not available during the stop process.
--- @param func function
function util.on_stop(func) end

--- Possible bitflags:
--- - `TOAST_ABOVE_MAP` — Uses Stand notifications if enabled
--- - `TOAST_LOGGER`
--- - `TOAST_WEB`
--- - `TOAST_CHAT`
--- - `TOAST_CHAT_TEAM`
--- - `TOAST_DEFAULT` — Equal to (TOAST_ABOVE_MAP | TOAST_WEB)
--- - `TOAST_ALL` — Equal to (TOAST_DEFAULT | TOAST_LOGGER)
---
--- Note that the chat flags are mutually exclusive.
--- @param message string
--- @param bitflags int?
function util.toast(message, bitflags) end

--- Alias for
--- ```lua
--- util.toast(message, TOAST_LOGGER)
--- ```
--- @param message string
function util.log(message) end

--- Draws the given text for the current tick using the "Info Text" system.
--- @param text string
function util.draw_debug_text(text) end

--- @param text string
function util.draw_centred_text(text) end

--- Shorthand for
--- ```lua
--- util.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(message)
--- if not HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0) then
---     util.BEGIN_TEXT_COMMAND_DISPLAY_HELP(message)
---     HUD.END_TEXT_COMMAND_DISPLAY_HELP(0, false, true, -1)
--- end
--- ```
--- @param message string
function util.show_corner_help(message) end

--- Shorthand for
--- ```lua
--- util.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(message)
--- if HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0) then
---     util.BEGIN_TEXT_COMMAND_DISPLAY_HELP(replacement_message)
---     HUD.END_TEXT_COMMAND_DISPLAY_HELP(0, false, true, -1)
--- end
--- ```
--- @param message string
--- @param replacement_message string
function util.replace_corner_help(message, replacement_message) end

--- Replacement for
--- ```lua
--- PLAYER.SET_PLAYER_WANTED_LEVEL_NO_DROP(PLAYER.PLAYER_ID(), wanted_level, false)
--- PLAYER.SET_PLAYER_WANTED_LEVEL_NOW(PLAYER.PLAYER_ID(), false)
--- ```
--- using pointers to avoid potentially tripping anti-cheat.
--- @param wanted_level int
function util.set_local_player_wanted_level(wanted_level) end

--- This produces the kind of hash used pretty much everywhere in GTA.
--- Although note that even tho this is named JOAAT, this uses RAGE's version of JOAAT — 
--- the most notable difference is that the input is computed as lowercase.
--- @param text string
--- @return int
function util.joaat(text) end

--- Similar to util.joaat, but returns an unsigned number:
--- ```lua
--- util.joaat("stand") --> -830507952
--- util.ujoaat("stand") --> 3464459344
--- ```
--- @param text string
--- @return int
function util.ujoaat(text) end

--- Returns an empty string if the given hash is not found in Stand's dictionaries.
--- @param hash int
--- @return string
function util.reverse_joaat(hash) end

--- @param model int|string
function util.is_this_model_a_blimp(model) end

--- @param model int|string
function util.is_this_model_an_object(model) end

--- @param model int|string
function util.is_this_model_a_submarine(model) end

--- @param model int|string
function util.is_this_model_a_trailer(model) end

--- Returns an index-based table with a table for each vehicle in the game.
--- The inner tables contain name, manufacturer, and class.
---
--- class is a signed JOAAT hash with the following possible keys: off_road, sport_classic, military, compacts, sport, muscle, motorcycle, open_wheel, super, van, suv, commercial, plane, sedan, service, industrial, helicopter, boat, utility, emergency, cycle, coupe, rail
---
--- class is guaranteed to be a valid builtin language label.
--- @return table<int, table>
function util.get_vehicles() end

--- Returns an index-based table with a string for each object.
--- @return table<int, string>
function util.get_objects() end

--- Returns an index-based table with a table for each weapon in the game.
--- The inner tables contain hash, label_key, category, & category_id. Note that the categories are specific to Stand.
--- @return table<int, table>
function util.get_weapons() end

--- Replacement for
--- ```lua
--- HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
--- HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
--- ```
--- which increases your message's character limit.
--- @param message string
function util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT(message) end

--- Replacement for
--- ```lua
--- HUD._BEGIN_TEXT_COMMAND_LINE_COUNT("STRING")
--- HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
--- ```
--- which increases your message's character limit.
--- @param message string
function util._BEGIN_TEXT_COMMAND_LINE_COUNT(message) end

--- Replacement for
--- ```lua
--- HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED("STRING")
--- HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
--- ```
--- which increases your message's character limit.
--- @param message string
function util.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(message) end

--- Replacement for
--- ```lua
--- HUD.BEGIN_TEXT_COMMAND_DISPLAY_HELP("STRING")
--- HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
--- ```
--- which increases your message's character limit.
--- @param message string
function util.BEGIN_TEXT_COMMAND_DISPLAY_HELP(message) end

--- Replacement for
--- ```lua
--- HUD._BEGIN_TEXT_COMMAND_GET_WIDTH("STRING")
--- HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
--- ```
--- which increases your message's character limit.
--- @param message string
function util._BEGIN_TEXT_COMMAND_GET_WIDTH(message) end

--- Replacement for
--- ```lua
--- HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
--- HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(message)
--- ```
--- which increases your message's character limit.
--- @param message string
function util.BEGIN_TEXT_COMMAND_THEFEED_POST(message) end

--- @param rank int
--- @return int
function util.get_rp_required_for_rank(rank) end

--- @return int
function util.get_session_players_bitflag() end

--- args[1] should be the event hash (f_0), args[2] is ignored, args[3] and onwards is the data (f_3 and onwards).
---
--- `session_player_bitflags` has a bit set to 1 for every player that should receive the script event;
--- you can use `util.get_session_players_bitflag()` if you intend for everyone to receive the script event
--- or use 1 << player_id to target individual players.
---
--- `reinterpret_floats` changes the behaviour when an argument is a float to push it as a float instead of casting it to an int.
--- @param session_player_bitflags int
--- @param args table<any, int>
--- @param reinterpret_floats boolean? [default = false]
function util.trigger_script_event(session_player_bitflags, args, reinterpret_floats) end

--- @return int
function util.current_time_millis() end

--- Returns how many seconds have passed since the UNIX epoch (00:00:00 UTC on 1 January 1970).
--- @return int
function util.current_unix_time_seconds() end

--- @param handler_id int
--- @return int
function util.remove_handler(handler_id) end

--- @return boolean
function util.is_session_started() end

--- @return boolean
function util.is_session_transition_active() end

--- @return int
function util.get_char_slot() end

--- The most precise way to get the ground Z coordinate which respects water.
---
--- The ground Z will be below the z_hint.
---
--- If the bool return value is true, the number is the ground Z. If not, you should try again next tick.
--- You may want to count the calls you made and abort after a certain amount of calls with the bool being false.
--- @param x number
--- @param y number
--- @param z_hint number? [default = 1000.0]
--- @return boolean, number
function util.get_ground_z(x, y, z_hint) end

--- If the provided script is not running, your function is not called and this returns false.
--- @param script string|int
--- @param func function
--- @return boolean
function util.spoof_script(script, func) end

--- If the script thread was not found, your function is not called and this returns false.
--- @param thread_id int
--- @param func function
--- @return boolean
function util.spoof_script_thread(thread_id, func) end

--- @param blip int
--- @return boolean
function util.remove_blip(blip) end

function util.arspinner_enable() end

function util.arspinner_disable() end

function util.is_bigmap_active() end

--- @param text string
--- @param notify? boolean [default = true]
function util.copy_to_clipboard(text, notify) end

--- @return string
function util.get_clipboard_text() end

--- Allows you to read a file in the colons and tabs format, which is what Stand uses for profiles, hotkeys, etc.
--- @param file string
--- @return table<string, string>
function util.read_colons_and_tabs_file(file) end

--- Allows you to write a file in the colons and tabs format.
--- @param file string
--- @param data table<string, string>
function util.write_colons_file(file, data) end

--- @param pos Vector3
function util.draw_ar_beacon(pos) end

--- Draws a box with 3d rotation using polys. Note that backfaceculling applies to the inside.
--- @param pos Vector3
--- @param rot Vector3
--- @param dimensions Vector3
--- @param r int
--- @param g int
--- @param b int
--- @param a? int [default = 255]
function util.draw_box(pos, rot, dimensions, r, g, b, a) end

--- @param script string|int
--- @return boolean
function util.request_script_host(script) end

--- @param script string|int
--- @param player int
--- @return boolean
function util.give_script_host(script, player) end

--- Registers the given file in the game so it can be used with natives, e.g.
--- util.register_file(filesystem.resources_dir() .. "myscript.ytd") will allow you to use "myscript"
--- as a texture dict for GRAPHICS natives.
--- @param path string
--- @return boolean
function util.register_file(path) end

--- Same as HUD._GET_LABEL_TEXT except it will bypass any replacements Stand might be making.
--- @param label_name string
--- @return string
function util.get_label_text(label_name) end

--- Registers a label, such that it can be used with HUD._GET_LABEL_TEXT and other natives.
--- @param text string
--- @return string
function util.register_label(text) end

--- `vk` int values can be found at https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes.
---
--- `vk` may also be a string, if it contains a single character and that character is A-Z, 0-9, or a space.
--- @param vk int|string
--- @return boolean
function util.is_key_down(vk) end

--- @param addr int
--- @param ... int|userdata|string
--- @return int
function util.call_foreign_function(addr, ...) end

--- @param inst_addr int
--- @return string
function util.get_rtti_name(inst_addr) end

--- @param inst_addr int
--- @return string
function util.get_rtti_hierarchy(inst_addr) end

--- @param hash int|string
function util.set_particle_fx_asset(hash) end

--- @param blip_handle int
--- @return int
function util.blip_handle_to_pointer(blip_handle) end

--- @param blip_handle int
--- @return int
function util.get_blip_display(blip_handle) end

--- @param x number
--- @param y number
--- @return int
function util.teleport_2d(x, y) end

--- @return boolean
function util.is_interaction_menu_open() end

--- @param callback function
--- @return int
function util.on_transition_finished(callback) end

--- @param target_r int
--- @param target_g int
--- @param target_b int
--- @param target_a int [default = 255]
--- @return int
function util.get_closest_hud_colour(target_r, target_g, target_b, target_a) end

--- @return boolean
function util.is_soup_netintel_inited() end

--- ```lua
--- util.on_pad_shake(function(light_duration, light_intensity, heavy_duration, heavy_intensity, delay_after_this_one)
---    -- Do stuff...
--- end)
--- ```
--- @param callback function
--- @return int
function util.on_pad_shake(callback) end

--- Attempts to load the given model within timeout milliseconds or throws an error.
--- @param model int|string
--- @param timeout int? [default = 2000]
function util.request_model(model, timeout) end

--- @param path string
function util.open_folder(path) end

--- How Stand should behave when it has to return a nullptr to you.
--- - `false` is the old behaviour, which is just returning the int 0.
--- - `true` is the new behaviour, which will return nil instead of an int, to simplify comparisons.
---
--- This currently affects the following functions:
--- - entities.get_user_vehicle_as_pointer
--- - entities.handle_to_pointer
--- - entities.handling_get_subhandling
--- - util.blip_handle_to_pointer
--- - util.get_model_info
--- - memory.scan
--- @param use_nil boolean? [default = true]
function util.set_nullptr_preference(use_nil) end

--- @return int
function util.get_tps() end

--- Example:
--- ```lua
--- local function get_session_code_for_user()
--- local applicable, code = util.get_session_code()
--- if applicable then
---     if code then
---         return code
---     end
---     return "Please wait..."
--- end
--- return "N/A"
--- end
---```
--- @return bool, string?
function util.get_session_code() end

--- @param stat int|string
--- @return int?
function util.stat_get_type(stat) end

--- @param stat int|string
--- @return int?
function util.stat_get_int64(stat) end

--- @param list CommandRef
--- @param bitflags int? [default = 0]
--- @param command_names_prefix table<any, string>? [default = {}]
--- @return int
function util.new_toast_config(list, bitflags, command_names_prefix) end

--- Example:
--- ```lua
--- local tc
--- menu.my_root():action("Show Notification", {}, "", function()
---     util.toast("Here is the notification!", util.toast_config_get_flags(tc))
--- end)
--- menu.my_root():divider(lang.find_builtin("Notifications"))
--- tc = util.new_toast_config(menu.my_root(), TOAST_DEFAULT)
--- ```
--- @param tc int
--- @return int
function util.toast_config_get_flags(tc) end

--- Returns the address of the CModelInfo for the given hash or 0 if not loaded.
--- @param hash int|string
--- @return int
function util.get_model_info(hash) end

--- @param name string
--- @param allow_folder boolean
--- @return boolean
function util.is_valid_file_name(name, allow_folder) end

--- @param r number
--- @param g number
--- @param b number
--- @return number, number, number
function util.rgb2hsv(r, g, b) end

--- @param h number
--- @param s number
--- @param v number
--- @return number, number, number
function util.hsv2rgb(h, s, v) end

--- @param r number
--- @param g number
--- @param b number
--- @return number
function util.calculate_luminance(r, g, b) end

--- @param r1 number
--- @param g1 number
--- @param b1 number
--- @param r2 number
--- @param g2 number
--- @param b2 number
--- @return number
function util.calculate_contrast(r1, g1, b1, r2, g2, b2) end

--- @param r1 number
--- @param g1 number
--- @param b1 number
--- @param r2 number
--- @param g2 number
--- @param b2 number
--- @return boolean
function util.is_contrast_sufficient(r1, g1, b1, r2, g2, b2) end

--- An extended version of HUD.SET_NEW_WAYPOINT that includes the Z axis for features like Stand's AR Waypoint.
--- @param pos Vector3
function util.set_waypoint(pos) end

--- @param cam int
--- @param x number
--- @param y number
--- @param z number
--- @param w number
--- @return nil
function util.set_cam_quaternion(cam, x, y, z, w) end

--- Alternative to GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD that does not do adjustments for multihead monitor configs.
---
--- ```lua
--- util.require_natives()
--- util.create_tick_handler(function()
---     local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
---
---     local v2 = memory.alloc(8)
---     if util.get_screen_coord_from_world_coord_no_adjustment(pos.x, pos.y, pos.z, v2, v2 + 4) then
---         util.draw_debug_text(memory.read_float(v2) .. ", " .. memory.read_float(v2 + 4))
---     else
---         util.draw_debug_text("Off-screen!")
---     end
--- end)
--- ```
--- @param fWorldX number
--- @param fWorldY number
--- @param fWorldZ number
--- @param pOutScreenX number
--- @param pOutScreenY number
--- @return boolean
function util.get_screen_coord_from_world_coord_no_adjustment(fWorldX, fWorldY, fWorldZ, pOutScreenX, pOutScreenY) end

--- @param utf8 string
--- @return string
function util.utf8_to_utf16(utf8) end

--- @param utf16 string
--- @return string
function util.utf16_to_utf8(utf16) end

--- Gets the GPS route information for the given slot. Slot 0 is waypoint.
---
--- The first return value is an index-based table of tables. Each inner table contains x, y, z and junction.
--- Junction nodes should be ignored when drawing a line to avoid jaggedness.
---
--- The second return value indicates if the route is partial.
--- @param slot int
--- @return table<int, table>, bool 
function util.get_gps_route(slot) end

--- [[ End of 'util' functions. ]] ---
--- [[ Start of 'v3' functions. ]] ---

--- V3 functions for the Stand API.
--- [Click here to view the official documentation.](https://stand.gg/help/lua-api-documentation#v3-functions)
v3 = {}

--- @param x float
--- @param y float
--- @param z float
--- @return userdata
function v3.new(x, y, z) end

--- @param pos Vector3
--- @return userdata
function v3.new(pos) end

--- Creates a new v3 instance, which can be used anywhere a Vector3 or Vector3* is accepted.
--- As an alternative to v3.new(...), you can also use v3(...).
--- Furthermore, all following functions can be called on a v3 instance using the `:` syntax.
--- @return userdata
function v3.new() end

--- @param addr userdata|int
--- @return float, float, float
function v3.get(addr) end

--- @param addr userdata|int
--- @return float
function v3.getX(addr) end

--- @param addr userdata|int
--- @return float
function v3.getY(addr) end

--- @param addr userdata|int
--- @return float
function v3.getZ(addr) end

--- @param addr userdata|int
--- @return float
function v3.getHeading(addr) end

--- @param addr userdata|int
--- @param x float
--- @param y float
--- @param z float
--- @return userdata|int
function v3.set(addr, x, y, z) end

--- @param addr userdata|int
--- @param x float
--- @return userdata|int
function v3.setX(addr, x) end

--- @param addr userdata|int
--- @param y float
--- @return userdata|int
function v3.setY(addr, y) end

--- @param addr userdata|int
--- @param z float
--- @return userdata|int
function v3.setZ(addr, z) end

--- @param addr userdata|int
--- @return userdata|int
function v3.reset(addr) end

--- Adds b to a. Returns a.
--- @param a userdata|int
--- @param b userdata|int
--- @return userdata|int
function v3.add(a, b) end

--- Subtracts b from a. Returns a.
--- @param a userdata|int
--- @param b userdata|int
--- @return userdata|int
function v3.sub(a, b) end

--- Multiplies a by f. Returns a.
--- @param a userdata|int
--- @param f number
--- @return userdata|int
function v3.mul(a, f) end

--- Divides a by f. Returns a.
--- @param a userdata|int
--- @param f number
--- @return userdata|int
function v3.div(a, f) end

--- Returns a new instance with the result of a + b.
--- @param a userdata|int
--- @param b userdata|int
--- @return userdata|int
function v3.addNew(a, b) end

--- Returns a new instance with the result of a - b.
--- @param a userdata|int
--- @param b userdata|int
--- @return userdata|int
function v3.subNew(a, b) end

--- Returns a new instance with the result of a * f.
--- @param a userdata|int
--- @param f number
--- @return userdata|int
function v3.mulNew(a, f) end

--- Returns a new instance with the result of a / f.
--- @param a userdata|int
--- @param f number
--- @return userdata|int
function v3.divNew(a, f) end

--- @param a userdata|int
--- @param b userdata|int
--- @return boolean
function v3.eq(a, b) end

--- Alternatively, you can use the # syntax on a v3 instance to get its magnitude.
--- @param a userdata|int
--- @return number
function v3.magnitude(a) end

--- @param a userdata|int
--- @param b userdata|int
--- @return number
function v3.distance(a, b) end

--- Ensures that every axis is positive.
--- @param addr userdata|int
--- @return userdata|int
function v3.abs(addr) end

--- @param addr userdata|int
function v3.sum(addr) end

--- Returns the value of the smallest axis.
--- @param addr userdata|int
--- @return float
function v3.min(addr) end

--- Returns the value of the biggest axis.
--- @param addr userdata|int
--- @return float
function v3.max(addr) end

--- @param a userdata|int
--- @param b int
--- @return number
function v3.dot(a, b) end

--- @param addr userdata|int
--- @return userdata|int
function v3.normalise(addr) end

--- The result is a new instance.
--- @param a userdata|int
--- @param b int
--- @return userdata
function v3.crossProduct(a, b) end

--- The result is a new instance with rotation data.
--- @param addr userdata|int
--- @return userdata
function v3.toRot(addr) end

--- The result is a new instance with rotation data.
--- @param addr userdata|int
--- @param b int
--- @return userdata
function v3.lookAt(addr, b) end

--- The result is a new instance with direction data.
--- The direction vector will have a magnitude of 1 / it is a unit vector, so you can safely multiply it.
--- Note that Stand expects/uses what is rotation order 2 for RAGE.
--- @param addr userdata|int
--- @return userdata
function v3.toDir(addr) end

--- @param addr userdata|int
--- @return string
function v3.toString(addr) end

--- [[ End of 'V3' functions. ]] ---
--- [[ Start of 'lang' functions. ]] ---

--- Language functions for the Stand API.
--- [Click here to view the official documentation.](https://stand.gg/help/lua-api-documentation#lang-functions)
lang = {}

--- Returns the current menu language, which could be a 2-letter language code, "en-us", "sex", "uwu", or "hornyuwu".
--- @return string
function lang.get_current() end

--- @param lang_code string
--- @return boolean
function lang.is_code_valid(lang_code) end

--- @param lang_code string
--- @return string
function lang.get_code_for_soup(lang_code) end

--- @param lang_code string
--- @return boolean
function lang.is_automatically_translated(lang_code) end

--- @param lang_code string
--- @return boolean
function lang.is_english(lang_code) end

--- @param text string
--- @return int
function lang.register(text) end

--- Starts the process of translating labels. lang_code must be a 2-letter language code or "sex".
--- @param lang_code string
function lang.set_translate(lang_code) end

--- @param label int
--- @param text string
function lang.translate(label, text) end

--- Finds an existing label using its text.
--- Returns 0 if not found. lang_code must be a 2-letter language code or "sex".
---
--- Note that if there are multiple possible results, it is basically random which one is returned.
--- @param text string
--- @param lang_code? string \"en"
--- @return int
function lang.find(text, lang_code) end

--- Similar to lang.find but limited to labels Stand has registered.
--- @param text string
--- @param lang_code? string \"en"
--- @return int
function lang.find_builtin(text, lang_code) end

--- Similar to lang.find but limited to labels your script has registered.
--- @param text string
--- @param lang_code? string \"en"
--- @return int
function lang.find_registered(text, lang_code) end

--- lang_code must be a 2-letter language code, "en-us", "sex", "uwu", or "hornyuwu".
--- @param label Label
--- @param lang_code? string \"en"
--- @return string
function lang.get_string(label, lang_code) end

--- Similar to lang.get_string but always using the current menu language.
--- @param label Label
--- @return string
function lang.get_localised(label) end

--- Returns true if the given label was registered by the calling script.
--- @param label int
--- @return boolean
function lang.is_mine(label) end

--- [[ End of 'lang' functions.         ]] ---
--- [[ Start of 'filesystem' functions. ]] ---

--- Filesystem functions for the Stand API.
--- [Click here for the official documentation.](https://stand.gg/help/lua-api-documentation#filesystem-functions)
filesystem = {}

--- Possible return value: `C:\Users\John\AppData\Roaming\`
--- @return string
function filesystem.appdata_dir() end

--- Possible return value: `C:\Users\John\AppData\Roaming\Stand\`
--- @return string
function filesystem.stand_dir() end

--- Possible return value: `C:\Users\John\AppData\Roaming\Stand\Lua Scripts\`
--- @return string
function filesystem.scripts_dir() end

--- Possible return value: `C:\Users\John\AppData\Roaming\Stand\Lua Scripts\resources\`
--- @return string
function filesystem.resources_dir() end

--- Possible return value: `C:\Users\John\AppData\Roaming\Stand\Lua Scripts\store\`
--- This function also creates the "store" directory if it doesn't exist.
--- @return string
function filesystem.store_dir() end

--- @param path string
--- @return boolean
function filesystem.exists(path) end

--- @param path string
--- @return boolean
function filesystem.is_regular_file(path) end

--- @param path string
--- @return boolean
function filesystem.is_dir(path) end

--- @param path string
function filesystem.mkdir(path) end

--- @param path string
function filesystem.mkdirs(path) end

--- Returns an index-based table with all files in the given directory.
--- ```lua
--- for i, path in ipairs(filesystem.list_files(filesystem.scripts_dir())) do
---     util.log(path)
--- end
--- ```
--- Note that directories in the resulting table don't end on a \.
--- @param path string
--- @return table<int, string>
function filesystem.list_files(path) end

--- [[ End of 'filesystem' functions.   ]] ---
--- [[ Start of 'async_http' functions. ]] ---

--- Async HTTP functions for the Stand API.
--- [Click here to view the official documentation.](https://stand.gg/help/lua-api-documentation#async-http-functions)
async_http = {}

--- @return boolean
function async_http.have_access() end

--- This will make a GET request unless you use async_http.set_post before calling async_http.dispatch.
--- On success, your success_func will be called with the response body as a string,
--- if your script is still alive when the request finishes; the lifetimes are independent.
--- @param host string
--- @param path string
--- @param success_func? function
--- @param fail_func? function
function async_http.init(host, path, success_func, fail_func) end

--- Finish building the async http request and carry it out in separate OS thread.
function async_http.dispatch() end

--- Changes the request method, adds Content-Type and Content-Length headers, and sets the payload.
--- Examples of content_type:
--- - `"application/json"`
--- - `"application/x-www-form-urlencoded; charset=UTF-8"`
--- @param content_type string
--- @param payload string
function async_http.set_post(content_type, payload) end

--- @param key string
--- @param value string
function async_http.add_header(key, value) end

--- @param method string
function async_http.set_method(method) end

function async_http.prefer_ipv6() end

--- [[ End of 'async_http' functions. ]] ---
--- [[ Start of 'memory' functions.   ]] ---

--- Memory functions for the Stand API.
--- [Click for the official documentation.](https://stand.gg/help/lua-api-documentation#memory-functions)
memory = {}

--- Returns the address of the given script global.
--- @param global int
--- @return int
function memory.script_global(global) end

--- Returns the address of the given script local or 0 if the script was not found.
--- @param script string|int
--- @param localvar int
--- @return int
function memory.script_local(script, localvar) end

--- The default size is 24 so it can fit a Vector3.
--- @param size int
--- @return userdata
function memory.alloc(size) end

--- Alias for memory.alloc(4).
--- @return userdata
function memory.alloc_int() end

--- Scans the game's memory for the given IDA-style pattern.
--- This is an expensive call so ideally you'd only ever scan
--- for a pattern once and then use the resulting address until your script finishes.
--- @param pattern string
--- @return int
function memory.scan(pattern) end

--- @param module_name string
--- @param pattern string
--- @return int
function memory.scan(module_name, pattern) end

--- Follows an offset from the instruction pointer ("RIP") at the given address.
--- So, whereas in C++ you might do something like this:
--- ```cpp
--- memory::scan("4C 8D 05 ? ? ? ? 48 8D 15").add(3).rip().as<const char*>();
--- ```
--- You'd do this in Lua (with a check for null-pointer because we're smart):
--- ```lua
--- local addr = memory.scan("4C 8D 05 ? ? ? ? 48 8D 15 ? ? ? ? 48 8B C8 E8")
--- if addr == 0 then -- Check for null pointer.
---     util.toast("pattern scan failed")
--- else
---     util.toast(memory.read_string(memory.rip(addr + 3)))
--- end
--- ```
--- @param addr int
--- @return int
function memory.rip(addr) end

--- @param ud userdata
--- @return lightuserdata
function memory.addrof(ud) end

--- Reads an 8-bit int at the given address.
--- @param addr int|userdata
--- @return int
function memory.read_byte(addr) end

--- Reads an unsigned 8-bit int at the given address.
--- @param addr int|userdata
--- @return int
function memory.read_ubyte(addr) end

--- Reads a 16-bit int at the given address.
--- @param addr int|userdata
--- @return int
function memory.read_short(addr) end

--- Reads an unsigned 16-bit int at the given address.
--- @param addr int|userdata
--- @return int
function memory.read_ushort(addr) end

--- Reads a 32-bit int at the given address.
--- @param addr int|userdata
--- @return int
function memory.read_int(addr) end

--- Reads an unsigned 32-bit int at the given address.
--- @param addr int|userdata
--- @return int
function memory.read_uint(addr) end

--- Reads a 64-bit int at the given address.
--- @param addr int|userdata
--- @return int
function memory.read_long(addr) end

--- @param addr int|userdata
--- @return number
function memory.read_float(addr) end

--- @param addr int|userdata
--- @return string
function memory.read_string(addr) end

--- @param addr int|userdata
--- @return Vector3
function memory.read_vector3(addr) end

--- @param addr int|userdata
--- @param size int
--- @return string
function memory.read_binary_string(addr, size) end

--- Writes an 8-bit int to the given address.
--- @param addr int|userdata
--- @param value int
function memory.write_byte(addr, value) end

--- Writes an unsigned 8-bit int to the given address.
--- @param addr int|userdata
--- @param value int
function memory.write_ubyte(addr, value) end

--- Writes a 16-bit int to the given address.
--- @param addr int|userdata
--- @param value int
function memory.white_short(addr, value) end

--- Writes an unsigned 16-bit int to the given address.
--- @param addr int|userdata
--- @param value int
function memory.white_ushort(addr, value) end

--- Writes a 32-bit int to the given address.
--- @param addr int|userdata
--- @param value int
function memory.write_int(addr, value) end

--- Writes an unsigned 32-bit int to the given address.
--- @param addr int|userdata
--- @param value int
function memory.write_uint(addr, value) end

--- Writes a 64-bit int to the given address.
--- @param addr int|userdata
--- @param value int
function memory.write_long(addr, value) end

--- @param addr int|userdata
--- @param value number
function memory.write_float(addr, value) end

--- @param addr int|userdata
--- @param value string
function memory.write_string(addr, value) end

--- @param addr int|userdata
--- @param value Vector3
function memory.write_vector3(addr, value) end

--- @param addr int|userdata
--- @param value string
function memory.write_binary_string(addr, value) end

--- @return string
function memory.get_name_of_this_module() end

--- Returns the address of the tunable with the given hash.
--- Note that the implementation of this function may call util.yield while the data is loaded.
--- @param hash int|string
--- @return int
function memory.tunable(hash) end

--- Returns the offset (the part after .f_) of the tunable with the given hash.
--- Note that the implementation of this function may call util.yield while the data is loaded.
--- @param hash int|string
--- @return int
function memory.tunable_offset(hash) end

--- [[ End of 'memory' functions.      ]] ---
--- [[ Start of 'profiling' functions. ]] ---

--- Profiling functions for the Stand API.
--- [Click here to view the official documentation.](https://stand.gg/help/lua-api-documentation#profiling-functions)
profiling = {}

--- Executes the given function and prints the time it took to your log.
--- @param name string
--- @param func function
function profiling.once(name, func) end

--- Executes the given function and shows the time it took via the info text/debug text.
--- @param name string
--- @param func function
function profiling.tick(name, func) end
