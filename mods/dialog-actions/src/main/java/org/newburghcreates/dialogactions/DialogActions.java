package org.newburghcreates.dialogactions;

import java.util.List;
import java.util.Optional;

import net.fabricmc.api.DedicatedServerModInitializer;
import net.minecraft.commands.CommandSourceStack;
import net.minecraft.nbt.CompoundTag;
import net.minecraft.nbt.Tag;
import net.minecraft.resources.Identifier;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.server.permissions.LevelBasedPermissionSet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A dialog button that runs an op command (e.g. /function) makes a vanilla client ask "Confirm Command
 * Execution" first. A minecraft:custom action (or dynamic/custom for forms) is sent without asking, and
 * vanilla ignores it on the server. This server-only mod treats a custom action whose id is an allowed
 * function (e.g. npc:internal/form_apply) as "run that function as the player", with the payload (the
 * button's payload, or a form's inputs plus additions) as its macro arguments. The player needs no op.
 * Registers nothing, so vanilla clients can join.
 */
public class DialogActions implements DedicatedServerModInitializer {
	static final Logger LOG = LoggerFactory.getLogger("dialog_actions");
	/** Function id prefixes a custom action may run; anything else is left to vanilla (ignored). */
	static final List<String> ALLOWED = List.of("npc:internal/");

	@Override
	public void onInitializeServer() {
		LOG.info("Dialog Actions: custom dialog actions may run {}", ALLOWED);
	}

	/** On the server thread, from the mixin. True if the action was ours. */
	public static boolean handle(ServerPlayer player, Identifier id, Optional<Tag> payload) {
		String function = id.toString();
		if (ALLOWED.stream().noneMatch(function::startsWith)) {
			return false;
		}
		String command = "function " + function;
		if (payload.isPresent() && payload.get() instanceof CompoundTag args && !args.isEmpty()) {
			command += " " + args;
		}
		CommandSourceStack source = player.createCommandSourceStack().withPermission(LevelBasedPermissionSet.GAMEMASTER);
		player.level().getServer().getCommands().performPrefixedCommand(source, command);
		return true;
	}
}
