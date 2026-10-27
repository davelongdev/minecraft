package org.newburghcreates.dialogactions.mixin;

import net.minecraft.network.protocol.common.ServerboundCustomClickActionPacket;
import net.minecraft.server.network.ServerCommonPacketListenerImpl;
import net.minecraft.server.network.ServerGamePacketListenerImpl;
import org.newburghcreates.dialogactions.DialogActions;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

/** MinecraftServer.handleCustomClickAction doesn't know who clicked, so catch the packet one step earlier (already on the server thread there). */
@Mixin(ServerCommonPacketListenerImpl.class)
abstract class ServerCommonPacketListenerImplMixin {
	@Inject(method = "handleCustomClickAction", cancellable = true, at = @At(value = "INVOKE",
			target = "Lnet/minecraft/server/MinecraftServer;handleCustomClickAction(Lnet/minecraft/resources/Identifier;Ljava/util/Optional;)V"))
	private void dialogActions$run(ServerboundCustomClickActionPacket packet, CallbackInfo ci) {
		if ((Object) this instanceof ServerGamePacketListenerImpl game
				&& DialogActions.handle(game.player, packet.id(), packet.payload())) {
			ci.cancel();
		}
	}
}
