package org.newburghcreates.chatcounter;

import net.fabricmc.api.DedicatedServerModInitializer;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerTickEvents;
import net.fabricmc.fabric.api.message.v1.ServerMessageEvents;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.scores.Objective;
import net.minecraft.world.scores.ReadOnlyScoreInfo;
import net.minecraft.world.scores.ScoreHolder;
import net.minecraft.world.scores.Scoreboard;

/**
 * Data packs can't see chat. This server-only mod adds 1 to the sender's score in the
 * chat_count objective for every chat message (only if a pack created the objective), and keeps
 * the fake player #mod at 1 in it so the pack can tell the mod is installed (packs reset #mod on
 * load, so a world copied somewhere without the mod notices). Registers nothing, so vanilla
 * clients can join.
 */
public class ChatCounter implements DedicatedServerModInitializer {
	static final String OBJECTIVE = "chat_count";
	static final ScoreHolder MOD = ScoreHolder.forNameOnly("#mod");

	@Override
	public void onInitializeServer() {
		ServerMessageEvents.CHAT_MESSAGE.register((message, sender, params) -> count(sender));
		ServerTickEvents.END_SERVER_TICK.register(ChatCounter::markPresent);
	}

	static void count(ServerPlayer player) {
		MinecraftServer server = player.level().getServer();
		server.execute(() -> {
			Scoreboard scoreboard = server.getScoreboard();
			Objective objective = scoreboard.getObjective(OBJECTIVE);
			if (objective != null) {
				scoreboard.getOrCreatePlayerScore(player, objective).increment();
			}
		});
	}

	static void markPresent(MinecraftServer server) {
		Scoreboard scoreboard = server.getScoreboard();
		Objective objective = scoreboard.getObjective(OBJECTIVE);
		if (objective == null) {
			return;
		}
		ReadOnlyScoreInfo info = scoreboard.getPlayerScoreInfo(MOD, objective);
		if (info == null || info.value() != 1) {
			scoreboard.getOrCreatePlayerScore(MOD, objective).set(1);
		}
	}
}
