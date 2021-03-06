/obj/structure/closet/crate
	name = "crate"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/crates.dmi'
	icon_state = "crate"
	req_access = null
	can_weld_shut = FALSE
	horizontal = TRUE
	allow_objects = TRUE
	allow_dense = TRUE
	dense_when_open = TRUE
	climbable = TRUE
	climb_time = 10 //real fast, because let's be honest stepping into or onto a crate is easy
	climb_stun = 0 //climbing onto crates isn't hard, guys
	var/obj/item/weapon/paper/manifest/manifest

/obj/structure/closet/crate/New()
	..()
	update_icon()

/obj/structure/closet/crate/CanPass(atom/movable/mover, turf/target, height=0)
	if(!istype(mover, /obj/structure/closet))
		var/obj/structure/closet/crate/locatedcrate = locate(/obj/structure/closet/crate) in get_turf(mover)
		if(locatedcrate) //you can walk on it like tables, if you're not in an open crate trying to move to a closed crate
			if(opened) //if we're open, allow entering regardless of located crate openness
				return 1
			if(!locatedcrate.opened) //otherwise, if the located crate is closed, allow entering
				return 1
	return !density

/obj/structure/closet/crate/update_icon()
	icon_state = "[initial(icon_state)][opened ? "open" : ""]"

	overlays.Cut()
	if(manifest)
		overlays += "manifest"

/obj/structure/closet/crate/attack_hand(mob/user)
	if(manifest)
		tear_manifest(user)
		return
	..()

/obj/structure/closet/crate/proc/tear_manifest(mob/user)
	user << "<span class='notice'>You tear the manifest off of the crate.</span>"
	playsound(src, 'sound/items/poster_ripped.ogg', 75, 1)

	manifest.loc = loc
	if(ishuman(user))
		user.put_in_hands(manifest)
	manifest = null
	update_icon()

/obj/structure/closet/crate/internals
	desc = "A internals crate."
	name = "internals crate"
	icon_state = "o2crate"

/obj/structure/closet/crate/trashcart
	desc = "A heavy, metal trashcart with wheels."
	name = "trash cart"
	icon_state = "trashcart"

/obj/structure/closet/crate/medical
	desc = "A medical crate."
	name = "medical crate"
	icon_state = "medicalcrate"

/obj/structure/closet/crate/freezer
	desc = "A freezer."
	name = "freezer"
	icon_state = "freezer"
	var/target_temp = T0C - 40
	var/cooling_power = 40

/obj/structure/closet/crate/freezer/return_air()
	var/datum/gas_mixture/gas = ..()
	if(!gas)
		return null
	var/datum/gas_mixture/newgas = gas.copy()
	if(newgas.temperature > target_temp)
		newgas.temperature = max(target_temp, newgas.temperature - cooling_power)
	return newgas

/obj/structure/closet/crate/freezer/blood
	name = "blood freezer"
	desc = "A freezer containing packs of blood."

/obj/structure/closet/crate/freezer/blood/New()
	. = ..()
	new /obj/item/weapon/reagent_containers/blood/empty(src)
	new /obj/item/weapon/reagent_containers/blood/empty(src)
	new /obj/item/weapon/reagent_containers/blood/AMinus(src)
	new /obj/item/weapon/reagent_containers/blood/BMinus(src)
	new /obj/item/weapon/reagent_containers/blood/BPlus(src)
	new /obj/item/weapon/reagent_containers/blood/OMinus(src)
	new /obj/item/weapon/reagent_containers/blood/OPlus(src)
	new /obj/item/weapon/reagent_containers/blood/lizard(src)
	for(var/i in 1 to 3)
		new /obj/item/weapon/reagent_containers/blood/random(src)

/obj/structure/closet/crate/radiation
	desc = "A crate with a radiation sign on it."
	name = "radiation crate"
	icon_state = "radiation"

/obj/structure/closet/crate/hydroponics
	name = "hydroponics crate"
	desc = "All you need to destroy those pesky weeds and pests."
	icon_state = "hydrocrate"

/obj/structure/closet/crate/engineering
	name = "engineering crate"
	icon_state = "engi_crate"

/obj/structure/closet/crate/engineering/electrical
	icon_state = "engi_e_crate"

/obj/structure/closet/crate/rcd
	desc = "A crate for the storage of an RCD."
	name = "\improper RCD crate"
	icon_state = "engi_crate"

/obj/structure/closet/crate/rcd/New()
	..()
	for(var/i in 1 to 4)
		new /obj/item/weapon/rcd_ammo(src)
	new /obj/item/weapon/rcd(src)
